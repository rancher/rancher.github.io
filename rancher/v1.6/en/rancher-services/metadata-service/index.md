---
title: Metadata Service in Rancher
layout: rancher-default-v1.6
version: v1.6
lang: en
redirect_from:
  - /rancher/rancher-services/metadata-service/
---

## Metadata Service
---

Rancher offers data for both your services and containers through our metadata infrastructure service. This data can be used to manage your running Docker instances in the form of a metadata service accessed directly through a HTTP based API.  These data can include static information when creating your Docker containers, Rancher Services, or runtime data such as discovery information about peer containers within the same service.

With Rancher's metadata service, you can exec into any container using the Rancher managed network and retrieve information about containers in Rancher. The metadata could be related to the container, the service or stack that the container is part of, or the host that the container is on. The metadata is in a JSON format.

Containers can be launched in the Rancher managed network in several ways. Read more about how [networking]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/networking) works in Rancher.

### How to Get the Metadata

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

##### V1 vs. V2

When drilling down to containers using the http path ending in `/services/<service-name>/containers` or `/stacks/<stack-name>/services/<service-name>/containers`, V1 returns container name(s) and V2 returns container object(s). More information is provided with V2 of the metadata service.

##### Example

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
dns/
dns_search/
external_id
health_check_hosts/
health_state
host_uuid
hostname
ips/
labels/
memory_reservation
milli_cpu_reservation
name
network_from_container_uuid
network_uuid
ports/
primary_ip
primary_mac_address
service_index
service_name
stack_name
stack_uuid
start_count
state
system
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

### Metadata Fields

#### Container

| Fields | Description |
| ----| ----|
| `create_index` | The order number of which the container was launched in the service, i.e. 2 means it was the second container launched in the service. Note: Create_index is never reused. If you had a service with 2 containers and deleted the 2nd container, the next container that gets launched for the service would have a `create_index` of 3 even though there are only 2 containers in the service.
| `dns` | The container's DNS server.
| `dns_search` | Search domains for the container.
| `external_id`  | The Docker container ID on the host
| `health_check_hosts` | List of the host UUIDs where the containers that run health checks are.
| `health_state` | The state of health for the container if a [health check]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/health-checks/) was enabled.
| `host_uuid` | Unique host identifier that Rancher server assigns to hosts
| `hostname` | The hostname of the container.
| `ips` | When multiple NICs are supported, it will be the list of IPs.
| `labels` | List of [Labels on Container]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/#labels). Format for labels is `key`:`value`.
| `memory_reservation` | The soft limit of the amount of memory that the container can use.
| `milli_cpu_reservation` | The soft limit of the amount of CPU container can use. The value is an integer representing 1/1000 of a CPU. So, 1000 would equal 1 CPU and 500 would equal half a CPU.
| `name` | Name of Container
| `network_from_container_uuid` | The container's UUID where the network is from.
| `network_uuid` | Unique network identifier that Rancher assigns to networks
| `ports` | List of [Ports used in the container]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#port-mapping). Format for ports is `hostIP:publicIP:privateIP[/protocol]`.
| `primary_ip` | IP of container
| `primary_mac_address` | The primary MAC address of the container
| `service_index` | The last number in the container name of the service
| `service_name` | Name of service (if applicable)
| `stack_name` | Name of stack that the service is in (if applicable)
| `stack_uuid` |  Unique stack identifier that Rancher assigns to stacks
| `start_count` | The number of times the container was started.
| `state` | The state of the container
| `system` | Whether or not the container is an [infrastructure service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/)
| `uuid` | Unique container identifier that Rancher assigns to containers

#### Service

 Fields | Description
----|----
`containers` | List of container names in the service
`create_index` | Create_index of the last container created of the service. Note: Create_index is never reused. If you had a service with 2 containers and deleted the 2nd container, the create_index will be 2. The next container that gets launched for the service would update the create_index to 3 even though there are only 2 containers.
`expose` | The ports that are exposed on the host without being published on the host.
`external_ips` | List of External IPs for [External Services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-external-services/)
`fqdn` | Fqdn of the service
`health_check` | The [health check configuration]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/health-checks/) on the service
`hostname` | CNAME for [External Services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-external-services/)
`kind` | Type of Rancher Service
`labels` | List of [Labels on Service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/#labels). Format for labels is `key:value`.
`lb_config` | The configuration of the [load balancer]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/)
`links` | List of linked services. Format for links is `stack_name/service_name:service_alias`. The `links` would show all the keys (i.e. `stack_name/service_name` for all links) and to retrieve the `service_alias`, you would need to drill down to the specific key.
`metadata` | [User added metadata]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/metadata-service/#adding-user-metadata-to-a-service)
`name` | Name of Service
`ports` | List of [Ports used in the Service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#port-mapping). Format for ports is `hostIP:publicIP:privateIP[/protocol]`.
`primary_service_name` | The name of the primary service if there are sidekicks
`scale` | Scale of Service
`sidekicks` | List of service names that are [sidekicks]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#sidekick-services)
`stack_name` | Name of stack the service is part of
`stack_uuid` | Unique stack identifier that Rancher assigns to stacks
`system` | Whether or not the service is an [infrastructure service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/)
`uuid` | Unique service identifier that Rancher assigns to services

#### Stack

Fields | Description
----|----
`environment_name` | Name of [Environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/) that the Stack is in
`environment_uuid` | Unique stack identifier that Rancher assigns to stacks
`name` | Name of [Stack]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/stacks/)
`services` | List of Services in the Stack
`system` | Whether or not the stack is an [infrastructure service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/)
`uuid` | Unique stack identifier that Rancher assigns to stacks

#### Host

Fields | Description
----|----
`agent_ip` | IP of the Rancher Agent, i.e. the value of the `CATTLE_AGENT_IP` environment variable.
`hostname` | Name of [Host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/)
`labels` | List of [Host Labels]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#host-labels). Format for labels is `key:value`.
`local_storage_mb` | Amount of storage on the host in MB
`memory` | Amount of memory on the host in MB
`milli_cpu` | Amount of CPU on the host. The value is an integer representing 1/1000 of a cpu. So, 1000 would equal 1 CPU.
`name` | Name of [Host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/)
`uuid` | Unique host identifier that Rancher server assigns to hosts

### Adding User Metadata To a Service

Rancher allows users to add in their own metadata to a service. Currently, this is only supported through [Rancher Compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/rancher-compose/) and the metadata is part of the `rancher-compose.yml` file. In the `metadata` key, the yaml will be parsed into JSON format to be used by the metadata-service.

#### Example `rancher-compose.yml`

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


#### JSON Query

```bash
$ curl --header 'Accept: application/json' 'http://rancher-metadata/latest/self/service/metadata'
{"example":{"name":"hello","value":"world"},"example2":{"foo":"bar"}}

```

#### Plaintext Queries

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
