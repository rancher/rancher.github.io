---
title: Installing Rancher Server with No Internet Access
layout: rancher-default-v1.1
version: v1.1
lang: en
redirect_from:
  - /rancher/v1.1/zh/installing-rancher/installing-server/no-internet-access/
---

## Launching Rancher Server with No Internet Access
---

Rancher Server is able to run without internet, but the web browser accessing the UI will need access to the private network. Rancher can be configured with either a private registry or with a HTTP proxy.

When launching Rancher server with no internet access, there will be a couple of features that will no longer work properly.

* Launching Hosts using the UI for Cloud Providers - Since Rancher is calling `docker-machine` to create hosts in the cloud providers, this functionality will not work. You will add [custom hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/) to your Rancher setup.
* GitHub Authentication
* Templates from the [Rancher Catalog](https://github.com/rancher/rancher-catalog) and [Community Catalog](https://github.com/rancher/community-catalog) - These catalogs rely on being cloned from Github, but you will be able to [add internal private catalogs]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/private-catalog) into Rancher.

### Using Private Registry

It is assumed you either have your own private registry or other means of distributing docker images to your machine. If you need help with creating a private registry, please refer to the [Docker documentation for private registries](https://docs.docker.com/registry/).

#### Pushing Images to Private Registry

It is **very important** that all images (i.e. rancher/server, rancher/agent, rancher/agent-instance) are distributed before attempting to install/upgrade Rancher Server. If these versions are not available in your private registry, Rancher Server will become unstable.

For each release of Rancher server, the corresponding Rancher agent and Rancher agent instance versions will be available in the release notes.

**Commands to Push Images to Private Registry**

These examples are for the v1.0.1 release using a machine that has access to both DockerHub and your private registry. We recommend tagging the version of the images in your private registry as the same version.

```bash
# rancher/server
$ docker pull rancher/server:v1.0.1
$ docker tag rancher/server:v1.0.1 localhost:5000/<NAME_OF_LOCAL_RANCHER_SERVER_IMAGE>:v1.0.1
$ docker push localhost:5000/<NAME_OF_LOCAL_RANCHER_SERVER_IMAGE>:v1.0.1

# rancher/agent
$ docker pull rancher/agent:v1.0.1
$ docker tag rancher/agent:v1.0.1 localhost:5000/<NAME_OF_LOCAL_RANCHER_AGENT_IMAGE>:v1.0.1
$ docker push localhost:5000/<NAME_OF_LOCAL_RANCHER_AGENT_IMAGE>:v1.0.1

# rancher/agent-instance
$ docker pull rancher/agent-instance:v0.8.1
$ docker tag rancher/agent-instance:v0.8.1 localhost:5000/<NAME_OF_LOCAL_RANCHER_AGENT_INSTANCE_IMAGE>:v0.8.1
$ docker push localhost:5000/<NAME_OF_LOCAL_RANCHER_AGENT_INSTANCE_IMAGE>:v0.8.1
```

#### Launching Rancher Server with Private Registry

On your machine, start Rancher server to use the specific Rancher images. We recommend using specific version tags instead of the `latest` tag to ensure you are working with the correct versions.

Example:

```bash
$ sudo docker run -d --restart=unless-stopped -p 8080:8080 \
    -e CATTLE_BOOTSTRAP_REQUIRED_IMAGE=<Private_Registry_Domain>:5000/<NAME_OF_LOCAL_RANCHER_AGENT_IMAGE>:v1.0.1 \
    -e CATTLE_AGENT_INSTANCE_IMAGE=<Private_Registry_Domain>:5000/<NAME_OF_LOCAL_RANCHER_AGENT_INSTANCE_IMAGE>:v0.8.1 \
    <Private_Registry_Domain>:5000/<NAME_OF_LOCAL_RANCHER_SERVER_IMAGE>:v1.0.1
```

#### Rancher UI

The UI and API will be available on the exposed port `8080`. You can access the UI by going to the following URL: `http://<SERVER_IP>:8080`.

#### Adding Hosts

After accessing the UI, click on the **Add Host** button. This will immediately bring you to the **Host Registration** page. Click **Save**.

The cloud providers will not work as Rancher uses `docker-machine` to provision the hosts through the cloud providers. Click on the **Custom** icon to add the host.

The command from the UI will be configured to use the private registry image for the Rancher agent.

##### Example Add Custom Host Command

```bash
$ sudo docker run -d --privileged -v /var/run/docker.sock:/var/run/docker.sock <Private_Registry_Domain>:5000/<NAME_OF_LOCAL_RANCHER_AGENT_IMAGE>:v1.0.1 http://<SERVER_IP>:8080/v1/scripts/<security_credentials>
```

### Using HTTP Proxy

Reminder, in this setup, the web browser accessing the UI will need access only the private network.

#### Configuring Docker to use a HTTP Proxy

In order to set up a HTTP proxy, the Docker daemon will need to be modified to point to the proxy for Rancher server and Rancher hosts. Before launching Rancher server or Rancher agents, edit the `/etc/default/docker` file to point to your proxy and restart Docker.

```bash
$ sudo vi /etc/default/docker
```

In the file, edit the `#export http_proxy="http://127.0.0.1:3128/"` to have it point to your proxy. Save your changes and then restart docker. Restarting Docker is different on every OS.

> **Note:** If you are running Docker with systemd, please follow Docker's [instructions](https://docs.docker.com/articles/systemd/#http-proxy) on how to configure the HTTP proxy.

#### Launching Rancher Server

Rancher server does not need to be launched using any environment variables when using a proxy. Therefore, the command to start Rancher server will be the same as a regular installation.

```bash
sudo docker run -d --restart=unless-stopped -p 8080:8080 rancher/server
```

#### Rancher UI

The UI and API will be available on the exposed port `8080`. You can access the UI by going to the following URL: `http://<SERVER_IP>:8080`.

#### Adding Hosts

After accessing the UI, you can click on the **Add Host** button. This will immediately bring you to the **Host Registration** page. Click **Save**.

The cloud providers will not work as Rancher uses `docker-machine` to provision the hosts through the cloud providers. Click on the **Custom** icon to add the host.

The command from the UI can be used on any machine that has Docker configured to use HTTP proxy.
