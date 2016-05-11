---
title: Rancher Documentation
layout: rancher-default
version: latest
lang: zh
---

##  Rancher 概述
---

Rancher 是以在生产环境中运行容器为目标而构建的开源软件平台。随着 Docker 容器这种类型的应用工作负载的逐渐流行，它催生了很多与之相应的基础架构服务，如网络服务、存储服务、负载均衡，安全，服务发现和资源管理。

### 计算资源
Rancher 使用的是来自于公有云或私有云上 Linux 主机的裸计算资源。每一个 Linux 主机既可以是虚拟机，也可以是物理机。Rancher 对每一个主机的期望不会多于 CPU，内存，磁盘存储和网络连接。从 Rancher 的角度看来，一个来自云服务商的云主机和私有数据中心的物理机是没多大差异。

### 关键功能
Rancher 产品的关键功能包括： 

1. 扩主机网络： Rancher 为每个环境生成一个软件定义网络，为扩主机和云的容器之间提供了安全的网络通讯。

2. 容器的负载均衡。Rancher 提供的内置、弹性负载均衡能在容器之间或者服务之间分发流量。负载均衡服务可以跨多个云工作。

3. 持久化存储服务： Rancher 对 Docker 提供持久化存储服务的编排，让开发者在部署容器化应用的同时可靠地部署与之相应的存储。这项新功能基于 Docker 1.9的卷插件功能，这让开发人员可以更加方便地运行需要有状态数据库和持久存储的应用。

4. 服务发现：Rancher 实现了分布式服务发现功能，具有内置的健康检查功能，并使容器自动地注册自己到相应至相应服务，并且各种服务之间可以在网络上动态地彼此发现。

5. 服务升级：通过使用服务克隆和请求重定向功能，Rancher 使用户能更加容易地升级以及存在的容器服务。这让新版本的服务在处理生产流量前，有机会在其所依赖的生产环境中被校验和确认。 

6. 资源管理：Rancher 支持 Docker Machine，这个强大的工具可以直接地对各种云提供商做主机部署。然后 Rancher 在对其做资源监控和容器部署管理。

7. 多租户和用户环境：Rancher 为多用户而设计，企业各个部门间可以跨应用生命周期协作。通过与已有目录服务的集成，Rancher 的用户可以创建独立的开发，测试和生产环境，然后邀请相关人员一起协作地管理资源和应用。

8. 多编排引擎支持：Rancher 用户在创建环境的时候，可以为他们的容器选择不同的容器编排引擎，默认是 Cattle，或者是 Kubernets 和 Docker Swarm。这让用户可以选择任意市场领先的调度框架的同时，依然能利用到Ranher 的其它所有功能，如：应用商店/目录，企业级用户管理，容器网络，和存储技术。

### 主要使用接口
用户有三种方式和 Rancher 交互：

1. 用户可以使用原生 Docker CLI 命令行或者 API 接口操作 Rancher 。Rancher 并不是其它那种把原生 Docker 体验给遮盖掉的编排系统或者管理系统。随着 Docker 平台不断地发展，封装层很可能会给原生的 Docker 功能给替代。而 Rancher 是在后台中工作，这样用户可以继续使用原生的 Dcoker CLI 和 Docker Compose 模板。Rancher 通过原生 Docker CLI 来用 Docker 标签的方式传递更多的信息，标签功能是 Rancher Labs贡献到 Docker 1.6中的功能。因为 Rancher 支持原生的 Docker CLI 和 API，像 Kubernets 这样第三方的工具可以在 Rancher 自如的使用。
2. 用户可以通过叫做 `rancher-compose` 的命令行工具和 rancher 交互。 `rancher-compose` 工具可以让用户基于 Docker Compose 模板在 Rancher 服务器上启动一套多容器和服务的应用。 `rancher-compose` 工具支持标准的 `docker-compose.yml` 文件格式。一个可选的 `rancher-compose.yml` 文件可以用来基于  `docker-compose.yml` 定义扩展或者覆盖原有的定义。
3. 用户还可以使用 Rancher 的图形界面来操作。Rancher图形界面可以完成很多配置工作，如配置访问控制权限，管理环境，添加 Docker 镜像库等。另外它为管理容器基础架构和服务提供了简单易用的用户体验。

Rancher 的主要功能如下的示意图，它可以被运行在任何云上，并且有三种方式与之交互。

<img src="{{site.baseurl}}/img/rancher/rancher_overview.png" width="800" alt="Rancher Overview">

### 本文档的线索
把 Rancher 运行起来是比较容易的。如果您有一个 Linux 虚拟机在笔记本上或者云主机，阅读  [快速安装指南]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/quick-start-guide/) 迅速获得第一手实战经验。

如果您想安装一套生产级别的 Rancher 环境，请按照  [Rancher 安装]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/) 这一章的指导，来部署配置 Rancher 服务器并添加节点进来。

在您开始使用 Rancher 之前，请一定阅读 [基本概念]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/concepts/) 这一节，以了解 Rancher 是如何工作的。

系统配置这一章描述了大量 Rancher 服务器部署和运行之后，如何做各种必要的一次性配置工作。

这三章 --[使用 Docker 原生命令行]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/native-docker/), [使用 Rancher Compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-compose), 和 [Rancher 图形界面]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/adding-services/)-- 描述了使用 Rancher 功能的三种主要方式。

[升级 Rancher]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/upgrading) 是很重要的一章，如果您在生产环境中运行 Rancher。

[为Rancher做贡献]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/contributing) 这一章包含了如何参与 Rancher 开源社区的信息。

