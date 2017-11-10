---
title: Mesos in Rancher
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## Mesos
---

在Rancher中部署Mesos，你首先需要添加一个新的[环境]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/)，这个环境需要[环境模版]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#什么是环境模版)中设定容器编排引擎是 **Mesos**。

### 创建一个Mesos环境

在左上角的环境的下拉菜单中，点击**环境管理**。通过点击**添加环境**去创建一个新的环境，需要填写**名称**，**描述**（可选），并选择Mesos作为编排引擎的环境模版。如果启用了[访问控制]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/)，你可以在环境中[编辑成员]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#成员编辑)并选择他们的[成员角色]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#成员角色)。所有被添加到成员列表的用户都能访问你的环境。

在创建Mesos环境后，你可以在左上角环境的下拉菜单中切换到你的环境，或者在环境管理页面中，在对应环境的下拉选项中点击 **切换到此环境** 。

> **注意：** Rancher支持多种容器编排引擎框架，但Rancher目前不支持在已有运行服务的环境里切换容器编排引擎。

### 启动 Mesos

在Mesos环境被创建后，在你添加一台主机到这个环境之前，[基础设施服务]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/)是不会启动的。**Mesos**服务需要至少3个主机节点。[添加主机]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/)的过程与其他编排引擎相同。一旦第一个主机被添加成功，Rancher将会自动启动基础设施服务，包括Mesos的组件（例如mesos-master，mesos-agent以及zookeeper）。你可以在 **Mesos**页面看到部署的过程。

> **注意：** 只有Rancher的管理员或者环境的所有者才能够看到[基础设施服务]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/)。

### 使用 Mesos

当安装成功后，你可以通过以下的方式开始创建或者管理你的Mesos应用：

#### Mesos UI

你可以通过点击**Mesos UI**去管理Mesos。它会打开一个新的页面，你可以在这个不同的UI中管理Mesos。任何在该UI上创建的framework同样会在Rancher反映出来。

#### Ranche应用商店

Rancher支持Mesos框架下的应用商店。通过点击 **Mesos** -> **启动一个framework**按钮或者直接点击 **应用商店** 标签去选择使用一个framework。选择你想启动的framework并且点击**查看详情**。查看并且编辑Stack名称，Stack描述以及配置选项，最后点击 **启动**。

如果你想添加你自己的Mesos应用模版，你可以把他们添加到你的私有[Rancher 应用商店]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/)并把你的模版放入`mesos-templates`的目录。
