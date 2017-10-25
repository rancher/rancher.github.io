---
title: Kubernetes - Disaster Recovery
layout: rancher-default-v1.5
version: v1.5
lang: en
---

## Kubernetes - Disaster Recovery
---

Rancher runs up to 3 instances of **etcd** on 3 different hosts. If a majority of hosts running **etcd** fail, follow these steps:

1. In **Kubernetes** -> **Infrastructure Stacks**, expand the **Kubernetes** stack. Click on the **etcd** service. Find a `kubernetes-etcd` container that is in `running` state. Exec into the container, by using **Execute Shell**. In the shell, run `etcdctl cluster-health`.
     * If the last output line reads `cluster is healthy`, then there is no disaster, stop immediately.
     * If the last output line reads `cluster is unhealthy`, make a note of this `kubernetes-etcd` container. This is your sole survivor. All other containers can be replaced as you will use this container to scale up.
2. Delete the hosts in `Disconnected` state. Confirm that none of these hosts are running your sole survivor.
3. Exec into the container that is your sole survivor. In the shell, run `disaster`. The container will restart automatically and etcd will heal itself to become a single-node cluster. System functionality will be restored.
4. Add **NEW** hosts until you have at least the number of hosts that were previously running etcd. Old hosts will contain an **etcd** data volume and back-ups that will cause problems. If you are unable to add new hosts, you can follow [Cleaning up hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/deleting/#cleaning-up-hosts) to clean the host properly before adding it again. We recommend running at least 3 hosts and if you are using [separated planes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/resiliency-planes/#separated-planes), don't forget to add the label `etcd=true` to your hosts. Etcd will scale back up as hosts are added and start running the **etcd** service. In most cases, everything will automatically heal. If new/dead containers are stuck in `initializing` after three minutes, exec into those containers and run `delete`. **Do not, under any circumstance, run the `delete` command on your sole survivor.**
