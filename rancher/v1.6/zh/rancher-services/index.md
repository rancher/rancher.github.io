---
title: Infrastructure Services in Rancher
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## 基础设施服务
---

当启动Rancher时，每个[环境]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/)的创建都基于[环境模版]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#什么是环境模版)。在启动一个环境时，你可以在环境模版中选择需要启动的基础设施服务。这些基础设施服务包括编排引擎，[外部DNS]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/external-dns-service/)，[网络]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/networking/)，[存储]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/storage-service/)，框架服务 (例如： [内部DNS]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/dns-service/)，[Metadata服务]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/metadata-service)，和[健康检查服务]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/health-checks))。

基础设施服务位于[Rancher应用商店](https://github.com/rancher/rancher-catalog)和[社区应用商店](https://github.com/rancher/community-catalog)中的`infra-templates`文件夹中。Rancher应用商店和社区应用商店是默认开启的，它们提供了一系列可以在环境模版中使用的基础服务。

当创建一个环境模版时，默认开启运行一个环境所需的一系列基础服务。
