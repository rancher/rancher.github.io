---
title: Upgrading Rancher
layout: rancher-default-v1.3
version: v1.3
lang: en
redirect_from:
  - /rancher/v1.3/zh/upgrading/
---

## Upgrading Rancher Server
---

> **Note:** If you are upgrading to v1.3.x, please read our release notes on [v1.3.0](https://github.com/rancher/rancher/releases/tag/v1.3.0) regarding what to expect for this upgrade.

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

After a Rancher server upgrade, your [infrastructure services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/) may have an upgrade available. We recommend checking your infrastructure stacks after upgrading Rancher server to see if any stack has an upgrade available. If there is an upgrade available, upgrade these stacks one at a time. Please finish the upgrade before moving on to upgrading the next infrastructure stack.

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

> **Note:** When upgrading an HA setup, the Rancher server setup will be down during the upgrade.

1. Before upgrading your Rancher server, we recommend backing up your external database.

2. On each node in the HA setup, stop and remove the running Rancher containers and then start a new Rancher server container using the same command that you had used when [installing Rancher server]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#multi-nodes), but with a new Rancher server image tag.

   ```bash
   # On all nodes, stop all Rancher server containers
   $ docker stop <container_name_of_original_server>
   # Execute the scrip with the latest rancher/server version
   $ docker run -d --restart=unless-stopped -p 8080:8080 -p 9345:9345 rancher/server --db-host myhost.example.com --db-port 3306 --db-user username --db-pass password --db-name cattle --advertise-address <IP_of_the_Node>
   ```
   <br>
   > **Note:** If you are upgrading from an HA setup that was running the [older version of HA]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#multi-nodes/), you would need to remove all running Rancher HA containers. `$ sudo docker rm -f $(sudo docker ps -a | grep rancher | awk {'print $1'})`

### Rancher Server with No Internet Access

Users without internet will need to download the latest [infrastructure service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/) images in order for the upgrade to succeed. Without the images in the latest default templates, the infrastructure services will not be able to upgrade.
