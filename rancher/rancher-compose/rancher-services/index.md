---
title: Custom Rancher Services
layout: rancher-default

---

## Custom Rancher Services

Custom Rancher services are configured by using a special image name in the compose template.  The image name is how `rancher-compose` knows to set up a Rancher service versus a normal service.

Service | Image Name
--------|-----------
Load Balancer | rancher/load-balancer-service
External Service | rancher/external-service
Alias/DNS Service | rancher/dns-service

## Load Balancer

A load balancer can be scheduled like any other service. Read more about [scheduling]({{site.baseurl}}/rancher/rancher-compose/scheduling/) services and load balancers using `rancher-compose`.

Rancher supports L4 load balancing by adding ports and linking target services. Any traffic directed to any of source port(s) will be sent to the private port(s) of the linked service(s).

> **Note:**  Port `42` cannot be used as a source port for load balancers because it's internally used for [health checks]({{site.baseurl}}/rancher/concepts/health-checks). 

When working with services that contains [sidekicks]({{site.baseurl}}/rancher/rancher-compose/#sidekicks), you need to link the [primary service]({{site.baseurl}}/rancher/rancher-compose/#primary-service), which is the service that contains the `sidekick` label. 

> **Note:** Load balancers will only work for services that are using the managed network. If you select any other network choice for your target services, it will **not** work with the load balancer.

### Load Balancer Example (L4)

**Sample configuration** `docker-compose.yml`

```yaml
lb:
  image: rancher/load-balancer-service
  ports:
  # Listen on public port 80 and direct traffic to private port 80 of the service
  - 80
  # Listen on public port 82 and by default forward traffic to private port 81 using HTTP
  - 82:81
  # Listen on public port 9999 using TCP and not HTTP
  - 9999/tcp
  links: 
  # Target services in the same stack will be listed as a link
  - web1:web1
  - web2:web2
  external_links:
  # Target services in a different stack will be listed as an external link
  - differentstack/web3:web3
```

**Sample** `rancher-compose.yml`

```yaml
lb:
  # Two load balancer containers
  scale: 2
  load_balancer_config:
    name: lb config
web1:
  scale: 1
web2:
  scale: 1
web3: 
  scale: 1
```

### Advanced Load Balancing (L7)

We also support L7 load balancing with advanced routing options, which include using host headers, host paths and specific target ports. We go into more detail on [advanced routing options]({{site.baseurl}}/rancher/rancher-ui/applications/stacks/adding-balancers/#advanced-routing-optons) for load balancers in our UI section, but anything that we can create in Rancher can be created using `rancher-compose`.

Advanced routing options use `labels` in the `docker-compose.yml` file. Here's the basic syntax for applying the label. You would only use this label if you were going to do some advanced routing rules. Advanced routing rules are optional and all of the fields  are optional as well. This syntax shows if you were to use all the options.

Label Key | Label Value
---| ---
`io.rancher.loadbalancer.target.SERVICE_NAME` | `REQUEST_HOST:SOURCE_PORT/REQUEST_PATH=TARGET_PORT`

> **Note:** If you use a source port with the advanced routing options, the source port must also be listed in `ports` section of the `docker-compose.yml`

#### Linking Services in a Different Stack 

In the label for target services, `SERVICE_NAME` is the name of the service regardless of which stack the service is in. You will need to make sure that there are no target services with the same names across stacks in order for the load balancer to work correctly. 

For any services in a different stack, the link to the target service will be under `external_links`. In the example, see `web3`

#### Syntax of the Combination of all Optional Fields 

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
**Note:** It is assumed that if you have only a port in the label, then the port is for the target port of the service. When using only a target port, it must be surrounded by single quotes.

**Wildcards**

Rancher supports wildcards when adding host based routing. The following wildcard syntax is supported.

```
*.domain.com -> hdr_end(host) -i .domain.com
domain.com.* -> hdr_beg(host) -i domain.com.
```

#### Multiple Routing Rules for the Same Service

In `rancher-compose`, you can configure multiple hostname routing rules to the same service by separating each rule with a comma. See the example for service `web2`.

**Priority**

When there are multiple hostname routing rules, the order of priority is as follows:

1. Hostname and URL
2. Hostname only
3. URL
4. Default (no hostname, no URL)


#### Load Balancer Example (L7)

**Sample configuration** `docker-compose.yml`

```yaml
lb:
  image: rancher/load-balancer-service
  ports:
  # Listen on public port 80 and direct traffic to private port 80 of the service
  - 80
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
    io.rancher.loadbalancer.target.web3: 82=8000
```

**Sample** `rancher-compose.yml`

```yaml
lb:
  # Two load balancer containers
  scale: 2
  load_balancer_config:
    name: lb config
web1:
  scale: 1
web2:
  scale: 1
web3: 
  scale: 1
```

### Internal Load Balancer 

To set an internal load balancer, the listening ports are listed under `expose` instead of `ports`.

**Sample configuration** `docker-compose.yml`

```yaml
lb:
  image: rancher/load-balancer-service
  # Instead of using ports, we use expose to define that it will be private ports
  expose: 
  # Listen on private port 80 and direct traffic to private port 80 of the service
  - 80
  # Listen on private port 82 and by default forward traffic to private port 81 using HTTP
  - 82:81
  links: 
  # Any service that is a target will be listed as a link
  - web1:web1
 ```

**Sample** `rancher-compose.yml`

```yaml
lb:
  # Two load balancer containers
  scale: 2
  load_balancer_config:
    name: lb config
web1:
  scale: 1
```

### Custom haproxy.cfg

_Available as of v0.50.0+_

For advanced users, you can specify `global` and `defaults` configuration to the load balancer in the `rancher-compose.yml`. Please refer to the [HAProxy documentation](http://cbonte.github.io/haproxy-dconv/configuration-1.5.html) for details on the available options you can add. 

**Sample `rancher-compose.yml`**

```
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

## External Service

With external services, you can set either external IP(s) **OR** a domain name.  

**Sample configuration** `docker-compose.yml`

```yaml
db:
  image: rancher/external-service

redis:
  image: redis
```

**Sample** `rancher-compose.yml` using external IPs

```yaml
db:
  external_ips:
  - 1.1.1.1
  - 2.2.2.2

# Override any service to become an external service
redis:
  image: redis
  external_ips:
  - 1.1.1.1
  - 2.2.2.2
```

**Sample** `rancher-compose.yml` using hostname

```yaml
db:
  hostname: example.com
```

## Service Alias/DNS service

**Sample configuration** `docker-compose.yml`

```yaml
web:
  image: rancher/dns-service
  links:
  - web1
  - web2

web1:
  image: nginx

web2:
  image: nginx
```

## Health Check for Services

Rancher implements a distributed health monitoring system by running an HAProxy instance on every host for the sole purpose of providing health checks to containers.  When health checks are enabled either on an individual container or a service,  each container is then monitored by up to three HAProxy instances running on different hosts. The container is considered healthy if at least one HAProxy instance reports a "passed" health check.

Rancher’s approach handles network partitions and is more efficient than client-based health checks. By using HAProxy to perform health checks, Rancher enables users to specify the same health check policy for DNS service and for load balancers.

> **Note:** Health checks will only work for services that are using the managed network. If you select any other network choice, it will **not** be monitored.

To enable health checks for services, we add the health check in the `rancher-compose.yml` file.

```yaml
wordpress:
  scale: 1
  health_check:
    port: 80
    # Interval is measured in milliseconds
    interval: 2000
    unhealthy_threshold: 3
    # For TCP, request_line needs to be ''
    # TCP Example: 
    # request_line: ''
    request_line: GET /healthcheck HTTP/1.0
    healthy_threshold: 2
    # Response timeout is measured in milliseconds
    response_timeout: 2000
```

More details about Health Checks can be read in the [concept section]({{site.baseurl}}/rancher/concepts/health-checks/).
