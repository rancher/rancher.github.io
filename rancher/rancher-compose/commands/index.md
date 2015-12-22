---
title: Rancher Compose Commands and Options
layout: rancher-default

---

## Rancher Compose Command and Options
---

The `rancher-compose` tool works just like the popular `docker-compose` and supports any `docker-compose.yml` file. There is also a `rancher-compose.yml` which extends and overwrites `docker-compose.yml.` The rancher-compose yaml file are attributes only supported in Rancher, for example, scale of a service.


## Rancher-Compose Commands

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

```bash
# Starting a service without environment variables and defining a stack name
$ rancher-compose --url URL_of_Rancher --access-key username_of_API_key --secret-key password_of_API_key -p stack1 up
# To change the scale of an existing service
$ rancher-compose -p stack1 scale web=3
```

> **Note:** If you don't pass in `-p STACK_NAME`, the stack name will be the directory that you are running the `rancher-compose` command in.

##Command Options

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
# If you do not use the -d flag, rancher-compose will continue to run until you Ctrl+C to quit. 
$ rancher-compose up
# Use the -d for rancher-compose to exit after running
$ rancher-compose up -d
```

Read more about [upgrading using rancher-compose]({{site.baseurl}}/rancher/rancher-compose/upgrading/).

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
<br>

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

### Rm Command

Name | Description
---|----
`--force`, `-f`	| Allow deletion of all services

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

> **Note:** Unlike `docker-compose pull`, you will not be specifying which service to pull. Rancher-compose looks at all services in the `docker-compose.yml` and pulls images for all services found in the file. 

### Upgrade Command

Rancher supports upgrades to services using `rancher-compose`. Please read more about when and how to [upgrade your services]({{site.baseurl}}/rancher/rancher-compose/upgrading/).

Name | Description
---|----
`--batch-size` `"2"`	| Number of containers to upgrade at once
`--scale` `"-1"`		| Final number of running containers
`--interval` `"2000"`	 | Update interval in milliseconds
`--update-links`	| Update inbound links on target service
`--wait`, `-w`		| Wait for upgrade to complete
`--pull`, `-p`		| Before doing the upgrade do an image pull on all hosts that have the image already
`--cleanup`, `-c`	| Remove the original service definition once upgraded, implies `--wait`

<br>

```bash
# Upgrade service1 to service2 
# service1 and service2 to be defined in the docker-compose.yml
$ rancher-compose upgrade service1 service2 

# Upgrade to a different scale
$ rancher-compose upgrade service1 service2 --scale 5

# Removes service1 from Rancher
$ rancher-compose upgrade service1 service2 --cleanup
```

## Compose Compatibility

`rancher-compose` strives to be completely compatible with Docker Compose.  Since `rancher-compose` is largely focused on running production workloads some behaviors between Docker Compose and Rancher Compose are different.

We support anything that can be created in a standard [docker-compose.yml](https://docs.docker.com/compose/yml/) file. There are a couple of differences in the behavior of rancher-compose that are documented below.


## Deleting Services/Container

`rancher-compose` will not delete things by default.  This means that if you do two `up` commands in a row, the second `up` will do nothing.  This is because the first up will create everything and leave it running.  Even if you do not pass `-d` to `up`, `rancher-compose` will not delete your services.  To delete a service you must use `rm`.

