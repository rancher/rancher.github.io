---
title: Upgrading Rancher (Single Node)
layout: rancher-default-v1.2
version: v1.2
lang: en
redirect_from:
  - /rancher/upgrading/
  - /rancher/latest/en/upgrading/
---

## Upgrading Rancher Server (Single Node)
---

If you have launched Rancher server **without** using an [external DB]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#external-db), the Rancher server database is inside your Rancher server container. We will use the running Rancher server container to create a data container. This data container will be used to start new Rancher server containers by using a `--volumes-from`. Alternatively, you can copy the database out of the container to a directory on the host and bind mount the database.

> **Note:** If you used an external DB, you can stop the original Rancher server container and launch a new version of Rancher server using the same [external DB instructions]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#external-db). After the new server is up and running, you can remove the old Rancher server container.

### Rancher Server Tags

The `rancher/server:latest` tag will be our stable release builds, which Rancher recommends for deployment in production. For each minor release tag, we will provide documentation for the specific version.

If you are interested in trying one of our latest development builds which will have been validated through our CI automation framework, please check our [releases page](https://github.com/rancher/rancher/releases) to find the latest development release tag. These releases are not meant for deployment in production. All development builds will be appended with a `*-pre{n}` suffix to denote that it's a development release. Please do not use any release with a `rc{n}` suffix. These `rc` builds are meant for the Rancher team to test out the development builds.

### Upgrading Rancher by Creating a Data Container

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

    > **Note:** If you set any environment variables or passed in a [ldap certificate]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#enabling-active-directory-or-openldap-for-tls) in your original Rancher server setup, you'll need to add those environment variables or certificate in the command.

5. Remove the old Rancher server container.

### Upgrading Rancher launched using Bind Mounts

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

### Users with No Internet Access

Users without internet will need to download the latest [infrastructure service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/) images in order for the upgrade to succeed. Without the images in the latest default templates, the infrastructure services will not be able to upgrade.

### Rancher Agents

Each Rancher agent version is pinned to a Rancher server version. If you upgrade Rancher server and Rancher agents require an upgrade, we will automatically upgrade the agents to the latest version of Rancher agent.
