---
title: Concepts
layout: rancher-default-v1.0
version: v1.0
lang: en 
---

## Concepts
---

In this section, we introduce the key concepts in Rancher. You should be familiar with these concepts before attempting to use Rancher.

### Users

Users govern who has the access rights to view and manage Rancher resources within their Environment.  Rancher allows access for a single tenant by default. However, multi-user support can also be enabled.

See [access control]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/) before you enable authentication.

### Environments

All hosts and any Rancher resources, such as containers, load balancers, and so on are created in and belong to an environment.  Access control permissions for viewing and managing these resources are then defined by the owner of the environment.  Rancher currently supports the capability for each user to manage and invite other users to their environment and allows for the ability to create multiple environments for different workloads.  For example, you may want to create a "dev" environment and a separate "production" environment with its own set of resources and limited user access for your application deployment.

Set up [access control]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/) before you [share environments]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/environments/) with users. 

<a id="host"></a>

### Hosts

Hosts are the most basic unit of resource within Rancher and is represented as any Linux server, virtual or physical, with the following minimum requirements:

* Any modern Linux distribution that supports Docker 1.10.3.
* Ability to communicate with a Rancher server via http or https through the pre-configured port. Default is 8080.
* Ability to be routed to any other hosts under the same environment to leverage Rancher's cross-host networking for Docker containers.

Rancher also supports Docker Machine and allows you to add your host via any of its supported drivers.

See [add your first host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/infrastructure/hosts) before adding your first host to Rancher.

### Networking

Rancher supports cross-host container communication by implementing a simple and secure overlay network using IPsec tunneling.  To leverage this capability, a container launched through Rancher must select "Managed" for its network mode or if launched through Docker, provide an extra label "--label io.rancher.container.network=true".  Most of Rancher's network features, such as load balancer or DNS service, require the container to be in the managed network.

Under Rancher's network, a container will be assigned both a Docker bridge IP (172.17.0.0/16) and a Rancher managed IP (10.42.0.0/16) on the default docker0 bridge.  Containers within the same environment are then routable and reachable via the managed network.

> **Note:** The Rancher managed IP address will not be present in Docker meta-data and as such will not appear in the result of a Docker "inspect." This sometimes causes incompatibilities with certain tools that require a Docker bridge IP. We are already working with the Docker community to make sure a future version of Docker can handle overlay networks more cleanly.

### Service Discovery

Rancher adopts the standard Docker Compose terminology for services and defines a basic service as one or more containers created from the same Docker image.  Once a service (consumer) is linked to another service (producer) within the same stack, a DNS record mapped to each container instance is automatically created and discoverable by containers from the "consuming" service.  Other benefits of creating a service under Rancher include:

* Service High Availability (HA) - the ability to have Rancher automatically monitor container states and maintain a service's desired scale.
* Health Monitoring - the ability to set basic monitoring thresholds for container health.
* Add Load Balancers - the ability to add a simple load balancer for your services using HAProxy.
* Add External Services - the ability to add any-IP as a service to be discovered.
* Add Service Alias - the ability to add a DNS record for your services to be discovered.

For more information, see [adding services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/adding-services/), [adding load balancers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/adding-balancers/), [adding external services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/adding-external-services/) or [adding service alias]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/adding-service-alias/).

### Load Balancer

Rancher implements a managed load balancer using HAProxy that can be manually scaled to multiple hosts.  A load balancer can be used to distribute network and application traffic to individual containers by directly adding them or "linked" to a basic service.  A basic service that is "linked" will have all its underlying containers automatically registered as load balancer targets by Rancher.

### Distributed DNS Service

Rancher implements a distributed DNS service by using its own light-weight DNS server coupled with a highly available control plane. Each healthy container is automatically added to the DNS service when linked to another service or added to a Service Alias. When queried by the service name, the DNS service returns a randomized list of IP addresses of the healthy containers implementing that service.

