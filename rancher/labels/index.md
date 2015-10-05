---
title: Labels in Rancher
layout: rancher-default

---

## Rancher-Compose Labels 
---

Labels are used to help Rancher start up services and leverage the features of Rancher. This index of labels are used to help users create services using `rancher-compose`. 

Key | Value |Description
----|-----|---
`io.rancher.sidekicks` | Service Names  | Used to define what services are [sidekicks]({{site.baseurl}}/rancher/rancher-compose/#sidekicks)
`io.rancher.loadbalancer.target.SERVICE_NAME` | `REQUEST_HOST:SOURCE_PORT/REQUEST_PATH=TARGET_PORT` |Used to determine [L7 Load Balancing]({{site.baseurl}}/rancher/rancher-compose/rancher-services/#advanced-load-balancing-(l7))
`io.rancher.container.dns`| `true` | Service is able to use Rancher DNS based service discovery and network will be the host network.
`io.rancher.container.hostname_override` | `container_name` | Used to set the hostname of the container to the name of the container (e.g. StackName_ServiceName_CreateIndex)
`io.rancher.container.start_once` |`true` | Used to run a container once and have it remain in stopped state while the service remains in `active` state
`io.rancher.container.pull_image` | `always` | Used to always pull a new image before deploying container. 
`io.rancher.container.requested_ip` | An IP from the 10.42.0.0/16 address space | Allows you to pick a specific IP for a container
`io.rancher.service.selector.container` |  [Selector Format]({{site.baseurl}}/rancher/labels/#selector-format) | Used on a service so that new standalone containers can be selected to join the service DNS. Note: As standalone containers, none of the service actions will affect the standalone container (i.e. deactivate/delete service, restart container, healthcheck, etc). 
`io.rancher.service.selector.link` | [Selector Format]({{site.baseurl}}/rancher/labels/#selector-format) | Used on a service to allow new services to be linked to the service based on service labels. Example: Service1 has a label `io.rancher.service.selector.link: foo=bar`. Any services that are added to Rancher that have a `foo=bar` label will automatically be linked to Service1. 
`io.rancher.scheduler.global` | `true` | Used to set [global services]({{site.baseurl}}/rancher/rancher-compose/scheduling/#global-service)
`io.rancher.scheduler.affinity:host_label` | Key Value Pair of Host Label| Used to schedule containers on hosts based on [host label]({{site.baseurl}}/rancher/rancher-compose/scheduling/#finding-hosts-with-host-labels) 
`io.rancher.scheduler.affinity:container_label` | Key Value Pair of Any Container Label | Used to schedule containers on hosts based on [container label or service name]({{site.baseurl}}/rancher/rancher-compose/scheduling/#finding-hosts-with-container-labels) 
`io.rancher.scheduler.affinity:container` | Name of Container | Used to schedule containers on hosts based on [container name]({{site.baseurl}}/rancher/rancher-compose/scheduling/#finding-hosts-with-container-names)

> **Note:** For the labels prefixed with `io.rancher.scheduler.affinity`, there are slight variations based on your how want to match (i.e. equal or not equal, hard or soft rules). More details can be found [here]({{site.baseurl}}/rancher/rancher-compose/scheduling/#table-of-scheduling-labels).

### Selector Format 

The values for selector labels (i.e. `io.rancher.service.selector.link`, `io.rancher.service.selector.container`) can be in multiple formats to be able to select services/containers based on their labels. 

```
# Label could be key=value1 OR key=value2
key in (value1, value2)
# Label cannot be key=value1 OR key=value2
key notin (value1, value2)
# Label is only the key (no matching value needed)
key
# Label must have key=value
key = value
# Labels must not have key=value 
key != value
```

Any combination of the formats can be used togetehr in a comma separated list. 

```
key != value, key in (value1, value2), key=value3
```

> **Note:** If there is a label with a value that contains a comma in it, the selector will not be able to match with the label due to the ability to select on `key` alone. Example:  `io.rancher.service.selector.link: foo=bar1,bar2` would translate to any containers that have labels, key of `foo` with value `bar1` or key of `bar2` would join the service. It would NOT pick up a service that has `foo=bar1,bar2` as a label. 

## System Labels

Besides labels that can be used by `rancher-compose`, there are a series of system labels that Rancher creates when starting services.

Key | Description
----|---
`io.rancher.stack.name`/`io.rancher.project.name` | Used to define the stack name of service
`io.rancher.stack_service.name`/`io.rancher.project_service.name`|Determines the name of the stack 
`io.rancher.service.deployment.unit` |  Used to define the deployments for sidekicked services.
`io.rancher.service.launch.config` |   Used to define configurations for side kicked services.
`io.rancher.service.requested.host.id` |  Used by the scheduler to know which host it was scheduled on


## Native Docker Labels

`io.rancher.container.network` | `true`|  Add this label to a `docker run` command to add Rancher networking to the container