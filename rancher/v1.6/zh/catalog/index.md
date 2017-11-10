---
title: Rancher Catalog
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## 应用商店
---

Rancher提供了一个应用商店，通过商店中的应用程序模版的可以简化部署复杂应用的过程。进入**应用商店**页面，你可以看到所有的[应用]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/settings/#应用商店)的应用模版。在**官方认证**应用商店下包含了[Rancher认证的应用](https://github.com/rancher/rancher-catalog)中的应用模版，在**社区共享**应用商店下包含了[社区贡献的应用](https://github.com/rancher/community-catalog)的应用模版。Rancher只维护官方认证的 _认证_ 模版。

### 添加应用商店 Catalogs

添加一个应用商店只需要添加一个应用商店名称，Git地址和一个分支名称。Git地址需要是`git clone`[可以处理的](https://git-scm.com/docs/git-clone#_git_urls_a_id_urls_a)。分支名称是你应用商店Git仓库的一个分支。如果不提供分支名称，我们默认会使用`master`。 你无论什么时候添加一个应用商店项目，它都会在你的应用商店中立刻生效。

目前有两类的应用商店可以添加到Rancher。全局应用商店以及环境应用商店。在全局的应用商店中，应用商店的模版会在所有的环境中。在环境应用商店中，应用商店的模版只会在对应的环境中生效。

Rancher的[管理员]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/#管理员)可以在 **系统管理** -> **系统设置** 添加或者移除全局应用商店。

Rancher环境的用户可以在特定的Rancher环境中通过**应用商店**页面，右上角的**管理**去添加或者删除环境应用商店。

如果你在一个代理后方运行Rancher Server，你需要[把HTTP代理设置在Rancher Server运行的环境变量中]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#http-proxy)，使得Rancher应用商店可以正常运行。

### 应用商店中的基础设施服务

在[环境模版]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#什么是环境模版)里的[基础设施服务]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/)来自Rancher中生效的应用商店中的 `infra-templates` 文件夹。

在**应用商店**中也可以看到这些服务。你可以看到全部的基础设施服务，即使这些服务可能和你当前所选择的编排引擎不兼容。建议在创建环境的时候通过环境模版来选择基础设施服务而不是从应用商店中手动部署这些服务。

### 部署应用模版

你可以按照关键字搜索你需要的模版，也可以通过分类来过滤你想要的模版。当你找到想要部署的应用后，点击**启动**并填写应用模版所需要的相关信息。

1. 默认下使用最新**版本**的应用模版，不过需要的话，你也可以选择旧的版本。
2. 输入一个**应用**的名字，按需填写应用的**描述**。
3. 填写配置选项，这些都是所选的应用模版需求的配置选项。
4. 点击**创建**去创建一个基于模版的应用。在创建应用之前，你可以通过点开**预览**窗口查看用于生成应用k的`docker-compose.yml`和`rancher-compose.yml`文件。

在你点击**创建**后，你的应用会马上被创建，但没有启动任何服务。在该应用的下拉菜单中点击**启动服务**去启动应用中的所有的服务。

### 更新应用模版

当一个新版本的应用模版被上传到应用商店后，Rancher会提示你，这个应用有新版本可以更新。当你点击**有可用更新**时，你可以选择需要升级的版本。请在升级前仔细检查，以发现升级带来的潜在风险。在选择一个版本后，点击保存之前需要检查**配置选项**。

在所有的服务都被更新后，应用和服务将会处于**升级完成**状态。如果你确认已经升级成功，最后只需要在应用的下拉菜单中点击**完成升级**。一旦完成升级，你将不能回退到旧版本。

> **注意：** 目前Rancher升级应用时，需要确保应用中的服务都是`active`或者`inactve`状态的，如果有服务异常，需要手动停止该服务后再进行升级。

#### 回滚

如果升级过程中出现了问题，并且你需要回退到之前的版本。你可以在应用的下拉菜单中选择**回滚**。
