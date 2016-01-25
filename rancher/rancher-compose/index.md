---
title: Rancher Compose
layout: rancher-default

---

## Rancher Compose
---

The `rancher-compose` tool is like a multi-host version of `docker-compose`. It operates within the scope of a [stack]({{site.baseurl}}/rancher/rancher-ui/applications/stacks/) in the Rancher UI, which belongs to one [environment]({{site.baseurl}}/rancher/configuration/access-control/) and has many [hosts]({{site.baseurl}}/rancher/rancher-ui/infrastructure/hosts/). The containers started by `rancher-compose` will go onto any of the hosts in the environment that meet the [scheduling rules]({{site.baseurl}}/rancher/rancher-compose/scheduling/), just like the containers would start the UI as they are calling the same API.

The `rancher-compose` tool works just like the popular `docker-compose` and supports any `docker-compose.yml` file. There is also a `rancher-compose.yml` which extends and overwrites `docker-compose.yml.` The rancher-compose yaml file are attributes only supported in Rancher, for example, scale of a service.

The documentation for `rancher-compose` expects users to have an understanding of `docker-compose`. Please read through the [docker-compose documentation](https://docs.docker.com/compose/) before starting to work with `rancher-compose`.

The binary can be downloaded directly from the UI. The link can be found on the **Applications** -> **Stacks** page in the upper right corner. We have binaries for Windows, Mac, and Linux.

To enable `rancher-compose` to launch services in a Rancher instance, you'll need to set a couple of environment variables or pass them into the `rancher-compose command` as an option:`RANCHER_URL`, `RANCHER_ACCESS_KEY`, and `RANCHER_SECRET_KEY`. The access key and secret key will be an [API key]({{site.baseurl}}/rancher/configuration/api-keys/). 

```bash
# Set the url that Rancher is on
$ export RANCHER_URL=http://server_ip:8080/
# Set the access key, i.e. username
$ export RANCHER_ACCESS_KEY=<username_of_key>
# Set the secret key, i.e. password
$ export RANCHER_SECRET_KEY=<password_of_key>
```

Now, you can create run any `docker-compose.yml` file using `rancher-compose`. The containers will automatically be launched in your Rancher instance in the [environment]({{site.baseurl}}/rancher/configuration/environments/) that the API key is located in.

### Commands

To read more about the different commands and options, please read our [rancher-compose command]({{site.baseurl}}/rancher/rancher-compose/commands/) documentation. 

#### Command Examples

```bash
# Creating and starting a service without environment variables and picking a stack
$ rancher-compose --url URL_of_Rancher --access-key username_of_API_key --secret-key password_of_API_key -p stack1 up
# To change the scale of an existing service
$ rancher-compose -p stack1 scale web=3
```

#### Deleting Services/Container

`rancher-compose` will not delete things by default.  This means that if you do two `up` commands in a row, the second `up` will do nothing.  This is because the first up will create everything and leave it running.  Even if you do not pass `-d` to `up`, `rancher-compose` will not delete your services.  To delete a service you must use `rm`.

### Builds

Docker builds are supported in two ways.  First is to set `build:` to a git or HTTP URL that is compatible with the remote parameter in the [Docker Remote API](https://docs.docker.com/reference/api/docker_remote_api_v1.18/#build-image-from-a-dockerfile).  The second approach is to set `build:` to a local directory and the build context will be uploaded to S3 and then built on demand on each node.

For S3 based builds to work you must [setup AWS credentials](https://github.com/aws/aws-sdk-go/#configuring-credentials). We've provided a [detailed example]({{site.baseurl}}/rancher/rancher-compose/build/) of how to build in rancher-compose.

### Sidekicks

With services, you may want to have your service use `volumes_from` and `net` to point to another service. In order for these to work, you need to set up a sidekick relationship. The sidekick relationship is how Rancher scales and schedules these services as one unit. Example: B is a sidekick of A, so the services will always deploy as a pair and scale of the services will always be the same. 

Another time that you may want to define the sidekick relationship is if you have multiple services that always need to be deployed on the same host.

To set a sidekick relationship, you add a label to one of the services. The key of the label will be `io.rancher.sidekicks` and the value will be the service(s). If you have multiple services to add as sidekicks, they should be separated with commas. Example: `io.rancher.sidekicks: sidekick1, sidekick2, sidekick3`

When defining a sidekick to a service, you do not need to link the services in `rancher-compose` as sidekicks are automatically DNS-resolved to each other.

#### Primary Service

Whichever service contains the sidekick label is considered the primary service, and the sidekicks are considered secondary services. The scale of the primary service will be used as the scale for all services in the sidekicks label. If your scale among all your services are different, then the scale of the primary service will be used for all services.

When using [load balancers]({{site.baseurl}}/rancher/rancher-compose/rancher-services/#load-balancer) with services that have sidekicks, you need to use the primary service as the target of the load balancer. A sidekick **can not** be the target.

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

If you have multiple services that will be using the same container to do a `volumes_from`, you can add the second service as a sidekick of the primary service and use the same data container. Only a primary service can be a target of a load balancer, so please make sure the correct service is chosen as the primary service (i.e. the one with the sidekick labels). 

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

### Cross-Stack Linking

In Rancher, we allow linking of services across stacks, which is easy to represent in the `docker-compose.yml` file.

Services in other stacks will be linked in `external_links`.

Sample configuration `docker-compose.yml`

```
wordpress:
  image: wordpress
  external_links:
    - alldbs/db1:mysql
```
<br>
In this example, the `alldbs` stack has a `db1` service that the wordpress service will link to.