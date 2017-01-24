---
title: Installing Rancher Server with SSL
layout: rancher-default-v1.2
version: v1.2
lang: en
redirect_from:
  - /rancher/v1.2/zh/installing-rancher/installing-server/basic-ssl-config/
---

## Installing Rancher Server With SSL
---

In order to run Rancher server from an `https` URL, you will need to terminate SSL with a proxy that is capable of setting headers. We've provided an example of how it could be set up with NGINX, HAProxy, or Apache, but other tools could be used.

### Requirements

Besides the typical Rancher server [requirements]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#requirements), you will also need:

* Valid SSL certificate: If your certificate is not part of the standard Ubuntu CA bundle, please use the [self signed certificate instructions]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/basic-ssl-config/#using-self-signed-certs-beta).
* DNS entries configured

### Rancher Server Tags

Rancher server has 2 different tags. For each major release tag, we will provide documentation for the specific version.

* `rancher/server:latest` tag will be our latest development builds. These builds will have been validated through our CI automation framework. These releases are not meant for deployment in production.
* `rancher/server:stable` tag will be our latest stable release builds. This tag is the version that we recommend for production.  

Please do not use any release with a `rc{n}` suffix. These `rc` builds are meant for the Rancher team to test out builds.

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
* For Rancher instances with a [bind mounted database]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#single-container-bind-mount), follow the [upgrade instructions for bind mounted instances]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/upgrading/#single-container-bind-mount).
* For Rancher instances launched using an external database, stop and remove the existing Rancher container. Launch the new container using the same [instructions for connecting to an external database]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#single-container-external-database).

### Example Nginx Configuration

Here is the minimum NGINX configuration that will need to be configured. You should customize your configuration to meet your needs.

#### Notes on the Settings

* `rancher-server` is the name of your rancher server container. When starting your rancher server container, the command must include `--name=rancher-server`. When starting your nginx container, the command must include `--link=rancher-server` for this exact configuration to work.
* `<server>` can be any arbitrary name, but the same name should be used for both the http and https servers.


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
        proxy_set_header Connection "Upgrade";
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

### EXAMPLE HAProxy CONFIGURATION
Here is the minimum HAProxy configuration that will need to be configured. You should customize your configuration to meet your needs.

#### Notes on the Settings

* `<rancher_server_X_IP>` is the IP address for your rancher servers.


```
global
  maxconn 4096
  ssl-server-verify none

defaults
  mode http
  balance roundrobin
  option redispatch
  option forwardfor

  timeout connect 5s
  timeout queue 5s
  timeout client 36000s
  timeout server 36000s

frontend http-in
  mode tcp
  bind *:443 ssl crt /etc/haproxy/certificate.pem
  default_backend rancher_servers

  acl is_websocket hdr(Upgrade) -i WebSocket
  acl is_websocket hdr_beg(Host) -i ws
  use_backend rancher_servers if is_websocket

backend rancher_servers
  server websrv1 <rancher_server_1_IP>:8080 weight 1 maxconn 1024
  server websrv2 <rancher_server_2_IP>:8080 weight 1 maxconn 1024
  server websrv3 <rancher_server_3_IP>:8080 weight 1 maxconn 1024
```

### Updating Host Registration

After Rancher is launched with these settings, the UI will be up and running at `https://<your domain>/`.

Before [adding hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/), you'll need to properly configure [Host Registration]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/settings/#host-registration) for SSL.

<a id="alb"></a>

### Running Rancher Server Behind an Application Load Balancer (ALB) in AWS with SSL

We recommend using an Application Load Balancer (ALB) in AWS over using an Elastic Load Balancer (ELB). With an ALB, you will only need to direct the traffic to the advertised port (`--advertise-http-port`), which is by default `8080`.

> **Note**: If you use an ALB with Kuberenetes, `kubectl exec` will not work and for that functionality, you will need to use an ELB.

<a id="elb"></a>

### Running Rancher Server Behind an Elastic Load Balancer (ELB) in AWS with SSL

_Supported as of v1.2.3+_

By default, ELB is enabled in HTTP/HTTPS mode, which does not support websockets. Since Rancher uses websockets, ELB must be configured specifically in order for Rancher’s websockets to work.

#### Configuration Requirements for Elastic Load Balancer (ELB)

* Enabling [proxy protocol](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/enable-proxy-protocol.html) mode

```
$ aws elb create-load-balancer-policy --load-balancer-name <LB_NAME> --policy-name <POLICY_NAME> --policy-type-name ProxyProtocolPolicyType --policy-attributes AttributeName=ProxyProtocol,AttributeValue=true
$ aws elb set-load-balancer-policies-for-backend-server --load-balancer-name <LB_NAME> --instance-port 81 --policy-names <POLICY_NAME>
$ aws elb set-load-balancer-policies-for-backend-server --load-balancer-name <LB_NAME> --instance-port 444 --policy-names <POLICY_NAME>
$ aws elb set-load-balancer-policies-for-backend-server --load-balancer-name <LB_NAME> --instance-port 8080 --policy-names <POLICY_NAME>
```

* For SSL terminated at the Rancher servers: Configure ELB listener for TLS/SSL:443 for the frontend and TCP:444 for the backend instance protocol:port.
* For SSL terminated at the ELB: Configure ELB listener for TCP:80 for the frontend and TCP:81 for the backend instance protocol:port.
* Health check can be configured to use HTTP:80 or HTTPS:443 using `/ping` as your path.
