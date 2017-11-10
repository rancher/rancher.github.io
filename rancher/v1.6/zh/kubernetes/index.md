---
title: Kubernetes in Rancher
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## Kubernetes
---

要在Rancher中部署Kubernetes，你首先需要创建一个新的[环境]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/) ，创建环境时需要使用一个设置了**Kubernetes**容器编排引擎的[环境模板]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#什么是环境模版)。

### 设置Kubernetes

Kubernetes可以在创建或者编辑环境模板时设置。如果你启动了一个**Cattle**环境, 你可以从**应用商店** -> **官方认证**中启动**Kubernetes**。 如果选择Catalog方式, 你可以跳过下列步骤1。

1. 在[环境模板]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#什么是环境模版)中编辑Kubernetes设置, 在环境模板的**Orchestration**一栏下点击**Edit Config**。你可以在创建一个新的环境模板时编辑设置或者编辑一个已有的环境模板的设置。
2. 确认模板中的Kubernetes版本是你需要的版本。
3. 选择[cloud providers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/providers/), [backups]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/backups/), [add-ons]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/addons/)等的设置选项。
4. 点击**设置**保存设置到环境模板并点击**启动**按钮从应用商店中启动Kubernetes。

> **注意：** 我们建议从正确的设置中启动Kubernetes环境。如果你希望修改一个已有的Kuberentes部署的设置，你可以点击**已经是最新版本**按钮升级Kubernetes部署到新的设置。

### 创建一个Kubernetes环境

在环境菜单的下拉列表中, 点击**管理环境**。要创建一个新的环境，点击**添加环境**, 输入**名称**, **描述** (可选)等信息, 选择你希望使用的设置了**Kubernetes**作为容器编排引擎的环境模板。 如果启用了[访问控制]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/), 你可以[添加成员]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#成员编辑)并设置他们的[成员角色]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#成员角色)。任何被添加到成员列表的用户都将能够访问你的环境。

在Kubernetes环境创建之后，你可以通过UI界面左上角环境菜单的环境下拉列表切换到这个环境，你也可以在环境管理页面中点击对应环境右侧的**切换到此环境**按钮切换到对应环境。

> **注意：** 由于Rancher支持多种容器编排框架，目前暂不支持在已有服务运行的环境中切换容器编排框架。

### 启动Kubernetes

创建Kubernetes环境之后, 直到你添加至少一台主机到这个环境之前，[基础设施]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/)服务将不会启动。[添加主机]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/)的操作步骤在各种容器编排框架下都是相同的。一旦第一台主机被添加，Rancher将会自动开始基础设施服务的部署包括Kubernetes相关服务(也就是：master, kubelet, etcd, proxy等)。你可以通过访问 **Kubernetes** -> **基础设施**标签查看部署进度。

#### Kubernetes环境主机需求

##### 所需端口

 * 被用为运行Kubernetes节点的主机需要开通`10250`和`10255`端口给`kubectl`。为了可以访问到暴露的服务，用作NodePort的端口也需要被开通。默认的NodePort是从`30000`到`32767`之间的TCP端口。

* 对于[重叠平面]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/resiliency-planes/#重叠平面overlapping-planes)部署: 至少1 CPU, 2GB RAM。资源需求根据应用负载不同而不同。
* 对于[分隔平面]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/resiliency-planes/#分隔平面separated-planes)部署: 此种部署类型至少需要5台主机。
 * 数据平面: 添加至少3台具有1 CPU, 大于等于1.5GB RAM, 大于等于20GB DISK的主机。添加主机时, 参考[设置主机标签]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#主机标签)中的步骤为主机设置`etcd=true`标签。
 * 编排平面: 添加至少1台由于大于等于1 CPU且大于等于2GB RAM的主机。添加主机时, 参考[设置主机标签]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#主机标签)中的步骤为主机设置`orchestration=true`标签。你可以仅使用一台主机部署, 但这样将牺牲高可用性。当仅有的一台主机发生故障时，一些K8s功能例如API、在pods发生故障时进行重新调度等，将不会正常工作，直到一台新的主机被加入。
 * 计算平面: 添加一台或多台主机。 添加主机时, 参考[设置主机标签]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#主机标签)中的步骤为主机设置`compute=true`标签。

> **注意：** 只有Rancher管理员和环境所有者有权限查看[基础设施服务]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/).

当添加主机到Kubernetes环境时，主机名将作为运行`kubectl get nodes`时返回的Kubernetes节点的唯一标识。

### 使用Kubernetes

一旦部署完成，你就可以开始通过以下方式创建或者管理你的Kubernetes应用:

#### Rancher应用商店

Rancher支持提供一个基于Kubernetes模板的应用商店。要使用一个模板，点击**应用商店**标签。选择你希望部署的模板并点击**查看详情**。检查并编辑应用栈名称、描述以及设置选项并点击**启动**。

如果你希望添加自己的应用模板到Kubernetes应用商店，你可以把编排文件添加到[Rancher catalog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/)中的`kubernetes-templates`目录下。

#### kubectl

要设置你自己的kubectl客户端访问新创建的Kubernetes集群，点击**Kubernetes** -> **kubectl**。点击**生成配置文件**按钮以生成需要的`kube/config_file`配置文件，你可以下载并添加此文件到你的本地目录。

配置文件中提供了本地主机所需要的相关信息，你通过`kubectl`创建的所有对象都将被显示在Rancher中。

#### kubectl via Shell

Rancher提供了一个易用的shell界面访问一个托管的kubectl实例，可以通过这个kubectl管理Kubernetes集群和应用。

### 在Kubernetes中添加私有镜像仓库

通过在Kubernetes环境中添加[私有镜像仓库]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/registries/)，环境中的Kubernetes服务能够使用这些私有镜像仓库。
