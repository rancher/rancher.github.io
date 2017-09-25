---
title: Quick Start Guide
layout: rancher-default-v2.0
version: v2.0
lang: en
redirect_from:
  - /rancher/quick-start-guide/
---

## Quick Start Guide
---

In this guide, you'll learn how to get started with Rancher v2.0, including:

* Preparing a Linux Host
* Launching Rancher Server and Accessing the Rancher UI
* Adding a Host through the Rancher UI
* Importing an Existing Kubernetes Cluster
* Adding a Container through the Rancher UI

We'll also cover a couple of advanced topics, such as:

* Launching Catalog Applications
* Using Advanced Kubernetes Options

<a id="prepare-host"></a>
### Preparing a Linux Host
To begin, you'll need to install a supported version of Docker on a single Linux host:
* Docker v1.12.6
* Docker v1.31.1
* Docker v17.03
* Docker v17.06

#### To Prepare a Linux Host:
1. Prepare a Linux host with 64-bit Ubuntu 16.04, at least 4GB of memory, and a kernel of 3.10+.
2. Install a supported version of Docker on the host. To install Docker on the server, follow the instructions from [Docker](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/).

<a id="launch-rancher"></a>
### Launching Rancher Server
It only takes one command and a few minutes to install and launch Rancher Server. Once installed, you can open a web browser to access the Rancher UI.

#### To Launch Rancher Server:
1. Run this Docker command on your host:

```bash
$ sudo docker run -d --restart=unless-stopped -p 8080:8080 rancher/server:preview
```
This process might take several minutes to complete.  

2. To access the Rancher UI, go to `http://<SERVER_IP>:8080`, replacing `<SERVER_IP>` with the IP address of your host. Rancher automatically deploys and manages Kubernetes, and the UI displays a Welcome page with two options for adding hosts.

>**Note:** Initially, Rancher creates a **Default** cluster and environment for you. Rancher supports grouping resources into multiples clusters and environments. A **cluster** is a group of physical (or virtual) compute resources. Each environment is tied to one cluster and runs its containers on the cluster's hosts, and you can share a cluster with more than one environment. An **environment** is a namespace where applications, services, and containers are defined. The containers in an environment can communicate with each other over a shared managed network, and you can give different users/groups access to manage the resources of the environment.

