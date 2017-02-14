---
title: Kubernetes in Rancher
layout: rancher-default-v1.4
version: v1.4
lang: en
---

## Kubernetes
---

### Concepts

#### Data Plane

This plane is comprised of one or more **Etcd** containers. Etcd is a distributed reliable key-value store which stores all Kubernetes state. This plane may be referred to as stateful, meaning the software comprising the plane maintains application state.

#### Orchestration Plane

This plane is comprised of stateless components that power our Kubernetes distro.

#### Compute Plane

This plane is comprised of the real workload, in the form of Kubernetes [pods](link/to/pod_docs).

### Planning

Before installation, it is important to consider your specific use case. Rancher provides a different deployment type for different users. At a high level, the major distinction between deployment types may be described by answering the following questions:

1. Is the system performant?
2. Is the system fault-tolerant?
3. Is the system low cost?

Developers might not care about the performance of their cluster, nor its tolerance to failure - they just want quick, easy access to Kubernetes. Their managers might be interested in the environment's cost. The [overlapping planes](link/to/overlapping-planes) deployment is recommended.

Users running production workloads care greatly about performance and fault tolerance. The [separated planes](link/to/separated-planes) deployment is recommended.

### Installation

#### Overlapping Planes

This is the simplest deployment. All planes overlap - all software may run on a single host (standalone). Containers are scheduled randomly and without any guarantees. Add three or more hosts to make the data plane (Etcd) resilient.

1. Create a Kubernetes environment.
2. Add one or more hosts with at least 1 CPU, 2GB RAM. Resource requirements vary depending on workload.

#### Separated Planes

This deployment allows the user to separate the planes - software may be intelligently scheduled on certain hosts. It provides Data Plane resilience and Compute Plane performance guarantees.A minimum of five hosts is required for this deployment type.

1. Create a Cattle environment.
2. Add 3 or more hosts with 1 CPU, >=1.5GB RAM, >=20GB DISK. Label these hosts **etcd=true** and **nopods=true**. This comprises the Data Plane.
    1. If you care about backups, see [Configuring Remote Backups](#configuring-remote-backups) now.
3. Add 1 or more hosts with >=1 CPU and >=2GB RAM. Label these hosts **orchestration=true** and **nopods=true**. This comprises the Orchestration Plane.
4. Add 1 or more hosts without any special labels. Resource requirements vary depending on user workload. This comprises the Compute Plane.
5. Navigate to **Catalog > Library**. On the Kubernetes catalog item, click **View Details**. Select your desired version, optionally update configuration options, and click **Launch**.

## Deployment Migrations
Any deployment plan may be migrated to any other deployment plan. For resilient deployment targets, this involves no downtime. If your desired migration is not listed, we don’t officially support it – but it is possible. Contact Rancher for further instruction.

### [Overlapping-Planes](#resilient-overlapping-planes) to [Separated-Planes](#resilient-separated-planes)
1. Add 3+ hosts to the environment. Ensure resource requirements are satisfied and create host labels as defined in the [Separated-Planes](#resilient-separated-planes) deployment instructions.
2. For etcd containers not on **etcd=true** hosts, migration is necessary. Delete one data sidekick container of an etcd. Ensure it is recreated on a correct host and becomes healthy (green circle) before continuing. Repeat this process as is necessary.
3. For kubernetes, scheduler, controller-manager, kubectld, rancher-kubernetes-agent, rancher-ingress-controller containers not on the **orchestration=true** host, delete the containers.
4. Make note of **etcd=true** and **orchestration=true** hostnames. From kubectl, type `kubectl delete node <hostname>` to remove the hosts from the [Compute Plane](#compute-plane). Wait until all pods on **etcd=true**, **orchestration=true** hosts are deleted. Kubelet and proxy containers will automatically shutdown once pod migration is complete.

## Failure Recovery
If a host enters reconnecting/disconnected state, attempt to re-run the agent registration command. Wait 3 minutes. If the host hasn’t re-entered active state, add a new host with similar resources and host labels. Delete the old host from the environment. Containers will be scheduled to the new host and eventually become healthy.

## Disaster Recovery
If a majority of hosts running etcd fail, follow these steps:

1. Find an etcd node in Running state (green circle). Click Execute Shell and run command `etcdctl cluster-health`. If the last output line reads *cluster is healthy*, then there is no disaster, stop immediately. If the last output line reads *cluster is unhealthy*, make a note of this etcd. This is your sole survivor, all other containers are dead or replaceable.
2. Delete hosts in reconnecting/disconnected state.
3. On your sole survivor, click **Execute Shell** and run command `disaster`. The container will restart automatically. Etcd will then heal itself and become a single-node cluster. System functionality is restored.
4. Add more hosts until you have at least three. Etcd scales back up. In most cases, everything will heal automatically. If new/dead containers are still initializing after three minutes, click **Execute Shell** and run command `delete`. **Do not, under any circumstance, run the `delete` command on your sole survivor.** System resiliency is restored.

## Restoring Backups
Backup restoration will only work for [Resilient Separated-Planes](#resilient-separated-planes) deployments. If all hosts running etcd fail, follow these steps:

1. Change your environment type to **Cattle**. This will tear down the Kubernetes system stack. Pods (the Compute plane) will remain intact and available.
2. Delete reconnecting/disconnected hosts and add new hosts if you need them.
3. Ensure at least one host is labelled **etcd=true**.
4. For each **etcd=true** host, mount the network storage containing backups - see [Configuring Remote Backups](#configuring-remote-backups) section for details. Then run these commands:

    ```bash
    # configure this to point to the desired backup in /var/etcd/backups
    target=2016-08-26T16:36:46Z_etcd_1
    # don’t touch anything below this line
    docker volume rm etcd
    docker volume create --name etcd
    docker run -d -v etcd:/data --name etcd-restore busybox
    docker cp /var/etcd/backups/$target etcd-restore:/data/data.current
    docker rm etcd-restore
    ```
    * Note - you must be logged in as a user with read access to the remote backups. Otherwise, the `docker cp` command will silently fail.
5. Change your environment type back to **Kubernetes**. The system stack will launch and your pods will be reconciled. Your backup may reflect a different deployment topology than what currently exists; pods may be deleted/recreated.

## Tearing Down

After tearing a down a Kubernetes stack, persistent data is left behind. A user may choose to manually delete this data if they wish to repurpose/reuse the hosts.

* A named volume `etcd` will exist on all hosts which ran etcd at some point. Run `docker volume rm etcd` on each host to delete it
* Backups are enabled by default and stored to `/var/etcd/backups` on hosts running etcd. Run `rm -r /var/etcd/backups/*` on one host (if network storage was mounted) or all hosts (if no network storage was mounted) to delete the backups
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

Rancher supports the ability to manage different Kubernetes namespaces. In the upper left hand corner next to the environment, you will be able to see which **Namespace** that you are working in. After the first host is added, Rancher creates the `default` namespace.

#### Adding Namespaces

To add an additional namespace into Kubernetes, click on the current namespace and a dropdown of available namespaces and **Manage Namespaces** will appear. Click on **Manage Namespaces**.

In the **Namespaces** page, click on **Add Namespace**. Update the configuration file and click **Create**.


#### Editing Namespaces

For existing namespaces, in the **Namespaces** page, click on **Edit** in the namespace's dropdown to update it. Click on **Save**.

#### Switching Namespaces

In the dropdown of namespaces, you can select the namespace that you want to launch services in to switch between the namespaces.
