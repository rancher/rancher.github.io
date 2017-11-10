---
title: Swarm in Rancher
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## Swarm
---

在Rancher中部署Swarm，你首先需要添加一个新的[环境]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/)。这个环境需要使用编排引擎为**Swarm**的[环境模版]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#什么是环境模版)进行创建。

### 需求
* Docker 1.13 以上
* 端口 `2377` 以及 `2378` 需要能在主机之间相互访问。

### 创建一个 Swarm 环境

在左上角的环境的下拉菜单中，点击**环境管理**。通过点击**添加环境**去创建一个新的环境，需要填写**名称**，**描述**（可选），并选择Swarm作为编排引擎的环境模版。如果启用了[访问控制]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/)，你可以在环境中[编辑成员]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#成员编辑)并选择他们的[成员角色]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#成员角色)。所有被添加到成员列表的用户都能访问你的环境。

在创建Swarm环境后，你可以在左上角环境的下拉菜单中切换到你的环境，或者在环境管理页面中，在对应环境的下拉选项中点击**切换到此环境**。

> **注意：** Rancher支持多种容器编排引擎框架，但Rancher目前不支持在已有运行服务的环境里切换容器编排引擎。

### 启动 Swarm

在Swarm环境被创建后，在你添加一台主机到这个环境之前，[基础设施服务]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/)是不会启动的。**Swarm**服务需要至少3个主机节点。[添加主机]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/)的过程与其他编排引擎相同。一旦第一个主机被添加成功，Rancher将会自动启动基础设施服务，包括Swarm的组件（例如swarm与swarm-agent）。你可以在**Swarm**页面看到部署的过程。

> **注意：** 请不要手动对docker daemon使用`docker swarm`命令。这可能与Rancher管理Swarm集群产生冲突。

> **注意：** 只有Rancher的管理员或者环境的所有者才能够看到[基础设施服务]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/)。

#### 在命令行中使用CLI

在Rancher的UI里，你可以方便的连接到能够运行`docker`或者`docker-compose`命令的容器中。通过这个命令行你可以控制Swarm集群。