* By default, all services within the same stack are added to the DNS service without requiring explicit links. 
    * You can resolve containers within the same stacks by the service names. 
    * If you need a custom DNS name for your service, that is different from your service name, you will be required to use a link to get the custom DNS name. 
    * Links are still required for load balancers to target services. 
    * Links are still required if a Service Alias is used. 
* To make services resolvable that are in different stacks, you will need to link them explicitly. 

Because Rancher’s overlay networking provides each container with a distinct IP address, you do not need to deal with port mappings and do not need to handle situations like duplicated services listening on different ports. As a result, a simple DNS service is adequate for handling service discovery.

### Health Checks

Rancher implements a health monitoring system by running managed network agents across its hosts to coordinate the distributed health checking of containers and services. These network agents internally utilize HAProxy to validate the health status of your applications. When health checks are enabled either on an individual container or a service, each container is then monitored by up to three network agents running on hosts separate to that containers parent host. The container is considered healthy if at least one HAProxy instance reports a “passed” health check.

> **Note:** The only exception to this model is when your environment contains a single host. In such instances the health checks will be performed by the same host.

Rancher handles network partitions and is more efficient than client-based health checks. By using HAProxy to perform health checks, Rancher enables users to specify the same health check policy across applications and load balancers.

For more information such as including example failure scenarios and how Rancher displays services, see [Health Checks]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/health-checks/). You can also read more about setting up health checks by using [rancher-compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-compose/rancher-services/#health-check-for-services) or in the [UI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/adding-services/#health-checks).

### Service HA

Rancher constantly monitors the state of your containers within a service and actively manages to ensure the desired scale of the service.  This can be triggered when there are fewer (or even more) healthy containers than the desired scale of your service, a host becomes unavailable, a container fails, or is unable to meet a health check.

### Service Upgrade

Rancher supports the notion of service upgrades by allowing users to either load balance or apply a service alias for a given service.  By leveraging either Rancher features, it creates a static destination for existing workloads that require that service.  Once this is established, the underlying service can be cloned from Rancher as a new service, validated through isolated testing, and added to either the load balancer or service alias when ready.  The existing service can be removed when obsolete. Subsequently, all the network or application traffic are automatically distributed to the new service.

### Rancher Compose

Rancher implements and ships a command-line tool called rancher-compose that is modeled after docker-compose. It takes in the same docker-compose.yml templates and deploys the Stacks onto Rancher. The rancher-compose tool additionally takes in a rancher-compose.yml file which extends docker-compose.yml to allow specifications of attributes such as scale, load balancing rules, health check policies, and external links not yet currently supported by docker-compose.

For more information, see [rancher-compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-compose/).

### Stacks

A Rancher stack mirrors the same concept as a docker-compose project.  It represents a group of services that make up a typical application or workload.

### Container Scheduling

Rancher supports container scheduling policies that are modeled closely after Docker Swarm.  They include scheduling based on:

* port conflicts
* shared volumes
* host tagging
* shared network stack: --net=container:dependency
* strict and soft affinity/anti-affinity rules by using both env var (Swarm) and labels (Rancher)

In addition, Rancher supports scheduling service triggers that allow users to specify rules, such as on "host add" or "host label", to automatically scale services onto hosts with specific labels.

For more information on how to schedule containers in Rancher, see how we use [labels and scheduling rules in the UI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/scheduling/) or how we use [labels in rancher-compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-compose/scheduling/).

### Sidekicks

Rancher supports the colocation, scheduling, and lock step scaling of a set of services by allowing users to group these services by using the notion of sidekicks.  A service with one or more sidekicks is typically created to support shared volumes (i.e. `--volumes_from`) and networking (i.e. `--net=container`) between containers.

For more information, see [sidekicks with rancher-compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-compose/#sidekicks).

### Metadata Services

Rancher offers data for both your services and containers. This data can be used to manage your running Docker instances in the form of a metadata service accessed directly through a HTTP based API.  These data can include static information when creating your Docker containers, Rancher Services, or runtime data such as discovery information about peer containers within the same service.

For more information, see [metadata service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/metadata-service/).
