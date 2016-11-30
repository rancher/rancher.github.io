---
title: Upgrading Rancher (Multi Nodes)
layout: rancher-default-v1.2
version: v1.2
lang: en
redirect_from:
  - /rancher/latest/en/upgrading/multi-nodes/
---

## Upgrading Rancher Server (Multi Nodes)


If you have launched Rancher server in [High Availability (HA)]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/multi-nodes/), the new Rancher HA set up will continue using the external database that was used to install the original HA setup.

> **Note:** When upgrading an HA setup, the Rancher server service will be down during the upgrade.

1. Before upgrading your Rancher server, we recommend backing up your external database.

2. On each node in the HA setup, stop and remove the running Rancher containers and then start a new Rancher server container using the same command that you had used when [installing Rancher server]({{site.baseurl}}), but with a new Rancher server image tag.

   ```bash
   # On all nodes, stop all Rancher server containers
   $ docker stop <container_name_of_original_server>
   # Execute the scrip with the latest rancher/server version
   $ docker run -d --restart=unless-stopped -p 8080:8080 -p 9345:9345 rancher/server --db-host myhost.example.com --db-port 3306 --db-user username --db-pass password --db-name cattle --advertise-address <IP_of_the_Node>
   ```
   <br>
   > **Note:** If you are upgrading from an HA setup that was running the [older version of HA]({{site.baseurl}}/rancher/1.1/{{page.lang}}/installing-rancher/multi-nodes/), you would need to remove all running Rancher HA containers. `$ sudo docker rm -f $(sudo docker ps -a | grep rancher | awk {'print $1'})`
