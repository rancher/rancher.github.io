---
title: Metadata Service
layout: rancher-default

---

## Metadata Service

With Rancher's metadata service, you can exec into any container and retrieve information about the container. The metada could be related to the container, the service  or stack that the container is part of, or the host that the container is on. The metada is in a JSON format. 

## How to Get the Metadata 

From the Rancher UI, you can exec into the container by selecting **Execute Shell** from the drop down of the container. The drop down of the container can be found by hovering over the container. 

Run this command inside the container:

```bash
# If curl is not installed, install it
$ apt-get install curl
# Retrieve the metadata
$ curl --header 'Accept: application/json' 'http://rancher-metadata/latest/self/stack' 
```

The `http` can be changed depending on what metadata you want to retrieve.

Metadata |  http
----|----
Container | `http://rancher-metadata/latest/self/container`
Stack that container is part of | `http://rancher-metadata/latest/self/stack`
Service that container is part of | `http://rancher-metadata/latest/self/service`
Host that container is deployed on | `http://rancher-metadata/latest/self/host`

## Metadata Fields 

### Container

| Fields | Description |
| ----| ----|
| `name` | Name of Container 
| `primary_ip` | IP of container
| `ips` | When multiple NICs are supported, it will be the list of IPs.
| `ports` | List of [Ports used in the container]({{site.baseurl}}/rancher/rancher-ui/infrastructure/containers/#port-mapping). Format for ports is `host:public:private`.
| `service_name` | Name of service (if applicable)
| `stack_name` | Name of stack that the service is in (if applicable)
| `labels` | List of [Labels on Container]({{site.baseurl}}/rancher/rancher-ui/scheduling/#labels). Format for labels is `key`:`value`.
| `create_index` | The order number of which the container was launched in the service, i.e. 2 means it was the second container launched in the service.

### Service

 Fields | Description
----|----
`name` | Name of Service
`kind` | Type of Rancher Service 
`hostname` | CNAME for [External Services]({{site.baseurl}}/rancher/rancher-ui/applications/stacks/adding-external-services/)
`external_ips` | List of External IPs for [External Services]({{site.baseurl}}/rancher/rancher-ui/applications/stacks/adding-external-services/)
`sidekicks` | List of service names that are [sidekicks]({{site.baseurl}}/rancher/rancher-compose/#sidekicks)
`containers` | List of container names in the service
`links` | List of linked services. Format for links is `stack_name/service_name:service_alias`. If the service is in the same stack, there will be no `stack_name`.
`ports` | List of [Ports used in the Service]({{site.baseurl}}/rancher/rancher-ui/applications/stacks/adding-services/#service-options). Format for ports is `host:public:private`.
`labels` | List of [Labels on Service]({{site.baseurl}}/rancher/rancher-ui/scheduling/#labels). Format for labels is `key:value`.
`create_index` | The order number of which the container was launched in the service, i.e. 2 means it was the second container launched in the service.

### Stack

Fields | Description
----|----
`environment_name` | Name of [Environment]({{site.baseurl}}/rancher/configuration/environments/) that the Stack is in
`name` | Name of [Stack]({{site.baseurl}}/rancher/rancher-ui/applications/stacks/)
`services` | List of Services in the Stack

### Host

Fields | Description
----|----
`agent_ip` | IP of the Rancher Agent, i.e. the value of the `CATTLE_AGENT_IP` environment variable.
`name` | Name of [Host]({{site.baseurl}}/rancher/rancher-ui/infrastructure/hosts/)
`labels` | List of [Host Labels]({{site.baseurl}}/rancher/rancher-ui/infrastructure/hosts/#host-labels). Format for labels is `key:value`.

