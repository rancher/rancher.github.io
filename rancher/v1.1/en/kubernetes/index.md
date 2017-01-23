---
title: Kubernetes in Rancher
layout: rancher-default-v1.1
version: v1.1
lang: en
redirect_from:
  - /rancher/v1.1/zh/kubernetes/
---

## Kubernetes
---

To deploy Kubernetes in Rancher, you'll first need to create a new [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/) that has specified the cluster management to be Kubernetes.

### Creating a Kubernetes Environment

In the dropdown of environments, click on the **Manage Environments**. To create a new environment, click on **Add Environment**, select **Kubernetes** as the cluster management, provide a **Name**, **Description** (Optional). If [access control]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/) is turned on, you can [add members]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#editing-members) and select their [membership role]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#membership-roles). Anyone added to the membership list would have access to your environment.

After a Kubernetes environment has been created, you can navigate to the environment by either selecting the name of the environment in the environment's dropdown in the upper right hand corner or by selecting **Switch to this Environment** in the specific environment's drop down.

> **Note:** As Rancher adds support for multiple cluster management frameworks, Rancher currently does not support the ability to switch between environments that already have services running in it.

### Starting Kubernetes

After a Kubernetes environment has been created, you can start the Kubernetes cluster by adding at least one host to your environment. The process of [adding hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/) is the same steps for all cluster management types. Once the first host has been added, Rancher will automatically start the deployment of the required Kubernetes components (i.e. master, kubelet, etcd, proxy, etc.). You can see the progress of the deployment by accessing the **Kubernetes** tab.

### Using Kubernetes

Once the setup has completed, you can begin to create or manage your own Kubernetes applications via the following ways:

#### Rancher UI

Rancher provides full CRUD capability of creating services, replication controllers (RCs), and pods. In the **Kubernetes** tab, click on the one of these items and click **Add**. A kubernetes template will be shown in the UI and is editable. After you have made changes to the configuration file, click on **Create**.

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

### Kubernetes Namespaces

Rancher supports the ability to manage different Kubernetes namespaces. In the upper right hand corner, you will be able to see which **Namespace** that you are working in. After the first host is added, Rancher creates the `default` namespace.

#### Adding Namespaces

To add an additional namespace into Kubernetes, click on the current namespace and a dropdown of available namespaces and **Manage Namespaces** will appear. Click on **Manage Namespaces**.

In the **Namespaces** page, click on **Add Namespace**. Update the configuration file and click **Create**.


#### Editing Namespaces

For existing namespaces, in the **Namespaces** page, click on **Edit** in the namespace's dropdown to update it. Click on **Save**.

#### Switching Namespaces

In the dropdown of namespaces, you can select the namespace that you want to launch services in to switch between the namespaces.
