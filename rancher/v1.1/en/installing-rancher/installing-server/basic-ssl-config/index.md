---
title: Installing Rancher Server with SSL
layout: rancher-default-v1.1
version: v1.1
lang: en
redirect_from:
  - /rancher/v1.1/zh/installing-rancher/installing-server/basic-ssl-config/
---

## Installing Rancher Server With SSL
---

In order to run Rancher server from an `https` URL, you will need to terminate SSL with a proxy that is capable of setting headers. We've provided an example of how it could be set up with NGINX or Apache, but other tools could be used.

### Requirements

Besides the typical Rancher server [requirements]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#requirements), you will also need:

* Valid SSL certificate: If your certificate is not part of the standard Ubuntu CA bundle, please use the [self signed certificate instructions]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/basic-ssl-config/#using-self-signed-certs-beta).
* DNS entries configured

### Launching Rancher Server

In our example configuration, all traffic will pass through the proxy and be sent over a Docker link to the Rancher server container. There are alternative approaches that could be followed, but this example is simple and translates well.

Start Rancher server. We have added in `--name=rancher-server` to this command in order to link the proxy container to the Rancher server container.

```bash
$ sudo docker run -d --restart=unless-stopped --name=rancher-server rancher/server
```
<br>

> **Note:** In our example, we have assumed the proxy will be running in another container. If you are planning to run a proxy from the host, you will need to expose port `8080` locally by adding `-p 127.0.0.1:8080:8080` to the `docker run` command.

If you are converting an existing Rancher instance, the upgrade to the new Rancher instance will depend on how you launched your original Rancher instance.

* For Rancher instances using the MySQL database inside the Rancher server container, follow the [upgrade instructions]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/upgrading/#upgrading-rancher-by-creating-a-data-container) of creating a data container and adding in the `--volumes-from=<data_container>` when launching your new Rancher server instance.
* For Rancher instances with a [bind mounted database]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#bind-mount-mysql-volume), follow the [upgrade instructions for bind mounted instances]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/upgrading/#upgrading-rancher-launched-using-bind-mounts).
* For Rancher instances launched using an external database, stop and remove the existing Rancher container. Launch the new container using the same [instructions for connecting to an external database]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#external-db).

> **Note:** After your new Rancher server is running, please make sure to **remove** the old Rancher instance. Otherwise, if your machine is rebooted, your old Rancher instance will start up if you have used `--restart=always` to the `docker run` commands. We recommend using `--restart=unless-stopped`.

### Example Nginx Configuration

Here is the minimum NGINX configuration that will need to be configured. You should customize your configuration to meet your needs.

#### Notes on the Settings

* `rancher-server` is the name of your rancher server container. When starting your rancher server container, the command must include `--name=rancher-server`. When starting your nginx container, the command must include `--link=rancher-server` for this exact configuration to work.
* `<server>` can be any arbitrary name, but the same name should be used for both the http and https servers.


```
upstream rancher {
    server rancher-server:8080;
}

map $http_upgrade $connection_upgrade {
    default Upgrade;
    ''      close;
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
        proxy_set_header Connection $connection_upgrade;
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


### Apache Configuration


Here is an Apache configuration.

#### Notes on the Settings

* `<server_name>` is the name of your rancher server container. When starting your Apache container, the command must include `--link=<server_name>` for this exact configuration to work.
* In the proxy settings, you'll need to substitute `rancher` for your configuration.
* Make sure the module `proxy_wstunnel` is enabled (websocket support).

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

### Example F5 BIG-IP configuration

The following iRule configuration can be applied to make Rancher Server accessible behind a F5 BIG-IP appliance.

```
when HTTP_REQUEST {
  HTTP::header insert "X-Forwarded-Proto" "https";
  HTTP::header insert "X-Forwarded-Port" "443";
  HTTP::header insert "X-Forwarded-For" [IP::client_addr];
}
```

### Updating Host Registration

After Rancher is launched with these settings, the UI will be up and running at `https://<your domain>/`.

Before [adding hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/), you'll need to properly configure [Host Registration]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/settings/#host-registration) for SSL.


### Running Rancher Server Behind an ELB in AWS with SSL

By default, ELB is enabled in HTTP/HTTPS mode, which does not support websockets. Since Rancher uses websockets, ELB must be configured specifically in order for Rancher's websockets to work.

#### Configuration Requirements for ELB to enable Rancher

 * Enabling [proxy protocol](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/enable-proxy-protocol.html) mode

```bash
$ aws elb create-load-balancer-policy --load-balancer-name my-elb --policy-name myorg-ProxyProtocol-policy --policy-type-name ProxyProtocolPolicyType --policy-attributes AttributeName=ProxyProtocol,AttributeValue=true
$ aws elb set-load-balancer-policies-for-backend-server --load-balancer-name my-elb --instance-port 81 --policy-names my-ProxyProtocol-policy
$ aws elb set-load-balancer-policies-for-backend-server --load-balancer-name my-elb --instance-port 444 --policy-names my-ProxyProtocol-policy
```

 * For SSL terminated at the Rancher servers: Configure ELB listener for TLS/SSL:443 for the frontend and TCP:444 for the backend instance protocol:port.
 * For SSL terminated at the ELB: Configure ELB listener for TCP:80 for the frontend and TCP:81 for the backend instance protocol:port.
 * Health check can be configured to use HTTP:80 or HTTPS:443 using `/ping` as your path.

### Using Self Signed Certs (Beta)

#### Disclaimers

This configuration will work for the 'core' services in Rancher running in a standalone mode (Non-HA setup). Currently, none of the certified Rancher templates from the [Rancher catalog](https://github.com/rancher/rancher-catalog) are supported.

Rancher Compose CLI will require the CA certificate as part of the default store for the operating system. See [Golang root_*](https://golang.org/src/crypto/x509/).

#### Server Pre-Requisites

* CA certificate file in PEM format
* Certificate signed by the CA for the Rancher Server
* An instance of NGINX or Apache configured to terminate SSL and reverse proxy Rancher server

#### Rancher Server

1. Launch the Rancher server container with the modified Docker command. The certificate **must** be called `ca.crt` inside the container.


   ```bash
   $ sudo docker run -d --restart=unless-stopped -p 8080:8080 -v /some/dir/cert.crt:/ca.crt rancher/server
   ```
    <br>

    > **Note:** If you are running NGINX or Apache in a container, you can directly link the instance and not publish the Rancher UI 8080 port.

    The command will configure the server's ca-certificate bundle so that the Rancher services for machine provisioning, catalog and compose executor can communicate with the Rancher server.

2. If you are using a container with NGINX or Apache to terminate SSL, launch the container and include the `--link=<rancher_server_container_name> in the command.

3. Access Rancher over the `https` address, i.e. `https://rancher.server.domain`.

4. Update the [Host Registration]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/settings/#host-registration) for SSL.

> **Note:** Unless the machine running your web browser trusts the CA certificate used to sign the Rancher server certificate, the browser will give an untrusted site warning whenever you visit the web page.

#### Adding Hosts

1. On the host that you want to add into Rancher, save the CA certificate, which must be in pem format, into the directory `/var/lib/rancher/etc/ssl` with the file name `ca.crt`.

2. Add the [custom host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/), which is just copying and pasting the command from the UI. The command will already include  `-v /var/lib/rancher:/var/lib/rancher`, so the file will automatically be copied onto your host.
