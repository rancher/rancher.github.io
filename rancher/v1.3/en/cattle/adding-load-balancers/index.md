---
title: Load Balancers
layout: rancher-default-v1.3
version: v1.3
lang: en
redirect_from:
  - /rancher/v1.3/zh/cattle/adding-load-balancers/
---

## Load Balancers
---

Rancher provides the ability to use different load balancer drivers within Rancher. A load balancer can be used to distribute network and application traffic to individual containers by adding rules to target services. Any target service will have all its underlying containers automatically registered as load balancer targets by Rancher. With Rancher, it's easy to add a load balancer to your stack.

By default, Rancher has provided a managed load balancer using HAProxy that can be manually scaled to multiple hosts. The rest of our examples in this document will cover the different options for load balancers, but specifically referencing our HAProxy load balancer service. We are planning to add in additional load balancer providers, and the options for all load balancers will be the same regardless of load balancer provider. We'll review the options for our load balancer for the [UI](#load-balancer-options-in-the-UI) and [Rancher Compose](#load-balancer-options-in-rancher-compose) and show examples using the [UI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/#adding-a-load-balancer-in-the-ui) and [Rancher Compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/#adding-a-load-balancer-with-rancher-compose).

### Adding a Load Balancer in the UI

We'll walk through how to set up a load balancer for our "letschat" application created earlier in the [adding services section]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#adding-services-in-the-ui).

First, you start by creating a load balancer, by clicking on the dropdown icon next to "Add Service" and clicking **Add Load Balancer**. By default, the scale will be of 1 container. Provide a name like "LetsChatLB".

For the port rules, use the default `Public` access, the default `http` protocol, a source port of `80`, select the "letschat" service, and use a target port of `8080`. Click on **Create**.

