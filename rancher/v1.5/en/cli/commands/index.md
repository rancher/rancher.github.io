---
title: Rancher CLI Commands and Options
layout: rancher-default-v1.5
version: v1.5
lang: en
---

## Commands and Options
---

The Rancher CLI is able to manipulate environments, hosts, stacks, services and containers in Rancher.

### Rancher CLI Commands

Name | Description
----|-----
`catalog`      |     [Operations with catalogs](#rancher-catalog-reference)
`config`     |       [Setup client configuration](#rancher-config-reference)
`docker`      |        [Run docker CLI on a host](#rancher-docker-reference)
`environment`, `env`  | [Interact with environments](#rancher-environment-reference)
`events`, `event`   |        [Displays resource change events](#rancher-events-reference)
`exec`       |       [Run a command on a container](#rancher-exec-reference)
`export`     |      [Export configuration yml for a stack as a tar archive or to local files](#rancher-export-reference)
`hosts`, `host`    |   [Operations on hosts](#rancher-hosts-reference)
`logs`           |   [Fetch the logs of a container](#rancher-logs-reference)
`ps`            |    [Show services/containers](#rancher-ps-reference)
`restart`       |   [Restart service, container](#rancher-restart-reference)
`rm`          |      [Delete service, container, stack, host, volume](#rancher-rm-reference)
`run`         |     [Run services](#rancher-run-reference)
`scale`       |      [Set number of containers to run for a service](#rancher-scale-reference)
`ssh`         |      [SSH into host](#rancher-ssh-reference)
`stacks`, `stack`  |   [Operations on stacks](#rancher-stacks-reference)
`start`, `activate`  | [Start or activate service, container, host, stack](#rancher-startactivate-reference)
`stop`, `deactivate` | [Stop or deactivate service, container, host, stack](#rancher-stopdeactivate-reference)
`up`           |     [Bring all services up](#rancher-up-reference)
`volumes`, `volume` |   [Operations on volumes](#rancher-volumes-reference)
`inspect`      |     [View details for service, container, host, environment, stack, volume](#rancher-inspect-reference)
`wait`        |      [Wait for resources service, container, host, stack, machine, projectTemplate](#rancher-wait-reference)
`help`        |     Shows a list of commands or help for one command

<br>

### Rancher CLI Global Options

Whenever you use the `rancher` command, there are different global options that you can use.

Name | Description
--- | ---
`--debug`         |                  Debug logging
`--config` value, `-c` value    |      Client configuration file (default ${HOME}/.rancher/cli.json) [$RANCHER_CLIENT_CONFIG]
`--environment` value, `--env` value | Environment name or ID [$RANCHER_ENVIRONMENT]
`--url` value                    |   Specify the Rancher API endpoint URL [$RANCHER_URL]
`--access-key` value             |   Specify Rancher API access key [$RANCHER_ACCESS_KEY]
`--secret-key` value             |   Specify Rancher API secret key [$RANCHER_SECRET_KEY]
`--host` value                   |   Host used for docker command [$RANCHER_DOCKER_HOST]
`--wait`, `-w`                   |     Wait for resource to reach resting state
`--wait-timeout` value           |   Timeout in seconds to wait (default: 600)
`--wait-state` value             |   State to wait for (active, healthy, etc)
`--help`, `-h`                   |     show help
`--version`, `-v`                |     print the version

<br>

#### Waiting For Resources

There is a global flag, i.e. `--wait` or `-w`,  that can be used for commands to reach resting state. When scripting your Rancher commands, using `-w` allows you to wait until the resources are ready before moving on to the next command.

By default, the timeout for waiting will be ten minutes, but if you want to change the waiting timeout, you can use `--wait-timeout` to change the amount of time before the CLI errors out.

You can also define which specific state of a resource to be in before exiting, by using `--wait-state`.

### Rancher Catalog Reference

The `rancher catalog` command provides operations around catalog templates.

#### Options

Name | Description
----|-----
`--quiet`, `-q`   |  Only display IDs
`--format` value  | `json` or Custom format: {% raw %}'{{.ID}} {{.Template.Id}}'{% endraw %}
`--system`, `-s`  |  Show system templates, not user

#### Subcommands

Name | Description
----|-----
`ls` | `List catalog templates`
`install` |  Install catalog template
`help`    |  Shows a list of commands or help for one command

#### Rancher Catalog Ls

The `rancher catalog ls` command lists all the templates in the environment.

##### Options

Name | Description
-----|-----
`--quiet`, `-q` |     Only display IDs
`--format` value  | `json` or Custom format: {% raw %}'{{.ID}} {{.Template.Id}}'{% endraw %}
`--system`, `-s` |   Show system templates, not user

<br>

```bash
# Lists all catalog templates
$ rancher catalog ls
# Lists all catalog templates in an environment that is running kubernetes
$ rancher --env k8sEnv catalog ls
# Lists the catalog templates that are system templates
$ rancher catalog ls --system
```

#### Rancher Catalog install

The `rancher catalog install` command installs catalog templates into your environment.

##### Options

Name | Description
----|-----
`-answers` value, `-a` value |  Answer file
`--name` value              |  Name of stack to create
`--system`, `-s`              |  Install a system template

<br>

```bash
# Install a catalog
$ rancher catalog install library/route53:v0.6.0-rancher1 --name route53
# Install a catalog and label it as a system template
$ rancher catalog install library/route53:v0.6.0-rancher1 --name route53 --system
```

### Rancher Config Reference

The `rancher config` command sets up your [configuration with Rancher server]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cli/#configuring-the-rancher-command-line-interface).

```bash
$ rancher config
URL []: http://<server_ip>:8080
Access Key []: <accessKey_of_account_api_key>
Secret Key []:  <secretKey_of_account_api_key>
# If there are more than one environment,
# you will be asked to select which environment to work with
Environments:
[1] Default(1a5)
[2] k8s(1a10)
Select: 1
INFO[0017] Saving config to /Users/<username>/.rancher/cli.json
```

#### Options

Name | Description
----|-----
`--print` | `Print the current configuration`

If you want to print the existing configuration, you can use `----print` to show the existing configuration.

```bash
# Clear out the existing Rancher configuration
$ rancher config --print
```

### Rancher Docker Reference

The `rancher docker` command allows you to run any Docker command on a specific host. Uses the ``$RANCHER_DOCKER_HOST` to run Docker commands. Use `--host <hostID>` or `--host <hostName>` to select a different host.


```bash
$ rancher --host 1h1 docker ps
```

#### Options

Name | Description
----|-----
`--help-docker` |  Display the `docker --help`

<br>

> **Note:** If the environment variable, `RANCHER_DOCKER_HOST`, is not set, you will need to pass in `--host` to specify which host to use.

### Rancher Environment Reference

The `rancher environment` command allows you to interact with environments. If you use an account API key, you will be able to create and update environments. If you use an environment API key, you will not be able to create or update other environments and you will only be able to see your existing environment.


#### Options

Name | Description
----|-----
`--all`, `-a`    |   Show stop/inactive and recently removed resources
`--quiet`, `-q`  |  Only display IDs
`--format` value | `json` or Custom format: {% raw %}'{{.ID}} {{.Environment.Name}}'{% endraw %}

#### Subcommands

Name | Description
----|-----
`ls`                    | List environments
`create`                | Create an environment
`templates`, `template` | Interact with environment templates
`rm`                    | Remove environment(s)
`deactivate`            | Deactivate environment(s)
`activate`              | Activate environment(s)
`help`                  | Shows a list of commands or help for one command


#### Rancher Env Ls

The `rancher env ls` command lists all the environments in the Rancher set up.

##### Options

Name | Description
----|-----
`--all`, `-a`    |   Show stop/inactive and recently removed resources
   `--quiet`, `-q` |     Only display IDs
   `--format` value  | `json` or Custom format: {% raw %}'{{.ID}} {{.Enviromment.Name}}'{% endraw %}

<br>

```bash
$ rancher env ls
ID        NAME      ORCHESTRATION   STATE     CREATED
1a5       Default   Cattle          active    2016-08-15T19:20:46Z
1a6       k8sEnv    Kubernetes      active    2016-08-17T03:25:04Z
# List only the IDs of the environments
$ rancher env ls -q
1a5
1a6
```

#### Rancher Env Create

The `rancher env create` command creates new environments of different orchestration types. By default, the orchestration type will be cattle.

##### Options

Name | Description
---|----
`--template` value, `-t` value | Environment template to create from (default: "Cattle")

<br>

```bash
# Create a environement
$ rancher env create newCattleEnv
# Create a kubernetes environment
$ rancher env create -t kubernetes newk8sEnv
```

#### Rancher Env Template

The `rancher env template` command allows you to export and import templates into Rancher.

##### Options

Name | Description
---|----
`--all`, `-a`    |   Show stop/inactive and recently removed resources
`--quiet`, `-q`  |  Only display IDs
`--format` value | `json` or Custom format: {% raw %}'{{.ID}} {{.ProjectTemplate.Name}}'{% endraw %}

##### Subcommands

Name | Description
---|----
`export` | Export an environment template to STDOUT
`import` | Import an environment template to from file
`help`    | Shows a list of commands or help for one command

#### Rancher Env Rm

The `rancher env rm` command removes environments. You can remove with either the environment name or environment ID.

```bash
# Remove environment by name
$ rancher env rm newk8sEnv
# Remove environment by ID
$ rancher env rm 1a20
```

#### Rancher Env Deactivate

The `rancher env deactivate` command deactivates the environment. You select which environment to update with either environment name or environment ID.

#### Rancher Env Activate

The `rancher env activate` command activates the environment. You select which environment to update with either environment name or environment ID.

### Rancher Events Reference

The `rancher events` command lists out all active events occurring inside the Rancher server.

#### Options

Name | Description
---|----
`--format` value  |  `json` or Custom format: {% raw %}'{{.Name}} {{.Data.resource.kind}}'{% endraw %}
`--reconnect`, `-r` | Reconnect on error


### Rancher Exec Reference

The `rancher exec` command allows you to directly exec into any container in Rancher. The user does not need to know what host the container is on. They only need to know the container ID, e.g. `1i1`, `1i788`) in the Rancher setup.

```bash
# Exec into a container
$ rancher exec -i -t 1i10
```

#### Options

Name | Description
----|-----
`--help-docker` |  Display the `docker exec --help`

After the `rancher exec` command finds the container, it runs the `docker exec` command on the specific host and container. To show the help for the `docker exec` command, you can pass in an option to show the `docker exec --help`.

```bash
# Show docker exec --help
$ rancher exec --help-docker
```

### Rancher Export Reference

The `rancher export` command exports the `docker-compose.yml` and `rancher-compose.yml` for a stack as a tar archive.

#### Options

Name | Description
---|----
`--file` value, `-f` value |  Write to a file, instead of local files, use - to write to STDOUT
`--system`, `-s`   |         If exporting the entire environment, include system

<br>

```bash
# Provide the docker-compose.yml and rancher-compose.yml for
# all services in a stack as a tar archive
$ rancher export mystack > files.tar
$ rancher export -f files.tar mystack
```

### Rancher hosts reference

The `rancher hosts` command allows you to interact with hosts in the environment.

#### Options

Name | Description
----|-----
  `--all`, `-a`    |    Show stop/inactive and recently removed resources
  `--quiet`, `-q`  |   Only display IDs
  `--format` value | `json` or Custom format: {% raw %}'{{.ID}} {{.Host.Hostname}}'{% endraw %}

#### Subcommands

Name | Description
----|-----
`ls`    |  List hosts
`create` | Create a host

#### Rancher Hosts Ls

The `rancher hosts ls` command lists all the hosts.

##### Options

Name | Description
----|-----
`--all`, `-a` |       Show stop/inactive and recently removed resources
    `--quiet`, `-q` |     Only display IDs
   `--format` value  | `json` or Custom format: {% raw %}'{{.ID}} {{.Host.Hostname}}'{% endraw %}

<br>

```bash
$ rancher hosts ls
ID        HOSTNAME      STATE     IP
1h1       host-1        active    111.222.333.444
1h2       host-3        active    111.222.333.555
1h3       host-2        active    111.222.333.666
1h4       host-4        active    111.222.333.777
1h5       host-5        active    111.222.333.888
1h6       host-6        active    111.222.333.999
# Only display the host IDs
$ rancher hosts ls -q
1h1       
1h2      
1h3      
1h4       
1h5       
1h6
```

#### Rancher Hosts Create

The `rancher hosts create` command allows you to create [hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/). When creating hosts, you will be calling a Docker Machine command, and will need to pass in the same options needed for the Docker Machine driver.

### Rancher Logs reference

The `rancher logs` allows you to fetch the logs of a container by container ID or container name.

#### Options

Name | Description
----|-----
`--service`, `-s`    | Show service logs
`--sub-log`       |  Show service sub logs
`--follow`, `-f` |     Follow log output
`--tail` value  |    Number of lines to show from the end of the logs (default: 100)
`--since` value  |   Show logs since timestamp
`--timestamps`, `-t`  | Show timestamps

<br>

```bash
# Get the logs for the last 50 lines using container ID
$ rancher logs --tail 50 <ID>
# Tail the logs using container name
$ rancher logs -f <stackName>/<serviceName>
```

### Rancher ps reference

The `rancher ps` command shows all the services or containers in Rancher. If you don't pass in any options into the `rancher ps` command, the command will return the list of all services in the environment.

#### Options

Name | Description
---|----
`--all`, `-a`        |  Show stop/inactive and recently removed resources
`--system`, `-s`     |  Show system resources
`--containers`, `-c` |  Display containers
`--quiet`, `-q` |		Only display IDs
`--format` value |	`json` or Custom format: {% raw %}'{{.Service.Id}} {{.Service.Name}} {{.Service.LaunchConfig.ImageUuid}}'{% endraw %}

<br>

```bash
# List all the services
$ rancher ps
ID        TYPE      NAME           IMAGE     STATE        SCALE     ENDPOINTS   DETAIL
1s1       service   Default/blog   ghost     activating   3                     Waiting for [instance:Default_blog_3]. Instance status: Storage : Downloading
# List all the containers instead of services
$ rancher ps -c
ID        NAME             IMAGE                           STATE     HOST      DETAIL
1i1       Default_blog_1   ghost                           running   1h1       
1i2       Default_blog_2   ghost                           running   1h2       
1i3       Default_blog_3   ghost                           running   1h3  
```

The `detail` column will provide the current status of the service.

### Rancher restart reference

You can restart any hosts, services or containers in Rancher using `rancher restart`.

#### Options

Name | Description
---|----
`--type` value	| Restrict restart to specific types (service, container)
`--batch-size` value |	Number of containers to restart at a time (default: 1)
`--interval` value |	Interval in millisecond to wait between restarts (default: 1000)

<br>

```bash
# Restart by ID of service, container, host
$ rancher restart <ID>
# Restart by name of service, container, host
$ rancher restart <stackName>/<serviceName>
```

<br>

> **Note:** The service name will always include the stack name to ensure that we're referencing the correct service.

### Rancher rm reference

The `rancher rm` command removes resources, i.e. hosts, stacks, services, containers or volumes, from Rancher.

#### Options

Name | Description
---|----
`--type` value	| Restrict delete to specific types
`--stop`, `-s`  |  Stop or deactivate resource first if needed before deleting

<br>

```bash
$ rancher rm <ID>
```

### Rancher run reference

The `run` command will deploy a service with the scale of 1 container into Rancher. When creating the service, if you want to place the service in a specific stack, you'll need to pass in `--name` and give the `stackName/serviceName`. If no `--name` is used, then it puts the service in the `Default` stack with a docker provided name.  

```bash
$ rancher run --name App2/app nginx
# CLI returns the service ID of the newly created service
1s3
$ rancher -i -t --name serviceA ubuntu:14.04.3
1s4
```

If you select to publish a port to the host, then you must have a host with the port available. Rancher will automatically schedule the container on a host that has that port available.

```bash
$ rancher -p 2368:2368 --name blog ghost
1s5
```

### Rancher scale reference

By default, when you start a service using `rancher run`, the scale of the service will be 1. You can use the `rancher scale` command to increase the scale of any service. You can select the service by name, i.e. `stackName/serviceName`, or by service ID.

```bash
$ rancher scale <stackName>/<serviceName>=5 <serviceID>=3
```

### Rancher ssh reference

The `rancher ssh` allows you to ssh into any host created by the UI. It will not allow you to ssh into a host added by the [custom]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/) command.

```bash
$ rancher ssh <hostID>
```

### Rancher stacks reference

The `rancher stacks` command interacts with the stacks in the environment.

#### Options

Name | Description
----|-----
`--system`, `-s`  |  Show system resources
 `--quiet`, `-q` |     Only display IDs
   `--format` value  | `json` or Custom format: {% raw %}'{{.ID}} {{.Stack.Name}}'{% endraw %}

#### Commands

Name | Description
----|-----
`ls` |     List stacks
`create` |   Create a stacks

#### Rancher Stacks Ls

The `rancher stacks ls` command lists the stacks in the selected environment.

##### Options

Name | Description
----|-----
`--system`, `-s` |    Show system resources
`--quiet`, `-q`     | Only display IDs
`--format` value | `json` or Custom format: {% raw %}'{{.ID}} {{.Stack.Name}}'{% endraw %}

<br>

```bash
#List all stacks
$ rancher stacks ls
ID        NAME        STATE      CATALOG                           SYSTEM    DETAIL
1e1       zookeeper   healthy    catalog://community:zookeeper:1   false     
1e2       Default     degraded                                     false     
1e3       App1        healthy                                      false     
# List only stack IDs
$ rancher stacks ls -q
1e1
1e2
1e3
```

#### Rancher Stacks Create

The `rancher stacks create` command creates new stacks. The stacks could be empty or created from a `docker-compose.yml` and `rancher-compose.yml`.

##### Options

Name | Description
----|-----
`--start`                     |       Start stack on create
`--system`, `-s`              |         Create a system stack
`--empty`, `-e`               |         Create an empty stack
`--quiet`, `-q`               |         Only display IDs
`--docker-compose` value, `-f` value  |  Docker Compose file (default: "docker-compose.yml")
`--rancher-compose` value, `-r` value |  Rancher Compose file (default: "rancher-compose.yml")

<br>

```bash
# Create an empty stack
$ rancher stacks create NewStack -e
# Create a stack from a docker-compose and rancher-compose files
# Also, start the stack upon creation
$ rancher stacks create NewStack -f dc.yml -r rc.yml --start
```

### Rancher start/activate reference

The `rancher start` or `rancher activate` command activates specific resource types, i.e. hosts, services or containers.

#### Options

Name | Description
---|----
`--type` value	| Restrict start/activate to specific types (service, container, host, stack)

<br>

```bash
# Start by ID of service, container, host
$ rancher start <ID>
# Start by name of service, container, host
$ rancher start <stackName>/<serviceName>
```

<br>

> **Note:** The service name will always include the stack name to ensure that we're referencing the correct service.

### Rancher stop/deactivate reference

The `rancher stop` or `rancher deactivate` command deactivates specific resource types, i.e. hosts, services or containers.

#### Options

Name | Description
---|----
`--type` value	| Restrict stop/deactivate to specific types (service, container, host, stack)

<br>

```bash
# Stop by ID of service, container, host
$ rancher stop <ID>
# Stop by name of service, container, host
$ rancher stop <stackName>/<serviceName>
```

<br>

> **Note:** The service name will always include the stack name to ensure that we're referencing the correct service.

### Rancher up Reference

The `rancher up` command is similar to the Docker Compose `up` command.

#### Options

Name | Description
---|----
`--pull`, `-p` |                         Before doing the upgrade do an image pull on all hosts that have the image already
`-d`                             |   Do not block and log
`--upgrade`, `-u`, `--recreate` |          Upgrade if service has changed
`--force-upgrade`, `--force-recreate` |  Upgrade regardless if service has changed
`--confirm-upgrade`, `-c`    |          Confirm that the upgrade was success and delete old containers
`--rollback`, `-r`            |         Rollback to the previous deployed version
`--batch-size` value          |       Number of containers to upgrade at once (default: 2)
`--interval` value            |       Update interval in milliseconds (default: 1000)
`--rancher-file` value        |       Specify an alternate Rancher compose file (default: rancher-compose.yml)
`--env-file` value, `-e` value     |    Specify a file from which to read environment variables
`--file` value, `-f` value       |      Specify one or more alternate compose files (default: docker-compose.yml) [$COMPOSE_FILE]
`--stack` value, `-s` value       |     Specify an alternate project name (default: directory name)


```bash
# Add in -d at the end to not block and log
$ rancher up -s <stackName> -d
```

### Rancher volumes Reference

The `rancher volumes` command allows you to interact with volumes in Rancher.

#### Options

Name | Description
---|----
`--all`, `-a`    |   Show stop/inactive and recently removed resources
`--quiet`, `-q`  |  Only display IDs
`--format` value | `json` or Custom format: {% raw %}'{{.ID}} {{.Volume.Name}}'{% endraw %}

#### Commands

Name | Description
---|----
  `ls`  |     List volumes
  `rm`   |   Delete volume
  `create` | Create volume

#### Rancher Volume LS

The `rancher volume ls` command lists all volumes in the selected environment.

##### Options

Name | Description
---|----
`--all`, `-a`    |   Show stop/inactive and recently removed resources
`--quiet`, `-q`  |  Only display IDs
`--format` value | `json` or Custom format: {% raw %}'{{.ID}} {{.Volume.Name}}'{% endraw %}

<br>

```bash
$ rancher volumes ls
ID        NAME                       STATE      DRIVER        DETAIL
1v1                                  active                   
1v2                                  active                   
1v3                                  detached                 
1v4                                  active                   
1v5                                  detached                 
1v6                                  detached                 
1v7       rancher-agent-state        active     local         
```

#### Rancher Volume Rm

The `rancher volume rm` command removes volumes from Rancher.

```bash
$ rancher volumes rm <VOLUME_ID>
```

#### Rancher Volume Create

The `rancher volume create` command creates volumes in Rancher.

##### Options

Name | Description
---|----
`--driver` value |  Specify volume driver name
`--opt` value    |  Set driver specific key/value options

 <br>

```bash
# Create a new volume in the Rancher NFS driver
$ rancher volume create NewVolume --driver rancher-nfs
```

### Rancher inspect Reference

The `rancher inspect` provides detail on the resource.

#### Options

Name | Description
---|----
`--type` value  |  Restrict inspect to specific types (service, container, host)
`--links`       |  Include URLs to actions and links in resource output
`--format` value  | `json` or Custom format: {% raw %}'{{.kind}}'{% endraw %} (default: "json")

<br>

```bash
# Inspect by ID of service, container, host
$ rancher inspect <ID>
# Inspect by name of service, container, host
$ rancher inspect <stackName>/<serviceName>
```

<br>

> **Note:** The service name will always include the stack name to ensure that we're referencing the correct service.

### Rancher wait Reference

The `rancher wait` command waits for a resource to complete it's action. This is very useful for when automating Rancher commands so that you can add in the script to wait for the resource to be ready for more actions.

```bash
$ rancher start 1i1
$ rancher wait 1i1
```
