---
title: Metadata Service
layout: rancher-default

---

## Metadata Service

_Available as of v0.35.0+_

With Rancher's metadata service, you can exec into any container and retrieve information about containers in Rancher. The metadata could be related to the container, the service or stack that the container is part of, or the host that the container is on. The metadata is in a JSON format. 

## How to Get the Metadata 

From the Rancher UI, you can exec into the container by selecting **Execute Shell** from the drop down of the container. The drop down of the container can be found by hovering over the container. 

To obtain the metadata, you'll run a curl command inside your container. 

```bash
# If curl is not installed, install it
$ apt-get install curl
# Basic curl command to obtain a plaintext response
$ curl http://rancher-metadata/{version}/{path}
```
The path can be changed depending on what metadata you want to retrieve as well as the response format.

Metadata | Description | http
----|---- | ---
Container | `http://rancher-metadata/2015-07-25/self/container` | Provides metadata on the container that you are executing the command in 
Service that container is part of | `http://rancher-metadata/2015-07-25/self/service` | Provides metadata on the service of the container that you are executing the command in 
Stack that container is part of | `http://rancher-metadata/2015-07-25/self/stack` | Provides metadata on the stack of the container that you are executing the command in 
Host that container is deployed on | `http://rancher-metadata/2015-07-25/self/host` | Provides metadata on the host of the container that you are executing the command in
Other Containers | `http://rancher-metadata/2015-07-25/containers | Provides metadata on all containers. In plaintext, it provides an indexed response of all containers. In JSON format, it provides all the metadata for all  containers. Using either the index number or name in the path, you can obtain  metadata on a specific container. 
Other Services | `http://rancher-metadata/2015-07-25/services` | Provides metadata on all services. In plaintext, it provides an indexed response of all services. In JSON format, it provides all the metadata for all services. Using either the index number or name in the path, you can obtain metadata on a specific service.
Other Stacks | `http://rancher-metadata/2015-07-25/stacks/<stack-name>` | Provides metadata on all stacks. In plaintext, it provides an indexed response of all stacks. In JSON format, it provides all the metadata for all stacks. Using either the index number or name in the path, you can obtain metadata on a specific stack.

### Versioning of Metadata

In the `curl` commands, we recommend using a specific version, but you can choose `latest`. As we make changes and push to `latest`, the data returned may change in any release and become incompatible with your code. 

The version of the metadata service is based on date. 

Available Versions |
---- |
2015-07-25 |

### Plaintext vs JSON 

The metadata can be returned in either JSON format or plaintext. Depending on how you want to use your metadata, you can pick either format. 

#### Plaintext

When executing the curl command, you'll receive plaintext for the path that was requested. You can start at the top level of the path to find the exact path to get a single value.

```bash
$ curl 'http://rancher-metadata/2015-07-25/self/container'
create_index
ips/
labels/
name
ports/
primary_ip
service_name
stack_name
$ curl 'http://rancher-metadata/2015-07-25/self/container/name'
# Note: Curl will not provide a new line, so the value will be on same line as the command prompt
Default_Example_1root@abcdefg$
$ curl 'http://rancher-metadata/2015-07-25/self/container/label/io.rancher.stack.name'
Defaultroot@abcdefg$
# Arrays can use either the index or name to go get the values
$ curl 'http://rancher-metadata/2015-07-25/services'
0=Example
# You can either user the index or name as a path
$ curl 'http://rancher-metadata/2015-07-25/services/0'
$ curl 'http://rancher-metadata/2015-07-25/services/Example1'
```

#### JSON

The JSON format can be retrieved by adding an `Accept: application/json` header to your curl command. 

```bash
$ curl --header 'Accept: application/json' 'http://rancher-metadata/2015-07-25/self/container' 

$ curl --header 'Accept: application/json' 'http://rancher-metadata/2015-07-25/self/stack' 

# Retrieve the metadata for another service in the stack
$ curl --header 'Accept: application/json' 'http://rancher-metadata/2015-07-25/services/<service-name>' 
```

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

