---
title: Rancher Compose
layout: rancher-default-v1.0
version: v1.0
lang: en
redirect_from:
  - /rancher/v1.0/en/cattle/rancher-compose/
---

## Rancher Compose
---

The `rancher-compose` tool is a multi-host version of `docker-compose`. It operates within the scope of a [stack]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/) in the Rancher UI, which belongs to one [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/environments/) and has many [hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/infrastructure/hosts/). The containers started by `rancher-compose` will be deployed on any of the hosts in the environment that satisfy the [scheduling rules]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-compose/scheduling/). If there are no scheduling rules, then the containers of the service are launched on the hosts with the fewest containers. These containers are launched just as if you had started a service in the UI as rancher-compose is making the same API calls.

The `rancher-compose` tool works just like the popular `docker-compose` and supports the V1 version of  `docker-compose.yml` files. To enable features that are supported in Rancher, you can also have a `rancher-compose.yml` which extends and overwrites the `docker-compose.yml`. For example, scale of services and health checks would be in the `rancher-compose.yml` file.

The documentation for `rancher-compose` expects users to have an understanding of `docker-compose`. Please read through the [docker-compose documentation](https://docs.docker.com/compose/) before starting to work with `rancher-compose`.

## Installation
---

The binary can be downloaded directly from the UI. The link can be found in the right hand side of the footer in the UI. We have binaries for Windows, Mac, and Linux.

You can also check the [releases page for rancher-compose](https://github.com/rancher/rancher-compose/releases) for direct downloads of the binary.

## Setting up Rancher-Compose with Rancher Server
---

To enable `rancher-compose` to launch services in a Rancher instance, you'll need to set environment variables or pass these variables as an option in the `rancher-compose` command. The environment variables that are required are`RANCHER_URL`, `RANCHER_ACCESS_KEY`, and `RANCHER_SECRET_KEY`. The access key and secret key will be an [environment API key]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/api-keys/).

```bash
# Set the url that Rancher is on
$ export RANCHER_URL=http://server_ip:8080/
# Set the access key, i.e. username
$ export RANCHER_ACCESS_KEY=<username_of_environment_api_key>
# Set the secret key, i.e. password
$ export RANCHER_SECRET_KEY=<password_of_environment_api_key>
```

If you choose not to set the environment variables, you'll need to pass the same values as options as part of any `rancher-compose` command.

```bash
$ rancher-compose --url http://server_ip:8080 --access-key <username_of_environment_api_key> --secret-key <password_of_environment_api_key> up
```

<br>

Now, you can use any `docker-compose.yml` file with `rancher-compose` to launch services. The services will automatically be launched in your Rancher instance in the [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/environments/) that the environment API key is located in.


### Launching a Simple Service

To get started, you can create a simple `docker-compose.yml` file and optionally a `rancher-compose.yml` file. If there is no `rancher-compose.yml` file, then all services will start with a scale of 1 container.

Sample `docker-compose.yml`

```yaml
service1:
  image: nginx
```

Sample `rancher-compose.yml`

```yaml
# Reference the service that you want to extend
service1:
  scale: 2
```

After your files are created, you can launch the services into Rancher server.

```bash
# Creating and starting a service without environment variables and selecting a stack
# If no stack is provided, the stack name will be the folder name that the command is running from
# If the stack does not exist in Rancher, it will be created
$ rancher-compose --url URL_of_Rancher --access-key <username_of_environment_api_key> --secret-key <password_of_environment_api_key> -p stack1 up

# Creating and starting a service with environment variables already set
$ rancher-compose -p stack1 up

# To change the scale of an existing service
$ rancher-compose -p stack1 scale service1=3
```

To read more about the different commands and options, please read our [rancher-compose command]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-compose/commands/) documentation.


### Deleting Services/Container

By default, `rancher-compose` will not delete containers/services.  This means that if you do two `up` commands in a row, the second `up` will do nothing.  This is because the first up will create everything and leave it running.  Even if you do not pass `-d` to `up`, `rancher-compose` will not delete your services.  To delete a service you must use `rm`.

## Builds
---

Docker builds are supported in two ways.  First is to set `build:` to a git or HTTP URL that is compatible with the remote parameter in the [Docker Remote API](https://docs.docker.com/reference/api/docker_remote_api_v1.18/#build-image-from-a-dockerfile).  The second approach is to set `build:` to a local directory and the build context will be uploaded to S3 and then built on demand on each node.

For S3 based builds to work you must [setup AWS credentials](https://github.com/aws/aws-sdk-go/#configuring-credentials). We've provided a [detailed example]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-compose/build/) of how to build using S3 in rancher-compose.

## Rancher Concepts in Rancher-Compose
---

### Sidekicks

With services, you may want to have your service use `volumes_from` and `net` to point to another service. In order for these to work, you need to set up a sidekick relationship. The sidekick relationship is how Rancher scales and schedules these services as one unit. Example: B is a sidekick of A, so the services will always deploy as a pair and scale of the services will always be the same.

Another time that you may want to define the sidekick relationship is if you have multiple services that always need to be deployed on the same host.

To set a sidekick relationship, you add a label to one of the services. The key of the label will be `io.rancher.sidekicks` and the value will be the service(s). If you have multiple services to add as sidekicks, they should be separated with commas. Example: `io.rancher.sidekicks: sidekick1, sidekick2, sidekick3`

When defining a sidekick to a service, you do not need to link the services in `rancher-compose` as services within an environment are automatically DNS-resolvable to each other.

#### Primary Service

Whichever service contains the sidekick label is considered the primary service, and the sidekicks are considered secondary services. The scale of the primary service will be used as the scale for all services in the sidekicks label. If your scale among all your services are different, then the scale of the primary service will be used for all services.

When using [load balancers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-compose/rancher-services/#load-balancer) with services that have sidekicks, you can only target the primary service. A sidekick **can not** be the target.

#### Example of Sidekicks in Rancher-Compose:

Sample configuration `docker-compose.yml`

```yaml
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
Sample `rancher-compose.yml`

```yaml
test:
  scale: 2
test-data:
  scale: 2
```

#### Example of Sidekicks in Rancher-Compose: Multiple services using the same service for `volumes_from`

If you have multiple services that will be using the same container to do a `volumes_from`, you can add the second service as a sidekick of the primary service and use the same data container. Since only the primary service can be a target of a load balancer, please make sure the correct service is chosen as the primary service (i.e. the one that will have the sidekick label).

```yaml
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

### Linking Services

In Rancher, all services within an environment are DNS resolvable so linking services explicitly is not required, unless you would like to use a specific alias for DNS resolution.

> **Note:** We currently do not support linking sidekick services to the primary service or vice versa. Read more about how [Rancher's internal DNS works]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/internal-dns-service/).

For services in the same stack, any service is DNS resolvable by it's native `service_name`, if you so wish, you can use links present this service under another alias.


Sample `docker-compose.yml`

```yaml
wordpress:
  image: wordpress
  links:
  - db:mysql
db:
  image: mysql
```
In this example, the `db` would be resolvable as `mysql`. Without the link, `db` would be resolvable as `db`.


For services in a different stack, the service is DNS already resolvable by `service_name.stack_name`. If you'd prefer to use a specific alias for DNS resolution, you can use `external_links` in the `docker-compose.yml`.

Sample `docker-compose.yml`

```yaml
wordpress:
  image: wordpress
  external_links:
    - alldbs/db1:mysql
```
<br>

In this example, the `alldbs` stack has a `db1` service that the wordpress service will link to. In the `wordpress` service, `db1` would be resolvable as `mysql`. Without the external link, `db1` would be resolvable as `db1.alldbs`.

> **Note:** Cross stack discovery is limited by environment (by design). Cross environment discovery is not supported.
