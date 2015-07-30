---
title: Rancher Compose
layout: rancher-default

---

## Rancher Compose
---

The `rancher-compose` tool works just like the popular `docker-compose` and supports any `docker-compose.yml` file. When we launch a service in rancher-compose, it will show up in the specified Rancher server instance. We also have a `rancher-compose.yml` which extends and overwrites `docker-compose.yml.` The rancher-compose yaml file are attributes only supported in Rancher, for example, scale of a service.

The documentation for `rancher-compose` expects users to have an understanding of `docker-compose`. Please read through the [docker-compose documentation](https://docs.docker.com/compose/) before starting to work with `rancher-compose`.

The binary can be downloaded directly from the UI. The link can be found on the **Applications** -> **Stacks** page in the upper right corner. We have binaries for Windows, Mac, and Linux.

To enable `rancher-compose` to launch services in a Rancher instance, you'll need to set a couple of environment variables:`RANCHER_URL`, `RANCHER_ACCESS_KEY`, and `RANCHER_SECRET_KEY`. The access key and secret key will be an [API key]({{site.baseurl}}/rancher/configuration/api-keys/). 

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

`rancher-compose` supports any command that `docker-compose` supports.

Name | Description
----|-----
`create`	| Create all services but do not start
`up`		| Bring all services up
`start`	| Start services
`logs`	| 	Get service logs
`restart`	| Restart services
`stop`, `down` |	Stop services
`scale`	| Scale services
`rm`		| Delete services
`upgrade`	| Perform rolling upgrade between services
`help`, `h`	| Shows a list of commands or help for one command

### Rancher-Compose Options

Whenever you use the `rancher-compose` command, there are different options that you can use. 

Name | Description
--- | ---
`--verbose`, `--debug`	|		
`--file`, `-f` `"docker-compose.yml"`|	Specify an alternate compose file (default: docker-compose.yml) [$COMPOSE_FILE]
`--project-name`, `-p` 		|	Specify an alternate project name (default: directory name)
`--url` 				| Specify the Rancher API endpoint URL [$RANCHER_URL]
`--access-key` 			| Specify Rancher API access key [$RANCHER_ACCESS_KEY]
`--secret-key` 		|	Specify Rancher API secret key [$RANCHER_SECRET_KEY]
`--rancher-file`, `-r` 	|		Specify an alternate Rancher compose file (default: rancher-compose.yml)
`--help`, `-h`			|	show help
`--version`, `-v`		|	print the version

### Command Options

#### Up Command

When you run the `up` command with `rancher-compose`, after all the tasks are complete, the process continues to run. If you want the process to exit, you'll need to add in the `-d` option, which is to not block and log. 

Name | Description
---|----
`-d` |	Do not block and log

#### Logs Command

Name | Description
---|----
   `--lines "100"` |	number of lines to tail

#### Restart/Stop/Down Command

Name | Description
---|----
   `--timeout`, `-t` `"10"` |	Specify a shutdown timeout in seconds.

#### Rm Command

Name | Description
---|----
`--force`, `-f`	| Allow deletion of all services

#### Upgrade Command

Rancher supports upgrades to services using `rancher-compose`. Please read more about when and how to [upgrade your services]({{site.baseurl}}/rancher/rancher-compose/upgrading/).

Name | Description
---|----
`--batch-size` `"2"`	| Number of containers to upgrade at once
`--scale` `"-1"`		| Final number of running containers
`--interval` `"2000"`	 | Update interval in milliseconds
`--update-links`	| Update inbound links on target service
`--wait`, `-w`		| Wait for upgrade to complete

### Compose Compatibility

`rancher-compose` strives to be completely compatible with Docker Compose.  Since `rancher-compose` is largely focused on running production workloads some behaviors between Docker Compose and Rancher Compose are different.

We support anything that can be created in a standard [docker-compose.yml](https://docs.docker.com/compose/yml/) file. There are a couple of differences in the behavior of rancher-compose that are documented below.


#### Deleting Services/Container

`rancher-compose` will not delete things by default.  This means that if you do two `up` commands in a row, the second `up` will do nothing.  This is because the first up will create everything and leave it running.  Even if you do not pass `-d` to `up`, `rancher-compose` will not delete your services.  To delete a service you must use `rm`.

#### Builds

Docker builds are supported in two ways.  First is to set `build:` to a git or HTTP URL that is compatible with the remote parameter in https://docs.docker.com/reference/api/docker_remote_api_v1.18/#build-image-from-a-dockerfile.  The second approach is to set `build:` to a local directory and the build context will be uploaded to S3 and then built on demand on each node.

For S3 based builds to work you must [setup AWS credentials](https://github.com/aws/aws-sdk-go/#configuring-credentials).

### Sidekicks

With services, you may want to have your service use `volumes_from` and `net` to point to another service. In order for these to work, you need to set up a sidekick relationship. The sidekick relationship is how Rancher scales and schedules these services as one unit. Example: B is a sidekick of A, so the services will always deploy as a pair and scale of the services will always be the same. 

Another time that you may want to define the sidekick relationship is if you have multiple services that always need to be deployed on the same host.

To set a sidekick relationship, you add a label to one of the services. The key of the label will be `io.rancher.sidekicks` and the value will be the service(s). If you have multiple services to add as sidekicks, they should be separated with commas. Example: `io.rancher.sidekicks: sidekick1, sidekick2, sidekick3` 

> **Note:** Whichever service contains the sidekick label is considered the primary service. The scale of the primary service will be used as the scale for all services in the sidekicks label. If your scale among all your services are different, then the scale of the primary service will be used for all services.

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

Sample `rancher-compose.yml`

```yaml
test:
  scale: 2
test-data:
  scale: 2
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

In this example, the `alldbs` stack has a `db1` service that the wordpress service will link to.