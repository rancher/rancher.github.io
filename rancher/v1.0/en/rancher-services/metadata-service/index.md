---
title: Metadata Service
layout: rancher-default-v1.0
version: v1.0
lang: en
---

## Metadata Service
---

With Rancher's metadata service, you can exec into any container using the Rancher managed network and retrieve information about containers in Rancher. The metadata could be related to the container, the service or stack that the container is part of, or the host that the container is on. The metadata is in a JSON format. 

A container can be launched in the Rancher managed network in several ways.

* In the [UI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/adding-services/), the service/container was started with _Managed_ as the network option. By default, the network of a service is set to _Managed_. 
* Using [Rancher-Compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-compose/), any service/container, that doesn't have another networking mode (`net`) specified, is launched in the managed network.
* When [using native docker]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/native-docker/#joining-natively-started-containers-to-the-rancher-network), if you add the label `io.rancher.container.network=true` to your `docker run` command, then the container will join the Rancher managed network.

> **Note:** Metadata service is not available for system containers, i.e. Network Agent and LB Agent. 

## How to Get the Metadata 
---

From the Rancher UI, you can execute into shell of the container by selecting **Execute Shell** from the drop down of the container. The drop down can be found by hovering over the container. 

To obtain the metadata, you'll run a curl command.

```bash
# If curl is not installed, install it
$ apt-get install curl
# Basic curl command to obtain a plaintext response
$ curl http://rancher-metadata/<version>/<path>
```
The path can be changed depending on what metadata you want to retrieve as well as the response format.

Metadata | path  | Description
----|---- | ---
Container | `self/container` | Provides metadata on the container that you are executing the command in 
Service that container is part of | `self/service` | Provides metadata on the service of the container that you are executing the command in 
Stack that container is part of | `self/stack` | Provides metadata on the stack of the container that you are executing the command in 
Host that container is deployed on | `self/host` | Provides metadata on the host of the container that you are executing the command in
Other Containers | `containers` | Provides metadata on all containers. In plaintext, it provides an indexed response of all containers. In JSON format, it provides all the metadata for all  containers. Using either the index number or name in the path, you can obtain metadata on a specific container. 
Other Services | `services` | Provides metadata on all services. In plaintext, it provides an indexed response of all services. In JSON format, it provides all the metadata for all services. Using either the index number or name in the path, you can obtain metadata on a specific service. If drilling down to containers, in V1 (`2015-07-25`), only container name(s) are returned, but in V2 (`2015-12-19`), container object(s) are returned. 
Other Stacks | `stacks/<stack-name>` | Provides metadata on all stacks. In plaintext, it provides an indexed response of all stacks. In JSON format, it provides all the metadata for all stacks. Using either the index number or name in the path, you can obtain metadata on a specific stack. When drilling down to container details, in V1 (`2015-07-25`), only container name(s) are returned, but in V2 (`2015-12-19`), container object(s) are returned. 

### Versioning of Metadata

In the `curl` commands, we strongly recommend using a specific version, but you could also choose `latest`.

> **Note:** As we make changes to our `latest` version, the data returned may change in any release and become incompatible with your code. 

The version of the metadata service is based on date. 

Version Reference | Version|
---- | ----
V2 | 2015-12-19 |
V1 | 2015-07-25 |

#### Differences in Versions

**V1 vs. V2**

When drilling down to containers using the http path ending in `/services/<service-name>/containers` or `/stacks/<stack-name>/services/<service-name>/containers`, V1 returns container name(s) and V2 returns container object(s). More information is provided with V2 of the metadata service. 

_Example_

In Rancher, there is a stack called `foostack` and it contains a service called `barservice` with 3 containers. 

```bash
# Using V1 returns only container names of the service
$ curl --header 'Accept: application/json' 'http://rancher-metadata/2015-07-25/services/barservice/containers'
["foostack_barservice_1", "foostack_barservice_2", "foostack_barservice_1"]

# Using V2 returns container objects of the service
$ curl --header 'Accept: application/json' 'http://rancher-metadata/2015-12-19/services/barservice/containers'
[{"create_index":1, "health_state":null,"host_uuid":...
...
# Lists all metadata for all containers of the service
...
...}]

# Using V2, you can drill down to a specific container's object
$ curl --header 'Accept: application/json' 'http://rancher-metadata/2015-12-19/services/barservice/containers/foostack_barservice_1'
[{"create_index":1, "health_state":null,"host_uuid":...
...
# Lists all metadata for all containers of the service
...
...}]

# Using /stacks/<service-name>, you can drill down to services and containers

# Using V1 returns only container names of the service
$ curl --header 'Accept: application/json' 'http://rancher-metadata/2015-07-25/stacks/foostack/services/barservice/containers'
["foostack_barservice_1", "foostack_barservice_2", "foostack_barservice_1"]

# Using V2 returns container objects of the service
$ curl --header 'Accept: application/json' 'http://rancher-metadata/2015-12-19/stacks/foostack/services/barservice/containers'
[{"create_index":1, "health_state":null,"host_uuid":...
...
# Lists all metadata for all containers of the service
...
...}]
```

### Plaintext vs JSON 

The metadata can be returned in either plaintext or JSON format. Depending on how you want to use your metadata, you can pick either format. 

#### Plaintext

When executing the curl command, you'll receive plaintext for the path that was requested. You can start at the top level of the path and continue to update the path based on available keys until your metadata service provides the data you were looking for. 