Now, let's see the load balancer in action. In the stack view, there is a link to  port `80` that you've used as the source port for your load balancer. If you click on it, it will automatically bring up a new tab in your browser and point to one of the hosts that has the load balancer launched. The request is re-directed to one of the "LetsChat" containers. If you were to refresh, the load balancer would redirect the new request to the other container in the "letschat" service. By default, we use the round robin algorithm to distribute traffic to the target services. The algorithm can be customized in the [custom HAProxy configuration](#custom-haproxy-configuration).

### Load Balancer Options in the UI

Rancher provides a load balancer running HAProxy software inside the container to direct traffic to the target services.

> **Note:** Load balancers will only work for services that are using the managed network. If you select any other network choice for your target services, it will **not** work with the load balancer.

You add a load balancer by clicking the dropdown icon next to the **Add Service** button and selecting **Add Load Balancer**.

You can use the slider to select the scale, i.e. how many containers of the load balancer. Alternatively, you can select **Always run one instance of this container on every host**. With this option, your load balancer will scale for any additional hosts that are added to your [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/). If you have scheduling rules in the **Scheduling** section, Rancher will only start containers on the hosts that meet the scheduling rules. If you add a host to your environment that does not meet the scheduling rules, a container will not be started on the host.

> **Note:** The scale of the load balancer cannot exceed the number of hosts in the environment, otherwise there will be a port conflict and the load balancer service will be stuck in an activating state. It will continue to try and find an available host and open port until you edit the scale of this load balancer or [add additional hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/).

You will need to provide a **Name** and if desired, **Description** of the load balancer.

Next, you'll define the port rules for a load balancer. There are two types of port rules that can be created. There are service rules that target existing services and selector rules that will target services that match the selector criteria.

When creating service and selector rules, the hostname and path rules are matched top-to-bottom in the order shown in the UI.

#### Service rule

Service rules are port rules to target existing services in Rancher.

In the **Access** section, you will decide if this load balancer port will be accessible publicly (i.e. accessible outside of the host) or only internally in the environment. By default, Rancher has assumed you want the port to be public, but you can select `Internal` if you want the port to only be accessed by services within the same environment.

Select the **Protocol**. Read more about our [protocol options](#protocol).  If you choose to select a protocol that requires SSL termination (i.e. `https` or `tls`), you will add in your certificates in the **SSL Termination** tab.

Next, you'll provide the **request host**, **source port** and **path** for where the traffic will be coming from.

> **Note:** Port `42` cannot be used as a source port for load balancers because Rancher uses this port for [health checks]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/health-checks).

##### Request Host/Path

The request host can be a specific HTTP host header for each service. The request path can be a specific path. The request host and request path can be used independently or in conjunction to create a specific request.

###### Example:

```
domain1.com -> Service1
domain2.com -> Service2

domain3.com -> Service1
domain3.com/admin -> Service2
```

###### Wildcards

Rancher supports wildcards when adding host based routing. The following wildcard syntax is supported.

```
*.domain.com -> hdr_end(host) -i .domain.com
domain.com.* -> hdr_beg(host) -i domain.com.
```

##### Target Service and Port

For each service rule, you select the specific **target** service to direct traffic to. The list of services is based on all the services within that environment. Along with the service, you select which **port** to direct the traffic to on the service. This private port on the service is typically the exposed port on the image.

#### Selector rule

For a selector rule, instead of targeting a specific service, you would provide a [selector value]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/labels/#selector-labels). The selector is used to pick up target services based on the labels of a service. When the load balancer is created, the selector rules will be evaluated against any existing services in the environment to see if there are any existing target services. Any additional services or changes to labels on a service would be compared against the selector values to see if the service should be a target service.

For each **source port**, you can add in **request host** and/or **path**. The [selector value]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/labels/#selector-labels) is provided under **target** and you can provide a specific **port** to direct the traffic to on the service. This private port on the service is typically the exposed port on the image.

##### Example: 2 Selector Rules

1. Source Port: `100`; Selector: `foo=bar`; Port: `80`
2. Source Port: `200`; Selector: `foo1=bar1`; Port: `80`

* Service A has a `foo=bar` label and would match the first selector rule. Any traffic to `100` would be directed to Service A.
* Service B has a `foo1=bar` label and would match the second selector rule. Any traffic to `200` would be directed to Service B.
* Service C has both `foo=bar` and `foo1=bar1` labels and match both selector rules. Traffic from either source port would be directed to Service C.

> **Note:** Currently, if you want to use one selector source port rule for multiple hostnames/paths, you would need to use [Rancher Compose](#selector) to set the hostname/path values on the target services.

#### SSL Termination

The **SSL Termination** tab provides the ability to add certificates to use for the `https` and `tls` protocols. In the **Certificate** dropdown, you can select the main certificate for the load balancers.

To add a certificate to Rancher, please read about [how to add certificates in the **Infrastructure** tab]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/certificates/).

It is possible to provide multiple certificates for the load balancer such that the appropriate certificate is presented to the client based on the hostname requested (see [Server Name Indication](https://en.wikipedia.org/wiki/Server_Name_Indication)). This may not work with older clients, which don't support SNI (those will get the main certificate). For modern clients, they will be offered the certificate from the list for which there is a match or the main certificate if there is no match.

#### Stickiness Policy for Load Balancers

You can select the **Stickiness** of the load balancer. Stickiness is the cookie policy that you want to use for when using cookies of the website.

The two options supported in Rancher are:

* **None**: This option means that no cookie policy is in place.
* **Create new cookie**: This option means that the cookie will be defined outside of your application. This cookie is what the load balancer would set on requests and responses. This cookie would determine the stickiness policy.

#### Custom HAProxy Configuration

Since Rancher is using an HAProxy specific load balancer, you can customize the HAProxy configuration of the load balancer. Whatever you define in this section will be appended to the configuration generated by Rancher.

##### Example of a Custom HAProxy Configuration

```
global
    maxconn 4096
    maxpipes 1024

defaults
    log global
    mode    tcp
    option  tcplog

frontend 80
    balance leastconn

frontend 90
    balance roundrobin

backend mystack_foo
    cookie my_cookie insert indirect nocache postonly
    server $IP <server parameters>

backend customUUID
    server $IP <server parameters>
```

#### Labels/Scheduling Load Balancers

We provide the ability to add labels to load balancers and schedule where the load balancer will be launched. Read more details about labels and scheduling [here]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/#scheduling-options-in-the-ui).

### Adding a Load Balancer with Rancher Compose

We'll walk through how to set up a load balancer for our "letschat" application created earlier in the [adding services section]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#adding-services-with-rancher-compose).

Read more about how to [set up Rancher Compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/rancher-compose/).

> **Note**: In our examples, we will use `<version>` as the image tag for our load balancers. Each version of Rancher will have a specific version of `lb-service-haproxy` that is supported for load balancers.

We'll set up the same example that we used above in the UI example. To get started, you will need to create a `docker-compose.yml` file and a `rancher-compose.yml` file. With Rancher Compose, we can launch the load balancer.

#### Example `docker-compose.yml`

```yaml
version: '2'
services:
  letschatlb:
    ports:
    - 80
    image: rancher/lb-service-haproxy:<version>
```

#### Example `rancher-compose.yml`

```yaml
version: '2'
services:
  letschatlb:
    scale: 1
    lb_config:
      port_rules:
      - source_port: 80
        target_port: 8080
        service: letschat
    health_check:
      port: 42
      interval: 2000
      unhealthy_threshold: 3
      healthy_threshold: 2
      response_timeout: 2000
```

### Load Balancer Options in Rancher Compose

Rancher provides a load balancer running HAProxy software inside the container to direct traffic to the target services.

> **Note:** Load balancers will only work for services that are using the managed network. If you select any other network choice for your target services, it will **not** work with the load balancer.

A load balancer can be scheduled like any other service. Read more about [scheduling]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/#adding-labels-in-rancher-compose) load balancers using Rancher Compose.

Load balancing is configured with a combination of ports exposed on a host and a load balancer configuration, which can include specific port rules for each target service, custom configuration and stickiness policies.

When working with services that contain [sidekicks]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#sidekick-services), you need to use the [primary service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#primary-service) as a target service, which is the service that contains the `sidekick` label.

### Source Ports

When creating a load balancer, you can add any ports you want exposed on the host. Any of these ports can be used as source ports in the port rules of a load balancer. If you want an internal load balancer, you would not expose any ports on the load balancer, and only add in port rules in the load balancer configuration.

> **Note:**  Port `42` cannot be used as a port for load balancers because it's internally used for [health checks]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/health-checks).

#### Example `docker-compose.yml`

```yaml
version: '2'
services:
  lb1:
    image: rancher/lb-service-haproxy:<version>
    # Any ports listed will be exposed on the host that is running the load balancer
    # To direct traffic to specific service, a port rule will need to be added.
    ports:
    - 80
    - 81
    - 90
```

### Load Balancer configuration

All load balancer configuration options are defined in the `rancher-compose.yml` under the `lb_config` key.

```yaml
version: '2'
services:
  lb1:
    scale: 1
    # All load balancer options are configured in this key
    lb_config:
      port_rules:
      - source_port: 80
        target_port: 80
        service: web1
    health_check:
      port: 42
      interval: 2000
      unhealthy_threshold: 3
      healthy_threshold: 2
      response_timeout: 2000
  web1:
    scale: 2
```

#### Port rules

Port rules are defined in the `rancher-compose.yml`. Since port rules are defined individually, there may be multiple port rules defined for the same service. By default, Rancher will prioritize these port rules based on a specific priority ordering. If you would like to change the ordering of the prioritization, you can also set a specific [priority](#priority) order of the rules.

#### Default Priority Order

1. Hostname with no wildcards and URL
2. Hostname with no wildcards
3. Hostname with wildcards and URL
4. Hostname with wildcards
5. URL
6. Default (no hostname, no URL)

##### Source Port

The source port is one of the ports exposed on the host (i.e. a port that is in the `docker-compose.yml`).

If you want to create internal load balancer, then the source port does not need to match any of the ports in the `docker-compose.yml` file.

##### Target Port

The target port is the private port on the service. This port correlates to the port exposed on the image used to start your service.

##### Protocol

There are multiple protocol types that are supported in the Rancher load balancer drivers.

* `http` - By default, if no protocol is set, the load balancer uses `http`. HAProxy doesn't decrypt the traffic and passes the traffic directly through
* `tcp` - HAProxy doesn't decrypt the traffic and passes the traffic directly through
* `https` - SSL termination is required. Traffic is decrypted by HAProxy using the provided [certificates]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/certificates/), which must be added into Rancher before being used in a load balancer. Traffic from the load balancer to the target service is unencrypted.
* `tls` - SSL termination is required. Traffic is decrypted by HAProxy using the provided [certificates]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/certificates/), which must be added into Rancher before being used in a load balancer. Traffic from the load balancer to the target service is unencrypted.
* `sni` - Traffic is encrypted to the load balancer and to the services. Multiple certificates are provided for the load balancer such that the appropriate certificate is presented to the client based on the hostname requested. (see [Server Name Indication](https://en.wikipedia.org/wiki/Server_Name_Indication) for more details).
* `udp` - This is not supported for Rancher's HAProxy provider.

Any additional load balancer providers might support only a subset of the protocols.

###### Hostname Routing

Hostname routing is only supported for `http`, `https` and `sni`. Only `http` and `https` support path based routing as well.

##### Service

The service name that you want the load balancer to direct traffic to. If the service is in the same stack, then you use the service name. If the service is in a different stack, then you would use `<stack_name>/<service_name>`.

###### Example `rancher-compose.yml`

```yaml
version: '2'
services:
  lb1:
    scale: 1
    lb_config:
      port_rules:
      - source_port: 81
        target_port: 2368
        # Service in the same stack
        service: ghost
      - source_port: 80
        target_port: 80
        # Target a service in a different stack
        service: differentstack/web1
    health_check:
      port: 42
      interval: 2000
      unhealthy_threshold: 3
      healthy_threshold: 2
      response_timeout: 2000
  ghost:
    scale: 2
```

##### Hostname and Path

Rancher's HAProxy load balancer supports L7 load balancing by being able to specify host header and path in the port rules.

###### Example `rancher-compose.yml`

```yaml
version: '2'
services:
  lb1:
    scale: 1
    lb_config:
      port_rules:
      - source_port: 81
        target_port: 2368
        service: ghost
        protocol: http
        hostname: example.com
        path: /path/a
    health_check:
      port: 42
      interval: 2000
      unhealthy_threshold: 3
      healthy_threshold: 2
      response_timeout: 2000
  ghost:
    scale: 2
```

##### Wildcards

Rancher supports wildcards when adding host based routing. The following wildcard syntax is supported.

```
*.domain.com -> hdr_end(host) -i .domain.com
domain.com.* -> hdr_beg(host) -i domain.com.
```

##### Priority

By default, Rancher [prioritizes port rules](#default-priority-order) targeting the same service, but if you wanted to, you could customize your own prioritization of the port rules.

###### Example `rancher-compose.yml`

```yaml
version: '2'
services:
  lb1:
    scale: 1
    lb_config:
      port_rules:
      - source_port: 88
        target_port: 2368
        service: web1
        protocol: http
        hostname: foo.com
        priority: 2
      - source_port: 80
        target_port: 80
        service: web2
        protocol: http
        priority: 1
    health_check:
      port: 42
      interval: 2000
      unhealthy_threshold: 3
      healthy_threshold: 2
      response_timeout: 2000
  web1:
    scale: 2
```

##### Selector

Instead of targeting a specific service, you can set up a [selector]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/labels/#selector-labels). By using selectors, you can define the service links and hostname routing rules on the target service instead of on the load balancer. Services with labels matching the selector become a target in the load balancer.

When using a selector in a load balancer, the `lb_config` can be set on the load balancer and any  target services that are matching the selector.

In the load balancer, the [selector value]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/labels/#selector-labels) is set in the `lb_config` under `selector`. The port rule in the `lb_config` of the load balancer cannot have a service and would typically not have a target port. Instead, the target port is set in port rules on the target service. If you choose to use hostname routing, the hostname and path would be set on the target service.

>**Note:** For any load balancers using the v1 load balancer yaml fields that uses selector labels will not be converted to the v2 load balancer as the port rules on the service would not be updated.

###### Example `docker-compose.yml`

```yaml
version: '2'
services:
  lb1:
    image: rancher/lb-service-haproxy:<version>
    ports:
    - 81
  # These services (web1 and web2) will be picked up by the load balancer as a target
  web1:
    image: nginx
    labels:
      foo: bar
  web2:
    image: nginx
    labels:
      foo: bar
```

###### Example `rancher-compose.yml`

```yaml
version: '2'
services:
  lb1:
    scale: 1
    lb_config:
      port_rules:
      - source_port: 81
        # Target any service that has foo=bar as a label
        selector: foo=bar
        protocol: http
    health_check:
      port: 42
      interval: 2000
      unhealthy_threshold: 3
      healthy_threshold: 2
      response_timeout: 2000
  # web1 and web2 are targeted with the same source port but with the different hostname and path rules
  web1:
    scale: 1
    lb_config:
      port_rules:
      - target_port: 80
        hostname: test.com
  web2:
    scale: 1
    lb_config:
      port_rules:
      - target_port: 80
        hostname: example.com/test     
```

##### Backend Name

If you want to explicitly label your backend in your load balancer configuration, you would use the `backend_name`. This option can be useful if you want to configure custom config parameters for a particular backend.

#### certificates

If you are using `https` or `tls` [protocol](#protocol), then you reference the certificates in the `rancher-compose.yml`.

##### Example `rancher-compose.yml`

```yaml
version: '2'
services:
  lb:
    scale: 1
    lb_config:
      certs:
      - <certName>
      default_cert: <defaultCertName>
```

#### Custom configuration

For advanced users, you can specify custom configuration to the load balancer in the `rancher-compose.yml`. Please refer to the [HAProxy documentation](http://cbonte.github.io/haproxy-dconv/configuration-1.5.html) for details on the available options you can add for the Rancher's HAProxy load balancer.

##### Example `rancher-compose.yml`

```yaml
version: '2'
services:
  lb:
    scale: 1
    lb_config:
      config: |-
        global
            maxconn 4096
            maxpipes 1024

        defaults
            log global
            mode    tcp
            option  tcplog

        frontend 80
            balance leastconn

        frontend 90
            balance roundrobin

        backend mystack_foo
            cookie my_cookie insert indirect nocache postonly
            server $$IP <server parameters>

        backend customUUID
  health_check:
    port: 42
    interval: 2000
    unhealthy_threshold: 3
    healthy_threshold: 2
    response_timeout: 2000
```

#### Stickiness Policy

If you want to specify stickiness policy, you can update the policies in `rancher-compose.yml`.

##### Example `rancher-compose.yml`

```yaml
version: '2'
services:
  lb:
    scale: 1
    lb_config:
      stickiness_policy:
        name: <policyName>
        cookie: <cookieInfo>
        domain: <domainName>
        indirect: false
        nocache: false
        postonly: false
        mode: <mode>
  health_check:
    port: 42
    interval: 2000
    unhealthy_threshold: 3
    healthy_threshold: 2
    response_timeout: 2000
```

### Rancher Compose Examples

#### Load Balancer Example (L7)

##### Example `docker-compose.yml`

```yaml
version: '2'
services:
  web:
    image: nginx
  lb:
    image: rancher/lb-service-haproxy
  ports:
  - 80
  - 82
```

##### Example `rancher-compose.yml`

```yaml
version: '2'
services:
  lb:
    scale: 1
    lb_config:
      port_rules:
      - source_port: 80
        target_port: 8080
        service: web1
        hostname: app.example.com
        path: /foo
      - source_port: 82
        target_port: 8081
        service: web2
        hostname: app.example.com
        path: /foo/bar
  health_check:
    port: 42
    interval: 2000
    unhealthy_threshold: 3
    healthy_threshold: 2
    response_timeout: 2000
```

#### Internal Load Balancer Example

To set up an internal load balancer, no ports are listed, but you can still set up port rules to direct traffic to the service.

##### Example `docker-compose.yml`

```yaml
version: '2'
services:
  lb:
    image: rancher/lb-service-haproxy
  web:
    image: nginx
```

<br>

##### Example  `rancher-compose.yml`

```yaml
version: '2'
services:
  lb:
    scale: 1
    lb_config:
      port_rules:
      - source_port: 80
        target_port: 80
        service: web
    health_check:
      port: 42
      interval: 2000
      unhealthy_threshold: 3
      healthy_threshold: 2
      response_timeout: 2000
  web:
    scale: 1
```

#### SSL Termination Example

The [certificates]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/certificates/) must be added into Rancher and are defined in the `rancher-compose.yml`.

##### Example `docker-compose.yml`

```yaml
version: '2'
services:
  lb:
    image: rancher/lb-service-haproxy
    ports:
    - 443
  web:
    image: nginx
```

<br>

##### Example `rancher-compose.yml`

```yaml
version: '2'
services:
  lb:
    scale: 1
    lb_config:
      certs:
      - <certName>
      default_cert: <defaultCertName>
      port_rules:
      - source_port: 443
        target_port: 443
        service: web
        protocol: https
  web:
    scale: 1
```
