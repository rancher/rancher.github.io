---
title: Load Balancers
layout: rancher-default-v1.2
version: v1.2
lang: en
redirect_from:
  - /rancher/rancher-ui/applications/stacks/adding-balancers/
  - /rancher/latest/en/cattle/adding-load-balancers/
---

## Load Balancers
---

Rancher implements a managed load balancer using HAProxy that can be manually scaled to multiple hosts.  A load balancer can be used to distribute network and application traffic to individual containers by adding rules to target services. Any target service will have all its underlying containers automatically registered as load balancer targets by Rancher. With Rancher, it's easy to add a load balancer to your stack. We'll review the options for our load balancer as if you were using the UI and show examples using the [UI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/#adding-a-load-balancer-in-the-ui) and [Rancher Compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/#adding-a-load-balancer-with-rancher-compose).

### Adding a Load Balancer in the UI

We'll walk through how to set up a load balancer for our "letschat" application created earlier in the [adding services section]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#adding-services-in-the-ui).

First, you start by creating a load balancer, by clicking on the dropdown icon next to "Add Service" and clicking **Add Load Balancer**. By default, the scale will be of 1 container. Provide a name like "LetsChatLB".

For the port rules, use the default `Public` access, the default `http` protocol, a source port of `80`, select the "letschat" service, and use a target port of `8080`. Click on **Create**.

Now, let's see the load balancer in action. In the stack view, there is a link to  port `80` that you've used as the source port for your load balancer. If you click on it, it will automatically bring up a new tab in your browser and point to one of the hosts that has the load balancer launched. The request is re-directed to one of the "LetsChat" containers. If you were to refresh, the load balancer would redirect the new request to the other container in the "letschat" service as we use the round robin algorithm to distribute traffic to the target services.

### Load Balancer Options in the UI

Rancher provides a load balancer running HAProxy software inside the containers. The load balancer uses a round robin algorithm from HAProxy to direct traffic to the target services.

> **Note:** Load balancers will only work for services that are using the managed network. If you select any other network choice for your target services, it will **not** work with the load balancer.

You add a load balancer by clicking the dropdown icon next to the **Add Service** button and selecting **Add Load Balancer**.

You can use the slider to select the scale, i.e. how many containers of the load balancer. Alternatively, you can select **Always run one instance of this container on every host**. With this option, your load balancer will scale for any additional hosts that are added to your [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/). If you have scheduling rules in the **Scheduling** section, Rancher will only start containers on the hosts that meet the scheduling rules. If you add a host to your environment that does not meet the scheduling rules, a container will not be started on the host.

> **Note:** The scale of the load balancer cannot exceed the number of hosts in the environment, otherwise there will be a port conflict and the load balancer service will be stuck in an activating state. It will continue to try and find an available host and open port until you edit the scale of this load balancer or [add additional hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/).

You will need to provide a **Name** and if desired, **Description** of the load balancer.

Next, you'll define the port rules for a load balancer. There are two types of port rules that can be created.

#### Service rule

The service rule defines the port rules for specific services in Rancher. These services must already be created in Rancher in order to be used in a service rule.

In the *Accesss* section, you will decide if this load balancer port will be accessible publicly (i.e. accessible outside of the host) or only internally in the environment. By default, Rancher has assumed you want the port to be public, but you can select `Internal` if you want the port to only be accessed by services within the same environment.

You can select the **Protocol**. If you choose to select a protocol that needs SSL termination, you will have to add in your certificates in the **SSL Termination** tab.

Next, you'll select the **request host**, **source port** and **path** for where the traffic will be coming from.

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
<br>

**Priority with Multiple Port Rules**

When there are multiple port rules for the same service, the order of priority is as follows:

1. Hostname with no wildcards and URL
2. Hostname with no wildcards
3. Hostname with wildcards and URL
4. Hostname with wildcards
5. URL
6. Default (no hostname, no URL)

##### Target Service and Port

For each rule, you select the specific **target** service to direct traffic to. Along with the service, you select the **port** for the service. This private port on the service is typically the exposed port on the image.

#### Selector rule

Selector rules allow you to add services into Rancher after the load balancer has been created. Services matching the selector will become a target in the load balancer.

You would define the [value of a selector label]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/labels/#selector-labels) for your selector as well as the **source port** for the selector.

When adding services into Rancher that will be picked up by a selector on a load balancer, you will need to add in the **target port**. You can optionally select what **hostname** and **path** for these selected services.

#### SSL Termination

The **SSL Termination** tab will provide the ability to add certificates. In the **Certificate** dropdown, you can select the main certificate for the load balancers.

To add a certificate to Rancher, please read about [how to add certificates in the **Infrastructure** tab]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/certificates/).

