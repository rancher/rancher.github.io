---
title: 删除 Kubernetes
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## 删除 Kubernetes
---

如果你选择从你的环境删除 **Kubernetes** 编排，并想继续使用你的环境和主机，你会需要清理你的主机。

### 清理 Pods

在通过 **Kubernetes** -> **Infrastructure Stacks** 删除Kubernetes栈之前，你需要删除你的Pods。你可以使用Kubernetes来删除所有的结点然后等待。

```
$ kubectl delete node --all
```

### 清理持久化数据

在删除了 Kubernetes 基础设施服务之后，持久化数据依然会保留在主机上。

#### 清理主机

对每台跑过 **etcd** 服务的主机，有几样东西需要通过执行进每台主机做清理：

* 一个命名存储卷 `etcd`: 通过执行 `docker volume rm etcd` 来删除该卷。
* 默认情况下， [备份]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/backups) 是被激活的，备份数据存储在 `/var/etcd/backups`。 通过执行 `rm -r /var/etcd/backups/*` 删除备份。

#### 清理持久化数据的场景

* 当一台主机需要被重新添加到另一个Kubertes运行的环境时。
* 当Kubernetes基础设施被删除并在同一组主机上通过应用商店（catalog）重建时。

> **注意：** 如果你正要清理持久化数据，你需要在删除Kubernetes基础设施之前先删掉 [pods](#清理-pods)。否则Pods会在主机上留存。

#### 不做清理的后果

如果不做清理，来自先前保存的 `etcd` 存储卷会被新的 Kubernetes 基础设施使用。这样会导致诸如以下的严重问题：

* 你可能不想重建所有先前存在的Kubernetes应用，但当Kubernetes API service连到原来保存的etcd数据时这一情况就会发生。
* **重要事项：** 每个新的Kubernetes API service 会从Rancher获得一个新的证书。这会导致所有先前存在etcd存储卷中的Kubernetes 密钥过期。这意味着所有需要和Kuvernetes API service通信的应用（例如：dashboard， [helm]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/addons/#helm)，heapster以及其他需要这种通信的应用）都会出故障。解决办法是要使用旧的密钥集合重建应用的Pods。
