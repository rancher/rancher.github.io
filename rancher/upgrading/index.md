---
title: Upgrading Rancher
layout: rancher-default
---

## Upgrading Rancher
---

Currently, upgrades are **NOT** officially supported between releases before we hit a GA release. Therefore, certain features might break in later versions as we enhance them. The procedure we follow when we upgrade is outlined below. We typically only go from one version to the next if we do upgrade.

If you have launched Rancher server **without** using an [external DB]({{site.baseurl}}/rancher/installing-rancher/installing-server/#external-db), the Rancher server database is inside your Rancher server container. We will use the running Rancher server container to create a data container. This data container will be used to start new Rancher server containers by using a `--volumes-from`. Alternatively, you can copy the database out of the container to a directory on the host and bind mount the database.

> **Note:** If you used an external DB, you can stop the original Rancher server container and launch a new version of Rancher server using the same [external DB instructions]({{site.baseurl}}/rancher/installing-rancher/installing-server/#external-db). After the new server is up and running, you can remove the old Rancher server container. Note: If you only stop the container, the container will be restarted if your machine is rebooted due to the `--restart=always`.


#### Upgrading Rancher by Creating a Data Container 

1. Stop the container.

    ```bash
    $ docker stop <container_name_of_original_server>
    ```

2. Create a `rancher-data` container. Note: This step can be skipped if you have already upgraded in the past and already have a `rancher-data` container.
    
    ```bash
    $ docker create --volumes-from <container_name_of_original_server> --name rancher-data rancher/server:<tag_of_previous_rancher_server>
    ```

3. Pull the most recent image of Rancher Server. Note: If you skip this step and try to run the `latest` image, it will not automatically pull an updated image.

    ```bash
    $ docker pull rancher/server:latest
    ```

4. Launch a new Rancher Server container using the database from the `rancher-data` container. Any changes in Rancher will be saved in the `rancher-data` container. If you are having issues with your upgrade, please refer to our [troubleshooting section]({{site.baseurl}}/rancher/faqs/troubleshooting/#databaselock).

    ```bash
    $ docker run -d --volumes-from rancher-data --restart=always -p 8080:8080 rancher/server:latest
    ```

    > **Note:** If you set any environment variables or passed in a [LDAP certificate]({{site.baseurl}}/rancher/installing-rancher/installing-server/#enabling-ldap-capabilities-for-tls) in your original Rancher server setup, you'll need to add those environment variables or certificate in the command. 

5. Remove the old Rancher server container. Note: If you only stop the container, the container will be restarted if your machine is rebooted due to the `--restart=always`. We recommend removing the container after your upgrade has been successful.

#### Upgrading Rancher launched using Bind Mounts

1. Stop the running Rancher Server container.

    ```bash
    $ docker stop <container_name_of_original_server>
    ```

2. Copy the database files out of the server container. Note: If you already have the database stored on the host, you can skip this step. Also, if the DB has been copied out of the container, it will be inside /<path>/mysql/ because of the way Docker copies it out. Be sure to account for this when bind mounting into the container. If you started with bind mounts, you will not need the mysql/.

    ```bash
    $ docker cp <container_name_of_original_server>:/var/lib/mysql <path on host>
    ```

3. Start new server container. 

    ```bash
    docker run -d -v <path_on_host>:/var/lib/mysql -p 8080:8080 --restart=always rancher/server:latest
    ```
   
    > **Note**: It is important that you have trailing '/' at the end of the host path if you have copied a database out of a previous container. Otherwise, the directory ends up in the wrong place.

### Rancher Agents 

Each Rancher agent version is pinned to a Rancher server version. If you upgrade Rancher server and Rancher agents require an upgrade, it will automatically upgrade the agents.
