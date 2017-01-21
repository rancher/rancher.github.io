---
title: Mesos in Rancher
layout: rancher-default-v1.1
version: v1.1
lang: en
redirect_from:
  - /rancher/v1.1/zh/mesos/
---

## Mesos
---

To deploy Mesos in Rancher, you'll first need to create a new [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/) that has specified the cluster management to be **Mesos**.

### Creating a Mesos Environment

In the dropdown of environments, click on the **Manage Environments**. To create a new environment, click on **Add Environment**, select **Mesos** as the cluster management, provide a **Name**, **Description** (Optional). If [access control]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/) is turned on, you can [add members]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#editing-members) and select their [membership role]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#membership-roles). Anyone added to the membership list would have access to your environment.

After a Mesos environment has been created, you can navigate to the environment by either selecting the name of the environment in the environment's dropdown in the upper right hand corner or by selecting **Switch to this Environment** in the specific environment's drop down.

> **Note:** As Rancher adds support for multiple cluster management frameworks, Rancher currently does not support the ability to switch between environments that already have services running in it.

### Starting Mesos

After a Mesos environment has been created, you can start the Mesos cluster by adding at least three hosts to your environment. The process of [adding hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/) is the same steps for all cluster management types. Once the first host has been added, Rancher will automatically start the deployment of the required Mesos components (i.e. mesos-master, mesos-slave and zookeeper).  You can see the progress of the deployment by accessing the **Mesos** tab.

### Using Mesos

Once the setup has completed, you can begin to create or manage your own Mesos applications via the following ways:

#### Mesos UI

You can manage Mesos by clicking on the **Mesos UI**. A new webpage will open up with a different UI to manage Mesos. Any frameworks created in this UI will also be reflected in Rancher.

#### Rancher Catalog

Rancher supports the capability of hosting a catalog of Mesos frameworks. To use a framework, click on either the **Mesos** -> **Launch a framework** button or click on the **Catalog** tab. Select the framework that you want to launch and click **View Details**. Review and edit the stack name, stack description, and configuration options and click on **Launch**.

If you want to add your own templates to Mesos, you add them to your own private[Rancher catalog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/) and place your templates in a `mesos-templates` folder.
