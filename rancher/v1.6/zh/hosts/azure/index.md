---
title: Adding Azure Hosts
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

Rancher支持使用`docker machine`部署[Microsoft Azure](https://azure.microsoft.com)。

### 准备工作

在你可以部署一台Azure主机之前，你需要获取到**Subscription ID**， **Client ID**和**Client Secret**。**Client ID**和**Client Secret**需要通过创建一个**应用注册**。你可以在[微软官方文档](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal)中获取更多信息。

#### 使用Azure控制台

登陆[https://portal.azure.com](https://portal.azure.com)并且输入你的账号密码。

##### Subscription ID

问了获取到Subscription ID，需要进到**More services**里，然后搜索**Subscriptions**并且打开它。Subscription ID会显示在**SUBSCRIPTION ID**这列里，紧挨着Subscription name。

##### 应用注册

Follow the steps below to create an App registration and the corresponding **Client ID** and **Client Secret**.
通过如下步骤创建一个应用注册，并且获取相应的**Client ID**和**Client Secret**。

1. 选择**Azure Active Directory**.
1. 选择**App registrations**.
1. 选择**New application registration**.
1. 选择一个**Name**, 选择`Web app / API`作为**Application Type**，并且任意输入一个**Sign-on URL**。
1. 选择**Create**.

在**App registrations**界面中，你应该可以看到你的应用注册。这个值显示在**APPLICATION ID**这列里，它就是你所需要的**Client ID**。下一步是生成**Client Secret**:

1. 打开你刚创建好的应用注册。
1. 在**Settings**页，打开**Keys**。
1. 输入一个**Key description**，并且选择一个过期时间，点击**Save**。
1. **Value**列中显示的自动生产的值就是你需要的**Client Secret**。这个值仅仅会被显示一次。

最后一件事是给你的应用注册合适的权限。

1. 进入**More services**，搜索**Subscriptions**并打开它。
1. 打开**Access control (IAM)**。
1. 选择**Add**。
1. **Role**那栏选择`Contributor`。
1. **Select**那栏选择你创建的应用注册名称。
1. 点击**Save**.

### 启动Azure主机

1. 为主机提供一个**名称**。
1. 使用滚动条选择你要启动的主机的**数量**。
1. 选择你的Azure资源所在的**区域**。
1. 默认的**环境**为`AzurePublicCloud`，但如果你使用的是政务云，你可以在这里对其进行修改。
1. 你可以输入**Availability Set**和**Resource Group**的名称，如果没有的话会进行创建。
1. 输入正确的上面提到的**Subscription ID**，**Client ID**和**Client Secret**。
1. 你可以自己定义你的**网络**设置，也可以使用默认的设置。
1. 选择一个你想要使用的**镜像**。任何Azure支持的`docker-machine`在Rancher中也同样支持。如果你设置了镜像，请不要忘记修改**SSH User**为正确的用户。
1. 选择镜像的**大小**。
1. 你可以修改**Docker端口**和**存储类型**。
1. (可选)向主机添加**[标签]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#labels)**，以帮助组织主机并[调度服务/负载均衡器]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/)或者是[使用除主机IP之外的其他IP解析外部DNS记录]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/external-dns-service/#为外部dns使用特定的ip).
1. (可选)在**高级选项**中，你可以利用[Docker引擎选项](https://docs.docker.com/machine/reference/create/#specifying-configuration-options-for-the-created-docker-engine)定制你的`docker-machine create`工具。
1. 所有的完成之后，点击**创建**。

一旦你点击创建，Rancher将会创建Azure虚拟机，并在实例中开启 _rancher-agent_ 容器。几分钟之后，主机将会启动并可以[添加服务]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/)。
