---
title: Quick Start Guide
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## 快速安装指南
---

在本节中，我们将进行简单快速的Rancher安装，即在一台Linux机器上安装Rancher，并使其能够完成所有Rancher必要功能。

### 准备Linux主机

先安装一个64位的Ubuntu 16.04 Linux主机，其内核必须高于3.10。你可以使用笔记本、虚拟机或物理服务器。请确保该Linux主机内存不低于*1GB*。在该主机上安装 [支持的Docker版本]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#docker版本适用对比)。

在主机上安装Docker的方法请参照[Docker](https://docs.docker.com/engine/installation/linux/ubuntulinux/)网站的安装说明。

> **注意：** 目前Rancher尚不支持Docker for Windows以及Docker for Mac。


### Rancher Server标签

Rancher Server当前版本中有2个不同的标签。对于每一个主要的release标签，我们都会提供对应版本的文档。

* `rancher/server:latest` 此标签是我们的最新一次开发的构建版本。这些构建已经被我们的CI框架自动验证测试。但这些release并不代表可以在生产环境部署。
* `rancher/server:stable` 此标签是我们最新一个稳定的release构建。这个标签代表我们推荐在生产环境中使用的版本。

请不要使用任何带有 `rc{n}` 前缀的release。这些构建都是Rancher团队的测试构建。

### 启动Rancher Server

你只需要一条命令就可以启动Rancher Server。当Rancher Server容器启动以后，我们将能查看到相关的日志。

```bash
$ sudo docker run -d --restart=unless-stopped -p 8080:8080 rancher/server:stable
# Tail the logs to show Rancher
$ sudo docker logs -f <CONTAINER_ID>
```

启动Rancher Server只需要几分钟时间。当日志中显示 `.... Startup Succeeded, Listening on port...`的时候，Rancher UI就能正常访问了。配置一旦完成，这行日志就会立刻出现。需要注意的是，这一输出之后也许还会有其他日志，因此，在初始化过程中这不一定是最后一行日志。

Rancher UI的默认端口是 `8080`。所以为了访问UI，需打开`http://<SERVER_IP>:8080`。需要注意的事，如果你的浏览器和Rancher Server是运行在同一主机上的，你需要通过主机的**真实IP地址**访问，比如 `http://192.168.1.100:8080` ，而不是 `http://localhost:8080` 或`http://127.0.0.1:8080`，以防在添加主机的时候使用了不可达的IP而出现问题。

> **注意：** 1. 初始安装时Rancher的访问控制并未配置，任何能够访问你的IP地址的人，都可以访问你的UI和API。我们建议你配置 [访问控制]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/). 2. 国内的公有云主机，如果需要使用80和8080端口，需备案后才可以使用。

### 添加主机

在这里，为了简化操作，我们将添加运行着Rancher Server的主机为Rancher内的主机。在实际的生产环境中，请使用专用的主机来运行Rancher Server。

想要添加主机，首先你需要进入UI界面，点击**基础架构**，然后你将看到**主机**界面。点击**添加主机**，Rancher将提示你选择主机注册URL。这个URL是Rancher Server运行所在的URL，且它必须可以被所有你要添加的主机访问到——当Rancher Server会通过NAT防火墙或负载均衡器被暴露至互联网时，这一设定就非常重要了。如果你的主机有一个私有或本地的IP地址，比如 `192.168.*.*`，Rancher将提示一个警告信息，提醒你务必确保这个URL可以被主机访问到。

因为我们现在只会添加Rancher Server主机自身，你可以暂时忽略这些警告。点击**保存**。默认选择**自定义**选项，你将得到运行Rancher agent容器的Docker命令。这里还有其他的公有云的选项，使用这些选项，Rancher可以使用Docker Machine来启动主机。

Rancher UI会给你提供一些指示，比如你的主机上应该开放的端口，还有其他一些可供选择的信息。鉴于我们现在添加的是Rancher Server运行的主机，我们需要添加这个主机所使用的公网IP。页面上的一个选项提供输入此IP的功能，此选项会自动更新Docker命令中的环境变量参数以保证正确。

然后请在运行Rancher Server的主机上运行这个命令。

当你在Rancher UI上点击**关闭**按钮时，你会被返回到**基础架构->主机**界面。一两分钟之后，主机会自动出现在这里。

### 基础设施服务

