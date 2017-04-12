---
title: Services
layout: rancher-default-v1.6
version: v1.6
lang: en
---

## Services
---

Cattle adopts the standard Docker Compose terminology for services and defines a basic service as one or more containers created from the same Docker image.  Once a service (consumer) is linked to another service (producer) within the same [stack]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/stacks/), a [DNS record]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/internal-dns-service/) mapped to each container instance is automatically created and discoverable by containers from the "consuming" service. Other benefits of creating a service under Rancher include:

* Service High Availability (HA): Rancher constantly monitors the state of your containers within a service and actively manages to ensure the desired scale of the service.  This can be triggered when there are fewer (or even more) healthy containers than the desired scale of your service, a host becomes unavailable, a container fails, or is unable to meet a health check.

* [Health Monitoring]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/health-checks/): Rancher implements a health monitoring system by running a `healthcheck` infrastructure service across its hosts to coordinate the distributed health checking of containers and services. These `healthcheck` containers internally utilize HAProxy to validate the health status of your applications. When health checks are enabled either on an individual container or a service, each container is then monitored.

### Services Options in the UI

In the following examples, we'll assume you've already created a [stack]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/stacks/), set up your [hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/), and are ready to build your application.

We'll review some of the options within adding a service and at the end walk through how to create a [LetsChat](http://sdelements.github.io/lets-chat/) application linked to a Mongo database.

Inside your stack, you add a service by clicking the **Add Service** button. Alternatively, if you are viewing the stacks at the stack level, the same **Add Service** button is visible for each individual stack.

In the **Scale** section, you can use the slider for the specific number of containers you want launched for a service. Alternatively, you can select **Always run one instance of this container on every host**. With this option, your service will scale for any additional hosts that are added to your [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/). If you have created scheduling rules in the **Scheduling** tab, Rancher will only start containers on the hosts that meet the scheduling rules.

You will also need to provide a **Name** and if desired, **Description** of the service.

