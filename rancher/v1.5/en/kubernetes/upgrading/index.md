---
title: Upgading Kubernetes
layout: rancher-default-v1.5
version: v1.5
lang: en
---

## Upgrading Kubernetes
---

If you are upgrading an existing Kubernetes setup to [require plane isolation]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/resiliency-planes/), please read more about the migration process.

The migration process is performed in two stages.

1. Ensuring that you have sufficient hosts with the appropriate labels.
2. Upgrading the Kubernetes infrastructure stack.

### Hosts with Labels

Confirm that your environment has enough hosts with labels for the planes. You can either add new hosts or use existing hosts.

1. **Compute Plane Hosts:** _For all existing hosts running kubelet and proxy containers_, add the label `compute=true`. These are the nodes already registered to Kubernetes when you run `kubectl get node`. This step is **critically important** because, without the label, Kubernetes pods will be orphaned on the host during this upgrade. If you have hosts running the kubelet and proxy containers, you can follow the steps of [removing them from the compute plane](#removing-hosts-with-pods-from-the-compute-plane).  You can also add more hosts and [label these hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#host-labels) with `compute=true`.
2. **Data Plane Hosts:** Have 3 or more hosts with 1 CPU, >=1.5GB RAM, >=20GB DISK. **If you have an existing Kubernetes setup with etcd services running, ensure that the `etcd=true` labels are on those hosts.** 
3. **Orchestration Plane Hosts:** Add 2 or more hosts with >=1 CPU and >=2GB RAM. When adding the host, [label these hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#host-labels) with `orchestration=true`. You can get away with 1 host, but you sacrifice high availability. In the event of this host failing, some K8s features such as the API, rescheduling pods in the event of failure, etc. will not occur until a new host is provisioned.

### Upgrade Kubernetes

1. In **Kubernetes** -> **Infrastructure Stacks**, find the Kubernetes infrastructure stack. Click on **Upgrade Available** or **Up to Date**  button.
2. Confirm the template version of Kubernetes is the one that you'd like to use.
3. Select `required` for **Plane Isolation**.
3. Select the configuration options for [cloud providers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/providers/), [backups]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/backups/), [add-ons]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/addons/).
4. Click on **Upgrade** to launch the updated Kubernetes infrastructure stack.
5. After the Kubernetes stack has finished upgrading all services and is in `upgraded` state, click on **Upgraded: Finish Upgrade**.

#### Removing Hosts with pods from the Compute Plane

**_WARNING:_** If you plan to remove any hosts from the compute plane, bare pods that aren't part of a replication controller or similar will _not_ be rescheduled. This is normal behavior.

Hosts in the compute plane are running the kubelet and proxy containers.

1. If the host has the `compute=true` label, remove the label from the host. This will prevent the kubelet and proxy containers to be re-scheduled onto the host after these containers are deleted.
2. Using `kubectl` through the remote CLI or shell, run `kubectl delete node <HOST>`. You can find the hostname (i.e. `<HOST>`) from the Rancher UI or from kubectl by running `kubectl get node`. Please wait for all pods to be deleted before moving to the next optional step.
3. **Optional:** If you want the kubelet and proxy to be removed from the host, you can perform an upgrade on the kubelet service and the proxy service, without changing any settings. Ensure all pods are deleted on the hosts before running this upgrade.