当你第一次登陆Rancher时，你将自动进入**默认**[环境]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/)。默认已经为此环境选择了Cattle[环境模板]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#什么是环境模版)来启动[基础设施服务]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/)。要想充分利用Rancher的一些功能，如[DNS]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/dns-service/)、[元数据]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/metadata-service)、[网络]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/networking)、[健康检查]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/health-checks/)，你需要启动这些基础设施服务。这些基础设施可以在**应用栈** -> **基础设施**中找到。在主机被添加至Rancher之前，这些栈会处于 `unhealthy` 状态。主机添加完成后，建议等到所有基础设施服务都处于`active`状态之后再添加服务。

在主机上，所有属于基础设施服务的容器将被隐藏，除非你单击“**显示系统容器**”复选框。

### 通过UI创建一个容器

导航到**应用**页面，如果你看到了欢迎屏幕，可以在欢迎屏幕中单击**定义服务**的按钮。如果你的Rancher设置中已有服务，你可以在任何现有应用中点击**添加服务**，或者创建一个新的应用来添加服务。应用只是将服务组合在一起的便捷方式。 如果需要创建新的应用，请单击**添加应用**，填写名称和描述，然后单击**创建**。 接着，在新的应用中单击**添加服务**。

给服务取个名字，比如“第一个服务”。你可以使用我们的默认设置，然后单击**创建**。Rancher将开始在主机上启动容器。不论你的主机IP地址是什么，***第一个容器***的IP地址都将在 `10.42.*.*` 的范围内，因为Rancher已使用`ipsec`基础设施服务创建了一个托管网络。各容器之间是通过这个托管网络进行跨主机通信的。

如果你单击***第一个容器***的下拉列表，你将可以进行各种管理操作，如停止容器、查看日志或访问容器控制台。

### 通过Docker原生CLI创建一个容器

Rancher会显示主机之上的所有容器，即使有些容器是在UI之外创建的。在主机的shell终端中创建一个容器。

```bash
$ docker run -d -it --name=second-container ubuntu:14.04.2
```

在UI中，你将看到***第二个容器***在你的主机上出现！

Rancher会对Docker守护进程中发生的事件做出反应，调整自己以反映现实情况。你可以在此了解更多通过[Docker原生CLI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/native-docker/)使用Rancher的事宜。

如果你查看***第二个容器***的IP地址，你将发现它不在`10.42.*.*` 范围内。它的IP地址是Docker守护进程分配的常用IP地址。这是通过CLI创建Docker容器的预期行为。

如果我们想通过CLI创建一个Docker容器，但仍希望它使用Rancher托管网络的IP地址，该怎么做呢？我们只需要在命令中添加一个标签(`io.rancher.container.network=true`)，让Rancher知道你希望此容器成为`托管`网络的一部分。

```bash
$ docker run -d -it --label io.rancher.container.network=true ubuntu:14.04.2
```

### 创建一个多容器应用

