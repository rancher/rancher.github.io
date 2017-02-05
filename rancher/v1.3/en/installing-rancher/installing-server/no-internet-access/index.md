---
title: Installing Rancher Server with No Internet Access
layout: rancher-default-v1.3
version: v1.3
lang: en
redirect_from:
  - /rancher/v1.3/zh/installing-rancher/installing-server/no-internet-access/
---

## Launching Rancher Server with No Internet Access
---

Rancher Server is able to run without internet, but the web browser accessing the UI will need access to the private network. Rancher can be configured with either a private registry or with an HTTP proxy.

When launching Rancher server with no internet access, there will be a couple of features that will no longer work properly.

* Launching Hosts using the UI for Cloud Providers - Since Rancher is calling Docker Machine to create hosts in the cloud providers, this functionality will not work. You will only be able to add [custom hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/) to your Rancher setup.
* Github Authentication

### Rancher Server Tags

Rancher server has 2 different tags. For each major release tag, we will provide documentation for the specific version.

* `rancher/server:latest` tag will be our latest development builds. These builds will have been validated through our CI automation framework. These releases are not meant for deployment in production.
* `rancher/server:stable` tag will be our latest stable release builds. This tag is the version that we recommend for production.  

Please do not use any release with a `rc{n}` suffix. These `rc` builds are meant for the Rancher team to test out builds.

### Using A Private Registry

It is assumed you either have your own private registry or other means of distributing docker images to your machine. If you need help with creating a private registry, please refer to the [Docker documentation for private registries](https://docs.docker.com/registry/).

#### Pushing Images to Private Registry

It is **very important** that all images (e.g.. `rancher/server`, `rancher/agent`, and any [infrastructure service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/) images) are distributed before attempting to install/upgrade Rancher Server. If these versions are not available in your private registry, Rancher Server will become unstable.

For each release of Rancher server, the corresponding Rancher agent and Rancher agent instance versions will be available in the release notes. In order to find the images for your infrastructure services, you would need to reference the `infra-templates` folders in our [Rancher catalog](https://github.com/rancher/rancher-catalog) and [community catalog](https://github.com/rancher/community-catalog) to see which infrastructure services that you'd like to include and the associated images in those templates from those [catalogs]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/).

##### Commands to Push Images to Private Registry

These examples are for the `rancher/server` and `rancher/agent` images using a machine that has access to both DockerHub and your private registry. We recommend tagging the version of the images in your private registry as the same version that exist in DockerHub.

```bash
# rancher/server
$ docker pull rancher/server:v1.3.0
$ docker tag rancher/server:v1.3.0 localhost:5000/<NAME_OF_LOCAL_RANCHER_SERVER_IMAGE>:v1.3.0
$ docker push localhost:5000/<NAME_OF_LOCAL_RANCHER_SERVER_IMAGE>:v1.3.0

# rancher/agent
$ docker pull rancher/agent:v1.1.3
$ docker tag rancher/agent:v1.1.3 localhost:5000/<NAME_OF_LOCAL_RANCHER_AGENT_IMAGE>:v1.1.3
$ docker push localhost:5000/<NAME_OF_LOCAL_RANCHER_AGENT_IMAGE>:v1.1.3
```

<br>

> **Note:** For any infrastructure services images, you would have to follow the same steps.

#### Launching Rancher Server with Private Registry

On your machine, start Rancher server to use the specific Rancher Agent image. We recommend using specific version tags instead of the `latest` tag to ensure you are working with the correct versions.

Example:

```bash
$ sudo docker run -d --restart=unless-stopped -p 8080:8080 \
    -e CATTLE_BOOTSTRAP_REQUIRED_IMAGE=<Private_Registry_Domain>:5000/<NAME_OF_LOCAL_RANCHER_AGENT_IMAGE>:v1.1.3 \
    <Private_Registry_Domain>:5000/<NAME_OF_LOCAL_RANCHER_SERVER_IMAGE>:v1.3.0
```

#### Rancher UI

The UI and API will be available on the exposed port `8080`. You can access the UI by going to the following URL: `http://<SERVER_IP>:8080`.

#### Adding Hosts

After accessing the UI, click on the **Add Host** button. This will immediately bring you to the **Host Registration** page. Click **Save**.

The cloud providers will not work as Rancher uses Docker Machine to provision the hosts through the cloud providers. Click on the **Custom** icon to add the host.

The command from the UI will be configured to use the private registry image for the Rancher agent.

##### Example Add Custom Host Command

```bash
$ sudo docker run -d --privileged -v /var/run/docker.sock:/var/run/docker.sock <Private_Registry_Domain>:5000/<NAME_OF_LOCAL_RANCHER_AGENT_IMAGE>:v1.1.3 http://<SERVER_IP>:8080/v1/scripts/<security_credentials>
```

#### Configuring the Default Registry for Infrastructure Stacks

In Rancher, all [infrastructure services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/) are defaulted to pull from DockerHub. Changing the default registry from DockerHub to a different private registry is located in the API settings.

* **Add the private registry:** In **Infrastructure** -> **Registries** section, add the private registry that contain the images for the infrastructure services.

* **Update the default registry:** Under **API**, click on the link for **Endpoint (v2-beta)**. Click on the link for **settings**, which will navigate to `v2-beta/settings`. Find the `registry.default` setting and click on the link under `self`. Edit the setting and add the private registry value. Once the `registry.default` setting has been updated, the infrastructure services will begin to pull from the private registry instead of DockerHub.

* **Create a New Environment:** After updating the default registry, you will need to re-create your environments so that the infrastructure services will be using the updated default registry. Any existing environments prior to the change in default registry would have their infrastructure services still pointing to DockerHub.

> **Note:** Any infrastructure stacks in an existing environment will still be using the original default registry (e.g. DockerHub). These stacks will need to be deleted and re-launched to start using the updated default registry. The stacks can be deployed from **Catalog** -> **Library**.

### Using an HTTP Proxy

Reminder, in this setup, the web browser accessing the UI will need access only the private network.

#### Configuring Docker to use an HTTP Proxy

In order to set up an HTTP proxy, the Docker daemon will need to be modified to point to the proxy for Rancher server and Rancher hosts. Before launching Rancher server or Rancher agents, edit the `/etc/default/docker` file to point to your proxy and restart Docker.

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
