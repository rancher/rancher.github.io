---
title: Quick Start Guide
layout: rancher-default-v1.2
version: v1.2
lang: en
redirect_from:
  - /rancher/v1.2/zh/quick-start-guide/
---

## Quick Start Guide
---

In this guide, we will create a simple Rancher install, which is a single host installation that runs everything on a single Linux machine.

### Prepare a Linux host

Provision a Linux host with 64-bit Ubuntu 16.04, which must have a kernel of 3.10+. You can use your laptop, a virtual machine, or a physical server. Please make sure the Linux host has at least **1GB** memory. Install [Docker](https://www.docker.com/) onto the host.

To install Docker on the server, follow the instructions from [Docker](https://docs.docker.com/engine/installation/linux/ubuntulinux/).

> **Note:** Currently, Docker for Windows and Docker for Mac are not supported.

#### Rancher Server Tags

Rancher server has 2 different tags. For each major release tag, we will provide documentation for the specific version.

* `rancher/server:latest` tag will be our latest development builds. These builds will have been validated through our CI automation framework. These releases are not meant for deployment in production.
* `rancher/server:stable` tag will be our latest stable release builds. This tag is the version that we recommend for production.  

Please do not use any release with a `rc{n}` suffix. These `rc` builds are meant for the Rancher team to test out builds.

### Start Rancher Server

All you need is one command to launch Rancher server. After launching the container, we'll tail the logs of the container to see when the server is up and running.

```bash
$ sudo docker run -d --restart=unless-stopped -p 8080:8080 rancher/server
# Tail the logs to show Rancher
$ sudo docker logs -f <CONTAINER_ID>
```

It will only take a couple of minutes for Rancher server to start up. When the logs show `.... Startup Succeeded, Listening on port...`, the Rancher UI is up and running. This line of the logs is almost immediately after the configuration is complete. There may be additional logs after this output, so please don't assume it will be the last line of the logs upon initialization.

Our UI is exposed on port `8080`, so in order to view the UI, go to `http://<SERVER_IP>:8080`. If you are running your browser on the same host running Rancher server, you will need to use the host’s real IP, like `http://192.168.1.100:8080` and not `http://localhost:8080` or `http://127.0.0.1:8080`.

> **Note:** Rancher will not have access control configured and your UI and API will be available to anyone who has access to your IP. We recommend configuring [access control]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/).

### Add Hosts

For simplicity, we will add the same host running the Rancher server as a host in Rancher. In real production deployments, we recommend having dedicated hosts running Rancher server(s).

To add a host, access the UI and click **Infrastructure**, which will immediately bring you to the **Hosts** page. Click on the **Add Host**. Rancher will prompt you to select a host registration URL. This URL is where Rancher server is running and must be reachable from all the hosts that you will be adding. This is useful in installations where Rancher server will be exposed to the Internet through a NAT firewall or a load balancer. If your host has a private or local IP address like `192.168.*.*`, Rancher will print a warning asking you to make sure that the hosts can indeed reach the URL.

For now you can ignore these warnings, we will only be adding the Rancher server host itself. Click **Save**. By default, the **Custom** option will be selected, which provides the Docker command to launch the Rancher agent container. There will also be options for cloud providers, which Rancher uses Docker Machine to launch hosts.

In the UI, it provides instructions of the ports that need to be open on your host as well as some optional information. Since we are adding a host that is also running Rancher server, we need to add the public IP that should be used for the host. One of the options provides the ability to input this IP, which automatically updates the custom command with an environment variable.

Run this command in the host that is running Rancher server.

When you click **Close** on the Rancher UI, you will be directed back to the **Infrastructure** -> **Hosts** view. In a couple of minutes, the host will automatically appear.

### Infrastructure services

When you first log in to Rancher, you are automatically in a **Default** [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/). The default cattle [environment template]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#what-is-an-environment-template) has been selected for this environment to launch [infrastructure services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/). These infrastructure services are required to be launched to take advantage of Rancher's benefits like [dns]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/dns-service/), [metadata]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/metadata-service),  [networking]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/networking), and [health checks]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/health-checks/). These infrastructure stacks can be found in **Stacks** -> **Infrastructure**. These stacks will be in an `unhealthy` state until a host is added into Rancher. After adding a host, it is recommended to wait until all the infrastructure stacks are `active` before adding services.

On the host, the containers from the infrastructure services will be hidden unless you click on the **Show System** checkbox.

### Create a Container through UI

Navigate to the **Stacks** page, if you see the welcome screen, you can click on the **Define a Service** button in the welcome screen. If there are already services in your Rancher set up, you can click on **Add Service** in any existing stack or create a new stack to add services in. A stack is just a convenient way to group services together. If you need to create a new stack, click on **Add Stack**, provide a name and description and click **Create**. Then, click on **Add Service** in the new stack.

Provide the service with a name like "first-service". You can just use our default settings and click **Create**. Rancher will start launching the container on the host. Regardless what IP address your host has, the **_first-container_** will have an IP address in the `10.42.*.*` range as Rancher has created a managed overlay network with the `ipsec` infrastructure service. This managed overlay network is how containers can communicate with each other across different hosts.

If you click on the dropdown of the **_first-container_**, you will be able to perform management actions like stopping the container, viewing the logs, or accessing the container console.

### Create a Container through Native Docker CLI

Rancher will display any containers on the host even if the container is created outside of the UI. Create a container in the host's shell terminal.

```bash
$ docker run -d -it --name=second-container ubuntu:14.04.2
```

In the UI, you will see **_second-container_** pop up on your host!

Rancher reacts to events that happen on the Docker daemon and does the right thing to reconcile its view of the world with reality. You can read more about using Rancher with the [native docker CLI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/native-docker/).

If you look at the IP address of the **_second-container_**, you will notice that it is **not** in the `10.42.*.*` range. It instead has the usual IP address assigned by the Docker daemon. This is the expected behavior of creating a Docker container through the CLI.

What if we want to create a Docker container through CLI and still give it an IP address from Rancher’s overlay network? All we need to do is add a label (i.e. `io.rancher.container.network=true`) in the command to let Rancher know that you want this container to be part of the `managed` network.

```bash
$ docker run -d -it --label io.rancher.container.network=true ubuntu:14.04.2
```

### Create a Multi-Container Application

We have shown you how to create individual containers and explained how they would be connected in our cross-host network. Most real-world applications, however, are made out of multiple services, with each service made up of multiple containers. A [LetsChat](http://sdelements.github.io/lets-chat/) application, for example, could consist of the following services:

1. A load balancer. The load balancer redirects Internet traffic to the "LetsChat" application.
2. A _web_ service consisting of two "LetsChat" containers.
3. A _database_ service consisting of one "Mongo" container.

The load balancer targets the _web_ service (i.e. LetsChat), and the _web_ service will link to the _database_ service (i.e. Mongo).

In this section, we will walk through how to create and deploy the [LetsChat](http://sdelements.github.io/lets-chat/) application in Rancher.

Navigate to the **Stacks** page, if you see the welcome screen, you can click on the **Define a Service** button in the welcome screen. If there are already services in your Rancher set up, you can click on **Add Stack** to create a new stack. Provide a name and description and click **Create**. Then, click on **Add Service** in the new stack.

First, we'll create a database service called `database` and use the `mongo` image. Click **Create**. You will be immediately brought to a stack page, which will contain the newly created _database_ service.

Next, click on **Add Service** again to add another service. We'll add a LetsChat service and link to the _database_ service. Let's use the name, `web`, and use the `sdelements/lets-chat` image. In the UI, we'll move the slider to have the scale of the service to be 2 containers. In the **Service Links**, add the _database_ service and provide the name `mongo`. Just like in Docker, Rancher will link the necessary environment variables in the `letschat` image from the linked database when you input the "as name" as `mongo`. Click **Create**.

Finally, we'll create our load balancer. Click on the dropdown menu icon next to the **Add Service** button. Select **Add Load Balancer**. Provide a name like `letschatapplb`. Input the source port (i.e. `80`), select the target service (i.e. _web_), and select a target port (i.e. `8080`). The _web_ service is listening on port `8080`. Click **Create**.

Our LetsChat application is now complete! On the **Stacks** page, you'll be able to find the exposed port of the load balancer as a link. Click on that link and a new browser will open, which will display the LetsChat application.

### Create a Multi-Container Application using Rancher CLI

In this section, we will show you how to create and deploy the same [LetsChat](http://sdelements.github.io/lets-chat/) application we created in the previous section using our command-line tool called [Rancher CLI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cli/).

When bringing services up in Rancher, the Rancher CLI tool works similarly to the popular Docker Compose tool. It takes in the same `docker-compose.yml` file and deploys the application on Rancher. You can specify additional attributes in a `rancher-compose.yml` file which extends and overwrites the `docker-compose.yml` file.

In the previous section, we created a LetsChat application with a load balancer. If you had created it in Rancher, you can download the files directly from our UI by selecting **Export Config** from the stack's dropdown menu. The `docker-compose.yml` and `rancher-compose.yml` files would look like this:

#### Example docker-compose.yml

```yaml
version: '2'
services:
  letschatapplb:
    #If you only have 1 host and also created the host in the UI,
    # you may have to change the port exposed on the host.
    ports:
    - 80:80/tcp
    labels:
      io.rancher.container.create_agent: 'true'
      io.rancher.container.agent.role: environmentAdmin
    image: rancher/lb-service-haproxy:v0.4.2
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

#### Example rancher-compose.yml

```yaml
version: '2'
services:
  letschatapplb:
    scale: 1
    lb_config:
      certs: []
      port_rules:
      - hostname: ''
        path: ''
        priority: 1
        protocol: http
        service: quickstartguide/web
        source_port: 80
        target_port: 8080
    health_check:
      port: 42
      interval: 2000
      unhealthy_threshold: 3
      healthy_threshold: 2
      response_timeout: 2000
  web:
    scale: 2
  database:
    scale: 1
```

<br>
Download the Rancher CLI binary from the Rancher UI by clicking on **Download CLI**, which is located on the right side of the footer. We provide the ability to download binaries for Windows, Mac, and Linux.

In order for services to be launched in Rancher using Rancher CLI, you will need to set some environment variables. You will need to create an [account API Key]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-keys/) in the Rancher UI. Click on **API** -> **Keys**. Click on **Add Account API Key**. Provide a name and click **Create**. Save the **Access Key** and **Secret Key**. Using the Rancher URL, Access Key and Secret Key, configure the Rancher CLI by running `rancher config`.

```bash
# Configure Rancher CLI
$ rancher config
# Set the Rancher URL
URL []: http://<SERVER_IP>:8080/
# Set the access key, i.e. username
Access Key []: <accessKey_of_account_api_key>
# Set the secret key, i.e. password
Secret Key []:  <secretKey_of_account_api_key>
```

<br>
Now, navigate to the directory where you saved `docker-compose.yml` and `rancher-compose.yml` and run the command.

```bash
$ rancher up -d -s NewLetsChatApp
```
<br>
In Rancher, a new stack will be created called **NewLetsChatApp** with all of the services launched in Rancher.
