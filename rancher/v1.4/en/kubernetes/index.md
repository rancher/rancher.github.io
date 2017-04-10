---
title: Kubernetes in Rancher
layout: rancher-default-v1.4
version: v1.4
lang: en
---

## Kubernetes
---

To deploy Kubernetes in Rancher, you'll first need to create a new [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/) that has an [environment template]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#what-is-an-environment-template) with the container orchestration set as **Kubernetes**.

### Creating a Kubernetes Environment

In the dropdown of environments, click on the **Manage Environments**. To create a new environment, click on **Add Environment**, provide a **Name**, **Description** (Optional), and select an environment template that has _Kubernetes_ as the orchestration. If [access control]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/) is turned on, you can [add members]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#editing-members) and select their [membership role]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#membership-roles). Anyone added to the membership list would have access to your environment.

After a Kubernetes environment has been created, you can navigate to the environment by either selecting the name of the environment in the environment's dropdown in the upper left hand corner or by selecting **Switch to this Environment** in the specific environment's drop down.

> **Note:** As Rancher adds support for multiple container orchestration frameworks, Rancher currently does not support the ability to switch between environments that already have services running in it.

### Starting Kubernetes

After a Kubernetes environment has been created, the [infrastructure services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/) will not be started until you add at least one host to your environment. The process of [adding hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/) is the same steps for all container orchestration types. Once the first host has been added, Rancher will automatically start the deployment of the infrastructure services including the Kubernetes services (i.e. master, kubelet, etcd, proxy, etc.). You can see the progress of the deployment by accessing the **Kubernetes** -> **Infrastructure Stacks** tab.

> **Note:** Only admins of Rancher or owners of the environment will be able to view the [infrastructure services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/).

When adding hosts to Kubernetes, the hostnames are used as unique identifiers for Kubernetes nodes when using `kubectl get nodes`.

### Using Kubernetes

Once the setup has completed, you can begin to create or manage your own Kubernetes applications via the following ways:

#### Rancher Catalog

Rancher supports the capability of hosting a catalog of Kubernetes templates. To use a template, click on the **Catalog** tab. Select the template that you want to launch and click **View Details**. Review and edit the stack name, stack description, and configuration options and click on **Launch**.

If you want to add your own templates to Kubernetes, you add them to the [Rancher catalog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/) and place your templates in a `kubernetes-templates` folder.

#### kubectl

To configure your own kubectl to talk to your newly created Kubernetes cluster, go to **Kubernetes** -> **kubectl**. Click on **Generate Config** to generate the necessary `kube/config_file` that you can download and add to your local directory.

In the config file, it provides the necessary information for your local machine so that anything you launch using `kubectl` will be displayed in Rancher.

#### kubectl via Shell

Rancher provides a convenient shell access to a managed kubectl instance that can be used to manage Kubernetes clusters and applications.

### Adding a Private Registry To Kubernetes

Private registries can be used with Kubernetes services by adding your [private registry]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/registries/) in your Kubernetes environment.
