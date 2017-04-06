---
title: Rancher Command Line Interface (CLI)
layout: rancher-default-v1.4
version: v1.4
lang: en
---

## Rancher Command Line Interface
---

The Rancher Command Line Interface (CLI) is a unified tool to manage your Rancher server. With this tool, you can control your [environments]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/), [hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/), stacks, services and containers.

### Installation

The binary can be downloaded directly from the UI. The link can be found in the right hand side of the footer in the UI. We have binaries for Windows, Mac, and Linux. You can also check the [releases page for our CLI](https://github.com/rancher/cli/releases) for direct downloads of the binary.

### Configuring the Rancher Command Line Interface

There are several methods you can configure the settings that the Rancher CLI uses when interacting with Rancher, i.e. Rancher URL and [account API keys]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-keys/#account-api-keys). Account API keys can be created in **API**.

There is a specific load order for what will be used.

1. During `rancher config`, you'll set the Rancher URL and API keys. If there are multiple environments, then you will select a specific environment.
2. You can set environment variables for the same values, which would override the values set in `rancher config`.
3. If you decide to pass in values directly into the Rancher command, those values would be used for the Rancher command over any other values.

#### Using Rancher Config

You can run `rancher config` to set up your configuration with Rancher server.

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

#### Using Environment Variables

You can set the following environment variables, `RANCHER_URL`, `RANCHER_ACCESS_KEY` and `RANCHER_SECRET_KEY`.

```bash
# Set the url that Rancher is on
$ export RANCHER_URL=http://<server_ip>:8080
# Set the access key, i.e. username
$ export RANCHER_ACCESS_KEY=<accessKey_of_account_api_key>
# Set the secret key, i.e. password
$ export RANCHER_SECRET_KEY=<secretKey_of_account_api_key>
```

<br>

If there is more than one environment in your Rancher server you'll also need to set an environment variable to select the specific environment, i.e. `RANCHER_ENVIRONMENT`.

```bash
# Set the environment to use, you can use either environment ID or environment name
$ export RANCHER_ENVIRONMENT=<environment_id>
```

#### Passing Options

If you choose not to run `rancher config` or set environment variables, you can pass the same values as options as part of any `rancher` command.

```bash
$ rancher --url http://server_ip:8080 --access-key <accessKey_of_account_api_key> --secret-key <secretKey_of_account_api_key> --env <environment_id> ps
```

### Debugging with Rancher CLI

When working with Rancher CLI, you can set the environment variable, `RANCHER_CLIENT_DEBUG`, to `true`, which will have all CLI commands print out verbose messages of the API calls being made.

```bash
# Print verbose messages for all CLI calls
$ export RANCHER_CLIENT_DEBUG=true
```
<br>
If you don't want the verbose response on every CLI command, set the environment variable `RANCHER_CLIENT_DEBUG` to `false` and pass in `--debug` to the specific command to get the verbose messages.

```bash
$ rancher --debug env create newEnv
```

### Working with  Environments

If you use an [account API key]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-keys/#account-api-keys), you will be able to create and update environments. If you use an [environment API key]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-keys/#environment-api-keys), you will not be able to create or update other environments and you will only be able to see your existing environment.

```bash
$ rancher env ls
ID        NAME        STATE     CATALOG                           SYSTEM    DETAIL
1e1       zookeeper   healthy   catalog://community:zookeeper:1   false     
1e2       Default     healthy                                     false     
1e3       App1        healthy                                     false     
```

### Working with a Specific Host

There are some commands (e.g. `rancher docker` and `rancher ssh`) that require selecting a specific host to use. You can either set up an environment variable to select a host, i.e. `RANCHER_DOCKER_HOST`, or pass in the ` --host` to specify a host.

Before selecting a host, you can list out all the hosts in the environment.

```
$ rancher hosts
ID        HOSTNAME      STATE     IP
1h1       host-1        active    111.222.333.444
1h2       host-3        active    111.222.333.445
1h3       host-2        active    111.222.333.446
```

<br>

Now, you can set the environment variable, `RANCHER_DOCKER_HOST`, or pass in `--host` using either the host ID or host name to select a different host.

```bash
# Set the host to always select host-1 (1h1)
$ export RANCHER_DOCKER_HOST=1h1
# List the containers running on host-1
$ rancher docker ps
# List the containers running on host-2
$ rancher --host host-2 docker ps
```

### Working with Services and Containers

#### Listing all Services

In your selected environment, you can view all the services running in an environment.

```bash
$ rancher ps
ID   TYPE                 NAME                IMAGE                       STATE     SCALE   ENDPOINTS            DETAIL
1s1  service              zookeeper/zk        rawmind/alpine-zk:3.4.8-4   healthy   3                              
1s2  service              Default/nginxApp    nginx                       healthy   1                              
1s4  service              App1/db1            mysql                       healthy   1                              
1s5  service              App1/wordpress      wordpress                   healthy   4                              
1s6  loadBalancerService  App1/wordpress-lb                               healthy   1       111.222.333.444:80   
```

#### Listing all Containers

Instead of specific services, you can view all the containers in the environment.

```bash
$ rancher ps -c
ID      NAME                       IMAGE                              STATE     HOST   IP              DOCKER         DETAIL
1i1     zookeeper_zk_zk-volume_1   rawmind/alpine-volume:0.0.1-1      stopped   1h1                    a92b6d3dad18   
1i2     zookeeper_zk_zk-conf_1     rawmind/rancher-zk:0.3.3           stopped   1h1                    2e8085a4b517   
1i3     zookeeper_zk_1             rawmind/alpine-zk:3.4.8-4          healthy   1h1    10.42.150.2     e3ef1c6ff70e   
1i5     zookeeper_zk_zk-volume_2   rawmind/alpine-volume:0.0.1-1      stopped   1h2                    e716f562e0a4   
1i6     zookeeper_zk_zk-conf_2     rawmind/rancher-zk:0.3.3           stopped   1h2                    5cd1cebea5a3   
1i7     zookeeper_zk_2             rawmind/alpine-zk:3.4.8-4          healthy   1h2    10.42.88.102    21984a4445d1   
1i9     zookeeper_zk_zk-volume_3   rawmind/alpine-volume:0.0.1-1      stopped   1h3                    7c614003f08c   
1i10    zookeeper_zk_zk-conf_3     rawmind/rancher-zk:0.3.3           stopped   1h3                    53fb77cd8ae0   
1i11    zookeeper_zk_3             rawmind/alpine-zk:3.4.8-4          healthy   1h3    10.42.249.162   84a80eb8e037   
1i13    Default_nginxApp_1         nginx                              running   1h1    10.42.107.28    e1195a563280   
1i15    App1_db1_1                 mysql                              running   1h3    10.42.116.171   0624e0a7f2fc   
1i16    App1_wordpress_1           wordpress                          running   1h1    10.42.66.199    4bb77abebc08   
1i17    App1_wordpress-lb_1        rancher/lb-service-haproxy:v0.4.2  healthy   1h2    10.42.199.163   5d3a005278d3   
1i18    App1_wordpress_2           wordpress                          running   1h2    10.42.88.114    01ec967c49ac   
1i19    App1_wordpress_3           wordpress                          running   1h3    10.42.218.81    3aae3fc6163a   
1i20    App1_wordpress_4           wordpress                          running   1h1    10.42.202.31    0b67ef86db22   
```

#### Listing Containers of a Specific Service

If you wanted to view the containers of a specific service, you can list out all the containers running in a service by adding in the service ID or service name.

```bash
$ rancher ps 1s5
ID      NAME               IMAGE       STATE     HOST      IP             DOCKER         DETAIL
1i16    App1_wordpress_1   wordpress   running   1h1       10.42.66.199   4bb77abebc08   
1i18    App1_wordpress_2   wordpress   running   1h2       10.42.88.114   01ec967c49ac   
1i19    App1_wordpress_3   wordpress   running   1h3       10.42.218.81   3aae3fc6163a   
1i20    App1_wordpress_4   wordpress   running   1h1       10.42.202.31   0b67ef86db22
```

### Launching a Simple Service using Docker Compose Files

To start adding services into Rancher, you can create a simple `docker-compose.yml` file and optionally a `rancher-compose.yml` file. If there is no `rancher-compose.yml` file, then all services will start with a scale of 1 container.

Sample `docker-compose.yml`

```yaml
version: '2'
services:
  service1:
    image: nginx
```

Sample `rancher-compose.yml`

```yaml
version: '2'
services:
  # Reference the service that you want to extend
  service1:
    scale: 2
```

After your files are created, you can launch the services into Rancher server.

```bash
# Creating and starting a service without environment variables and selecting a stack
# If no stack is provided, the stack name will be the folder name that the command is running from
# If the stack does not exist in Rancher, it will be created
# Add in -d at the end to not block and log
$ rancher --url URL_of_Rancher --access-key <username_of_account_api_key> --secret-key <password_of_account_api_key> --env Default up -s stack1 -d

# Creating and starting a service with environment variables already set
# Add in -d at the end to not block and log
$ rancher up -s stack1 -d

# To change the scale of an existing service, you can use stackName/serviceName or service ID
$ rancher scale Default/service1=3
$ rancher scale 1s4=5
```

### Launching a Service using `Rancher run`

If you have been using the Docker CLI to add in services, you can also add containers into Rancher using `rancher run`.

```bash
# Services should be stackName/service_name
$ rancher run --name stackA/service1 nginx
```

### Command Reference

To read more about all the supported commands, please read our [rancher command]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cli/commands/) documentation.
