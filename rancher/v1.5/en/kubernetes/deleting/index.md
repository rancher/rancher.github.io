---
title: Deleting Kubernetes
layout: rancher-default-v1.5
version: v1.5
lang: en
---

# Deleting Kubernetes
---

After deleting the Kubernetes stack in **Kubernetes** -> **Infrastructure Stacks**, persistent data is left behind. A user may choose to manually delete this data if you'd like to re-use the hosts.

For any hosts that had run the **etcd** service, there are a couple of items that need to be cleaned up by execing onto each host:

* A named volume `etcd`: Remove the named volume by running `docker volume rm etcd`.
* By default, [backups]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/backups) are enabled and stored at `/var/etcd/backups`: Remove the backups by running `rm -r /var/etcd/backups/*`.
