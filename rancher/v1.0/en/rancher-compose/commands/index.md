---
title: Rancher Compose Commands and Options
layout: rancher-default-v1.0
version: v1.0
lang: en
---

## Rancher Compose Command and Options
---

The `rancher-compose` tool works just like the popular `docker-compose` and supports the V1 version of  `docker-compose.yml` files. To enable features that are supported in Rancher, you can also have a `rancher-compose.yml` which extends and overwrites the `docker-compose.yml`. For example, scale of services and health checks would be in the `rancher-compose.yml` file.

## Rancher-Compose Commands
---

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
`pull` | Pulls images for services
`upgrade`	| Perform rolling upgrade between services
`help`, `h`	| Shows a list of commands or help for one command

## Rancher-Compose Options
---

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
`--env-file`, `-e` 		|	Specify a file from which to read environment variables
`--help`, `-h`			|	show help
`--version`, `-v`		|	print the version

<br>

### Examples

To get started, you can create a simple `docker-compose.yml` file and optionally a `rancher-compose.yml` file. If there is no `rancher-compose.yml` file, then all services will start with a scale of 1 container.

Sample `docker-compose.yml`

```yaml
web:
  image: nginx
```

Sample `rancher-compose.yml`

```yaml
# Reference the service that you want to extend
web:
  scale: 2
```

After your files are created, you can launch the services into Rancher server.

```bash
# Creating and starting a service without environment variables and selecting a stack
# If the stack does not exist in Rancher, it will be created in Rancher
$ rancher-compose --url URL_of_Rancher --access-key <username_of_environment_api_key> --secret-key <password_of_environment_api_key> -p stack1 up

# Creating and starting a service with environment variables already set
$ rancher-compose -p stack1 up

# To change the scale of an existing service
$ rancher-compose -p stack1 scale service1=3
```

<br>

> **Note:** If you don't pass in `-p <STACK_NAME>`, the stack name will be the directory that you are running the `rancher-compose` command in.

## Command Options
---

### Up Command

Name | Description
---|----
`--pull`, `-p` |				Before doing the upgrade do an image pull on all hosts that have the image already
`-d` |					Do not block and log
`--upgrade`, `-u`, `--recreate` |		Upgrade if service has changed
`--force-upgrade`, `--force-recreate` |	Upgrade regardless if service has changed
`--confirm-upgrade`, `-c` |		Confirm that the upgrade was success and delete old containers
`--rollback`, `-r` |			Rollback to the previous deployed version
`--batch-size "2"`	 |		Number of containers to upgrade at once
`--interval "1000"`	 |		Update interval in milliseconds

<br>

When you run the `up` command with `rancher-compose`, after all the tasks are complete, the process continues to run. If you want the process to exit after completion, you'll need to add in the `-d` option, which is to not block and log.

```bash
# If you do not use the -d flag, rancher-compose will continue to run until you Ctrl+C to quit
$ rancher-compose up

# Use the -d flag for rancher-compose to exit after running
$ rancher-compose up -d
```

Read more about [upgrading using rancher-compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-compose/upgrading/).

### Start Command

Name | Description
---|----
`-d` |	Do not block and log

<br>

If you want the start process to exit after completion, you'll need to add in the `-d` option, which is to not block and log.

### Logs Command

Name | Description
---|----
`--lines "100"` |	number of lines to tail

### Restart Command

Name | Description
---|----
`--batch-size` `"1"` |	Number of containers to retart at once
`--interval` `"0"` |	Restart interval in milliseconds

<br>

By default, restarting services will restart the containers individually and immediately sequentially. You can set the batch size and interval of the restart policy.

### Stop/Down & Scale Command

Name | Description
---|----
`--timeout`, `-t` `"10"` |	Specify a shutdown timeout in seconds.

<br>

```yaml
# To change the scale of an existing service
$ rancher-compose -p stack1 scale service1=3
```

### Rm Command

Name | Description
---|----
`--force`, `-f`	| Allow deletion of all services

When removing services, `rancher-compose` will only delete the services that are found in the `docker-compose.yml`. If there are more services within the stack in Rancher, they will not be deleted as rancher-compose will not know they exist.

Also, the stack will not be deleted as rancher-compose will not be aware if there are any remaining services.


### Pull Command

Name | Description
---|----
`--cached`, `-c` |	Only update hosts that have the image cached, don't pull new

<br>

```bash
# Pulls new images for all services located in the docker-compose.yml file on ALL hosts in the environment
$ rancher-compose pull

# Pulls new images for all services located in docker-compose.yml file on hosts that already have the image
$ rancher-compose pull --cached
```

<br>

> **Note:** Unlike `docker-compose pull`, you will not be specifying which service to pull. Rancher-compose looks at all services in the `docker-compose.yml` and pulls images for all services found in the file.

### Upgrade Command

You can upgrade your services in Rancher using `rancher-compose`. Please read more about when and how to [upgrade your services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-compose/upgrading/).


## Deleting Services/Container
---

`rancher-compose` will not delete things by default.  This means that if you do two `up` commands in a row, the second `up` will do nothing.  This is because the first up will create everything and leave it running.  Even if you do not pass `-d` to `up`, `rancher-compose` will not delete your services.  To delete a service you must use `rm`.
