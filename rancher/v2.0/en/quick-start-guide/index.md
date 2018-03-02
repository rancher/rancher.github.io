---
title: Quick Start Guide
layout: rancher-default-v2.0
version: v2.0
lang: en
redirect_from:
  - /rancher/quick-start-guide/
  - /rancher/v2.0/en/
---

## Quick Start Guide
---

In this guide, you'll learn how to get started with Rancher v2.0, including:

* Preparing a Linux Host
* Launching Rancher Server and Accessing the Rancher UI
* Creating Clusters through the Rancher UI
* Importing an Existing Kubernetes Cluster
* Adding a Pod through the Rancher UI
* Using Kubeconfig file

<a id="prepare-host"></a>

### Preparing a Linux Host

1. Prepare a Linux host with 64-bit Ubuntu 16.04, at least 4GB of memory.
2. Install the latest stable version of Docker on the host. To install Docker on the server, follow the instructions from [Docker](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/).

<a id="launch-rancher"></a>

### Launching Rancher Server

It only takes one command and less than a minute to install and launch Rancher Server. Once installed, you can open a web browser to access the Rancher UI.

#### To Launch Rancher Server:

1. Run this Docker command on your host:

   ```bash
   $ sudo docker run -d --restart=unless-stopped -p 80:80 -p 443:443 rancher/server:preview
   ```

2. To access the Rancher UI, go to `https://<SERVER_IP>`, replacing `<SERVER_IP>` with the IP address of your host. Rancher is automatically authenticated with a default admin. You will need to log in with this user (`admin`) and password (`admin`). Upon logging in the first time, you will be asked to change the default admin's password.

   > **Note:** Rancher only supports HTTPS and is configured, by default, with a self-signed cert.  The ability to replace this cert will be made available before GA.  Due to this, you will be prompted by your browser to trust this cert before continuing.

