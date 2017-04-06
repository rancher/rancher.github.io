---
title: Commands and Options in Rancher Compose
layout: rancher-default-v1.5
version: v1.5
lang: en
---

## Command and Options
---

The Rancher Compose tool works just like the popular Docker Compose and supports the V1 version of  `docker-compose.yml` files. To enable features that are supported in Rancher, you can also have a `rancher-compose.yml` which extends and overwrites the `docker-compose.yml`. For example, scale of services and health checks would be in the `rancher-compose.yml` file.

### Rancher-Compose Commands

Rancher Compose supports any command that Docker Compose supports.

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

### Rancher Compose Options

Whenever you use the Rancher Compose command, there are different options that you can use.

Name | Description
--- | ---
`--verbose`, `--debug`	|		
`--file`, `-f` [--file option --file option]|	Specify an alternate compose file (default: `docker-compose.yml`) [$COMPOSE_FILE]
`--project-name`, `-p` 		|	Specify an alternate project name (default: directory name)
`--url` 				| Specify the Rancher API endpoint URL [$RANCHER_URL]
`--access-key` 			| Specify Rancher API access key [$RANCHER_ACCESS_KEY]
`--secret-key` 		|	Specify Rancher API secret key [$RANCHER_SECRET_KEY]
`--rancher-file`, `-r` 	|		Specify an alternate Rancher compose file (default: `rancher-compose.yml`)
`--env-file`, `-e` 		|	Specify a file from which to read environment variables
`--help`, `-h`			|	show help
`--version`, `-v`		|	print the version

#### Examples

To get started, you can create a simple `docker-compose.yml` file and optionally a `rancher-compose.yml` file. If there is no `rancher-compose.yml` file, then all services will start with a scale of 1 container.

##### Example `docker-compose.yml`

```yaml
version: '2'
services:
  web:
    image: nginx
  db:
    image: mysql
    environment:
      MYSQL_ROOT_PASSWORD: test    
```

##### Example `rancher-compose.yml`

```yaml
# Reference the service that you want to extend
version: '2'
services:
  web:
    scale: 2
  db:
    scale: 1
```

After your files are created, you can launch the services into Rancher server.

```bash
# Creating and starting services without environment variables and selecting a stack
# If the stack does not exist in Rancher, it will be created in Rancher
$ rancher-compose --url URL_of_Rancher --access-key <username_of_environment_api_key> --secret-key <password_of_environment_api_key> -p stack1 up

# Creating and starting services with environment variables already set
$ rancher-compose -p stack1 up

# To change the scale of an existing service
$ rancher-compose -p stack1 scale web=3

# To launch a specific service in the docker-compose.yml
$ rancher-compose -p stack1 up web
```

<br>

> **Note:** If you don't pass in `-p <STACK_NAME>`, the stack name will be the directory that you are running the Rancher Compose command in.

#### Using the `--env-file` Option

You can pass in a file of environment variables using `--env-file` while running a Rancher Compose command.

##### Example `secrets` file

```
MYSQL_ROOT_PASSWORD=test
```

##### Example `docker-compose.yml`

```yaml
version: '2'
services:
  db:
    image: mysql
    environment:
    # Just like Docker Compose, if there is only a key, Rancher Compose will resolve to
    # the values on the machine or the file passed in using --env-file
      MYSQL_ROOT_PASSWORD:
```

You can launch your service and pass in the `secrets` file.

```bash
$ rancher-compose --env-file secrets up -d
```

By passing in a file and having an environment variable with only a key, Rancher Compose resolves to the value in the file or on the machine that Rancher Compose is running on. If the environment variable is set in the file and on the machine, Rancher Compose will use the value in the file.  

### Command Options

#### Up Command

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

When you run the `up` command with Rancher Compose, after all the tasks are complete, the process continues to run. If you want the process to exit after completion, you'll need to add in the `-d` option, which is to not block and log.

```bash
# If you do not use the -d flag, Rancher Compose will continue to run until you Ctrl+C to quit
$ rancher-compose up

# Use the -d flag for rancher-compose to exit after running
$ rancher-compose up -d
```

Read more about [upgrading using Rancher Compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/upgrading/#upgrading-services-with-rancher-compose).

#### Start Command

Name | Description
---|----
`-d` |	Do not block and log

<br>

If you want the start process to exit after completion, you'll need to add in the `-d` option, which is to not block and log.

#### Logs Command

Name | Description
---|----
`--follow` | Follow log output

#### Restart Command

Name | Description
---|----
`--batch-size` `"1"` |	Number of containers to retart at once
`--interval` `"0"` |	Restart interval in milliseconds

<br>

By default, restarting services will restart the containers individually and immediately sequentially. You can set the batch size and interval of the restart policy.

#### Stop/Down & Scale Command

Name | Description
---|----
`--timeout`, `-t` `"10"` |	Specify a shutdown timeout in seconds.

<br>

```yaml
# To change the scale of an existing service
$ rancher-compose -p stack1 scale service1=3
```

#### Rm Command

Name | Description
---|----
`--force`, `-f`	| Allow deletion of all services
`-v`	| Remove volumes associated with containers

<br>

When removing services, Rancher Compose will only delete the services that are found in the `docker-compose.yml`. If there are more services within the stack in Rancher, they will not be deleted as Rancher Compose will not know they exist.

Also, the stack will not be deleted as Rancher Compose will not be aware if there are any remaining services.

By default, volumes attached to containers will not be removed. You can see all volumes with `docker volume ls`.

#### Pull Command

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

> **Note:** Unlike `docker-compose pull`, you will not be specifying which service to pull. Rancher Compose looks at all services in the `docker-compose.yml` and pulls images for all services found in the file.

#### Upgrade Command

You can upgrade your services in Rancher using Rancher Compose. Please read more about when and how to [upgrade your services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/upgrading/#upgrading-services-with-rancher-compose).


### Deleting Services/Container

Rancher Compose will not delete things by default.  This means that if you do two `up` commands in a row, the second `up` will do nothing.  This is because the first up will create everything and leave it running.  Even if you do not pass `-d` to `up`, Rancher Compose will not delete your services.  To delete a service you must use `rm`.
