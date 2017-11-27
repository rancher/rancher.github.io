---
title: Kubernetes - 弹性平面
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## Kubernetes - 弹性平面（Resiliency Planes）
---

对生产环境的部署，最佳实践是每一个平面运行在专门的物理或虚拟主机上。对开发环境，可以用多租户去简化管理和减少开销。

#### 数据平面

数据平面由一个或多个 **etcd** 容器组成。Etcd是一个分布式可靠的键-值存储，它存储了所有Kubernetes状态。可以认为数据平面是有状态的，也就是说组成数据平面的软件维护着应用状态。

#### 编排平面

编排平面由无状态的组件组成，它们控制Kubernetes分发。

#### 计算平面

计算平面由 Kubernetes [pods](https://kubernetes.io/docs/user-guide/pods/)组成。

### 计划

在安装之前，考虑你特定的用例是很重要的。Rancher提供了两种不同的部署类型。

如果你在寻找一种快速启动Kubernetes的方式以试验我们的Kubernetes，我们建议通过 [重叠的平面](#重叠平面overlapping-planes)的方式启动Kubernetes。这是默认Kubernetes模版的默认配置。

针对生产环境，Rancher建议通过 [分隔的平面](#分隔平面separated-planes)的方式启动Kubernetes。

### 安装

#### 重叠平面（OVERLAPPING PLANES）

默认情况，Kubernetes设置为用重叠平面的方式做部署。所有平面可以重叠，所有服务可以运行在一个主机上。服务会被随机地调度。增加至少三台主机以使数据平面（亦即 etcd）有复原能力。

1. 创建一个 Kubernetes 环境。
2. 增加1个或多个主机，主机至少有 1 CPU， 2GB 内存。资源需求依据工作负荷有所区别。

#### 分隔平面（SEPARATED PLANES）

这种部署方式允许用户分割开不通类型的平面，使每一种平面运行在特定、专用的主机上。它可以提供数据平面的恢复能力，保证计算平面的性能。你需要在增加主机之前 [配置 Kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#设置kubernetes)。在配置 Kubernetes 的时候，在 **Plane Isolation** 选项中选择 `required`。

> **注意：** 如果你想要从重叠平面升级Kubernetes到分隔平面，请 [阅读如何升级Kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/upgrading/)以正确地处理改变。

##### 增加带标签（label）的主机

所有加入到Kubernetes环境的主机必须打好标签，这样 Rancher 就可以根据平面类型去调度不同的服务。在这种部署类型的情况下，最少需要5台主机。

1. **数据平面：** 增加三个或以上的主机，主机需要有 >=1的CPU，>=1.5GB的内存，>=20GB的磁盘存储空间。在加入主机的时候，[给主机打上标签]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#主机标签) `etcd=true`。
2. **编排平面** 增加2个或以上的主机，主机需要有 >=1 的CPU和 >=2GB 的内存。在加入主机的时候， [给主机打上标签]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#主机标签) `orchestration=true`。你可以只用一台主机，但是在这台主机故障的时候，直到新的用于编排的主机加入之前，K8s API将会不可用。
3. **计算平面** 增加一个或以上的主机。在加入主机的时候， [给主机打上标签]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#主机标签) `compute=true`。

> **注意：** 主机标签可以加到已有的主机上，从而将这台主机添加到某一种平面中，但我们不支持通过修改标签把一种平面类型的主机转到另一种平面类型。如果想改变一台主机的平面类型，你可以删除旧的平面类型标签，接着删除主机上已有的所有服务，接着再增加或更新为新的平面类型标签，最后通过 [升级 Kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/upgrading/)来根据新的平面标签重新平衡容器。