```bash
$ curl 'http://rancher-metadata/2015-12-19/self/container'
create_index
health_state
host_uuid
hostname
ips/
labels/
name
ports/
primary_ip
service_name
stack_name
start_count
uuid
$ curl 'http://rancher-metadata/2015-12-19/self/container/name'
# Note: Curl will not provide a new line, so single values will be on same line as the command prompt
Default_Example_1$root@<container_id>
$ curl 'http://rancher-metadata/2015-12-19/self/container/label/io.rancher.stack.name'
Default$root@<container_id>
# Arrays can use either the index or name to go get the values
$ curl 'http://rancher-metadata/2015-12-19/services'
0=Example
# You can either user the index or name as a path
$ curl 'http://rancher-metadata/2015-12-19/services/0'
$ curl 'http://rancher-metadata/2015-12-19/services/Example'
```

#### JSON

The JSON format can be retrieved by adding an `Accept: application/json` header to your curl command. 

```bash
$ curl --header 'Accept: application/json' 'http://rancher-metadata/2015-12-19/self/container' 
$ curl --header 'Accept: application/json' 'http://rancher-metadata/2015-12-19/self/stack' 
# Retrieve the metadata for another service in the stack
$ curl --header 'Accept: application/json' 'http://rancher-metadata/2015-12-19/services/<service-name>' 
```

## Metadata Fields 
---

### Container

| Fields | Description |
| ----| ----|
| `create_index` | The order number of which the container was launched in the service, i.e. 2 means it was the second container launched in the service. Note: Create_index is never reused. If you had a service with 2 containers and deleted the 2nd container, the next container that gets launched for the service would have a `create_index` of 3 even though there are only 2 containers in the service.
| `health_state` | The state of health for the container if a [health check]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/health-checks/) was enabled.
| `host_uuid` | Unique host identifier that Rancher server assigns to hosts
| `hostname` | The hostname of the container.
| `ips` | When multiple NICs are supported, it will be the list of IPs.
| `labels` | List of [Labels on Container]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/scheduling/#labels). Format for labels is `key`:`value`.
| `name` | Name of Container 
| `ports` | List of [Ports used in the container]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/infrastructure/containers/#port-mapping). Format for ports is `hostIP:publicIP:privateIP[/protocol]`.
| `primary_ip` | IP of container
| `service_index` | The last number in the container name of the service
| `service_name` | Name of service (if applicable)
| `stack_name` | Name of stack that the service is in (if applicable)
| `start_count` | The number of times the container was started.
| `uuid` | Unique container identifier that Rancher assigns to containers

### Service

 Fields | Description
----|----
`containers` | List of container names in the service
`create_index` | Create_index of the last container created of the service. Note: Create_index is never reused. If you had a service with 2 containers and deleted the 2nd container, the create_index will be 2. The next container that gets launched for the service would update the create_index to 3 even though there are only 2 containers.
`expose` | 
`external_ips` | List of External IPs for [External Services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/adding-external-services/)
`fqdn` | Fqdn of the service 
`hostname` | CNAME for [External Services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/adding-external-services/)
`kind` | Type of Rancher Service 
`labels` | List of [Labels on Service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/scheduling/#labels). Format for labels is `key:value`.
`links` | List of linked services. Format for links is `stack_name/service_name:service_alias`. The `links` would show all the keys (i.e. `stack_name/service_name` for all links) and to retrieve the `service_alias`, you would need to drill down to the specific key.
`metadata` | [User added metadata]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/metadata-service/#adding-user-metadata-to-a-service) 
`name` | Name of Service
`ports` | List of [Ports used in the Service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/adding-services/#port-mapping). Format for ports is `hostIP:publicIP:privateIP[/protocol]`.
`scale` | Scale of Service
`sidekicks` | List of service names that are [sidekicks]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-compose/#sidekicks)
`stack_name` | Name of stack the service is part of
`uuid` | Unique service identifier that Rancher assigns to services

### Stack

Fields | Description
----|----
`environment_name` | Name of [Environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/environments/) that the Stack is in
`name` | Name of [Stack]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/)
`services` | List of Services in the Stack
`uuid` | Unique stack identifier that Rancher assigns to stacks

### Host

Fields | Description
----|----
`agent_ip` | IP of the Rancher Agent, i.e. the value of the `CATTLE_AGENT_IP` environment variable.
`hostId` | Identifier of the host in the specific environment
`labels` | List of [Host Labels]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/infrastructure/hosts/#host-labels). Format for labels is `key:value`.
`name` | Name of [Host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/infrastructure/hosts/)
`uuid` | Unique host identifier that Rancher server assigns to hosts

## Adding User Metadata To a Service
---

Rancher allows users to add in their own metadata to a service. Currently, this is only supported through [rancher-compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-compose/) and the metadata is part of the `rancher-compose.yml` file. In the `metadata` key, the yaml will be parsed into JSON format to be used by the metadata-service.

Example `rancher-compose.yml` 

```yaml
service:
  # Scale of service
  scale: 3
  # User added metadata
  metadata:
    example:
      name: hello
      value: world
    example2:
      foo: bar

```

After the service is up, you can find metadata using the metadata service in `.../self/service/metadata` or in `.../services/<service_id>/metadata`. 


### JSON Query

```bash
$ curl --header 'Accept: application/json' 'http://rancher-metadata/latest/self/service/metadata'
{"example":{"name":"hello","value":"world"},"example2":{"foo":"bar"}}

```

### Plaintext Queries

```bash
$ curl 'http://rancher-metadata/latest/self/service/metadata'
example/
$ curl 'http://rancher-metadata/latest/self/service/metadata/example'
name
value
$ curl 'http://rancher-metadata/latest/self/service/metadata/example/name'
# Note: Curl will not provide a new line, so single values will be on same line as the command prompt
hello$root@<container_id>
```

     
