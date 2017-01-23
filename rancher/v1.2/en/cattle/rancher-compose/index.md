---
title: Rancher Compose
layout: rancher-default-v1.2
version: v1.2
lang: en
redirect_from:
  - /rancher/v1.2/zh/cattle/rancher-compose/
---

## Rancher Compose
---

The Rancher Compose tool is a multi-host version of Docker Compose. It operates within the scope of a [stack]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/stacks/) in the Rancher UI, which belongs to one [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/) and has many [hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/). The containers started by Rancher Compose will be deployed on any of the hosts in the environment that satisfy the [scheduling rules]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/). If there are no scheduling rules, then the containers of the service are launched on the hosts with the fewest containers. These containers are launched just as if you had started a service in the UI as Rancher Compose is making the same API calls.

The Rancher Compose tool works just like the popular Docker Compose and supports the V1 version of  `docker-compose.yml` files. To enable features that are supported in Rancher, you can also have a `rancher-compose.yml` which extends and overwrites the `docker-compose.yml`. For example, scale of services and health checks would be in the `rancher-compose.yml` file.

The documentation for Rancher Compose expects users to have an understanding of Docker Compose. Please read through the [Docker Compose documentation](https://docs.docker.com/compose/) before starting to work with Rancher Compose.

### Installation

The binary can be downloaded directly from the UI. The link can be found in the right hand side of the footer in the UI. We have binaries for Windows, Mac, and Linux.

You can also check the [releases page for Rancher Compose](https://github.com/rancher/rancher-compose/releases) for direct downloads of the binary.

### Setting up Rancher Compose with Rancher Server

To enable Rancher Compose to launch services in a Rancher instance, you'll need to set environment variables or pass these variables as an option in the Rancher Compose command. The environment variables that are required are`RANCHER_URL`, `RANCHER_ACCESS_KEY`, and `RANCHER_SECRET_KEY`. The access key and secret key will be an [environment API key]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-keys/). Environment API keys can be created in **API** -> **Advanced Options**.

> **Note:** By default, the API keys under the **API** section are **account API keys** and you need to create an **environment API key**, which is in the **Advanced Options**.

```bash
# Set the url that Rancher is on
$ export RANCHER_URL=http://server_ip:8080/
# Set the access key, i.e. username
$ export RANCHER_ACCESS_KEY=<username_of_environment_api_key>
# Set the secret key, i.e. password
$ export RANCHER_SECRET_KEY=<password_of_environment_api_key>
```

If you choose not to set the environment variables, you'll need to pass the same values as options as part of any Rancher Compose command.

```bash
$ rancher-compose --url http://server_ip:8080 --access-key <username_of_environment_api_key> --secret-key <password_of_environment_api_key> up
```

<br>

Now, you can use any `docker-compose.yml` file with Rancher Compose to [launch services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#adding-services-with-rancher-compose). The services will automatically be launched in your Rancher instance in the [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/) that the environment API key is located in.

Just like in Docker Compose, you can choose to interact with all services in your `docker-compose.yml` or you can select to interact with specific services by listing their names after the command.

```baseurl
$ rancher-compose up servicename1 servicename2
$ rancher-compose stop servicename2
```

### Debugging with Rancher Compose

When working with Rancher Compose, you can set the environment variable, `RANCHER_CLIENT_DEBUG`, to `true`,  which will have all CLI commands print out verbose messages of the API calls being made.

```bash
# Print verbose messages for all CLI calls
$ export RANCHER_CLIENT_DEBUG=true
```

<br>

If you don't want the verbose response on every CLI command, you can pass in `--debug` to the specific command to get the verbose messages.

```bash
$ rancher-compose --debug up -d
```

### Deleting Services/Container

By default, Rancher Compose will not delete containers/services.  This means that if you do two `up` commands in a row, the second `up` will do nothing.  This is because the first up will create everything and leave it running.  Even if you do not pass `-d` to `up`, Rancher Compose will not delete your services.  To delete a service you must use `rm`.

### Builds

Docker builds are supported in two ways.  First is to set `build:` to a git or HTTP URL that is compatible with the remote parameter in the [Docker Remote API](https://docs.docker.com/reference/api/docker_remote_api_v1.18/#build-image-from-a-dockerfile).  The second approach is to set `build:` to a local directory and the build context will be uploaded to S3 and then built on demand on each node.

For S3 based builds to work you must [setup AWS credentials](https://github.com/aws/aws-sdk-go/#configuring-credentials). We've provided a [detailed example]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/rancher-compose/build/) of how to build using S3 in Rancher Compose.
