---
title: Swarm in Rancher
layout: rancher-default-v1.6
version: v1.6
lang: en
---

## Swarm
---

To deploy Swarm in Rancher, you'll first need to create a new [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/) that has an [environment template]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#what-is-an-environment-template) with the container orchestration set as **Swarm**.

### Requirements
* Docker 1.13 or later
* Ports `2377` and `2378` must be open between hosts

### Creating a Swarm Environment

In the dropdown of environments, click on the **Manage Environments**. To create a new environment, click on **Add Environment**, provide a **Name**, **Description** (Optional), and select an environment template that has Swarm as the orchestration. If [access control]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/) is turned on, you can [add members]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#editing-members) and select their [membership role]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#membership-roles). Anyone added to the membership list would have access to your environment.

After a Swarm environment has been created, you can navigate to the environment by either selecting the name of the environment in the environment's dropdown in the upper left hand corner or by selecting **Switch to this Environment** in the specific environment's drop down.

> **Note:** As Rancher adds support for multiple container orchestration frameworks, Rancher currently does not support the ability to switch between environments that already have services running in it.

### Starting Swarm

After a Swarm environment has been created, the [infrastructure services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/) will not be started until you add at least one host to your environment. The **Swarm** service will require at least 3 hosts to be added.  The process of [adding hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/) is the same steps for all  container orchestration types. Once the first host has been added, Rancher will automatically start the deployment of the infrastructure services including the Swarm components (i.e. swarm and swarm-agent).  You can see the progress of the deployment by accessing the **Swarm** tab.

> **Note:** Please do not attempt to run `docker swarm` commands against the docker daemon manually. This can conflict with Rancher's management of the Swarm cluster.

> **Note:** Only admins of Rancher or owners of the environment will be able to view the [infrastructure services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/).

#### CLI via Shell

Rancher provides a convenient shell access to instance that can be used to execute `docker` or `docker-compose` commands.
