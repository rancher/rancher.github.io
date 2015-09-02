---
title: Basic SSL Rancher Server Configuration
layout: rancher-default
---

## Installing Rancher Server With SSL
---

In order to run Rancher Server from an https url, you will need to terminate SSL with a proxy that is capable of setting headers. We'll provide an outline of how to set it up with NGINX, but other tools could be used.

## Requirements

Besides the typical Rancher Server [requirements]({{site.baseurl}}/rancher/installing-rancher/installing-server/#requirements), you will also need:

* Valid SSL certificate
* DNS entries configured

## Launching Rancher Server

In our configuration, all traffic will pass through the proxy and be sent over a Docker link to the Rancher Server container. There are alternative approaches that could be followed, but this approach is simple and translates well.

Start the Rancher Server as normal:

```bash
$ sudo docker run -d --restart=always --name=rancher-server rancher/server
```

> **Note:** We are assuming that you will run your proxy in a container. If you are going to run a proxy from the host, you will need to expose port 8080 by adding `-p 8080:8080` to the command.

If you are converting an existing Rancher instance configured with a data volume or external DB, stop and remove the existing Rancher Server container. Launch the new container with `--volumes-from=<data_container>` or [external DB settings]({{site.baseurl}}/rancher/installing-rancher/installing-server/#external-db).

## Nginx Configuration

Here is the minimum NGINX configuration that will need to be configured. You should customize your configuration to meet best practices.

```
upstream rancher {
    server rancher-server:8080;
}

server {
    listen 443 ssl;
    server_name <server>;
    ssl_certificate <cert_file>;
    ssl_certificate_key <key_file>;

    location / {
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Port $server_port;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass http://rancher;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}

server {
    listen 80;
    server_name <server>;
    return 301 https://$server_name$request_uri;
}
```

**Important Setting Notes:**

* `rancher-server` is the name of your rancher server container. In other words, you must start your rancher server container with `--name=rancher-server` and your nginx container with `--link=rancher-server` for this exact configuration to work.
* `<server>` can be any arbitrary name, but the same name should be used for both the http and https servers.


## Apache Configuration

Here is an Apache configuration. You'll need to launch an Apache container and do a docker link to provide DNS resolution for Rancher. 

```
<VirtualHost *:80>
ServerName myhost.rancher.io
Redirect / https://myhost.rancher.io/
</VirtualHost>

<VirtualHost *:443>
ServerName myhost.rancher.io

SSLEngine on
SSLCertificateFile /etc/ssl/certs/loadtest.rancher.io.crt
SSLCertificateKeyFile /etc/ssl/certs/loadtest.rancher.io.key

ProxyRequests Off
ProxyPreserveHost On

RewriteEngine On
RewriteCond %{HTTP:Connection} Upgrade [NC]
RewriteCond %{HTTP:Upgrade} websocket [NC]
RewriteRule /(.*) ws://rancher:8080/$1 [P,L]

RequestHeader set X-Forwarded-Proto "https"
RequestHeader set X-Forwarded-Port "443"

<Location />
ProxyPass "http://rancher:8080/"
ProxyPassReverse "http://rancher:8080/"
</Location>

</VirtualHost>
```

**Important Setting Notes:**

* In the proxy settings, you'll need to substitute `rancher` for your configuration.

## Host Registration
After Rancher is launched with these settings, the UI will be up and running at `https://<your domain>/`.

In the UI, you'll need to properly configure Host Registration for SSL. See the [Host Registration ]({{site.baseurl}}/rancher/configuration/host-registration) section for more details.
