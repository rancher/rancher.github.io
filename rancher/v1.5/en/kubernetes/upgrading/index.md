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
2. **Data Plane Hosts:** Add 3 or more hosts with 1 CPU, >=1.5GB RAM, >=20GB DISK. When adding the host, [label these hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#host-labels) with `etcd=true`.
3. **Orchestration Plane Hosts:** Add 2 or more hosts with >=1 CPU and >=2GB RAM. When adding the host, [label these hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#host-labels) with `orchestration=true`. You can get away with 1 host, but in the event of host failure, the k8s API will be unavailable until a new orchestration host is added.

### Upgrade Kubernetes

1. In **Kubernetes** -> **Infrastructure Stacks**, find the Kubernetes infrastructure stack. Click on **Upgrade Available** or **Up to Date**  button.
2. Confirm the template version of Kubernetes is the one that you'd like to use.
3. Select `required` for **Plane Isolation**.
3. Select the configuration options for [cloud providers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/providers/), [backups]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/backups/), [add-ons]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/addons/).
4. Click on **Upgrade** to launch the updated Kubernetes infrastructure stack.
5. After the Kubernetes stack has become in `upgraded` state, click on **Upgraded: Finish Upgrade**.

#### Removing Hosts with pods from the Compute Plane

**_WARNING:_** If you plan to remove any hosts from the compute plane, bare pods that aren't part of a replication controller or similar will _not_ be rescheduled. This is normal behavior.

Hosts in the compute plane are running the kubelet and proxy containers.

1. If the host has the `compute=true` label, remove the label from the host. This will prevent any new pods to be scheduled onto the host.
2. Using `kubectl` through the remote CLI or shell, run `kubectl delete node <HOST>`. You can find the hostname (i.e. `<HOST>`) from the Rancher UI or from kubectl by running `kubectl get node`.
3. **Optional:** If you want the kubelet and proxy to be removed from the host, you can perform an upgrade on the kubelet service and the proxy service, without changing any settings.
