---
title: Adding Load Balancers
layout: rancher-default-v1.1
version: v1.1
lang: en
redirect_from:
  - /rancher/v1.1/en/rancher-ui/applications/stacks/adding-balancers/
  - /rancher/v1.1/zh/rancher-ui/applications/stacks/adding-balancers/
  - /rancher/v1.1/zh/cattle/adding-load-balancers/
---

## Adding Load Balancers
---

Rancher implements a managed load balancer using HAProxy that can be manually scaled to multiple hosts.  A load balancer can be used to distribute network and application traffic to individual containers by directly adding them or "linked" to a basic service.  A basic service that is "linked" will have all its underlying containers automatically registered as load balancer targets by Rancher.

After adding multiple services to your stack, you might have decided that you want to load balance your web applications. With Rancher, it's easy to add a load balancer to your stack. We'll review the options for our load balancer as if you were using the UI and show examples using the [UI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/#adding-a-load-balancer-in-the-ui) and [Rancher Compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/#adding-a-load-balancer-with-rancher-compose).

### Load Balancer Options in the UI

Our load balancer has HAProxy software installed on the load balancer agent containers. The load balancer uses a round robin algorithm from HAProxy to select the target services.

> **Note:** Load balancers will only work for services that are using the managed network. If you select any other network choice for your target services, it will **not** work with the load balancer.

You add a load balancer by clicking the dropdown icon next to the **Add Service** button and selecting **Add Load Balancer**.

You can use the slider to select the scale, i.e. how many containers of the load balancer. Alternatively, you can select **Always run one instance of this container on every host**. With this option, your load balancer will scale for any additional hosts that are added to your [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/). If you have scheduling rules in the **Scheduling** section, Rancher will only start containers on the hosts that meet the host labels rules. If you add a host to your environment that doesn't meet the scheduling rules, a container will not be started on the host. Please select the "Always run one instance of this container on every host".

> **Note:** The scale of the load balancer cannot exceed the number of hosts in the environment, otherwise there will be a port conflict and the load balancer service will be stuck in an activating state. It will continue to try and find an available host and open port until you edit the scale of this load balancer or [add additional hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/).

You will need to provide a **Name** and if desired, **Description** of the load balancer.

Next, you'll define the listening ports of the load balancer. The **source port** is the port that is exposed on the host. You can select the **Protocol** and decide if you want to use **SSL** termination for that port. The **target port** is the exposed port on a container that traffic will be directed to. If no target port is defined, the source port will also be used as the target port.

In the *Accesss* section, you will decide if this load balancer port will be accessible publicly (i.e. accessible outside of the host) or only internally on the host.

> **Note:** Port `42` cannot be used as a source port for load balancers because Rancher uses this port for [health checks]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/health-checks).

#### Basic Load Balancing

Rancher supports L4 load balancing by simply adding listening ports and linking target services. We can add as many listening ports and services as we'd like. We've made the assumption that the access is set as `public` for every listening ports. The source port(s) of the load balancer will use the round robin algorithm to forward traffic to **all service(s)**.

#### Example:

When we set up 2 listening ports and 3 services, the load balancer will direct traffic on both listening ports across all services.

Source Port | Target Port
---|---
`80` | `8080`
`81` | `8081`

<br>

|Target Services|
|---|
|Service1|
|Service2|
|Service3|

<br>
In our example, any traffic directed to port `80` on the host of the load balancer would get round robin-ed to  Service1, Service2, Service3 on the target port `8080` and `8081`. Any traffic directed to port `81` on the host of the load balancer would get round robin-ed to Service1, Service2, Service3 on port `8080` and `8081`.

#### Internal Load Balancing

You will have the option to not publish source ports to the host by setting the access level of each individual “Listening Port” to `Internal`.  All internal ports can only be accessed by services within the same environment.

#### Advanced Routing Options

