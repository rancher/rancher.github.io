---
title: Windows in Rancher
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## Windows (实验性)
---

在Rancher中部署Windows，你首先需要添加一个新的[环境]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/)。这个环境需要使用编排引擎为**Windows**的[环境模版]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#什么是环境模版)进行创建。

目前Rancher只支持在特定主机上创建容器。大多数在Cattle和Rancher UI上有的特性目前都不支持**Windows**(如 服务发现, 健康检查, 元数据, DNS, 负载均衡)。

> **注意：** Rancher中有一个默认的Windows环境模版。如果你想创建你自己的Windows环境模版，你需要禁用所有其它的基础设施服务，因为这些服务目前都不兼容Windows。

### 创建一个 Windows 环境

在左上角的环境的下拉菜单中，点击**环境管理**。通过点击**添加环境**去创建一个新的环境，需要填写**名称**，**描述**（可选），并选择Windows作为编排引擎的环境模版。如果启用了[访问控制]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/)，你可以在环境中[编辑成员]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#成员编辑)并选择他们的[成员角色]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#成员角色)。所有被添加到成员列表的用户都能访问你的环境。

在创建Windows环境后，你可以在左上角环境的下拉菜单中切换到你的环境，或者在环境管理页面中，在对应环境的下拉选项中点击**切换到此环境**。

> **注意：** Rancher支持多种容器编排引擎框架，但Rancher目前不支持在已有运行服务的环境里切换容器编排引擎。

### 添加 Windows 主机
在Rancher中添加一个Windows主机，你需要先有一个运行了Docker的[Windows Server 2016](https://msdn.microsoft.com/en-us/virtualization/windowscontainers/about/index)主机。

在**基础架构**->**主机**->**添加主机**页面，你可以按照指示用自动生产的自定义命令启动Rancher Agent。

在主机上，Rancher的二进制客户端会被下载到`C:/Program Files/rancher`目录，你可以在`C:/ProgramData/rancher/agent.log`找到客户端日志。

### 移除 Windows 主机
作为一个Rancher中的主机，Rancher客户端已经被安装并且注册在了主机上。你必须在Windows主机上删除已经存在的Rancher客户端服务，你可以在 powershell 中运行如下命令来删除客户端。删除客户端后你可以在 Windows 环境中重用这个主机

```bash
& 'C:\Program Files\rancher\agent.exe' -unregister-service
```

### Windows 中的网络
我们默认支持NAT和[透明网络](https://docs.microsoft.com/en-us/virtualization/windowscontainers/container-networking/architecture).

目前，默认的 **Windows** 环境模版支持名为transparent的透明网络
这个透明网络是在运行 `docker network create -d transparent transparent`时创建的。

如果你要创建一个名字不是 `transparent` 的透明网络，你需要创建一个新的环境模版，并把 Windows 设为容器编排平台。选择**Windows**后，你可以点击 **编辑配置** 来更改透明网络的名字。你可以用这个环境模版创建一个环境。但在 Rancher UI 中这个透明网络的默认名字依然是 `transparent`。 因此，你需要把命令更新为 `docker network create -d transparent <NEW_NAME_IN_TEMPLATE`.
