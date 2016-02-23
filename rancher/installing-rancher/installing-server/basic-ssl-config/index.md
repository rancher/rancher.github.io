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
        # This allows the ability for the execute shell window to remain open for up to 15 minutes. Without this parameter, the default is 1 minute and will automatically close.
        proxy_read_timeout 900s;
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
  ServerName <server_name>
  Redirect / https://<server_name>/
</VirtualHost>

<VirtualHost *:443>
  ServerName <server_name>

  SSLEngine on
  SSLCertificateFile </path/to/ssl/cert_file>
  SSLCertificateKeyFile </path/to/ssl/key_file>

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

In the UI, you'll need to properly configure Host Registration for SSL. See the [Host Registration ]({{site.baseurl}}/rancher/configuration/settings/#host-registration) section for more details.

## Running Rancher Server Behind an ELB in AWS with SSL

By default, ELB in HTTP/HTTPS mode does not support websockets. Since Rancher uses websockets, ELB must be configured specifically in order for Rancher's websockets to work. 

Configuration Requirements for ELB to enable Rancher:

 * Enabling [proxy protocol](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/enable-proxy-protocol.html) mode
 * Configuring TLS/SSL for the frontend and TCP for the backend

## Using Self Signed Certs (Beta)

### Disclaimers

This configuration will work for the 'core' services in Rancher running in stand alone mode (Non-HA setup). At the time of this writing, Rancher services deployed by the catalog.

Rancher Compose CLI will need the CA certificate as part of the default store for the operating system. See [Golang root_*](https://golang.org/src/crypto/x509/)

### Server Pre-Requisites

* CA certificate file in PEM format 
* Certificate signed by the CA for the Rancher Server
* An instance of NGINX or Apache configured to terminate SSL and reverse proxy Rancher server
* Rancher Server >= v0.57.0

### Steps

#### Rancher Server

Launch the Rancher server container with the modified Docker command below:

```bash
$ docker run -d --restart=always -p 8080:8080 -v /some/dir/ca.crt:/ca.crt rancher/server
```

> **Note:** If you are running NGINX or Apache in a container, you can link the instance and not publish the Rancher UI 8080 port.

This command will configure the server's ca-certificate bundle so that the Rancher services for machine provisioning, catalog and compose executor can communicate with the Rancher server.

If you are using a container with NGINX or Apache to terminate SSL, you can launch that container and link the two containers.

Access Rancher over the `https` address, which will be something similar to `https://rancher.server.domain`.

Unless the machine running your web browser trusts the CA certificate used to sign the Rancher server certificate, the browser will give an untrusted site warning whenever you visit the web page.

#### Adding Hosts

1. On the host, place the CA certificate, which must be in pem format, into the directory `/var/lib/rancher/etc/ssl` with the file name `ca.crt`.

2. Run the custom registration command from the UI, which will already have the `-v /var/lib/rancher:/var/lib/rancher` in the command. 


