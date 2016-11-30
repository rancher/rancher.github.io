---
title: Installing Rancher Server (Multi Nodes)
layout: rancher-default-v1.2
version: v1.2
lang: en
redirect_from:
  - /rancher/installing-rancher/installing-server/multi-nodes/
  - /rancher/latest/en/installing-rancher/installing-server/multi-nodes/
---

## Installing Rancher Server (Multi Nodes)
---

Running Rancher server in High Availability (HA) is as easy as running [Rancher server using an external database]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#using-an-external-database), and exposing an additional port and adding in an additional argument to the command for the external load balancer.

### Requirements

* Node [requirements]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#requirements)
    * Port that needs to be opened between nodes: `9345`
* MySQL database
    * At least 1 GB RAM
    * 50 connections per Rancher server node (e.g. A 3 node setup will need to support at least 150 connections)
* External Load Balancer
    * Port that needs to be opened between nodes and external load balancer: `8080`

> **Note:** Currently, Docker for Windows and Docker for Mac are not supported in Rancher.

### Recommendations for Larger Deployments

* Each Rancher server node should have a 4 GB or 8 GB heap size, which requires having at least 8 GB or 16 GB of RAM
* MySQL database should have fast disks
* For true HA, a replicated MySQL database with proper backups is recommended. Using Galera and forcing writes to a single node, due to transaction locks, would be an alternative.

### Rancher Server Tags

The `rancher/server:latest` tag will be our stable release builds, which Rancher recommends for deployment in production. For each minor release tag, we will provide documentation for the specific version.

If you are interested in trying one of our latest development builds which will have been validated through our CI automation framework, please check our [releases page](https://github.com/rancher/rancher/releases) to find the latest development release tag. These releases are not meant for deployment in production. All development builds will be appended with a `*-pre{n}` suffix to denote that it's a development release. Please do not use any release with a `rc{n}` suffix. These `rc` builds are meant for the Rancher team to test out the development builds.

### Launching Rancher Server in HA

1. On each of your nodes that you want to add into the HA setup, run the following command:

   ```bash
   # Launch on each node in your HA cluster
   $ docker run -d --restart=unless-stopped -p 8080:8080 -p 9345:9345 rancher/server --db-host myhost.example.com --db-port 3306 --db-user username --db-pass password --db-name cattle --advertise-address <IP_of_the_Node>
   ```

   For each node, the `<IP_of_the_Node>` will be unqiue to each node, as it will be the IP of each specific node that is being added into the HA cluster.

2. Configure an external load balancer that will balance traffic on ports `80` and `443` across a pool of nodes that will be running Rancher server and target the nodes on port `8080`. Your load balancer must support websockets and forwarded-for headers, in order for Rancher to function properly. See [SSL settings page]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}//installing-rancher/installing-server/basic-ssl-config/) for example configuration settings.

3. Your HA setup is now complete and you can start launching [services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/), or start launching templates from the [Rancher Catalog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/)!

### Rancher Server Nodes

If the IP of your Rancher server node changes, your node will no longer be part of the Rancher HA cluster. You must stop the old Rancher server container using the incorrect IP for `--advertise-address` and start a new Rancher server with the correct IP for `--advertise-address`.
