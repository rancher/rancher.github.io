---
title: Kubernetes in Rancher
layout: rancher-default-v1.5
version: v1.5
lang: en
---

## Kubernetes
---

To deploy Kubernetes in Rancher, you'll first need to create a new [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/) that has an [environment template]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#what-is-an-environment-template) with the container orchestration set as **Kubernetes**.

### Configuring Kubernetes

Kubernetes can be configured while creating or editing environment templates. If you start with a **Cattle** environment, you can configure and launch **Kubernetes** from the **Catalog** -> **Library**. If you choose the catalog route, you can skip step 1.

1. Edit the Kubernetes configuration in an [environment template]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#what-is-an-environment-template), click on **Edit Config** in the **Orchestration** section of the template. You can edit the configuration when creating a new environment templates or when editing an existing environment template.
2. Confirm the template version of Kubernetes is the one that you'd like to use.
3. Select the configuration options for the [plane isolation]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/resiliency-planes/), [cloud providers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/providers/), [backups]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/backups/), [add-ons]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/addons/).
4. Click on **Configure** to save the configuration options for the environment template of click on **Launch** to launch Kubernetes from the catalog.

> **Note:** We recommend starting your Kubernetes environments with the correct configuration, if you want to change the configuration of an existing Kubernetes setup, you can click on **Up to Date** button to upgrade the Kubernetes setup to your new one.

### Creating a Kubernetes Environment

In the dropdown of environments, click on the **Manage Environments**. To create a new environment, click on **Add Environment**, provide a **Name**, **Description** (Optional), and select an environment template that has **Kubernetes** as the orchestration configured as you'd like. If [access control]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/) is turned on, you can [add members]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#editing-members) and select their [membership role]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#membership-roles). Anyone added to the membership list would have access to your environment.

After a Kubernetes environment has been created, you can navigate to the environment by either selecting the name of the environment in the environment's dropdown in the upper left hand corner or by selecting **Switch to this Environment** in the specific environment's drop down.

> **Note:** As Rancher adds support for multiple container orchestration frameworks, Rancher currently does not support the ability to switch between environments that already have services running in it.

### Starting Kubernetes

After a Kubernetes environment has been created, the [infrastructure services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/) will not be started until you add at least one host to your environment. The process of [adding hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/) is the same steps for all container orchestration types. Once the first host has been added, Rancher will automatically start the deployment of the infrastructure services including the Kubernetes services (i.e. master, kubelet, etcd, proxy, etc.). You can see the progress of the deployment by accessing the **Kubernetes** -> **Infrastructure Stacks** tab.

#### Host Requirements for Kubernetes

* For [overlapping planes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/resiliency-planes/#overlapping-planes) setup: At least 1 CPU, 2GB RAM. Resource requirements vary depending on workload.
* For [separated planes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/resiliency-planes/#separated-planes) setup: A minimum of five hosts is required for this deployment type.
 * Data Plane: Add 3 or more hosts with 1 CPU, >=1.5GB RAM, >=20GB DISK. When adding the host, [label these hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#host-labels) with `etcd=true`.
 * Orchestration Plane: Add 1 or more hosts with >=1 CPU and >=2GB RAM. When adding the host, [label these hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#host-labels) with `orchestration=true`. You can get away with 1 host, but you sacrifice high availability. In the event of this host failing, some K8s features such as the API, rescheduling pods in the event of failure, etc. will not occur until a new host is provisioned.
 * Compute Plane: Add 1 or more hosts. When adding the host, [label these hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#host-labels) with `compute=true`.

> **Note:** Only admins of Rancher or owners of the environment will be able to view the [infrastructure services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/).

When adding hosts to Kubernetes, the hostnames are used as unique identifiers for Kubernetes nodes when using `kubectl get nodes`.

### Using Kubernetes

Once the setup has completed, you can begin to create or manage your own Kubernetes applications via the following ways:

#### Rancher Catalog

Rancher supports the capability of hosting a catalog of Kubernetes templates. To use a template, click on the **Catalog** tab. Select the template that you want to launch and click **View Details**. Review and edit the stack name, stack description, and configuration options and click on **Launch**.

If you want to add your own templates to Kubernetes, you add them to the [Rancher catalog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/) and place your templates in a `kubernetes-templates` folder.

#### kubectl

To configure your own kubectl to talk to your newly created Kubernetes cluster, go to **Kubernetes** -> **CLI**. Click on **Generate Config** to generate the necessary `.kube/config` that you can download and add to your local directory. In the config file, it provides the necessary information for your local machine so that anything you launch using `kubectl` will be displayed in Rancher. The `kubectl` binary will only send requests using authentication over a TLS connection (HTTPS), because of this we rewrite the `server` variable to start with `https://`. The `rancher/server` container will accept and forward both HTTP and HTTPS requests on the same port.

#### kubectl via Shell

Rancher provides a convenient shell access to a managed kubectl instance that can be used to manage Kubernetes clusters and applications.

### Adding a Private Registry To Kubernetes

Private registries can be used with Kubernetes services by adding your [private registry]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/registries/) in your Kubernetes environment.
