---
title: Adding Amazon EC2 Hosts
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## 添加Amazon EC2主机
---

Rancher支持使用`docker machine`部署[Amazon EC2](http://aws.amazon.com/ec2/)。

### 找到AWS凭据

在AWS上开启一台主机之前，你需要找到你的AWS账号凭证和你的安全组信息。通过亚马逊的[文档](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSGettingStartedGuide/AWSCredentials.html)找到正确的密钥，从而找到你的**账号访问**信息。对新创建的密钥对**access key**和**secret key**，务必将它们保存好，一旦丢失将会不可用。

### 启动Amazon EC2主机

通过**基础架构** -> **主机**进入主机主界面，点击**添加主机**，选中**Amazon EC2**图标，选择你所在的**区域**，并提供你访问AWS的密钥对**Access key**和**Secret Key**，点击**下一步：验证及选择网络**。Rancher将会根据你提供的凭据决定是否在AWS上创建新的实例。

为了创建实例，你需要选择一个可用的区域，根据你选择的区域，会显示可用的VPC IDs和Subnet IDs，选择一个**VPC ID**或者**子网ID**，并点击**下一步：选择一个安全组**.

接下来，为你的主机使用选择一个安全组，这里有两种模式可供选择。一种是**Standard**，该模式将会创建或者直接使用已经存在的`rancher-machine`安全组，这种安全组默认会开放所有必要的端口，以便Rancher能够正常工作。`docker machine`将会自动打开`2376`，该端口是Docker守护进程用到的端口。

另一种是**Custom**，该模式下你可以选择一个存在的安全组，但是需要自己确定指定的端口已经打开，以便Rancher能够正常工作。

<a id="EC2Ports"></a>

### Rancher需要用到的端口：

* Rancher Server访问的TCP端口 `22` (通过SSH安装和配置Docker)
* 如果你正在使用IPsec [网络驱动]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/networking/), 所有主机都需要打开UDP端口`500`和`4500`
* 如果你正在使用VXLAN [网络驱动]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/networking/), 所有主机需要打开UDP端口`4789`

> **注意：** 如果你再次使用`rancher-machine`安全组, 之前任何丢失的端口都不会再次打开。如果主机没有正常启动，你需要检查一下AWS上的安全组。

选择安全组选项之后，点击**下一步：设置实例选项**。

最后，你只需要完成填写主机的的一些细节信息。

1. 使用滚动条选择需要启动的主机的数量。
2. 如果需要为主机提供一个**名字**和**描述**。
3. 根据你的需要选择**实例类型**。
4. 选择镜像的**根大小**，`docker machine`中默认大小为16G，这也是Rancher默认需要的大小。
5. (可选) 对于**AMI**，`docker machine` 默认是该特定区域的一个Ubuntu 16.04 LTS镜像。你也可以选择你自己的AMI，但是如果你选择自己的AMI，请确保以下几点：
   1. 在前面选中的区域中是可访问的；
   2. 定义正确的**SSH User**。如果是使用的[RancherOS AMI](https://github.com/rancher/os#amazon)，SSH User就应该是`rancher`。
6. (可选)提供用作实例概要的**IAM简介**。
7. (可选)向主机添加**[标签]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#labels)**，以帮助组织主机并[调度服务/负载均衡器]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/)或者是[使用除主机IP之外的其他IP解析外部DNS记录]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/external-dns-service/#为外部dns使用特定的ip)。
8. (可选)在***高级选项**中，你可以定制`docker-machine create`命令[Docker引擎配置选项](https://docs.docker.com/machine/reference/create/#specifying-configuration-options-for-the-created-docker-engine)。
9. 完成之后，点击**创建**。


Rancher将会创建EC2的实例，并在实例中开启 _rancher-agent_ 容器。几分钟之后，主机将会启动并正常提供[服务]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/)。