Provide the **Image** to use. You can use any image on [DockerHub](https://hub.docker.com/) as well as any [registries]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/registries) that have been added to your [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/). The syntax for image name  match any `docker run` commands.

Syntax of image names. By default, we pull from the docker registry. If no tag is specified, we will pull the latest tag.

`[registry-name]/[namespace]/[imagename]:[version]`

Underneath the image name, there is a checkbox for `Always pull image before creating`. By default, this is enabled. When this option is enabled, the image for the service will **always** be pulled on the host even if image is already cached for any time a container is launched on the host.

#### Options

Rancher strives to maintain parity with Docker and we aim to support any option that `docker run` supports. Port mapping and service links are shown on the main page, but all other options are in the different tabs.

By default, all containers in a service are running in detached mode, i.e. `-d` in a `docker run` command.

##### Port Mapping

When we are mapping ports, we are creating the ability to access the exposed ports of the container to a public port on the host. In the **Port Map** section, you define the public ports that will be exposed on the host. This port will direct traffic to the defined private port. The private port is typically the port that is exposed on the container (i.e. `EXPOSE` in the [Dockerfile](https://docs.docker.com/engine/reference/builder/#expose) of the image). Whenever you map a port, Rancher will check the host to see if there are any port conflicts on the host before attempting to launch the container.

When using port mapping, if the scale of your service is more than the number of hosts with available port(s), your service will become stuck in an activating state. If you look at the details of your service, you will be able to see a container in `Error` state, which will indicate that the container failed due to inability to find an open port on a host. The service will continue to try and if a host/port(s) becomes available, the service will launch a container on that host.

> **Note:** When ports are exposed in Rancher, it will only display the port upon creating. If there are any edits to the port mapping, it will not update in `docker ps` as Rancher manages the iptable rules to make the ports fully dynamic.

##### Random Port Mapping

If you would like to take advantage of Rancher's random port mapping, the public port can be left blank and you only need to define the private port.

##### Linking Services

If other services have already been created in your environment, you can link services to the service that you are creating. Linking services will link all containers in the service to all containers in the linked service. Linking services acts like the `--link` functionality in a `docker run` command.

Linking services is additional functionality on top of Rancher's [internal DNS]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/internal-dns-service/) and is not required to resolve services by service name.

#### Rancher Options

Besides providing all the options that `docker run` support, Rancher provides additional concepts available in the UI.

##### Health Checks

If a host is down in Rancher (i.e. in `reconnecting` or `inactive` state), you will need to implement a health check in order for Rancher to launch the containers on your service on to a different host.

> **Note:** Health checks will only work for services that are using the managed network. If you select any other network choice, it will **not** be monitored.

In the **Health Check** tab, you can check TCP connections or HTTP responses for services.

Read more details about how Rancher handles [health checks]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/health-checks/).

##### Labels/Scheduling

In the **Labels** tab, Rancher allows you to add any labels to containers in a service. Labels are very useful to be used when creating scheduling rules. In the **Scheduling** tab, you can use the [host labels]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#host-labels), container/service labels, and container/service names to create where you want the containers of your service to be scheduled.

Read more details about [labels and scheduling]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/).

### Adding Services in the UI  

First, let's create our _database_ service by setting the scale to be 1 container, giving it a name `database`, and using the `mongo:latest` as the image. There are no other options that need to be set to get this service running, so click on **Create**. The service will immediately start to launch.

Now that we've launched our _database_ service, we'll add the _web_ service to our stack. This time, we'll set the scale of the service as 2 containers in our service, provide another name `web` and use `sdelements/lets-chat` as the image. We will not expose any ports in the _web_ service as we will plan on load balancing to this service. Since we've already created the _database_ service, we'll pick the _database_ service in the **Service Links** and put the "as name" to be `mongo` in the service links. Click on **Create** and our [LetsChat](http://sdelements.github.io/lets-chat/) app is ready to have a load balancer pointed to it.

### Service Options in Rancher Compose

Read more about how to [set up Rancher Compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/rancher-compose/).

The  Rancher Compose tool works just like the popular Docker Compose and supports the V1 and V2 versions of `docker-compose.yml` files. To enable features that are supported in Rancher, you can also have a `rancher-compose.yml` which extends and overwrites the `docker-compose.yml`. For example, scale of services and health checks would be in the `rancher-compose.yml` file.

If you're new to Docker Compose or Rancher Compose, we recommend using the UI to start your services. IF you click on a stack name, you can view the configuration of the entire stack (i.e. the equivalent `docker-compose.yml` and `rancher-compose.yml` files of your stack) by clicking on **View Config** in the stack drop down.

#### Linking Services

In Rancher, all services within an environment are DNS resolvable so linking services explicitly is not required, unless you would like to use a specific alias for DNS resolution.

> **Note:** We currently do not support linking sidekick services to the primary service or vice versa. Read more about how [Rancher's internal DNS works]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/internal-dns-service/).

For services in the same stack, any service is DNS resolvable by it's native `service_name`, if you so wish, you can use links present this service under another alias.

##### Example  `docker-compose.yml`

```yaml
version: '2'
services:
  web:
    labels:
      io.rancher.container.pull_image: always
    tty: true
    image: sdelements/lets-chat
    links:
    - database:mongo
    stdin_open: true
  database:
    labels:
      io.rancher.container.pull_image: always
    tty: true
    image: mongo
    stdin_open: true
```
<br>
In this example, the `database` would be resolvable as `mongo`. Without the link, `database` would be resolvable as `database` fro the _web_ service.

For services in a different stack, the service is DNS already resolvable by `service_name.stack_name`. If you'd prefer to use a specific alias for DNS resolution, you can use `external_links` in the `docker-compose.yml`.

##### Example  `docker-compose.yml`

```yaml
version: '2'
services:
  web:
    image: sdelements/lets-chat
    external_links:
    - alldbs/db1:mongo
```
<br>

In this example, the `alldbs` stack has a `db1` service that the `web` service will link to. In the `web` service, `db1` would be resolvable as `mongo`. Without the external link, `db1` would be resolvable as `db1.alldbs`.

> **Note:** Cross stack discovery is limited by environment (by design). Cross environment discovery is not supported.

### Adding Services with Rancher Compose

Read more about how to [set up Rancher Compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/rancher-compose/).

We'll set up the same example that we used above in the UI example. To get started, you will need to create a `docker-compose.yml` file and a `rancher-compose.yml` file. With Rancher Compose, we can launch all the services in the application at once. If there is no `rancher-compose.yml` file, then all services will start with a scale of 1 container.

#### Example `docker-compose.yml`

```yaml
version: '2'
services:
  web:
    labels:
      io.rancher.container.pull_image: always
    tty: true
    image: sdelements/lets-chat
    links:
    - database:mongo
    stdin_open: true
  database:
    labels:
      io.rancher.container.pull_image: always
    tty: true
    image: mongo
    stdin_open: true
```

#### Example `rancher-compose.yml`

```yaml
# Reference the service that you want to extend
version: '2'
services:
  web:
    scale: 2
  database:
    scale: 1
```
<br>
After your files are created, you can launch the services into Rancher server.

```bash
# Creating and starting a service without environment variables and selecting a stack
# If no stack is provided, the stack name will be the folder name that the command is running from
# If the stack does not exist in Rancher, it will be created
$ rancher-compose --url URL_of_Rancher --access-key <username_of_environment_api_key> --secret-key <password_of_environment_api_key> -p LetsChatApp up -d

# Creating and starting a service with environment variables already set
$ rancher-compose -p LetsChatApp up -d
```

### Sidekick Services

Rancher supports the colocation, scheduling, and lock step scaling of a set of services by allowing users to group these services by using the notion of sidekicks.  A service with one or more sidekicks is typically created to support shared volumes (i.e. `--volumes_from`) and networking (i.e. `--net=container`) between containers.

With services, you may want to have your service use `volumes_from` and `net` to another service. In order for these to work, you need to set up a sidekick relationship. The sidekick relationship is how Rancher scales and schedules these services as one unit onto hosts. Example: B is a sidekick of A, so the services will always deploy as a pair and scale of the services will always be the same.

Another time that you may want to define the sidekick relationship is if you have multiple services that always need to be deployed on the same host.

When defining a sidekick to a service, you do not need to link the services as sidekicks are automatically DNS-resolved to each other.

When using [load balancers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/) with services that have sidekicks, you need to use the primary service as the target of the load balancer. A sidekick **can not** be the target.

Read more about [Rancher's internal DNS]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/internal-dns-service/).

#### Adding Sidekicks in the UI

To set a sidekick relationship, you can click on **+ Add Sidekick Container**, which is located within the scale section. The first service is considered the primary service and each additional sidekick is a secondary service.

#### Adding Sidekicks through Rancher Compose

To set a sidekick relationship, you add a label to one of the services. The key of the label will be `io.rancher.sidekicks` and the value will be the service(s). If you have multiple services to add as sidekicks, they should be separated with commas. Example: `io.rancher.sidekicks: sidekick1, sidekick2, sidekick3`

##### Primary Service

Whichever service contains the sidekick label is considered the primary service, and the sidekicks are considered secondary services. The scale of the primary service will be used as the scale for all services in the sidekicks label. If your scale among all your services are different, then the scale of the primary service will be used for all services.

When using [load balancers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/) with services that have sidekicks, you can only target the primary service. A sidekick **can not** be the target.

##### Example of Sidekicks in Rancher Compose:

Example `docker-compose.yml`

```yaml
version: '2'
services:
  test:
    tty: true
    image: ubuntu:14.04.2
    stdin_open: true
    volumes_from:
    - test-data
    labels:
      io.rancher.sidekicks: test-data
  test-data:
    tty: true
    command:
    - cat
    image: ubuntu:14.04.2
    stdin_open: true
```

<br>
Example `rancher-compose.yml`

```yaml
version: '2'
services:
  test:
    scale: 2
  test-data:
    scale: 2
```

##### Example of Sidekicks in Rancher Compose: Multiple services using the same service for `volumes_from`

If you have multiple services that will be using the same container to do a `volumes_from`, you can add the second service as a sidekick of the primary service and use the same data container. Since only the primary service can be a target of a load balancer, please make sure the correct service is chosen as the primary service (i.e. the one that will have the sidekick label).

Example `docker-compose.yml`

```yaml
version: '2'
services:
  test-data:
    tty: true
    command:
    - cat
    image: ubuntu:14.04.2
    stdin_open: true
  test1:
    tty: true
    image: ubuntu:14.04.2
    stdin_open: true
    labels:
      io.rancher.sidekicks: test-data, test2
    volumes_from:
    - test-data
  test2:
    tty: true
    image: ubuntu:14.04.2
    stdin_open: true
    volumes_from:
    - test-data
```
