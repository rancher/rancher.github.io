---
title: Adding Services
layout: rancher-default-v1.0
version: v1.0
lang: en
---

## Adding Services
---

With Rancher, you can add multiple services in a stack to make an application. A service is just one or more Docker containers. With this guide, we'll assume you've already created a [stack]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/), set up your [hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/infrastructure/hosts/), and are ready to build your application. 

We'll review all the options within adding a service and at the end walk through how to create a [LetsChat](http://sdelements.github.io/lets-chat/) application linked to a Mongo database. 

Inside your stack, you add a service by clicking the **Add Service** button. Alternatively, if you are viewing the stacks at the stack level, the same **Add Service** button is visible for each individual stack. 

In the **Scale** section, you can use the slider for the specific number of containers you want launched for a service. Alternatively, you can select **Always run one instance of this container on every host**. With this option, your service will scale for any additional hosts that are added to your [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/environments/). If you have created scheduling rules in the **Scheduling** tab, Rancher will only start containers on the hosts that meet the scheduling rules. 

You will also need to provide a **Name** and if desired, **Description** of the service. 

Provide the **Image** to use. You can use any image on [DockerHub](https://hub.docker.com/) as well as any [registries]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/registries) that have been added to your [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/environments). The syntax for image name  match any `docker run` commands. 

Syntax of image names. By default, we pull from the docker registry. If no tag is specified, we will pull the latest tag. 

`[registry-name]/[namespace]/[imagename]:[version]`

Underneath the image name, there is a checkbox for `Always pull image before creating`. By default, this is enabled. When this option is enabled, the image for the service will **always** be pulled on the host even if image is already cached for any time a container is launched on the host. 

### Options

Just like adding individual [containers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/infrastructure/containers/), any options that `docker run` supports, Rancher also supports! Port mapping and service links are shown on the main page, but all other options are in the different tabs.

By default, all containers in a service are running in detached mode, i.e. `-d` in a `docker run` command. 

#### Port Mapping

When we are mapping ports, we are creating the ability to access the exposed ports of the container to a public port on the host. In the **Port Map** section, you define the public ports that will be exposed on the host. This port will direct traffic to the defined private port. The private port is typically the port that is exposed on the container (i.e. `EXPOSE` in the [Dockerfile](https://docs.docker.com/engine/reference/builder/#expose) of the image). Whenever you map a port, Rancher will check the host to see if there are any port conflicts on the host before attempting to launch the container. 

When using port mapping, if the scale of your service is more than the number of hosts with available port(s), your service will become stuck in an activating state. If you look at the details of your service, you will be able to see a container in `Error` state, which will indicate that the container failed due to inability to find an open port on a host. The service will continue to try and if a host/port(s) becomes available, the service will launch a container on that host. 

> **Note:** When ports are exposed in Rancher, it will only display the port upon creating. If there are any edits to the port mapping, it will not update in `docker ps` as Rancher manages the iptable rules to make the ports fully dynamic. 

**Random Port Mapping**

If you would like to take advantage of Rancher's random port mapping, the public port can be left blank and you only need to define the private port. 

#### Linking Services 

If other services have already been created in your environment, you can link services to the service that you are creating. Linking services will link all containers in the service to all containers in the linked service. Linking services acts like the `--link` functionality in a `docker run` command.

Linking services is additional functionality on top of Rancher's [internal DNS]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/internal-dns-service/) and is not required to resolve services by service name.

### Rancher Options

Besides providing all the options that `docker run` support, Rancher provides additional concepts available in the UI.

#### Health Checks

Rancher implements a distributed health monitoring system by running an HAProxy instance on every host for the sole purpose of providing health checks to containers.  When health checks are enabled either on an individual container or a service,  each container is then monitored by up to three HAProxy instances running on different hosts. The container is considered healthy if at least one HAProxy instance reports a "passed" health check and it is considered unhealthy when all HAProxy instances report a "unhealthy" health check.

Rancher’s approach handles network partitions and is more efficient than client-based health checks. By using HAProxy to perform health checks, Rancher enables users to specify the same health check policy for DNS service and for load balancers.

> **Note:** Health checks will only work for services that are using the managed network. If you select any other network choice, it will **not** be monitored.

In the **Health Check** tab, you can check TCP connections or HTTP responses for services. 

Read more details about how Rancher handles [health checks]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/health-checks/).

> **Note:** If a host is down in Rancher (i.e. in `reconnecting` or `inactive` state), you will need to implement a health check in order for Rancher to launch the containers on your service on to a different host.

#### Labels/Scheduling 

In the **Labels** tab, Rancher allows you to add any labels to containers in a service. Labels are very useful to be used when creating scheduling rules. In the **Scheduling** tab, you can use the [host labels]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/infrastructure/hosts/#host-labels), container/service labels, and container/service names to create where you want the containers of your service to be scheduled. 

More details about labels and scheduling can be read [here]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/scheduling/).

### Sidekick Services

With services, you may want to have your service use `volumes_from` and `net` to another service. In order for these to work, you need to set up a sidekick relationship. The sidekick relationship is how Rancher scales and schedules these services as one unit onto hosts. Example: B is a sidekick of A, so the services will always deploy as a pair and scale of the services will always be the same. 

Another time that you may want to define the sidekick relationship is if you have multiple services that always need to be deployed on the same host.

To set a sidekick relationship, you can click on **+ Add Sidekick Container**, which is located within the scale section. The first service is considered the primary service and each additional sidekick is a secondary service. 

When defining a sidekick to a service, you do not need to link the services as sidekicks are automatically DNS-resolved to each other. 

When using [load balancers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-compose/rancher-services/#load-balancer) with services that have sidekicks, you need to use the primary service as the target of the load balancer. A sidekick **can not** be the target.

Read more about [Rancher's internal DNS]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/internal-dns-service/).

### Example of Starting Services

First, let's create our MongoDB service by setting the scale to be 1 container, giving it a name like "MongoDB", and using the `mongo:latest` as the image. There are no other options that need to be set to get this service running, so click on **Create**. 

The service will immediately start to launch. If this is your first container launched on the host, a _Network Agent_ container will be launched onto the host, which is a system container created by Rancher to handle tasks such as cross-host networking, health checking, etc.

Now that we've launched our "MongoDB" service, we'll add the "LetsChat" service to our stack. This time, we'll set the scale of the service as 2 containers in our service, provide another name like "LetsChat" and use  `sdelements/lets-chat` as the image. We will not expose any ports in the "LetsChat" service as we will plan on load balancing this application. Since we've already created the database service, we'll pick the "MongoDB" service in the **Service Links** and update the name to be `mongo` in the service links. Click on **Create** and our "LetsChat" app is ready to have a load balancer pointed to it. 

Now, you can continue to create as many other services as you want inside Rancher. 

### Load Balancing Services

Next steps would be to load balance our "LetsChat" service. Let's move on to how to [add a load balancer]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/adding-balancers/) into our stack.
