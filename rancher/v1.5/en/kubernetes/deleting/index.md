---
title: Deleting Kubernetes
layout: rancher-default-v1.5
version: v1.5
lang: en
---

# Deleting Kubernetes
---

After deleting the Kubernetes stack in **Kubernetes** -> **Infrastructure Stacks**, persistent data is left behind. A user may choose to manually delete this data.

### Cleaning up hosts

For any hosts that had run the **etcd** service, there are a couple of items that need to be cleaned up by execing onto each host:

* A named volume `etcd`: Remove the named volume by running `docker volume rm etcd`.
* By default, [backups]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/backups) are enabled and stored at `/var/etcd/backups`: Remove the backups by running `rm -r /var/etcd/backups/*`.

### Reasons to clean up persistent data

* When a host is being re-added to the different environment where Kubernetes needs to run.
* When the Kubernetes system stack gets removed and recreated launching Kubernetes through the catalog on the same set of hosts.

### Consequences of not cleaning up

If cleanup is not performed, the data from the saved `etcd` volume will be used by the new Kubernetes system stack. It can cause several problems like:

* You might not want to recreate the all pre-existing Kubernetes apps that are stored in etcd data, but it is gonna happen when the Kubernetes API service gets connected to the etcd service mapped to saved etcd data.
* **Important:** Every new Kubernetes API service obtains a new certificate from Rancher. That makes all previously created Kubernetes secrets stored in the etcd volume, obsolete. It means that any Kubernetes application that needs to communicate with the Kubernetes API service (i.e. [dashboard]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/addons/#dashboard), [helm]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/addons/#helm), heapster, and any user app that needs this kind of communication) will be broken. The only way to work around this lack of communication is to recreate user pods using the old set of secrets.