上文中我们已经介绍了如何创建单个容器以及这些单个容器之间如何进行跨主机网络通信。然而，现实情况中，大多数应用程序其实是由多个服务构成的，而每个服务又是由多个容器构成的。比如说，一个[LetsChat](http://sdelements.github.io/lets-chat/)应用程序，就是由下列几项服务构成的：

1. 一个负载均衡器。负载均衡器把Internet流量转发给“LetsChat”应用程序。
2. 一个由两个“LetsChat”容器组成的*web*服务。
3. 一个由一个“Mongo”容器组成的数据库服务。

负载均衡器的目标是*web*服务（即LetsChat），Web服务将连接到数据库服务（即Mongo）。

在本节中，我们将介绍如何在Rancher中创建和部署[LetsChat](http://sdelements.github.io/lets-chat/)应用程序。

导航到**应用**页面，如果你看到了欢迎屏幕，可以在欢迎屏幕中单击**定义服务**的按钮。 如果你的Rancher设置中已有服务，你可以在任何现有应用中点击**添加应用**，来创建一个新的应用。填写名称和描述，然后单击**创建**。 接着，在新的应用中单击**添加服务**。

首先，我们将创建一个名为`database`的数据库服务，并使用`mongo`镜像。单击**创建**。你将立即被带到应用页面，页面中将包含新创建的数据库服务。

接下来，再次点击**添加服务**以添加其他服务。我们将添加一个LetsChat服务并链接到*database*服务。让我们使用名称`web`以及`sdelements/lets-chat`镜像。在UI中，我们可以移动滑块，将服务扩容至2个容器。在**服务链接**中，添加*database*服务并将其命名为`mongo`。就像Docker的做法一样，Rancher会在`letschat`容器里加入这个链接所需要的相关环境变量。单击**创建**。

最后，我们将创建我们的负载均衡器。单击**添加服务**按钮旁的下拉菜单图标。选择**添加负载均衡**。提供一个类似于`letschatapplb`这样的名字。输入访问端口（例如`80`端口），选择目标服务（即*web*），并选择目标端口（即`8080`端口）。*web*服务正在侦听`8080`端口。单击**创建**。

至此，我们的LetsChat应用程序已完成！在**应用**页面上，你可以查找到超链接形式的负载均衡所暴露端口。点击该链接，将会打开一个新的页面，你将能看到LetsChat应用程序了。

### 使用Rancher CLI创建一个多容器应用程序

在本节中，我们将介绍如何使用我们的命名行工具[Rancher CLI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cli/)创建和部署跟上一节中我们创建的一样的[LetsChat](http://sdelements.github.io/lets-chat/)应用程序。

当在Rancher中创建服务时，Rancher CLI工具与颇受欢迎的Docker Compose工具的工作方式类似。 它接收相同的`docker-compose.yml`文件，并在Rancher上部署应用程序。 你可以在`rancher-compose.yml`文件中指定更多的属性，该文件将扩展并覆盖`docker-compose.yml`文件。

在上一节中，我们创建了一个具有一个负载均衡器的LetsChat应用程序。如果你已经在Rancher中创建了它，你可以直接在UI中下载这些文件，只需在应用的下拉菜单中选择**导出配置**即可。`docker-compose.yml`文件与 `rancher-compose.yml` 文件与下方示例类似：

#### docker-compose.yml示例

```yaml
version: '2'
services:
  letschatapplb:
    #If you only have 1 host and also created the host in the UI,
    # you may have to change the port exposed on the host.
    ports:
    - 80:80/tcp
    labels:
      io.rancher.container.create_agent: 'true'
      io.rancher.container.agent.role: environmentAdmin
    image: rancher/lb-service-haproxy:v0.4.2
  web:
    labels:
      io.rancher.container.pull_image: always
    tty: true
    image: sdelements/lets-chat
    links:
    - database:mongo
    stdin_open: true
  database:
    labels:
      io.rancher.container.pull_image: always
    tty: true
    image: mongo
    stdin_open: true
```

#### rancher-compose.yml示例

```yaml
version: '2'
services:
  letschatapplb:
    scale: 1
    lb_config:
      certs: []
      port_rules:
      - hostname: ''
        path: ''
        priority: 1
        protocol: http
        service: web
        source_port: 80
        target_port: 8080
    health_check:
      port: 42
      interval: 2000
      unhealthy_threshold: 3
      healthy_threshold: 2
      response_timeout: 2000
  web:
    scale: 2
  database:
    scale: 1
```

<br>
在Rancher UI中单击**下载CLI**（该按钮位于页面的右下角），即可下载Rancher CLI二进制文件，Windows、Mac和Linux的二进制文件均可下载。

若想使用Rancher CLI在Rancher中启动服务，你需要设置一些环境变量。你需要在Rancher UI中创建一个账户[API Key]({{site.baseurl}}/rancher/{{page.version}}/en/api/v2-beta/api-keys/)。单击**API** -> **密钥**。单击**添加账户API Key**。填写一个名字，然后单击**创建**。保存**Access Key（用户名）**和**Secret Key（密码）**。通过运行`rancher config`配置RancherCLI，使用Rancher URL、Access Key和Secret Key。

```bash
# Configure Rancher CLI
$ rancher config
# Set the Rancher URL
URL []: http://<SERVER_IP>:8080/
# Set the access key, i.e. username
Access Key []: <accessKey_of_account_api_key>
# Set the secret key, i.e. password
Secret Key []:  <secretKey_of_account_api_key>
```

<br>
现在进入保存了`docker-compose.yml`和`rancher-compose.yml` 文件的目录中，运行下面这个命令。

```bash
$ rancher up -d -s NewLetsChatApp
```
<br>
在Rancher中，一个叫做**NewLetsChatApp**的应用将被创建，且所有服务都将在Rancher中运行起来。
