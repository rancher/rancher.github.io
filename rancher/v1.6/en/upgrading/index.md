---
title: Upgrading Rancher
layout: rancher-default-v1.6
version: v1.6
lang: en
---

## Upgrading Rancher Server
---

> **Note:** If you are upgrading to v1.6.x, please read our release notes on [v1.6.0](https://github.com/rancher/rancher/releases/tag/v1.6.0) regarding what to expect for this upgrade.

Depending on how you installed Rancher server, your upgrade steps may vary.

* [Rancher Server - Single Container (non-HA)](#single-container)
* [Rancher Server - Single Container (non-HA) - External database](#single-container-external-database)
* [Rancher Server - Single Container (non-HA) - Bind mounted MySQL volume](#single-container-bind-mount)
* [Rancher Server - Full Active/Active HA](#multi-nodes)
* [Rancher Server - No Internet Access](#rancher-server-with-no-internet-access)

> **Note:** If you set any environment variables or passed in a [ldap certificate]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#enabling-active-directory-or-openldap-for-tls) in your original Rancher server setup, you'll need to add those environment variables or certificate in any new command.

### Rancher Server Tags

Rancher server has 2 different tags. For each major release tag, we will provide documentation for the specific version.

* `rancher/server:latest` tag will be our latest development builds. These builds will have been validated through our CI automation framework. These releases are not meant for deployment in production.
* `rancher/server:stable` tag will be our latest stable release builds. This tag is the version that we recommend for production.  

Please do not use any release with a `rc{n}` suffix. These `rc` builds are meant for the Rancher team to test out builds.

### Infrastructure Services

After a Rancher server upgrade, your [infrastructure services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/) may have an upgrade available. We recommend checking your infrastructure stacks after upgrading Rancher server to see if any stack has an upgrade available. If there is an upgrade available, upgrade these stacks one at a time in the following order:

1. `network-policy-manager` (if installed, this is an optional component in Rancher)
2. `network-services`
3. `ipsec`
4. remainder of the infrastructure stacks

> **Note:** It is important to complete the upgrade of each infrastructure stack before moving on to the next one. After the upgrade has completed, select "Finish Upgrade" in the menu for the stack before proceeding.

There may be times when Rancher will require you to upgrade one of your infrastructure stacks in order for Rancher to continue working. There is an API setting that can be updated to prevent these required upgrades, but it is not recommended.

_As of v1.6.1+_

We have introduced an API setting, which can allow how you want to upgrade infrastructure stacks. The `upgrade.manager` setting accepts 3 values.

* `mandatory` - This is the default value. This value will only automatically upgrade any infrastructure stacks that are deemed to be required in order to have Rancher server functioning correctly.
* `all` - Any updated templates that are available for a infrastructure stack will be automatically upgraded. If an infrastructure stack has a new template version, but the default version of the infrastructure stack is still an older one, it will not automatically upgrade to the latest.
* `none` - No infrastructure stack will be automatically upgraded. **Warning: This could cause your Rancher setups to stop working as this will stop the required Rancher upgrades.**

### Rancher Agents

Each Rancher agent version is pinned to a Rancher server version. If you upgrade Rancher server and Rancher agents require an upgrade, we will automatically upgrade the agents to the latest version of Rancher agent.
<a id="single-container"></a>

### Upgrading a Single Container (non-HA)

If you have launched Rancher server **without** using an external DB or bind mounted MySQL volume, the Rancher server database is inside your Rancher server container. We will use the running Rancher server container to create a data container. This data container will be used to start new Rancher server containers by using a `--volumes-from`. Alternatively, you can copy the database out of the container to a directory on the host and bind mount the database.

1. Stop the container.

   ```bash
   $ docker stop <container_name_of_original_server>
   ```

2. Create a `rancher-data` container. Note: This step can be skipped if you have already upgraded in the past and already have a `rancher-data` container.

   ```bash
   $ docker create --volumes-from <container_name_of_original_server> \
    --name rancher-data rancher/server:<tag_of_previous_rancher_server>
   ```

3. Pull the most recent image of Rancher Server. Note: If you skip this step and try to run the `latest` image, it will not automatically pull an updated image.

   ```bash
   $ docker pull rancher/server:latest
   ```

4. Launch a new Rancher Server container using the database from the `rancher-data` container. Any changes in Rancher will be saved in the `rancher-data` container. If you seen an exception in the server regarding a log lock, please refer to [how to fix the log lock]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/faqs/server/#databaselock).

    > **Note:** Depending on how long you've had Rancher server, certain database migrations may take longer than expected. Please do not stop upgrades in the middle of upgrading as you will hit a database migration error the next time you upgrade.

   ```bash
   $ docker run -d --volumes-from rancher-data --restart=unless-stopped \
     -p 8080:8080 rancher/server:latest
   ```
    <br>

5. Remove the old Rancher server container. Note: If you only stop the container, the container will be restarted if your machine is rebooted if you had used `--restart=always`. We recommend using `--restart=unless-stopped` and removing the container after your upgrade has been successful.

<a id="single-container-external-database"></a>

### Upgrading a Single Container (non-HA) - External Database

If you launched Rancher server using an external database, you can stop the original Rancher server container and launch a new version of Rancher server using the same [external DB instructions]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#single-container-external-database). Before upgrading your Rancher server, we recommend backing up your external database. After the new server is up and running, you can remove the old Rancher server container.

<a id="single-container-bind-mount"></a>

### Upgrading a Single Container (non-HA) - Bind Mounted MySQL Volume

1. Stop the running Rancher Server container.

   ```bash
   $ docker stop <container_name_of_original_server>
   ```

2. Copy the database files out of the server container. Note: If you already have the database stored on the host, you can skip this step. Also, if the DB has been copied out of the container, it will be inside /<path>/mysql/ because of the way Docker copies it out. Be sure to account for this when bind mounting into the container. If you started with bind mounts, you will not need the mysql/.

   ```bash
   $ docker cp <container_name_of_original_server>:/var/lib/mysql <path on host>
   ```

3. Now set the UID/GID for the folder so that the mysql user within the container has the correct ownership of the mysql mount.

   ```bash
   $ sudo chown -R 102:105 <path on host>
   ```

4. Start new server container.

   ```bash
   $ docker run -d -v <path_on_host>:/var/lib/mysql -p 8080:8080 \
     --restart=unless-stopped rancher/server:latest
   ```
  <br>

   > **Note:** It is important that you have trailing '/' at the end of the host path if you have copied a database out of a previous container. Otherwise, the directory ends up in the wrong place.

5. Remove the old Rancher server container. Note: If you only stop the container, the container will be restarted if your machine is rebooted if you had used `--restart=always`. We recommend using `--restart=unless-stopped` and removing the container after your upgrade has been successful.

<a id="multi-nodes"></a>

### Upgrading HA setup

If you have launched Rancher server in [High Availability (HA)]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#multi-nodes), the new Rancher HA set up will continue using the external database that was used to install the original HA setup.

> **Important:** When upgrading an HA setup, all `rancher/server` containers have to be stopped. The Rancher server setup will be down during the upgrade.

> **Note:** Ensure Rancher server containers, as they are brought up, are allowed sufficient "settling-down" time before starting the next Rancher server container. A baseline for the database's CPU usage could be used as a gauge to determine how much time is sufficient time. As a new Rancher server comes up, watch spikes in CPU usage to settle down to near-baseline levels before starting the next Rancher server. Additionally, Rancher logs can be monitored to see if a server has had sufficient time to settle down before starting the next one.

1. Before upgrading your Rancher server, we recommend backing up your external database.

2. On each node in the HA setup, stop the running Rancher server containers. Then start a new Rancher server container on one host using the same command that you had used when [installing Rancher server]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#multi-nodes), but with a new Rancher server image tag. When the container is fully started (UI and API are responding, and the server is listed under `Admin` -> `High Availability` in the UI), you can start the new Rancher server container.

   ```bash
   # On all nodes, stop all Rancher server containers
   $ docker stop <container_name_of_original_server>
   # Start a new container with the new version tag
   $ docker run -d --restart=unless-stopped -p 8080:8080 -p 9345:9345 rancher/server:<tag_of_new_version> --db-host myhost.example.com --db-port 3306 --db-user username --db-pass password --db-name cattle --advertise-address <IP_of_the_Node>
   ```
   <br>

   > **Note:** If you are upgrading from an HA setup that was running the [older version of HA]({{site.baseurl}}/rancher/v1.1/{{page.lang}}/installing-rancher/installing-server/multi-nodes/), you would need to remove all running Rancher HA containers. `$ sudo docker rm -f $(sudo docker ps -a | grep rancher | awk {'print $1'})`

### Rancher Server with No Internet Access

Users without internet will need to download the latest [infrastructure service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/) images in order for the upgrade to succeed. Without the images in the latest default templates, the infrastructure services will not be able to upgrade. See [Using a Private Registry]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/no-internet-access/#using-a-private-registry) how to do this.

#### Upgrading Rancher when using private registry with authentication

As described in [Rancher Agents]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/upgrading/#rancher-agents), agents will be automatically upgraded. If the image needed for the Rancher agent is in a private registry with authentication (Docker daemon needs credentials to access the registry), you will need to pre-pull the images before upgrading Rancher. This can be done using the catalog item called `pre-pull-images`.

> **Note:** `pre-pull-images` expects that the setting `registry.default` is configured correctly, as this will be used to pull the images from the correct registry. See [Configuring the default registry for infrastructure stacks]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/no-internet-access/#configuring-the-default-registry-for-infrastructure-stacks) how to configure this setting.

##### Setting up pre-pull-images

* Open the catalog
  * **Cattle**: Navigate to **Catalog** -> **All**
  * **Kubernetes**: Navigate to **Kubernetes** -> **Infrastructure Stacks** and open **Add from Catalog**
* Search for `pre-pull-images`, select **View Details** on the catalog item
* Configure the catalog according to your situation, options are described below:

  | Option | Default | Description |
  |---|---|---|
  | CHECK_CPU_USAGE | `True` | Enable checking CPU usage while running to avoid overloading the host |
  | CPU_USAGE_MAX | `75` | Maximum CPU usage percentage to halt pulling images |
  | CPU_USAGE_SLEEP | `120` | Amount of seconds to sleep when CPU usage percentage is above CPU_USAGE_MAX |
  | MOUNT_DOCKER_CONFIG | `False` | Mount the Docker daemon config as a volume (required for registries with authentication) |
  | DOCKER_CONFIG_LOCATION | `/root/.docker/config.json` | Location of the Docker daemon config on the host (required for registries with authentication) |
  | PRIVILEGED | `False` | Run pre-pull-images as privileged container (needed when SELinux is in Enforcing mode) |
  | RANDOM_SLEEP | `False` | Sleep a random interval between pulls |
  | RANCHER_AGENT_IMAGE | `rancher/agent:v1.2.10` | Rancher agent image to pull (this can be found in the [release notes](https://github.com/rancher/rancher/releases/tag/v1.6.17) of the version you are upgrading to) |
  | RANCHER_VERSION | `v1.6.17` | Rancher server version you are upgrading to after running pre-pull-images |

* Click **Launch**, this will launch a global start-once service that will pull all the needed images for the `RANCHER_VERSION` you specified. It will also pull the `RANCHER_AGENT_IMAGE` you configured.
* When all the containers are in `Started-Once` state, the images needed for the upgrade are present on the hosts.