3.   Start adding clusters into your Rancher server. Select one of the options for adding clusters, and continue to the relevant section below:

    * **Creating a Cloud Cluster** -- Select this option to create and use a new cluster and nodes managed by a cloud Kubernetes provider. To create a new cloud cluster, go to [**Creating Cloud Clusters**](#creating-cloud-clusters).
    * **Creating a [RKE](https://github.com/rancher/rke) Cluster** -- Select this option to have Rancher deploy and automatically manage a Kubernetes cluster for you. To create a RKE cluster, go to [**Creating RKE Clusters**](#creating-rke-clusters).
    * **Import an Existing Kubernetes Cluster** – Select this option if you want the cluster provider to manage hosts outside Rancher. To import an existing Kubernetes installation, go to [**Importing Kubernetes Clusters**](#importing-kuberentes-clusters).

### Creating Cloud Clusters

In Rancher v2.0, you can create new Kubernetes clusters from hosted services like Google Container Engine (GKE).

1. Click on the **Add Cluster** button and in "Create a Cloud Cluster", click on **Select**.

2.  Follow the instructions in the Rancher UI to create and add your cluster. The provisioning process might take a few minutes to complete. Once your cluster is ready, you can view its status on the Clusters page. Once your cluster is running, Rancher creates a `Default` project and a `default` namespace. Once the cluster is active, you can start adding pods into your namespace.

### Creating RKE Clusters

You can create a cluster using [RKE](https://github.com/rancher/rke), which will install Kubernetes on any nodes that you bring into your cluster. You can add node(s) from various cloud providers that Rancher v2.0 support and specify the role for each node for the Kubernetes cluster.

> **Note:** Currently in the tech preview, only Digital Ocean and AWS nodes are supported, but support for all the cloud providers and adding custom nodes will be added.

<!--
If you're adding a custom host, note these requirements:

* Typically, Rancher automatically detects the IP address to register the host.
  * If the host is behind a NAT or the same machine that is running the `rancher/server` container, you might need to explicitly specify its IP address. To do so, click **Show advanced options**, and then enter the **Registration IP Address**.
* The host agent initiates a connection to the server, so make sure firewalls or security groups allow it to reach the URL in the command.
* All hosts in the environment must to allow traffic between each other for cross-host networking
  * IPSec: `500/udp` and `4500/udp`
  * VXLAN: `4789/udp`
-->

1. Follow the instructions in the Rancher UI to create and add your RKE cluster.

2. In the Nodes section, click on **Add a new node** to select which type of node you want to add. You can configure a new node template to launch nodes or select from an existing node template (i.e. if you had previously launched a node). When launching any new nodes, a node template is saved with your configuration to allow you to re-use this configuration for adding additional nodes.

3. After selecting your node(s) to be created, select which roles you want the node(s) to act in the Rancher managed Kubernetes cluster.

    Select from the following roles:

    * **etcd** -- On this node, `etcd` is launched. Etcd is a distributed reliable key-value store which stores all Kubernetes state. We recommend running 1, 3, or 5 nodes with the etcd role.
    * **management** -- On this node, master components will run (`kube-api`, `kube-scheduler`, `kube-controller`) as well as `kubelet` and `kubeproxy`. These nodes are used to help manage the Kubernetes cluster as well as where your applications (i.e. pods) can be launched.
    * **worker node** -- On these nodes, only worker components (`kubelet`, `kubeproxy`, `nginx-proxy`) are launched and these nodes will only have your applications (i.e. pods) running.

4. Finish creating your cluster by clicking **Create**. This process might take a few minutes to complete. Once your cluster is ready, you can view its status on the Clusters page. Once the cluster is active, you can start adding pods into your namespace.

### Importing Kubernetes Clusters

In Rancher v2.0, you can import an existing, external installation of Kubernetes v1.8. In this scenario, the cluster provider manages your hosts outside of Rancher.

#### To Import a Kubernetes Cluster:

1. Follow the instructions in the Rancher UI to import an existing Kubernetes cluster. Import the _kubeconfig_ file of your existing cluster.
2. Click **Import**. Once your cluster is ready, you can view its status on the Clusters page. Once the cluster is active, you can start adding pods into your namespace.

### Rancher Concepts

Rancher supports grouping resources into multiples clusters, projects and namespaces.

A **cluster** is a group of physical (or virtual) compute resources. Each project is tied to one cluster and runs its pods on the cluster's nodes. You can share a cluster with more than one project as well as give different users access to manage the various resources of a cluster.

A **project** is a group of namespaces where workloads are defined. The pods in a project can communicate with each other over a shared managed network, and you can give different users access to manage the various resources of a project.

### Adding Pods

After at least one cluster with nodes is created and active, you're ready to create your first pod. You can check on your cluster status by clicking on the cluster or viewing the status on the Global view of all clusters.

#### To Add a Pod:

1. Click into the `Default` project of a cluster.
2. Click **Deploy**. The Add Pod page displays.
3. Enter a **Name**, such as "first-pod."
4. Enter a **Docker Image** hosted on Docker Hub.
5. Click **Launch**. This process might take a few minutes to complete. Once your pod starts running, you can view its status on the Workloads page.

Now that you've added nodes and your first pod is up and running, you can check out the rest of our new features in Rancher v2.0.

<!--
<a id="catalog"></a>

### Launching Catalog Applications

To help you deploy complex stacks, Rancher offers a catalog of application templates.

#### To Launch a Catalog Application:

1. On the Rancher UI menu, click **Apps**. The Applications page displays.
2. Click **Launch from Catalog**. The Catalog displays the available application templates.
3. Search for the template you want to launch, and then click **View Details**.
4. Complete the required fields.

   > **Note:** To review the `docker-compose.yml` and `rancher-compose.yml` files used to generate the stacks, click **Preview** before launching the stack.

5. Click **Launch**. On the Applications page, you'll see Rancher is creating a stack based on your new application. This process might take a few minutes.

Once its services are up and running, the state of your new stack displays in green.
-->

### Using Kubeconfig File

You can generate a Kubernetes configuration file to use `kubectl` on your desktop. A Kubernetes configuration file, i.e. *kubeconfig*, lets you configure access to one or more clusters from your desktop.  

1. On the Rancher UI menu, select the cluster.
2. In the **Dashboard**, click on the **Kubeconfig File** button. A *kubeconfig* file will be generated so you can use `kubectl` on your desktop. Copy and paste the code that displays into your `~/.kube/config` file, and then start using `kubectl`. Click **Close** to return to the Rancher UI.

### Deploying on Canonical Kubernetes

It is possible to use Rancher to control Canonical Kubernetes (cdk) clusters running on Ubuntu. A full set of instructions has been provided by Canonical for doing this [https://github.com/CalvinHartwell/canonical-kubernetes-rancher.git](https://github.com/CalvinHartwell/canonical-kubernetes-rancher.git). 