3. Select one of the options for adding hosts, and then continue to the relevant section below:
  * **Add Hosts** -- Select this option if you want to manage hosts in Rancher. To add an existing host with Docker installed or a new host through a supported cloud provider, go to [**Adding Hosts**](#addhost).
  * **Use existing Kubernetes** -- Select this option if you want the cluster provider to manage hosts outside Rancher. To import an existing Kubernetes installation, go to [**Importing Kubernetes Clusters**](#import-k8s).

<a href="#addhost" id="addhost"></a>
### Adding Hosts
You can either add a host from a cloud provider that Rancher v2.0 supports, or you can add a custom host. If you don't see your cloud provider in the UI, don't worry. Simply use the custom host option.

If you're adding a custom host, note these requirements:
* Typically, Rancher automatically detects the IP address to register the host.
  * If the host is behind a NAT or the same machine that is running the `rancher/server` container, you might need to explicitly specify its IP address. To do so, click **Show advanced options**, and then enter the **Registration IP Address**.
* The host agent initiates a connection to the server, so make sure firewalls or security groups allow it to reach the URL in the command.
* All hosts in the environment must to allow traffic between each other for cross-host networking
  * IPSec: `500/udp` and `4500/udp`
  * VXLAN: `4789/udp`

<a id="cloudprovided"></a>
#### To Add a Host from a Cloud Provider:
1. On the Add Hosts page, select your cloud provider:
   * Amazon EC2
   * Microsoft Azure
   * DigitalOcean
   * Packet

2. Follow the instructions in the Rancher UI to add your host. This process might take a few minutes to complete. Once your host is ready, you can view its status on the Hosts page.

<a id="custom"></a>
#### To Add a Custom Host:
1. On the Add Hosts page, click **Custom**. A `docker` command displays. For example:
   ```bash
   sudo docker run --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/rancher:/var/lib/rancher rancher/agent:v2.0-alpha2
   http://<SERVER_IP>:8080/v3/scripts/D5433C26EC51325F9D98:1483142400000:KvILQKwz1N2MpOkOiIvGYKKGdE
   ```

   >**Note:** The IP address in the command must match your `<SERVER_IP>` and must be reachable from inside your host.

2. To register your host with Rancher, copy, paste, and run the `docker` command on your host. This process might take a few minutes to complete.
3. Click **Close**. On the Hosts page, you can view the status of your host.

<a href="#import-k8s" id="import-k8s"></a>
### Importing Kubernetes Clusters

In Rancher v2.0, you can import an existing, external installation of Kubernetes v1.7+. In this scenario, the cluster provider manages your hosts outside of Rancher. We support hosted services like Google Container Engine, Azure Container Service, IBM Bluemix, and bring-your-own-Kubernetes installations.

#### To Import a Kubernetes Cluster:
1. A `kubectl` command displays in the UI. Copy, paste, and execute this command against your Kubernetes cluster. This process might take a few minutes to complete.
2. Click **Close**. On the Hosts page, you can view the status of your Kubernetes nodes.

<a id="containers"></a>
### Adding Containers

After you add at least one host or cluster to your environment, it might take several minutes for all Rancher system services to launch. To verify the status of your environment, from the **Default** menu, select **System**. If a service is healthy, its state displays in green.

Once you've verified that all system services are up and running, you're ready to create your first container.

#### To Add a Container:
1. On the Rancher UI menu, click **Containers**.
2. Click **Add Container**. The Add Container page displays.
3. Enter a **Name**, such as "first-container."
4. Enter a **Docker Image** hosted on Docker Hub.
5. Click **Launch**. This process might take a few minutes to complete. Once your container starts running, you can view its status on the Containers page.

Now that you've added hosts and your first container is up and running, you can check out the rest of our new features in Rancher v2.0.

<a id="catalog"></a>
### Launching Catalog Applications

To help you deploy complex stacks, Rancher offers a catalog of application templates.

#### To Launch a Catalog Application:
1. On the Rancher UI menu, click **Apps**. The Applications page displays.
2. Click **Launch from Catalog**. The Catalog displays the available application templates.
3. Search for the template you want to launch, and then click **View Details**.
4. Complete the required fields.

>**Note:** To review the `docker-compose.yml` and `rancher-compose.yml` files used to generate the stacks, click **Preview** before launching the stack.

5. Click **Launch**. On the Applications page, you'll see Rancher is creating a stack based on your new application. This process might take a few minutes.

Once its services are up and running, the state of your new stack displays in green.

<a id="advanced-k8s"></a>
### Using Advanced Kubernetes Options

From the Rancher UI, you can access the native Kubernetes dashboard with one click.

You can also run `kubectl` from your web browser. The Kubernetes CLI, or `kubectl`, helps you deploy and manage your Kubernetes applications. For more information, or to download `kubectl`, visit the [Kubernetes documenation](https://kubernetes.io/docs/tasks/tools/install-kubectl/).

In addition, you can generate a Kubernetes configuration file to use `kubectl` on your desktop. A Kubernetes configuration, or *kubeconfig*, file lets you configure access to one or more clusters.  

#### To Use Advanced Kubernetes Options:
1. On the Rancher UI menu, click **Containers**.
2. Select the **Advanced** tab. The following advanced options display:
   * **Launch Dashboard** -- Select this option to access the native Kubernetes dashboard in a new browser window.
   * **Launch kubectl** -- Select this option to run `kubectl` commands from your browser using shell. Click **Close** to return to the Rancher UI.
   * **Download kubeconfig** -- Select this option to generate a *kubeconfig* file to use `kubectl` on your desktop. Copy and paste the code that displays into your `~/.kube/config file`, and then run `kubectl`. Click **Close** to return to the Rancher UI.
