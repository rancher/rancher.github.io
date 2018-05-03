---
title: Internal DNS Service in Cattle Environments
layout: rancher-default-v1.4
version: v1.4
lang: en
---

## Internal DNS Service in Cattle Environments
---

Within Rancher, we have our own internal DNS service that allows all services within one [cattle environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/) to resolve to any other in the environment.

All services in the stack are resolvable by `<service_name>` and there is no need to set a service link between the services. When creating services, you can define **Service Links** to link services together. For any services that are in a different stack, you'd resolve by `<service_name>.<stack_name>` instead of just `<service_name>`. If you would like to resolve a service by a different name, you could set a service link so that the service could be resolvable by the service alias.

### Setting Service Alias via linking

In the UI, when [adding a service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#adding-services-in-the-ui), expand the **Service Links** section, select the service, and provide the alias name.

If you're using Rancher Compose to [add the service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#adding-services-with-rancher-compose), the `docker-compose.yml` would use either the `links` or `external_links` directive.

```yaml
version: '2'
services:
  service1:
    image: wordpress
    # If the other service is in the same stack
    links:
    # <service_name>:<service_alias>
    - service2:mysql
    # If the other service is in a different stack
    external_links:
    # <stackname>/<service_name>:<service_alias>
    - Default/service3:mysql
```

### Sidekicks and Linking

When launching a service, you may require services to be launched together on the same host all the time. Specific use cases include when trying to use a `volumes_from` or `net` from another service. When creating a [sidekick relationship]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#sidekick-services), the services are automatically resolvable to each other by their name. We currently do not support creating a service alias via links/external_links inside a sidekick service.

When creating a sidekick relationship, there is always a primary service and sidekick service(s). Together, they are considered as a single launch configuration. This launch configuration would be deployed onto a host as a group of containers, 1 from the primary service and 1 from each sidekick defined. Within any service in the launch configuration, you can resolve the primary and sidekick(s) by their names. For any service outside of the launch configuration, the primary service is resolvable by name, but the sidekick services are only resolvable by `<sidekick_name>.<primary_service_name>`.

### Container Names

All containers are resolvable globally by their name as every service's container name is unique within each environment. There is no need to append service name or stack name.

### Examples

#### Pinging Services in the Same Stack

If you exec into the shell of a container, you are able to ping other services in the same stack by the service name.

In our example, there is a stack named `stackA` with two services, `foo` and `bar`.

After execing into one of the containers in the `foo` service, you can ping the `bar` service.

```bash
$ ping bar
PING bar.stacka.rancher.internal (10.42.x.x) 58(84) bytes of data.
64 bytes from 10.42.x.x: icmp_seq=1 ttl=62 time=1.63 ms
64 bytes from 10.42.x.x: icmp_seq=2 ttl=62 time=1.13 ms
64 bytes from 10.42.x.x: icmp_seq=3 ttl=62 time=1.07 ms
```

#### Pinging Services in a Different Stack

For services that are in different stacks, you can ping the services in a different stack by using `<service_name>.<stack_name>`.

In our example, we have a stack called `stackA`, which contains a service called `foo`, and we also have a stack called `stackB`, which contains a service called `bar`.

If we exec into one of the containers in the `foo` service, you can ping the `bar` service with `bar.stackb`.

```bash
$ ping bar.stackb
PING bar.stackb (10.42.x.x) 56(84) bytes of data.
64 bytes from 10.42.x.x: icmp_seq=1 ttl=62 time=1.43 ms
64 bytes from 10.42.x.x: icmp_seq=2 ttl=62 time=1.15 ms
64 bytes from 10.42.x.x: icmp_seq=3 ttl=62 time=1.27 ms
```

#### Pinging Sidekick Services

Depending on which service you ping from, you can reach a sidekick service by either `<sidekick_name>` or `<sidekick_name>.<primary_service_name>`.

In our example, we have a stack called `stackA`, which contains a service called `foo`, which has a sidekick `bar` and a service called `hello`. We also have a stack called `stackB`, which contains a service `world`.

If we exec into one of the containers in the `foo` service, you can ping the `bar` service directly by its name.

```bash
# Inside  one of the containers in the `foo` service, which `bar` is a sidekick to.
$ ping bar
PING bar.foo.stacka.rancher.internal (10.42.x.x) 56(84) bytes of data.
64 bytes from 10.42.x.x: icmp_seq=1 ttl=64 time=0.060 ms
64 bytes from 10.42.x.x: icmp_seq=2 ttl=64 time=0.111 ms
64 bytes from 10.42.x.x: icmp_seq=3 ttl=64 time=0.114 ms
```

If we exec into one of the containers in the `hello` service, which is in the same stack, you can ping the `foo` service by `foo` and the `bar` sidekick service by `bar.foo`.

```bash
# Inside one of the containers in the `hello` service, which is not part of the service/sidekick service
# Ping the primary service (i.e. foo)
$ ping foo
PING foo.stacka.rancher.internal (10.42.x.x) 56(84) bytes of data.
64 bytes from 10.42.x.x: icmp_seq=1 ttl=62 time=1.04 ms
64 bytes from 10.42.x.x: icmp_seq=2 ttl=62 time=1.40 ms
64 bytes from 10.42.x.x: icmp_seq=3 ttl=62 time=1.07 ms
# Ping the sidekick service (i.e. bar)
$ ping bar.foo
PING bar.foo (10.42.x.x) 56(84) bytes of data.
64 bytes from 10.42.x.x: icmp_seq=1 ttl=62 time=1.01 ms
64 bytes from 10.42.x.x: icmp_seq=2 ttl=62 time=1.12 ms
64 bytes from 10.42.x.x: icmp_seq=3 ttl=62 time=1.05 ms
```

If we exec into one of the containers in the `world` service, which is in a different stack, you can ping the `foo` service by `foo.stacka` and the `bar` sidekick service by `bar.foo.stacka`.

```bash
# Inside one of the containers in the `world` service, which is in a different stack
# Ping the primary service (i.e. foo)
$ ping foo.stacka
PING foo.stacka (10.42.x.x) 56(84) bytes of data.
64 bytes from 10.42.x.x: icmp_seq=1 ttl=62 time=1.13 ms
64 bytes from 10.42.x.x: icmp_seq=2 ttl=62 time=1.05 ms
64 bytes from 10.42.x.x: icmp_seq=3 ttl=62 time=1.29 ms
# Ping the sidekick service (i.e. bar)
$ ping bar.foo.stacka
PING bar.foo.stacka (10.42.x.x) 56(84) bytes of data.
64 bytes from 10.42.x.x: icmp_seq=1 ttl=62 time=1.23 ms
64 bytes from 10.42.x.x: icmp_seq=2 ttl=62 time=1.00 ms
64 bytes from 10.42.x.x: icmp_seq=3 ttl=62 time=0.994 ms
```

#### Pinging Container Name

From any container, you can ping another container in the environment by their name regardless if they are in a different stack or service.

In our example, we have a stack called `stackA`, which contains a service called `foo`. We also have another stack called `stackB`, which contains a service called `bar`. The names of containers are `<stack_name>_<service_name>_<number>`.

If we exec into one of the containers in the `foo` service, you can ping the container in the `bar` service.

```bash
$ ping stackB_bar_1
PING stackB_bar_1.rancher.internal (10.42.x.x): 56 data bytes
64 bytes from 10.42.x.x: icmp_seq=1 ttl=62 time=1.994 ms
64 bytes from 10.42.x.x: icmp_seq=2 ttl=62 time=1.090 ms
64 bytes from 10.42.x.x: icmp_seq=3 ttl=62 time=1.100 ms
```