Rancher supports L7 load balancing with our advanced routing options. To expand the advanced options, click on the **Show advanced routing options**. The only required field is **Target Service**, which would be the equivalent of L4 load balancing. All of the other fields for L7 load balancing are optional. Since all the fields are optional, the listening ports are default when adding host/request paths, and the ports will be overridden if you specify source/target ports for a service. For each option, we cover some basic examples, but you can use all or some of these options together to define exactly how you want your load balancer to direct traffic to your services.

##### Request Host/Request Path

The request host can be a specific HTTP host header used for each service. The request path can be a specific path. The request host and request path can be used independently or in conjunction to create a specific request.

**Example:**

```
domain1.com -> Service1
domain2.com -> Service2

domain3.com -> Service1
domain3.com/admin -> Service2
```

Since source/target ports are optional, the listening ports are used as defaults to direct traffic based on the request. If a source port is defined, traffic coming to a specific host header/path will need to match a specific rule in order to be directed to the target.

**Wildcards**

Rancher supports wildcards when adding host based routing. The following wildcard syntax is supported.

```
*.domain.com -> hdr_end(host) -i .domain.com
domain.com.* -> hdr_beg(host) -i domain.com.
```
<br>

**Priority with Multiple Hostname Routing Rules**

When there are multiple hostname routing rules, the order of priority is as follows:

1. Hostname with no wildcards and URL
2. Hostname with no wildcards
3. Hostname with wildcards and URL
4. Hostname with wildcards
5. URL
6. Default (no hostname, no URL)

##### Target Port

For each service, you can override the target port defined in the listening port section. This would allow you to direct traffic to services on different ports from the same source port.

**Example**

Source Port| Default Target Port
---|---
80 | 80

<br>

|Target Services| Target Ports|
|---| ---|
|Service1| None|
|Service2 | `90`|

<br>
In our example above, the load balancer will direct traffic to different ports depending on the service. Since the load balancer is using a round robin algorithm, any traffic to the source port `80` will be directed alternatively between the services. When traffic is being directed to Service1, it will use the default target port `80`. When traffic is directed to Service2, it will use the target port `90`, that was defined with Service2.

##### Source Port

For any source port defined in in the listening port section, you can create specific routes for services. This might be helpful if you had multiple source ports and want to direct traffic differently for each source port. You would only add a source port if you also have defined a request host/path or target port.

> **Note:** If you choose a source port in the advanced section, you must add it in the listening ports section.

#### SSL Termination

To add SSL termination to your load balancer, you can enable the **SSL** checkbox for your listening port. When you enable the checkbox, the **SSL Termination** tab will provide the ability to add certificates. In the **Certificate** dropdown, you can select the main certificate for the load balancers.

To add a certificate to Rancher, please read about [how to add certificates in the **Infrastructure** tab]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/certificates/).

For example, if you were load balancing a web server and wanted both `http` and `https` being served on ports 80 and 443 respectively, you would do the following:

1. [Add a certificate to the infrastructure]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/certificates/).
2. Create the load balancer service.
3. In the *Listening Ports* section of the screen, create an entry to map the incoming port 80, with the `http` protocol and SSL _unchecked_.
4. And then add another port mapping the incoming port 443, `http` protocol and SSL _checked_.
5. In the *SSL Termination* section, select the certificate to use for the SSL port.

