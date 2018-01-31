---
title: Installing Rancher Server with No Internet Access
layout: rancher-default-v1.6
version: v1.6
lang: en
redirect_from:
  - /rancher/installing-rancher/installing-server/no-internet-access/
---

## Launching Rancher Server with No Internet Access
---

Rancher Server is able to run without internet, but the web browser accessing the UI will need access to the private network. Rancher can be configured with either a private registry or with an HTTP proxy.

When launching Rancher server with no internet access, there will be a couple of features that will no longer work properly.

* Launching Hosts using the UI for Cloud Providers - Since Rancher is calling Docker Machine to create hosts in the cloud providers, this functionality will not work. You will only be able to add [custom hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/) to your Rancher setup.
* Github Authentication

### Requirements

Review the Rancher server [requirements]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#requirements).

### Rancher Server Tags

Rancher server has 2 different tags. For each major release tag, we will provide documentation for the specific version.

* `rancher/server:latest` tag will be our latest development builds. These builds will have been validated through our CI automation framework. These releases are not meant for deployment in production.
* `rancher/server:stable` tag will be our latest stable release builds. This tag is the version that we recommend for production.  

Please do not use any release with a `rc{n}` suffix. These `rc` builds are meant for the Rancher team to test out builds.

### Using A Private Registry

It is assumed you either have your own private registry or other means of distributing docker images to your machine. If you need help with creating a private registry, please refer to the [Docker documentation for private registries](https://docs.docker.com/registry/).

#### Pushing Images to Private Registry

It is **very important** that all images (e.g.. `rancher/server`, `rancher/agent`, `rancher/lb-service-haproxy`, and any [infrastructure service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/) images) are distributed before attempting to install/upgrade Rancher Server. If these versions are not available in your private registry, Rancher Server will become unstable.

For each release of Rancher, the corresponding `rancher/server`, `rancher/agent` and `rancher/lb-service-haproxy` versions will be available in the release notes. In order to find the images for your infrastructure services, you can use the `print-catalog-images.py` script inside the `scripts` directory in the `rancher/rancher` repository. See an example below:

```bash
# We need python to run the script
$ docker run -ti python:2.7 bash
# Clone the rancher repository
$ git clone https://github.com/rancher/rancher
# Install required python modules
$ cd rancher/scripts/print-catalog-images/
$ pip install -r requirements.txt
...
Successfully installed ...
# Run the script to print the needed images
$ ./print-catalog-images.py -v 1.6.14
Rancher Version: 1.6.14
Catalog URL: https://git.rancher.io/rancher-catalog
Catalog Branch: v1.6-release
...
```

##### Kubernetes

When using Kubernetes, you will need to distribute a few additional images which are used for running pods and running the addons like the kubernetes-dashboard. You can check the [Private Registry]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/private-registry/) documentation for instructions how to do this.

##### Options for `print-catalog-images.py`

| Option | Description |
|---|---|
| -h, --help | show help |
| -u URL, --url URL | Rancher catalog URL accessible in airgap environment |
| -b BRANCH, --branch BRANCH | Rancher catalog branch accessible in airgap environment |
| -k, --k8saddons | Print k8s addon images |
| -ku K8SURL, --k8surl K8SURL | Rancher URL for kubernetes-package accessible in airgap environment |
| -v VERSION, --version VERSION | Rancher Server version |

##### Commands to Push Images to Private Registry

These examples are for the `rancher/server` and `rancher/agent` images using a machine that has access to both DockerHub and your private registry. We recommend tagging the version of the images in your private registry as the same version that exist in DockerHub.

```bash
# rancher/server
$ docker pull rancher/server:v1.6.0
$ docker tag rancher/server:v1.6.0 localhost:5000/<NAME_OF_LOCAL_RANCHER_SERVER_IMAGE>:v1.6.0
$ docker push localhost:5000/<NAME_OF_LOCAL_RANCHER_SERVER_IMAGE>:v1.6.0

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
    <Private_Registry_Domain>:5000/<NAME_OF_LOCAL_RANCHER_SERVER_IMAGE>:v1.6.0
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

* **Update the default registry:** Under **Admin** -> **Setting** -> **Advanced Settings**, click on the **I understand that I can break things by changing advanced settings**. Find the **registry.default** setting and click on the edit icon. Add the registry value and click on **Save**. Once the `registry.default` setting has been updated, the infrastructure services will begin to pull from the private registry instead of DockerHub.

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

### Catalogs

On every release, the `rancher/server` container will be built containing a cached copy of the [Rancher catalog](https://github.com/rancher/rancher-catalog) and [community catalog](https://github.com/rancher/community-catalog) belonging to that release at that point of time. As updates are released to the catalogs, you will need to make sure the `rancher/server` container can fetch updates to the catalogs.

#### Rancher catalog

The [Rancher catalog](https://github.com/rancher/rancher-catalog) contains all the supported catalog items like [infrastructure services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/). To keep the Rancher catalog updated, you will need to make that the `rancher/server` container can either access `https://git.rancher.io/rancher-catalog.git` or that you configure the Rancher catalog to be updated from your own mirrored Git repository.

#### Community catalog

The [community catalog](https://github.com/rancher/community-catalog) is updated regularly by the community. If you need updates to this catalog, you will need to make sure that you can either access `https://git.rancher.io/community-catalog.git` or that you configure the community catalog to be updated from your own mirrored Git repository.

#### Configuring catalogs

##### On startup

To point your `rancher/server` container to the correct repositories upon start, you can configure the environment variable `DEFAULT_CATTLE_CATALOG_URL`.

```
$ sudo docker run -d --restart=unless-stopped -p 8080:8080 \
 -e DEFAULT_CATTLE_CATALOG_URL='{"catalogs":{"community":{"url":"https://your_local_git_server/community-catalog.git","branch":"master"},"library":{"url":"https://your_local_git_server/rancher-catalog.git","branch":"your_branch"}}}' \
rancher/server:stable
```

##### Manual

You can use the steps provided in [adding catalogs]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/#adding-catalogs) to add global catalogs. To override the default catalog URL for Rancher catalog, you can use `library` as name of the catalog. To override the default catalog for community catalog, you can use `community` as name of the catalog.
