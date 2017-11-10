---
title: Kubernetes - 灾难恢复
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## Kubernetes - 灾难恢复
---

Rancher在三个不同的主机上运行多达三个 **etcd** 实例。如果运行 **etcd** 的多数主机出了故障，按以下步骤做灾难恢复：

1. 在 **Kubernetes** -> **Infrastructure Stacks**页面中，展开 **Kubernetes** 栈。点击 **etcd** 服务。查找一个处于 `running` 状态的 `kubernetes-etcd` 容器。通过 **Execute Shell** 执行进这个容器中，运行 `etcdctl cluster-health`。
     * 如果输出的最后一行显示 `cluster is healthy`，那么这会儿没有灾难发生并且etcd集群也正常。
     * 如果最后行显示 `cluster is unhealthy`，记下这个 `kubernetes-etcd` 容器。这是你唯一的幸存者。使用这个容器做扩展（scale up）可以取代其余的出故障的容器。
2. 删除处于 `Disconnected` 状态的主机。确认其中没有主机在运行你的幸存者容器。
3. 执行进入上述幸存者容器，在shell中运行 `disaster`。容器会自动重启，并且etcd会自愈成单节点的集群。系统功能会恢复。
4. 添加**新的**主机直到有至少拥有先前运行etcd的主机的数量。旧的主机会包含**etcd**数据卷和备份，这将引起问题。如果你不能添加新主机，你可以先[清理主机]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/deleting/#清理主机)然后再重新添加这台主机。我们建议运行至少三个主机。如果你正在使用 [分隔平面]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/resiliency-planes/#分隔平面separated-planes)，别忘了给你的主机加上 `etcd=true` 标签。 随主机的加入并运行 **etcd** 服务，etcd会扩展回集群的数量。在大部分情况，一切都会自动恢复。如果新的／死掉的容器在 `initializing` 状态卡住超过三分钟，执行进这些容器并运行 `delete`。 **在任何情况都不要在你的幸存者容器中运行 `delete` 命令。**
