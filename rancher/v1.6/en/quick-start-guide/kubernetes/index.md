---
title: Quick Start: Setup a Kubernetes Environment
layout: rancher-default-v1.6
version: v1.6
lang: en
redirect_from:
  - /rancher/quick-start-guide/cattle
  - /rancher/latest/en/quick-start-guide/cattle
---

## Quick Start: Setup a Kubernetes Environment
---

This is a prescriptive guide for quickly setting up a Rancher 2 node cluster with a Kubernetes environment.
For purposes of this guide, we'll assume using Amazon Web Services with Ubuntu Linux, but you can
substitute these for alternatives according to our [hosts guide](http://docs.rancher.com/rancher/v1.6/en/hosts/).

### Prepare Linux Hosts

1. Create a VPC or EC2 classic security group that allows the follow inbound ports to all hosts in the security group:
  * `500/udp`
  * `4500/udp`
  * `8080/tcp`
1. Provision 3 m4.medium (one for server, two for container nodes) running Ubuntu 16.04 LTS, placing them in the above security group.
2. Install Docker `apt-get update && apt -y install docker.io=1.12.6-0ubuntu1~16.04.1` on all three.

> **Note:** If you do not have direct access to the VPC your EC2 instances are in, or are using EC2 Classic, you may need another security
group to allow you to connect to the Rancher Server UI at port 8080. Assign this only to the one instance running Rancher Server.


### Setup Rancher Server

Choose one node to run Rancher Server. Login to this host and run:

```bash
sudo docker run -d --restart=unless-stopped -p 8080:8080 rancher/server:stable
```

After a few minutes the Rancher Server interface should be available at `http://<INSTANCE-IP>:8080`. Once logged in, using the
navigation bar at the top, select `Environments > Manage Environments`. We need to create a new environment that is configured to run
Kubernetes. Select the `Add Environment` button at the top left, and then on the next page after giving it a useful name, select the Kubernetes environment template. Once the environment has been created, switch to it by again selecting the Environments menu option at the top and then the name of your new Kubernetes environment.

Once in the new Environment, select `Infrastructure > Hosts`. On this page, click the "Add Hosts" button at the top left. It will ask you to confirm the URL of the server (usually the default is fine). Then scroll downloaded the page to get the registration command (step 5). Copy this for our next steps.


### Setup Rancher Nodes

Using the registration command we previously copied, login to the other two instances and execute the `docker run` command by copying it into your shell. This will configure the instances and container nodes within Rancher.

In the Rancher UI you should see the nodes appear after 1-2 minutes.

### Next Steps
Now that you've setup your Rancher environment, you might want to check out how to deploy an application.