It is possible to provide multiple certificates for the load balancer such that the appropriate certificate is presented to the client based on the hostname requested (see [Server Name Indication](https://en.wikipedia.org/wiki/Server_Name_Indication)). This may not work with older clients which don't support SNI (those will get the main certificate). For modern clients, they will be offered the certificate from the list for which there is a match or the main certficate if there is no match.

#### Stickiness Policy for Load Balancers

You can select the **Stickiness** of the load balancer. Stickiness is the cookie policy that you want to use for when using cookies of the website.

The two options supported in Rancher are:

* **None**: This option means that no cookie policy is in place.
* **Create new cookie**: This option means that the cookie will be defined outside of your application. This cookie is what the load balancer would set on requests and responses. This cookie would determine the stickiness policy.

#### Custom haproxy.cfg

Since Rancher is using HAProxy software, we have allowed the ability to define your own `global` and `defaults` configuration to your load balancer. Whatever you define in these sections will be appended to the configuration generated by Rancher.

#### Labels/Scheduling Load Balancers

We provide the ability to add labels to load balancers and schedule where the load balancer will be launched. Read more details about labels and scheduling [here]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/#scheduling-options-in-the-ui).

### Adding a Load Balancer in the UI

We'll walk through how to set up a load balancer for our "letschat" application created earlier in the [adding services section]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#adding-services-in-the-ui).

First, you start by creating a load balancer, by clicking on the dropdown icon next to "Add Service" and clicking **Add Load Balancer**. By default, the scale will be of 1 container. Provide a name like "LetsChatLB". For the listening ports section, use a source port of `80`, use the default `http` protocol, use a target port of `8080`, and use the default `Public` access.

Next, let's add our targets for our load balancer. We can select the "letschat" service and click on **Save**.

Now, let's see the load balancer in action. In the stack view, there is a link to  port `80` that you've used as the source port for your load balancer. If you click on it, it will automatically bring up a new tab in your browser and point to one of the hosts that has the load balancer launched. The request is re-directed to one of the "LetsChat" containers. If you were to refresh, the load balancer would redirect the new request to the other container in the "letschat" service as we use the round robin algorithm to distribute traffic to the targetted services.

### Load Balancer Options in Rancher Compose

A load balancer can be scheduled like any other service. Read more about [scheduling]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/#adding-labels-in-rancher-compose) services and load balancers using Rancher Compose.

Rancher supports L4 load balancing by adding ports and linking target services. Any traffic directed to any of source port(s) will be sent to the private port(s) of the linked service(s).

> **Note:**  Port `42` cannot be used as a source port for load balancers because it's internally used for [health checks]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/health-checks).

When working with services that contains [sidekicks]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#sidekick-services), you need to link the [primary service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#primary-service), which is the service that contains the `sidekick` label.

> **Note:** Load balancers will only work for services that are using the managed network. If you select any other network choice for your target services, it will **not** work with the load balancer.

#### Load Balancer Example (L4)

##### Example `docker-compose.yml`

```yaml
lb:
  image: rancher/load-balancer-service
  ports:
  # Assign a random public port and direct traffic to private port 80 of the service.
  - 80
  # Listen on public port 80 and direct traffic to private port 80 of the service
  - 80:80
  # Listen on public port 82 and by default forward traffic to private port 81 using HTTP
  - 82:81
  # Assign a random public port and direct traffic to private port 9999 using TCP and not HTTP
  - 9999/tcp
  links:
  # Target services in the same stack will be listed as a link
  - web1:web1
  - web2:web2
  external_links:
  # Target services in a different stack will be listed as an external link
  - differentstack/web3:web3
```

##### Example `rancher-compose.yml`

```yaml
lb:
  # Two load balancer containers
  scale: 2
  load_balancer_config:
    name: lb config
  health_check:
    port: 42
    interval: 2000
    unhealthy_threshold: 3
    healthy_threshold: 2
    response_timeout: 2000
web1:
  scale: 1
web2:
  scale: 1
web3:
  scale: 1
```

#### Advanced Load Balancing (L7)

We also support L7 load balancing with advanced routing options, which include using host headers, host paths and specific target ports. Advanced routing options use `labels` in the `docker-compose.yml` file.


Here's the basic syntax for applying the label. You would only use this label if you were going to do some advanced routing rules. Advanced routing rules are optional and all of the fields  are optional as well. This syntax shows if you were to use all the options.

Label Key | Label Value
---| ---
`io.rancher.loadbalancer.target.<SERVICE_NAME>` | `<REQUEST_HOST>:<SOURCE_PORT>/<REQUEST_PATH>=<TARGET_PORT>`

<br>

> **Note:** If you use a source port with the advanced routing options, the source port must also be listed in `ports` section of the `docker-compose.yml`

##### Linking Services in a Different Stack

In the label for target services, `<SERVICE_NAME>` is the name of the service. If your service is in another stack, the `<SERVICE_NAME>` will need to include stack name using the following format `<STACK_NAME>/<SERVICE_NAME>`. The link to the target service of other stacks will be under `external_links`.

##### Syntax of the Combination of all Optional Fields

Since the fields are optional, we support all combinations of the fields. Here is the syntax for all combinations using request host, source port, path and target port.

Request Host | Source Port | Path | Target Port | Label Value
---|---|---|---| ---
example.com | 80 | /path | 81 | `example.com:80/path=81`
example.com | 80 | /path/a | | `example.com:80/path/a`
example.com | 80||81 | `example.com:80=81`
example.com |80 | | | `example.com:80`
example.com | | /path/b/c | 81 | `example.com/path/b/c=81`
example.com | | /path | | `example.com/path`
example.com| | | 81 | `example.com=81`
example.com | | | | `example.com`
| 80| /path | 81 | `80/path=81`
| 80 |/path | | `80/path`
|80 | | 81 | `80=81`
| | /path | 81| `/path=81`
| | /path | | `/path`
| | | 81 | `'81'` *See Note

<br>

> **Note:** It is assumed that if you have only a port in the label, then the port is for the target port of the service. When using only a target port, it must be surrounded by single quotes.

**Wildcards**

Rancher supports wildcards when adding host based routing. The following wildcard syntax is supported.

```
*.domain.com -> hdr_end(host) -i .domain.com
domain.com.* -> hdr_beg(host) -i domain.com.
```

##### Multiple Routing Rules for the Same Service

In Rancher Compose, you can configure multiple hostname routing rules to the same service by separating each rule with a comma. See the example for service `web2`.

**Priority**

When there are multiple hostname routing rules, the order of priority is as follows:

1. Hostname and URL
2. Hostname only
3. URL
4. Default (no hostname, no URL)

#### Load Balancer Example (L7)

##### Example `docker-compose.yml`

```yaml
lb:
  image: rancher/load-balancer-service
  ports:
  # Listen on public port 80 and direct traffic to private port 80 of the service
  - 80:80
  # Listen on public port 82 and by default forward traffic to private port 81 using HTTP
  - 82:81
  # Listen on public port 9999 using TCP and not HTTP
  - 9999/tcp
  links:
  # Target services in the same stack will be listed as a link
  - web1:web1a
  - web2:web2a
  external_links:
  # Target services in a different stack will be listed as an external link
  - differentstack/web3:web3a
  labels:
    # Put load balancer containers on hosts with label lb=true
    io.rancher.scheduler.affinity:host_label: lb=true
    # Requests to http://app.example.com/foo:80 should be routed to web1 over port 8000
    io.rancher.loadbalancer.target.web1: app.example.com:80/foo=8000
    # Requests to http://app.example.com/foo should be routed to web2 over port 8000
    # and http://app.example.com/foo/bar over port 8001
    io.rancher.loadbalancer.target.web2: app.example.com/foo=8000,app.example.com/foo/bar=8001
    # Requests routed to web3 go to port 8000, overriding the default configuration
    # of 82:81
    io.rancher.loadbalancer.target.differentstack/web3: 82=8000
```

##### Example `rancher-compose.yml`

```yaml
lb:
  # Two load balancer containers
  scale: 2
  load_balancer_config:
    name: lb config
  health_check:
    port: 42
    interval: 2000
    unhealthy_threshold: 3
    healthy_threshold: 2
    response_timeout: 2000
web1:
  scale: 1
web2:
  scale: 1
web3:
  scale: 1
```

##### Examples of Using Multiple Ports in Advanced Routing Options

Regardless of the priority, every service specified on the load balancer is registered for every load balancer listening port.

Example:

```yaml
lb-test:
  ports:
  - 80:80
  - 81:81
  labels:
    io.rancher.loadbalancer.target.service1: 80=80
    io.rancher.loadbalancer.target.service2: 81=81
  tty: true
  image: rancher/load-balancer-service
  links:
  - service1:service1
  - service2:service2
  stdin_open: true
```

In our example, with hostname routing rules, every service is still registered for all the ports listed in `ports`. This is by design as we originally had only supported L4 load balancing. In order to force the traffic to only be service specific, you will need to include some dummy hostname routing rules to exclude the unneeded target service from the specific port.

```yaml
lb-test:
  ports:
  - 80:80
  - 81:81
  labels:
    io.rancher.loadbalancer.target.service1: 80=80
    # Add in dummy rule for service1 to force the traffic coming to 81 to not be redirected to service1
    io.rancher.loadbalancer.target.service1: dummy1:81=81
    io.rancher.loadbalancer.target.service2: 81=81
    # Add in dummy rule for service2 to force the traffic coming to 80 to not be redirected to service1
    io.rancher.loadbalancer.target.service2: dummy2:80=80
  tty: true
  image: rancher/load-balancer-service
  links:
  - service1:service1
  - service2:service2
  stdin_open: true
```

#### Internal Load Balancer

To set an internal load balancer, the listening ports are listed under `expose` instead of `ports`.

##### Example `docker-compose.yml`

```yaml
lb:
  image: rancher/load-balancer-service
  # Instead of using ports, we use expose to define that it will be private ports
  expose:
  # Listen on private port 80 and direct traffic to private port 80 of the service
  - 80:80
  # Listen on private port 82 and by default forward traffic to private port 81 using HTTP
  - 82:81
  links:
  # Any service that is a target will be listed as a link
  - web1:web1
```

<br>

##### Example  `rancher-compose.yml`

```yaml
lb:
  # Two load balancer containers
  scale: 2
  load_balancer_config:
    name: lb config
  health_check:
    port: 42
    interval: 2000
    unhealthy_threshold: 3
    healthy_threshold: 2
    response_timeout: 2000
web1:
  scale: 1
```

<br>

#### SSL Termination

Rancher Compose uses labels to define the SSL ports to be used in SSL termination. The [certificates]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/certificates/) must be added into Rancher and are defined in the `rancher-compose.yml`.

##### Example `docker-compose.yml`

```yaml
lb:
  ports:
  - 443:443
  labels:
    io.rancher.loadbalancer.ssl.ports: '443'
  image: rancher/load-balancer-service
  links:
  - web1:web1
```

<br>

##### Example `rancher-compose.yml`

```yaml
lb:
  scale: 1
  certs:
  - certName
  load_balancer_config:
    name: lb
  default_cert: defaultCertName
```

#### Custom `haproxy.cfg`

For advanced users, you can specify `global` and `defaults` configuration to the load balancer in the `rancher-compose.yml`. Please refer to the [HAProxy documentation](http://cbonte.github.io/haproxy-dconv/configuration-1.5.html) for details on the available options you can add.

##### Example `rancher-compose.yml`

```yaml
lb:
  scale: 1
  load_balancer_config:
    haproxy_config:
      defaults: <DEFAULTS_INPUTS>
      global: <GLOBAL_INPUTS>
  health_check:
    port: 42
    interval: 2000
    unhealthy_threshold: 3
    healthy_threshold: 2
    response_timeout: 2000
```

### Adding a Load Balancer with Rancher Compose

We'll walk through how to set up a load balancer for our "letschat" application created earlier in the [adding services section]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#adding-services-with-rancher-compose).

Read more about how to [set up Rancher Compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/rancher-compose/).

We'll set up the same example that we used above in the UI example. To get started, you will need to create a `docker-compose.yml` file and a `rancher-compose.yml` file. With Rancher Compose, we can launch the load balancer.

#### Example `docker-compose.yml`

```yaml
letschatlb:
  ports:
  - 80:8080
  image: rancher/load-balancer-service
  links:
  - letschat:letschat
```

#### Example `rancher-compose.yml`

```yaml
letschatlb:
  scale: 1
  load_balancer_config:
    haproxy_config: {}
  health_check:
    port: 42
    interval: 2000
    unhealthy_threshold: 3
    healthy_threshold: 2
    response_timeout: 2000
```
