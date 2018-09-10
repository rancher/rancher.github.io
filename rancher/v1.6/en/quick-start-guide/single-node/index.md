---
title: Quick Start: Single Node Quickstart 
layout: rancher-default-v1.6
version: v1.6
lang: en
redirect_from:
  - /rancher/quick-start-guide/single-node
  - /rancher/latest/en/quick-start-guide/single-node
---

## Quick Start: Single Node Quickstart
---

## Quick Start Guide
---

In this guide, we will create a simple Rancher install, which is a single host installation that runs everything on a single Linux machine.

### Prepare a Linux host

Provision a Linux host with 64-bit Ubuntu 16.04, which must have a kernel of 3.10+. You can use your laptop, a virtual machine, or a physical server. Please make sure the Linux host has at least **1GB** memory. Install a [supported version of Docker]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#supported-docker-versions) onto the host.

To install Docker on the server, follow the instructions from [Docker](https://docs.docker.com/engine/installation/linux/ubuntulinux/).

> **Note:** Currently, Docker for Windows and Docker for Mac are not supported.


### Rancher Server Tags

Rancher server has 2 different tags. For each major release tag, we will provide documentation for the specific version.

* `rancher/server:latest` tag will be our latest development builds. These builds will have been validated through our CI automation framework. These releases are not meant for deployment in production.
* `rancher/server:stable` tag will be our latest stable release builds. This tag is the version that we recommend for production.  

Please do not use any release with a `rc{n}` suffix. These `rc` builds are meant for the Rancher team to test out builds.

### Start Rancher Server

All you need is one command to launch Rancher server. After launching the container, we'll tail the logs of the container to see when the server is up and running.

```bash
$ sudo docker run -d --restart=unless-stopped -p 8080:8080 rancher/server:stable
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
