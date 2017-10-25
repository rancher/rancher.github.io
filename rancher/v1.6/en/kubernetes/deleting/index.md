---
title: Deleting Kubernetes
layout: rancher-default-v1.6
version: v1.6
lang: en
---

## Deleting Kubernetes
---

If you have chosen to delete **Kubernetes** orchestration from your environment, and want to continue using your environment and hosts, you will want to clean up your hosts.

### Cleaning up pods

Before deleting the Kubernetes stack in **Kubernetes** -> **Infrastructure Stacks**, you will need to remove your pods. You can use kubernetes to delete all the nodes and wait.

```
$ kubectl delete node --all
```

### Cleaning up Persistent Data

After deleting the Kubernetes infrastructure stack, persistent data still remains on the hosts.

#### Cleaning up hosts

For any hosts that had run the **etcd** service, there are a couple of items that need to be cleaned up by execing onto each host:

* A named volume `etcd`: Remove the named volume by running `docker volume rm etcd`.
* By default, [backups]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/backups) are enabled and stored at `/var/etcd/backups`: Remove the backups by running `rm -r /var/etcd/backups/*`.

#### Reasons to clean up persistent data

* When a host is being re-added to the different environment where Kubernetes needs to run.
* When the Kubernetes system stack gets removed and recreated launching Kubernetes through the catalog on the same set of hosts.

> **Note:** If you are cleaning up the persistent data, you will need to have deleted the [pods](#cleaning-up-pods) before deleting the Kubernetes infrastructure stack. Otherwise, the pods will remain on the hosts.

#### Consequences of not cleaning up

If cleanup is not performed, the data from the saved `etcd` volume will be used by the new Kubernetes system stack. It can cause several problems like:

* You might not want to recreate the all pre-existing Kubernetes apps that are stored in etcd data, but it is going to happen when the Kubernetes API service gets connected to the etcd service mapped to saved etcd data.
* **Important:** Every new Kubernetes API service obtains a new certificate from Rancher. That makes all previously created Kubernetes secrets stored in the etcd volume, obsolete. It means that any Kubernetes application that needs to communicate with the Kubernetes API service (i.e. [dashboard]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/addons/#dashboard), [helm]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/addons/#helm), heapster, and any user app that needs this kind of communication) will be broken. The only way to work around this lack of communication is to recreate user pods using the old set of secrets.
