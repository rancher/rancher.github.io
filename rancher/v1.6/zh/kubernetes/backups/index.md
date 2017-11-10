---
title: Kubernetes - 备份
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## Kubernetes - 备份
---

默认情况下，Kubernetes中的备份是激活的。网络存储的延迟和大小都应该在备份中被考虑到。 每个备份50MB是一个比较好的对存储需求的估计。比如，每15分钟创建一个备份，保留一天的策略会存储最多96个备份数据，需要大约5GB的存储。如果没有从任意时刻及时恢复到前一个保存点的意图，可以保留更少的历史备份数。

### Kubernetes 配置

在 [配置 Kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#设置kubernetes)的时候，你可以选择是否激活备份。

如果备份被激活，你可以指明**备份创建周期**和**备份保留周期**。

备份周期的时间设置必须是十进制数字序列，每个可以带额外的分数以及单位后缀，例如 `300ms`, `1.5h` 或者 `2h45m`。有效的时间单位有 `ns`， `us` 或 `µs`， `ms`， `s`， `m` 以及 `h`。

**备份创建周期** 表明了备份创建的速率，不推荐短于 `30s` 的创建周期。

**备份保留周期** 表明历史备份删除的速率。留存时间超过该周期的备份会在下一次成功备份之后过期。

磁盘中存储的最大备份数量满足如下等式 `ceiling(保留周期 / 创建周期)`。 例如， `5m` 的创建周期和 `4h` 的保留周期最多会存储 `ceiling(4h / 5m)` 个备份，亦即 `48` 个备份。对备份大小的保守估计是 `50MB`，因此挂载的网络存储应该有至少 `2.4GB` 空闲空间。备份大小会依据使用情况有所区别。

如果备份被禁用， **备份创建周期** 和 **备份保留周期** 会被忽略。

### 设置远程备份

目前，备份存储在host上的一个静态位置： `/var/etcd/backups`。你需要在所有运行**etcd**服务的host的该目录挂载网络存储。网络存储必须在Kubernetes启动之前设置好。

### 从备份恢复

如果所有运行 **etcd** 服务的主机都出故障，遵循以下步骤：

1. 通过从**Kubernetes** -> **Infrastructures Stacks** 删除 **Kubernetes** 应用栈，将你的环境中的调度类型修改为 **Cattle**。Pods会保持完整及可用。
2. 删除 `disconnected` 的主机并增加新的主机。如果你选择了 [弹性控制面板resiliency planes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/resiliency-planes)，你需要加入带`etcd=true`标签的主机。
3. 对将会运行 **etcd** 服务的每台主机，挂载包含备份的网络存储，这应该作为 [配置远程备份](#设置远程备份)的部分被创建。然后执行以下命令：

    在命令行中运行:
    * ```target=<NAME_OF_BACKUP>```
    * ```docker volume rm etcd```
    * ```docker volume create --name etcd```
    * ```docker run -d -v etcd:/data --name etcd-restore busybox```
    * ```docker cp /var/etcd/backups/$target etcd-restore:/data/data.current```
    * ```docker rm etcd-restore```
    ```
    > **注意：** 你必须以一个对远程备份有读权限的用户登录。否则 `docker cp` 命令会默默失败。

5. 通过应用商店（catalog）启动Kubernetes。请确保你 [配置好 Kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#设置kubernetes)。 **Kubernetes** 的基础设施应用会启动并且你的Pods会恢复一致。你的备份可能会导致一个与当前存在的部署不同的拓扑结构，Pods可能会被**删除／重建**。
