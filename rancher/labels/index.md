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
 `io.rancher.scheduler.global` | `true` | Used to set [global services]({{site.baseurl}}/rancher/rancher-compose/scheduling/#global-service)
`io.rancher.scheduler.affinity:host_label` | Key Value Pair of Host Label| Used to schedule containers on hosts based on [host label]({{site.baseurl}}/rancher/rancher-compose/scheduling/#finding-hosts-with-host-labels) 
`io.rancher.scheduler.affinity:container_label` | Key Value Pair of Any Container Label | Used to schedule containers on hosts based on [container label or service name]({{site.baseurl}}/rancher/rancher-compose/scheduling/#finding-hosts-with-container-labels) 
`io.rancher.scheduler.affinity:container` | Name of Container | Used to schedule containers on hosts based on [container name]({{site.baseurl}}/rancher/rancher-compose/scheduling/#finding-hosts-with-container-names)
`io.rancher.container.dns`| `true` | Service is able to use Rancher DNS based service discovery and network will be the host network.


> **Note:** For the scheduling labels, there are slight variations based on your affinity choice. More details can be found [here]({{site.baseurl}}/rancher/rancher-compose/scheduling/#table-of-scheduling-labels).


## System Labels

Besides labels that can be used by `rancher-compose`, there are a series of system labels that Rancher creates when starting services.

Key | Description
----|---
`io.rancher.project.name`/`io.rancher.stack.name` | Used to define the stack name of service
`io.rancher.project_service.name`/`io.rancher.stack_service.name`|Determines the name of the stack 
`io.rancher.service.deployment.unit` |  Used to define the deployments for sidekicked services.
`io.rancher.service.launch.config` |   Used to define configurations for side kicked services.
`io.rancher.service.requested.host.id` |  Used by the scheduler to know which host it was scheduled on


## Native Docker Labels

`io.rancher.container.network` | `true`|  Add this label to a `docker run` command to add Rancher networking to the container
