---
title: Upgrading Rancher (Multi Nodes)
layout: rancher-default-v1.1
version: v1.1
lang: en
redirect_from:
  - /rancher/v1.1/zh/upgrading/multi-nodes/
---

## Upgrading Rancher Server (Multi Nodes)


If you have launched Rancher server in [High Availability (HA)]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/multi-nodes/), the new Rancher HA set up will continue using the external database that was used to install the original HA setup.

> **Note:** When upgrading a HA setup, the Rancher server service will be down during the upgrade.

1. Before upgrading your Rancher server, we recommend backing up your external database.

2. On each node in the HA setup, stop and remove the running Rancher containers and then execute the HA generating script with the latest rancher/server version.

   ```bash
   # Removing all the running Rancher containers
   $ sudo docker rm -f $(sudo docker ps -a | grep rancher | awk {'print $1'})
   # Execute the scrip with the latest rancher/server version
   $ sudo sh rancher-ha.sh rancher/server:v1.1.0
   ```

3. Monitoring your upgrade.

* Log into the Rancher UI and in the environments drop down, navigate to **System HA**.
* Click on **Stacks**. Expand the **Management** stack.
* The services that were part of the previous version will automatically upgrade to the version selected in Step 1.
* Once all the services have become `Active`, the Rancher HA upgrade will be complete.
