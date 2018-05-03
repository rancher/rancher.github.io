---
title: Settings in Rancher
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## 系统设置
---

在Rancher的**系统管理** -> **系统设置**页面，你可以定制Rancher产品。

### 主机注册

在启动任何主机之前，你需要完成主机注册地址设置。主机注册地址是用来设置Rancher Server将如何与主机进行连接。如果你已经设置了[访问控制]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control)，则不会提示你设置主机注册地址，因为Rancher假定你的URL是可以被访问到的。

Rancher通过该设置确定你的主机连接Rancher API所用的URL。默认情况下，Rancher将使用访问UI的URL。如果你选择更改注册地址，请确保设置用于连接到Rancher API的端口。如果你使用配置了SSL的Rancher Server，请确保将协议更改为`https`。此注册地址设置决定了[添加自定义主机]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/)的命令。

如果为Rancher启用了[访问控制]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/)功能，则只有**管理员**才能更改主机注册地址。默认情况下，第一个**管理员**是配置启用访问控制的用户。如果仍未配置访问控制，则该任何用户都可以更新主机注册地址。可以在**系统设置** -> **主机注册地址**选项卡中更新此选项。

### 应用商店

默认情况下，[应用商店]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/)有三类可使用的应用：

* [Rancher基础设施](https://github.com/rancher/infra-catalog)所有基础设施服务的模版。
* [Rancher官方认证](https://github.com/rancher/rancher-catalog)包括Rancher认证过的应用模版。
* [Rancher社区共享](https://github.com/rancher/community-catalog)包含社区共享的模版。

由于系统设置页面只有[管理员]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/accounts/#管理员)有访问权限，因此只有管理员有权限添加私有的应用商店。添加一个应用商店就是添加一个应用名称和git地址。正确的git地址的格式可以参考[这里](https://git-scm.com/docs/git-clone#_git_urls_a_id_urls_a)。无论什么时候添加应用商店，你都可以马上使用它。

如果要添加自己创建的私有应用商店，那么git仓库的文件必须遵守Rancher应用商店的[特定格式]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/private-catalog)。


### 信息统计

默认情况下，Rancher会询问你是否允许收集匿名统计信息。这些数据使我们更好的了解我们的用户群，帮助改进Rancher产品。点击[这里]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/telemetry/)了解更多。