It is possible to provide multiple certificates for the load balancer such that the appropriate certificate is presented to the client based on the hostname requested (see [Server Name Indication](https://en.wikipedia.org/wiki/Server_Name_Indication)). This may not work with older clients which don't support SNI (those will get the main certificate). For modern clients, they will be offered the certificate from the list for which there is a match or the main certificate if there is no match.

#### Stickiness Policy for Load Balancers

You can select the **Stickiness** of the load balancer. Stickiness is the cookie policy that you want to use for when using cookies of the website.

The two options supported in Rancher are:

* **None**: This option means that no cookie policy is in place.
* **Create new cookie**: This option means that the cookie will be defined outside of your application. This cookie is what the load balancer would set on requests and responses. This cookie would determine the stickiness policy.

#### Custom haproxy.cfg

Since Rancher is using HAProxy software, we have allowed the ability to define your own configuration to your load balancer. Whatever you define in this section will be appended to the configuration generated by Rancher.

#### Labels/Scheduling Load Balancers

We provide the ability to add labels to load balancers and schedule where the load balancer will be launched. Read more details about labels and scheduling [here]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/#scheduling-options-in-the-ui).

### Adding a Load Balancer with Rancher Compose

We'll walk through how to set up a load balancer for our "letschat" application created earlier in the [adding services section]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#adding-services-with-rancher-compose).

Read more about how to [set up Rancher Compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/rancher-compose/).

We'll set up the same example that we used above in the UI example. To get started, you will need to create a `docker-compose.yml` file and a `rancher-compose.yml` file. With Rancher Compose, we can launch the load balancer.

#### Example `docker-compose.yml`

```yaml
version: '2'
services:
  letschatlb:
    ports:
    - 80
    image: rancher/lb-service-haproxy
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

A load balancer can be scheduled like any other service. Read more about [scheduling]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/#adding-labels-in-rancher-compose) services and load balancers using Rancher Compose.

Load balancing is configured with a combination of ports exposed on a host and a load balancer configuration, which can include specific port rules for each target service, custom configuration and stickiness policies.

When working with services that contains [sidekicks]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#sidekick-services), you need to use the [primary service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#primary-service) as a target service, which is the service that contains the `sidekick` label.

> **Note:** Load balancers will only work for services that are using the managed network. If you select any other network choice for your target services, it will **not** work with the load balancer.

### Source Ports

When creating a load balancer, you can add any ports you want exposed on the host. Any of these ports can be used as source ports in the port rules of a load balancer. If you want an internal load balancer, you would not expose any ports on the load balancer, and only add in port rules in the load balancer configuration.

> **Note:**  Port `42` cannot be used as a port for load balancers because it's internally used for [health checks]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/health-checks).

#### Example `docker-compose.yml`

```yaml
version: '2'
services:
  lb1:
    image: rancher/lb-service-haproxy
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
        protocol: http
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

Port rules are defined in the `rancher-compose.yml`. Since port rules are defined individually, there may be multiple port rules defined for the same service. By default, Rancher will prioritize these port rules based on a specific priority ordering. If you would like to change the ordering of the prioritization, you can also set specific [priority](#priority) order of the rules.

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

There are multiple protocol types that are supported in the Rancher HAProxy load balancer.

* `http` - By default, if no protocol is set, the load balancer uses `http`.
* `tcp`
* `https`
* `tls`
* `sni`
* `udp`

For `https` and `tls`, the [certificates]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/certificates/) must be added into Rancher. After they are added into Rancher, you select them in the load balancer configuration.

##### Service

The service that you want to place the load balancer in front of. If the service is in the same stack, then you use the service name. If the service is in a different stack, then you would use `<stack_name>/<service_name>`.

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

By default, Rancher prioritizes port rules targetting the same service, but if you wanted to, you could re-prioritize these targets by defining your own priority for the port rules.

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

Instead of targeting a specific service, you can set up a selector. By using selectors, you can add in services to Rancher after your load balancer has been created and have the load balancer automatically start targeting those services without having to edit your load balancer.

When using a selector in a load balancer, the `lb_config` would be set on the load balancer and any services that are matching the selector.

In the load balancer, the [value of a selector label]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/labels/#selector-labels) would be set in the `lb_config` under `selector`. The port rule in the `lb_config` of the load balancer can not have a service or target port. In the service that will be targeted, the target port must be set. If you choose to use hostname routing, the `hostname` and `path` would be set on the target service.

>**Note:** For any load balancers using the v1 load balancer yaml fields that uses selector labels will not be converted to the v2 load balancer as the port rules on the service would not be updated.

###### Example `docker-compose.yml`

```yaml
version: '2'
services:
  lb1:
    image: rancher/lb-service-haproxy
    ports:
    - 81
  web:
    image: nginx
    # This service will be picked up by the load balancer as a target as
    # the selector in the load balancer would pick up this service
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
  web:
    scale: 1
    lb_config:
      port_rules:
      - target_port: 80
        hostname: test.com    
```

##### Backend Name

If you want to explicitly label your backend in your load balancer configuration, you would use the `backend_name`.

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

For advanced users, you can specify custom configuration to the load balancer in the `rancher-compose.yml`. Please refer to the [HAProxy documentation](http://cbonte.github.io/haproxy-dconv/configuration-1.5.html) for details on the available options you can add for the Rancher's HAproxy load balancer.

##### Example `rancher-compose.yml`

```yaml
version: '2'
services:
  lb:
    scale: 1
    lb_config:
      config: <CustomConfig>
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
