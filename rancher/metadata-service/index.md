---
title: Metadata Service
layout: rancher-default

---

## Metadata Service

_Available as of v0.35.0+_

With Rancher's metadata service, you can exec into any container within the Rancher managed network and retrieve information about containers in Rancher. The metadata could be related to the container, the service or stack that the container is part of, or the host that the container is on. The metadata is in a JSON format. 

A container can be launched in the Rancher managed network in several ways.

* In the [UI]({{site.baseurl}}/rancher/rancher-ui/applications/stacks/adding-services/), the service/container was started with _Managed_ as the network option. By default, the network is set to _Managed_. 
* Using [Rancher-Compose]({{site.baseurl}}/rancher/rancher-compose/), any service/container, that doesn't have another networking mode (`net`) specified, is launched in the managed network.
* When [using native docker]({{site.baseurl}}/rancher/native-docker/#joining-natively-started-containers-to-the-rancher-network), if you add the label `io.rancher.container.network=true` to your `docker run` command, then the container will join the Rancher managed network.

> **Note:** Metadata service is not available for system containers, i.e. Network Agent and LB Agent. 

## How to Get the Metadata 

From the Rancher UI, you can execute into shell of the container by selecting **Execute Shell** from the drop down of the container. The drop down can be found by hovering over the container. 

To obtain the metadata, you'll run a curl command.

```bash
# If curl is not installed, install it
$ apt-get install curl
# Basic curl command to obtain a plaintext response
$ curl http://rancher-metadata/{version}/{path}
```
The path can be changed depending on what metadata you want to retrieve as well as the response format.

Metadata | http path  | Description
----|---- | ---
Container | `http://rancher-metadata/2015-07-25/self/container` | Provides metadata on the container that you are executing the command in 
Service that container is part of | `http://rancher-metadata/2015-07-25/self/service` | Provides metadata on the service of the container that you are executing the command in 
Stack that container is part of | `http://rancher-metadata/2015-07-25/self/stack` | Provides metadata on the stack of the container that you are executing the command in 
Host that container is deployed on | `http://rancher-metadata/2015-07-25/self/host` | Provides metadata on the host of the container that you are executing the command in
Other Containers | `http://rancher-metadata/2015-07-25/containers` | Provides metadata on all containers. In plaintext, it provides an indexed response of all containers. In JSON format, it provides all the metadata for all  containers. Using either the index number or name in the path, you can obtain  metadata on a specific container. 
Other Services | `http://rancher-metadata/2015-07-25/services` | Provides metadata on all services. In plaintext, it provides an indexed response of all services. In JSON format, it provides all the metadata for all services. Using either the index number or name in the path, you can obtain metadata on a specific service.
Other Stacks | `http://rancher-metadata/2015-07-25/stacks/<stack-name>` | Provides metadata on all stacks. In plaintext, it provides an indexed response of all stacks. In JSON format, it provides all the metadata for all stacks. Using either the index number or name in the path, you can obtain metadata on a specific stack.

### Versioning of Metadata

In the `curl` commands, we strongly recommend using a specific version, but you could also choose `latest`.

> **Note:** As we make changes to our `latest` version, the data returned may change in any release and become incompatible with your code. 

The version of the metadata service is based on date. 

Available Versions |
---- |
2015-07-25 |

### Plaintext vs JSON 

The metadata can be returned in either plaintext or JSON format. Depending on how you want to use your metadata, you can pick either format. 

#### Plaintext

When executing the curl command, you'll receive plaintext for the path that was requested. You can start at the top level of the path and continue to update the path based on available keys until your metadata service provides the data you were looking for. 

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
# Note: Curl will not provide a new line, so single values will be on same line as the command prompt
Default_Example_1$root@<container_id>
$ curl 'http://rancher-metadata/2015-07-25/self/container/label/io.rancher.stack.name'
Default$root@<container_id>
# Arrays can use either the index or name to go get the values
$ curl 'http://rancher-metadata/2015-07-25/services'
0=Example
# You can either user the index or name as a path
$ curl 'http://rancher-metadata/2015-07-25/services/0'
$ curl 'http://rancher-metadata/2015-07-25/services/Example'
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
| `create_index` | The order number of which the container was launched in the service, i.e. 2 means it was the second container launched in the service.
| `host_uuid` | Unique host identifier that Rancher server assigns to hosts
| `ips` | When multiple NICs are supported, it will be the list of IPs.
| `labels` | List of [Labels on Container]({{site.baseurl}}/rancher/rancher-ui/scheduling/#labels). Format for labels is `key`:`value`.
| `name` | Name of Container 
| `ports` | List of [Ports used in the container]({{site.baseurl}}/rancher/rancher-ui/infrastructure/containers/#port-mapping). Format for ports is `host:public:private`.
| `primary_ip` | IP of container
| `service_name` | Name of service (if applicable)
| `stack_name` | Name of stack that the service is in (if applicable)


### Service

 Fields | Description
----|----
`containers` | List of container names in the service
`external_ips` | List of External IPs for [External Services]({{site.baseurl}}/rancher/rancher-ui/applications/stacks/adding-external-services/)
`hostname` | CNAME for [External Services]({{site.baseurl}}/rancher/rancher-ui/applications/stacks/adding-external-services/)
`kind` | Type of Rancher Service 
`labels` | List of [Labels on Service]({{site.baseurl}}/rancher/rancher-ui/scheduling/#labels). Format for labels is `key:value`.
`links` | List of linked services. Format for links is `stack_name/service_name:service_alias`. If the service is in the same stack, there will be no `stack_name`.
`metadata` | [User added metadata]({{site.baseurl}}/rancher/metadata-service/#adding-user-metadata-to-a-service) 
`name` | Name of Service
`ports` | List of [Ports used in the Service]({{site.baseurl}}/rancher/rancher-ui/applications/stacks/adding-services/#service-options). Format for ports is `host:public:private`.
`sidekicks` | List of service names that are [sidekicks]({{site.baseurl}}/rancher/rancher-compose/#sidekicks)
`stack_name` | Name of stack the service is part of

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
`labels` | List of [Host Labels]({{site.baseurl}}/rancher/rancher-ui/infrastructure/hosts/#host-labels). Format for labels is `key:value`.
`name` | Name of [Host]({{site.baseurl}}/rancher/rancher-ui/infrastructure/hosts/)
`uuid` | Unique host identifier that Rancher server assigns to hosts

## Adding User Metadata To a Service

As of v0.42.0+, Rancher allows users to add in their own metadata to a service. Currently, this is only supported through [rancher-compose]({{site.baseurl}}/rancher/rancher-compose/) and the metadata is part of the `rancher-compose.yml` file. In the `metadata` key, the yaml will be parsed into JSON format to be used by the metadata-service.

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

     
