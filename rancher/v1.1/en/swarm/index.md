---
title: Swarm in Rancher
layout: rancher-default-v1.1
version: v1.1
lang: en
redirect_from:
  - /rancher/v1.1/zh/swarm/
---

## Swarm
---

To deploy Swarm in Rancher, you'll first need to create a new [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/) that has specified the cluster management to be **Swarm**.

### Creating a Swarm Environment

In the dropdown of environments, click on the **Manage Environments**. To create a new environment, click on **Add Environment**, select **Swarm** as the cluster management, provide a **Name**, **Description** (Optional). If [access control]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/) is turned on, you can [add members]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#editing-members) and select their [membership role]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#membership-roles). Anyone added to the membership list would have access to your environment.

After a Swarm environment has been created, you can navigate to the environment by either selecting the name of the environment in the environment's dropdown in the upper right hand corner or by selecting **Switch to this Environment** in the specific environment's drop down.

> **Note:** As Rancher adds support for multiple cluster management frameworks, Rancher currently does not support the ability to switch between environments that already have services running in it.

### Starting Swarm

After a Swarm environment has been created, you can start the Swarm cluster by adding at least one host to your environment. The process of [adding hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/) is the same steps for all cluster management types. Once the first host has been added, Rancher will automatically start the deployment of the required Swarm components (i.e. swarm and swarm-agent) on at least one host.  You can see the progress of the deployment by accessing the **Swarm** tab.

> **Note:** The swarm agent does not need to be deployed on all hosts.

### Using Swarm

Once the setup has completed, you can begin to create or manage your own Swarm applications via the following ways:

#### Rancher UI

Rancher provides full CRUD capability of creating projects. In the **Swarm** tab, click on the **Projects** and click **Add Project**. When adding a project, you can input your `docker-compose.yml` either by reading a file or copying and pasting the contents directly into the UI. If your compose-template contains any environment interpolation, you will need to declare the variables by adding **variable substitution**. Click on **Create**.

#### Rancher Catalog

Rancher supports the capability of hosting a catalog of Swarm templates. To use a template, click on the **Catalog** tab. Select the template that you want to launch and click **View Details**. Review and edit the stack name, stack description, and configuration options and click on **Launch**.

If you want to add your own templates to Swarm, you add them to the [Rancher catalog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/) and place your templates in a `swarm-templates` folder.

#### CLI

To configure your own workstation to work with swarm, click on **Swarm** -> **CLI** -> **Generate Config** to generate the necessary API key and configuration file into a `docker-cli.zip` file. Follow the instructions in the UI to set up TLS and connect to Docker.

#### CLI via Shell

Rancher provides a convenient shell access to instance that can be used to execute `docker` or `docker-compose` commands.
