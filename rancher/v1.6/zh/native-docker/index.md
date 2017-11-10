---
title: Using Native Docker CLI with Rancher
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## 以原生 Docker 命令行的形式使用 Rancher
---

Rancher整合了原生Docker CLI，所以Rancher可以和其它DevOps和Docker工具同时使用。从高层次上，这意味着如果你在Rancher外启动、停止、或销毁一个容器，Rancher能检测到相应的变化和更新。

### Docker 事件监控
Rancher通过实时监控所有主机上Docker事件来更新自己的状态。因此，当容器在Rancher外启动、停止、或销毁时(比如，直接在主机上执行`docker stop sad_einstein`)，Rancher能检测到这些变化和更新，并且相应地更新自己的状态。

> **注意：** 目前的一个局限是：我们要等到容器启动(而不是创建)才能把容器导入到Rancher。 运行`docker create ubuntu`不会使相应的容器出现在Rancher UI，但运行`docker start ubuntu`或`docker run ubuntu`会.

你可以在主机上运行`docker events`来观察Docker事件流。这个事件流就是Rancher正在监听的事件流。

### 添加 Docker 直接启动的容器到 Rancher 的网络

你可以在Rancher外启动容器，然后把它们添加到Rancher管理的网络中。 这意味着这些容器可以参与夸主机网络。要激活这个功能，创建容器时把`io.rancher.container.network`标签设为`true` 。下面是一个例子:

```bash
$ docker run -l io.rancher.container.network=true -itd ubuntu bash
```

请查阅[Rancher中的网络]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/networking/)了解更多关于Rancher管理的网络和夸主机网络的详情。

### 导入已有容器

Rancher支持在注册主机的时候倒入已有的容器。当你用Rancher UI上的[自定义命令]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/)注册主机时， 任何当前在该主机上的容器都能被检测到，并且会被导入到Rancher。

### 周期性同步状态
除了实时监控Docker事件之外，Rancher还会周期性地和主机同步状态。每5秒钟主机就会向Rancher报告主机上的所有容器的状态，以保证Rancher中的状态和主机中的状态同步。这能够防止由于网络中断或服务器重启而导致Rancher遗漏某些Docker事件。 用这种方式来保持同步，主机上的容器的状态为单一数据源。比如, 如果Rancher认为一个容器正在运行，但它在主机上实际是停止的，Rancher会把容器的状态更新为`停止`，但Rancher不会尝试重启容器。
