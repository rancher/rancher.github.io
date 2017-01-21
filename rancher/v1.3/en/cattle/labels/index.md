---
title: Labels
layout: rancher-default-v1.3
version: v1.3
lang: en
redirect_from:
  - /rancher/v1.3/zh/cattle/labels/
---

## Labels
---

Rancher uses labels on services/containers and hosts to help manage different features of Rancher.

### Rancher Compose Labels for Services

Labels are used to help Rancher start up services and leverage the features of Rancher. This index of labels are used to help users create services using Rancher Compose. There are UI equivalents of these labels that should be used instead of adding labels to a service.

Key | Value |Description
----|-----|---
`io.rancher.sidekicks` | Service Names  | Used to define what services are [sidekicks]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#sidekick-services)
`io.rancher.loadbalancer.target.SERVICE_NAME` | `REQUEST_HOST:SOURCE_PORT/REQUEST_PATH=TARGET_PORT` |Used to determine [L7 Load Balancing]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/#advanced-load-balancing-l7)
`io.rancher.container.dns`| `true` | Service is able to use Rancher DNS based service discovery to resolve other services and to be resolved by other services. This label is required if you require DNS, when networking is set to `host`.
`io.rancher.container.hostname_override` | `container_name` | Used to set the hostname of the container to the name of the container (e.g. StackName_ServiceName_CreateIndex)
`io.rancher.container.start_once` |`true` | Used to run a container once and have it remain in stopped state while the service remains in `active` state
`io.rancher.container.pull_image` | `always` | Used to always pull a new image before deploying container.
`io.rancher.container.requested_ip` | An IP from the 10.42.0.0/16 address space | Allows you to pick a specific IP for a container. Note: If the IP is not available on any host, container will start with a random IP.
`io.rancher.container.dns.priority` | `service_last` | Use the DNS search path of the host before the service domain. This will place the `*.rancher.internal` search after the search from the hosts `/etc/resolv.conf`.
`io.rancher.service.selector.container` |  [_Selector Label_ Values]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/labels/#selector-labels) | Used on a service so that  standalone containers can be selected to join the service DNS. Note: As standalone containers, none of the service actions will affect the standalone container (i.e. deactivate/delete/edit service, healthcheck, etc).
`io.rancher.service.selector.link` | [_Selector Label_ Values]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/labels/#selector-labels) | Used on a service to allow  services to be linked to the service based on service labels. Example: Service1 has a label `io.rancher.service.selector.link: foo=bar`. Any services that are added to Rancher that have a `foo=bar` label will automatically be linked to Service1.
`io.rancher.scheduler.global` | `true` | Used to set [global services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/#global-service)
`io.rancher.scheduler.affinity:host_label` | Key Value Pair of Host Label| Used to schedule containers on hosts based on [host label]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/#finding-hosts-with-host-labels)
`io.rancher.scheduler.affinity:container_label` | Key Value Pair of Any Container Label | Used to schedule containers on hosts based on [container label or service name]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/#finding-hosts-with-container-labels)
`io.rancher.scheduler.affinity:container` | Name of Container | Used to schedule containers on hosts based on [container name]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/#finding-hosts-with-container-names)

<br>

> **Note:** For the labels prefixed with `io.rancher.scheduler.affinity`, there are slight variations based on your how want to match (i.e. equal or not equal, hard or soft rules). More details can be found [here]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/#table-of-scheduling-labels).

#### Selector Labels

Using a _selector label_ (i.e. `io.rancher.service.selector.link`, `io.rancher.service.selector.container`), Rancher can identify services/containers by their labels and have them automatically linked to the service. _Selector labels_ are evaluated in two scenarios. Scenario 1 is when a _selector label_ is added to a service. In Scenario 1, all existing labels are evaluated to see if they match the _selector label_. Scenario 2 is when a service already has a _selector label_. In Scenario 2, any new services/containers added to Rancher is checked to see if it qualifies to be linked. A _selector label_ can be made of multiple requirements, which are comma separated. If there are multiple requirements, all requirements must be satisfied so the comma separator acts as an **AND** logical operator.

```
# One of the container labels must have a key equal to `foo1` and value equal to `bar1`
foo1 = bar1
# One of the container labels must have a key equal to `foo2` with a value not equal to `bar2`
foo2 != bar2
# One of the container labels must have a key equal to `foo3`, value of the label does not matter
foo3
# One of the container labels must have a key equal to `foo4` and value equal to `bar1` OR `bar2`
foo4 in (bar1, bar2)
# One of the container labels must have a key equal to `foo5` and value other than `bar3` OR `bar4`
foo5 notin (bar3, bar4)
```
<br>

> **Note:** If there is a label with a value that contains a comma in it, the selector will not be able to match with the label as the _selector label_ can match on any key with no associated value. Example: A label of `io.rancher.service.selector.link: foo=bar1,bar2` would translate to any service that have one label must be key equals to `foo` and value equal to `bar1` **AND** another label with key equal to `bar2`. It would NOT pick up a service that has a label with key equal to `foo` and value equal to `bar1,bar2`.

#### Example of a comma separated list

```
service1:
  labels:
    # Selector label added to pick up other services
    io.rancher.service.selector.link: hello != world, hello1 in (world1, world2), foo = bar
```

In this example, the service that would be linked to `service1` would need to satisfy all of the following conditions:

* A label with key equal to `hello` and value NOT equal to `world`
* A label with key equal to `hello1` can have either value equal to `world1` or `world2`
* A label with key equal to `foo` and value equal to `bar`


With the example below, `service2` would automatically link to `service1` when deployed.

```
service2:
   labels:
      hello: test
      hello1: world2
      foo: bar
```

### System Labels on a Service

Besides labels that can be used by Rancher Compose, there are a series of system labels that Rancher creates when starting services.

Key | Description
----|---
`io.rancher.stack.name`/`io.rancher.project.name` | Created based on the stack name
`io.rancher.stack_service.name`/`io.rancher.project_service.name`| Created based on the service name
`io.rancher.service.deployment.unit` |  Created based on the deployments for sidekicked services
`io.rancher.service.launch.config` |   Created based on the configurations for sidekicked services.
`io.rancher.service.requested.host.id` |  Created based on which host the service was scheduled on

### Host Labels

[Host labels]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#host-labels) can be added to a host during registration of a host or added later by **Editing** the host.

Key | Value |Description
----|-----|---
`io.rancher.host.external_dns_ip` | IP to be used for [External DNS]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/external-dns-service/), e.g. a.b.c.d | To be used for external DNS services and requiring the programming of the DNS records [using an IP other than the host IP]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/external-dns-service/#using-a-specific-ip-for-external-dns)

### Automatically Applied Host Labels

Rancher automatically creates host labels related to linux kernel version and Docker Engine version of the host. These labels can be used for [scheduling]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/).

Key | Value | Description
----|----|----
`io.rancher.host.linux_kernel_version` | Linux Kernel Version on Host (e.g, `3.19`) |  Version of the Linux kernel running on the host
`io.rancher.host.docker_version` | Docker Version on the host (e.g. `1.10.3`) | Docker Engine Version on the host

### Native Docker Labels

`io.rancher.container.network` | `true`|  Add this label to a `docker run` command to add Rancher networking to the container
