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

### Load Balancer

A load balancer can be scheduled like any other service. Read more about [scheduling]({{site.baseurl}}/rancher/rancher-compose/scheduling/) services and load balancers using `rancher-compose`.

Rancher supports L4 load balancing by adding ports and linking services. Any traffic directed to any of source port(s) will be sent to the private port(s) of the linked service(s).

We also support L7 load balancing with advanced routing options, which include using host headers, host paths and specific target ports. We go into more detail on [advanced routing options]({{site.baseurl}}/rancher/rancher-ui/applications/stacks/adding-balancers/#advanced-routing-optons) for load balancers in our UI section, but anything that we can create in Rancher can be created using `rancher-compose`.

Advanced routing options use `labels` in the `docker-compose.yml` file. Here's the basic syntax for applying the label. You would only use this label if you were going to do some advanced routing rules. Advanced routing rules are optional and all of the fields  are optional as well. This syntax shows if you were to use all the options.

Label Key | Label Value
---| ---
`io.rancher.loadbalancer.target.SERVICE_NAME` | `REQUEST_HOST:SOURCE_PORT/REQUEST_PATH=TARGET_PORT`

> **Note:** If you use a source port with the advanced routing options, the source port must also be listed in `ports` section of the `docker-compose.yml`

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

In `rancher-compose`, you can configure multiple hostname routing rules to the same service by separating each rule with a comma. See example below for service `web2`.

**Load Balancer Sample configuration** `docker-compose.yml`

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
  # Any service that is a target will be listed as a link
  - web1:web1
  - web2:web2
  - web3:web3
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

#### Internal Load Balancer 

To set an internal load balancer, the listening ports are listed under `expose` instead of `ports`.

**Internal Load Balancer Sample configuration** `docker-compose.yml`

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


### External Service

In external services, you can set either external IP(s)s or a domain name. With external services, you can only set either an external IP(s) OR a domain name. 

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

### Service Alias/DNS service

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
