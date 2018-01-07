---
title: Hosts in Rancher
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## 入门指南
---

在Rancher中，主机是调度资源的基本单位（直观的理解就是所发生的操作最终都会落到某台主机上），它可以是虚拟的或者物理的Linux服务器。Rancher管理的主机需要满足以下的条件：


* 任何可以运行[支持的Docker版本](#docker版本适用对比)的 Linux 发行版本，例如：[RancherOS](http://docs.rancher.com/os/)，Ubuntu，RHEL/CentOS 7。不过针对RHEL/CentOS系列，有些需要注意的地方：
    * Docker 并不推荐使用 RHEL/CentOS 默认的存储驱动（devicemapper），可以参考[这篇文档](https://docs.docker.com/engine/reference/commandline/dockerd/#/storage-driver-options)来修改。
    * 如果启用 SELinux，[需要安装额外的模块]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/selinux/)。
    * 内核版本要求是 `3.10.0-514.2.2.el7.x86_64` 及以上，建议使用 RHEL/CentOS 7.3 或者更高的发行版本。
* 1GB的内存。
* 推荐 w/AES-NI 架构的 CPU。
* 主机可以通过HTTP或HTTPS来访问Rancher Server服务，默认端口是8080。
* 主机与主机之间是可以相互访问的，从而确保容器之间的跨主机通信。

另外，Rancher也可以管理由Docker Machine驱动的主机，只要这些主机满足上面的条件即可。

在Rancher的操作界面上，选择 **基础架构**->**主机**，点击 **添加主机**按钮，然后再做些工作，就可以让 Rancher 管理到这台新主机了。

### Docker版本适用对比

版本               | Rancher适用？ | K8S适用？ | 安装脚本 |
----------------------|------------|---------------------|-----------------
`1.9.x` 和更低的版本   | No         |                     |
`1.10.0` - `1.10.2`   | No         |                     |
`1.10.3` (和更高的版本) | No{::nomarkdown}<p>(Yes v1.6.5以及更低版本中)</p>{:/} | No            | `curl https://releases.rancher.com/install-docker/1.10.sh | sh`
`1.11.x`              | No         |                     | `curl https://releases.rancher.com/install-docker/1.11.sh | sh`
`1.12.0` - `1.12.2`   | No         |                     |
`1.12.3` (和更高的版本) | **Yes**    | **Yes**             | `curl https://releases.rancher.com/install-docker/1.12.sh | sh`
`1.13.x`              | **Yes**    | No                  | `curl https://releases.rancher.com/install-docker/1.13.sh | sh`
`17.03.x-ce`          | **Yes**    | No                  | `curl https://releases.rancher.com/install-docker/17.03.sh | sh`
`17.03.x-ee`          | **Yes**    | No                  | n/a
`17.04.x-ce`          | No         |                     | `curl https://releases.rancher.com/install-docker/17.04.sh | sh`
`17.05.x-ce`          | No         | No                  | `curl https://releases.rancher.com/install-docker/17.05.sh | sh`
`17.06.x-ce`          | **Yes**{::nomarkdown}<p>(v1.6.3以及更高版本)</p>{:/}    | No                  | `curl https://releases.rancher.com/install-docker/17.06.sh | sh`
`17.06.x-ee`          | **Yes**{::nomarkdown}<p>(v1.6.3以及更高版本)</p>{:/}    | No                  | n/a

> **注意：** 我们不会支持Docker的edge版本，但是我们会支持Docker的稳定版本。

### 安装特定版本的Docker

一般会使用 `curl https://get.docker.com | sh` 脚本来安装最新版的 Docker 。但是，最新版的 Dokcer 有可能不适用于正准备安装或已经在使用中的 Rancher 版本。因此，一种推荐的做法是：安装特定版本的 Docker。按照上方的对比表，选择 Rancher 适用的安装脚本执行即可。

> **注意：** 如果从操作界面上添加云主机，可以通过 **高级选项** 里面的 **Docker Install URL**来选择需要安装的 Docker 版本。

### 主机是如何工作的？

Rancher Agent容器在主机上启动成功之后，这台主机就连接到了Rancher Server上。在**添加主机**->**Custom（自定义）**界面中的很长的URL就是主机注册口令。这个注册口令在主机第一次连接Rancher Server的时候会被用到。在注册的过程中，Rancher Server会生成一个Agent账号和一个API密钥。之后Agent与Server直接的全部通信都要使用这个密钥，它们之间的认证逻辑和其他的API密钥认证逻辑是一样的。

从设计的角度而言，Rancher Agent是运行在独立于Rancher Server的主机上，所以Rancher Agent本身是不可信的。采用接口访问密钥的机制，可以确保Rancher Agent只访问被授权的接口，而Rancher Server只响应可信的请求。但是目前是单向认证，只认证从Rancher Agent到Rancher Server的请求，并没有认证从Rancher Server到Rancher Agent的响应。因此，用户可以根据需要，使用TLS和证书来做校验。

每个[环境]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/)的注册口令，都是由Rancher Server生成并保存到数据库，然后和API密钥一起下发给Rancher Agent使用。Rancher Agent和Rancher Server之间是采用AES对称加密的点对点通讯。

<a id="addhost"></a>

### 添加主机

第一次添加主机时，Rancher Server会要求配置[主机注册地址]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/settings/##主机注册)。这个地址可以是域名或者IP地址（如果80端口不可访问，还需要加上可访问的端口号，默认 `8080`），能够访问Rancher接口即可。任何时候都可以改变 [主机注册地址]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/settings/#主机注册)，相关操作可以查看 **系统管理** 下的 **系统设置**。设置好主机注册地址后，点击 **保存**.

Rancher支持添加云提供商（例如AWS，DigitalOcean，阿里云，vSphere等）所提供的主机或者本地（例如VirtualBox，VMWare等）设置好的主机。对于云提供商，Rancher可以通过`docker-machine`来添加的，所以本质上实现了 Docker Machine 驱动的厂商的云主机，都可以被添加。

接下来，选择:

* [添加自定义主机]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/)
* [添加 AWS EC2 主机]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/amazon/)
* [添加 Azure 主机]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/azure/)
* [添加 DigitalOcean 主机]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/digitalocean/)
* [添加 Exoscale 主机]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/exoscale/)
* [添加 Packet 主机]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/packet/)
* [添加 Rackspace 主机]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/rackspace/)
* [添加其他云提供商的主机]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/other/)

当主机被添加到Rancher时，这台主机会运行一个合适版本的`rancher/agent`容器。

<a id="labels"></a>

### 主机标签

在Rancher中，可以通过添加标签的方式来管理某台主机，做法就是在 `rancher/agnet` 容器启动的时候，以环境变量的方法把标签加进去。在操作界面上可以看到，标签其实是一些键不可以重复的键值对。值得注意的是，如果有两个相同的键但是值不一样，那么最后添加的值将会被Rancher使用。

给主机增加标签后，你可以根据需求来[调度服务／负载均衡]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/)。如果不希望某个服务运行在某台主机上或者要求某个服务必须运行在某台主机上，可以在[添加服务]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/)时通过主机标签来进行配置。

在你需要使用[外部DNS服务（类似 Bind9 这类）]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/external-dns-service/)或者[通过程序来控制DNS记录]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/external-dns-service/#为外部dns使用特定的ip)的时候，如果所需的IP不是主机IP的话，那就要在运行 `rancher/agent` 时增加标签 `io.rancher.host.external_dns_ip=<IP_TO_BE_USED_FOR_EXTERNAL_DNS>`。切记，当要某个容器服务要使用外部DNS服务时，一定要增加这个标签。

通过UI添加云提供商的主机时，你可以在UI上添加主机标签，`rancher/agent` 会保证这些标签都会自动添加到主机上。

如果通过UI添加自定义主机，当增加标签时，UI上的运行注册脚本会增加对应的环境变量：`CATTLE_HOST_LABELS`。比如，增加一个标签：foo=bar，会出现下面的效果：

```bash
$  sudo docker run -e CATTLE_HOST_LABELS='foo=bar' -d --privileged \
    -v /var/run/docker.sock:/var/run/docker.sock rancher/agent:v0.8.2 \
    http://<rancher-server-ip>:8080/v1/projects/1a5/scripts/<registrationToken>

# 当再增加一个标签：hello=world
$  sudo docker run -e CATTLE_HOST_LABELS='foo=bar&hello=world' -d --privileged \
    -v /var/run/docker.sock:/var/run/docker.sock rancher/agent:v0.8.2 \
    http://<rancher-server-ip>:8080/v1/projects/1a5/scripts/<registrationToken>
```

<br>

> **注意：** `rancher/agent` 的版本与 `rancher/server` 的版本是相关的，执行添加自定义主机的时候，需要注意注册脚本的 `rancher/agent` 是否正确。正常情况下，通过操作界面获取的脚本内的版本信息都是正确的，用户不需要做额外修改。

#### 自动添加的标签

Rancher 会自动创建一些和Linux内核版本信息以及Docker引擎版本信息相关的标签。

键 | 值 | 描述
----|----|----
`io.rancher.host.linux_kernel_version` | Linux内核版本 (e.g, `3.19`) |  主机当前运行的内核版本
`io.rancher.host.docker_version` | Docker引擎版本 (e.g. `1.10`) | 主机运行的 Docker 版本
`io.rancher.host.provider` | 云提供商信息 | 目前仅适用于某些云提供商
`io.rancher.host.region` | 云提供商地域 | 目前仅适用于云提供商
`io.rancher.host.zone` | 云提供商区域 | 目前仅适用于云提供商

### 主机调度地址

为了使Rancher可以在[有多个IP的主机上暴露端口]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/#多ip主机调度)，需要给这些主机进行配置，从而使Rancher知道哪些IP可以使用。配置调度IP的方法取决于这台主机是已经存在的主机（运行了 `rancher/agent` 容器的服务器）还是还没有添加的主机（还没有运行 `rancher/agent` 容器的服务器）。

#### 给已有主机添加调度地址
在环境中已存在的主机，可以通过增加`io.rancher.scheduler.ips`标签来设置调度IP。通过操作界面，点击这台主机的**编辑**按钮，然后增加 **调度IP**。如果是通过接口的方式，只需要给主机添加标签 `io.rancher.scheduler.ips` 和值（多个地址，可以通过逗号分隔）即可。

> **注意：** 在没有添加调度地址前，如果某些容器已经暴露了端口，那么这些容器的端口暴露在`0.0.0.0`上。那就意味着，已有的容器已经占用了全部的IP地址，后来添加的调度地址也被占用了。

#### 给新主机添加调度地址

对于新添加的[自定义主机]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/) 需要像下面的例子，给注册脚本增加一个环境变量 `CATTLE_SCHEDULER_IPS` ：

```bash
$  sudo docker run -e CATTLE_SCHEDULER_IPS='1.2.3.4,<IP2>,..<IPN>' -d --privileged \
    -v /var/run/docker.sock:/var/run/docker.sock rancher/agent:v0.8.2 \
    http://<rancher-server-ip>:8080/v1/projects/1a5/scripts/<registrationToken>
```

### 在代理后的主机

如果当前的环境是在代理之后，要给Rancher添加主机，需要修改这台主机的Docker deamon指向代理。相关的细节可以浏览[本文]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/#添加代理服务器之后的主机)，在此不在累述。

<a id="machine-config"></a>

### 访问云提供商的主机

当用Rancher添加云提供商的主机时，实质上是采用Docker Machine执行的工作。

### 克隆主机

在云提供商上启动主机需要使用访问密钥，Rancher提供了克隆的方法，来轻松地创建另一个主机，而无需再次输入所有认证配置。在操作界面上，从 **基础架构** 进入 **主机** 页面，点击某台主机的下拉菜单，选择 **克隆**，然后就会进入之前的认证配置都已经填写的 **添加主机** 页面。

### 修改主机

在操作界面上，从 **基础架构** 进入 **主机** 页面，点击需要修改的主机的下拉菜单，选择 **编辑**，就可以修改这台主机的名称，描述以及标签。

### 启停主机

停止一台主机后，操作界面上会显示 _Inactive_ 状态。在这种状态下，不会再有容器服务被部署到这台主机。而处于 _Active_ 状态下的主机，容器服务会被正常的部署、停止、重启或销毁。

如果需要停止一台主机，从 **基础架构** 进入 **主机** 页面，点击需要停止的这台主机的下拉菜单，选择 **停用** 即可。

如果需要把一台停止的主机重新激活，从 **基础架构** 进入 **主机** 页面，点击已经停止的这台主机的下拉菜单，选择 **激活** 即可。

> **注意：** 在Rancher中如果主机宕机了（比如处于 `reconnecting` 或 `inactive` 的状态），需要给服务配置[健康检查]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/health-checks/) 以便于Rancher把这台宕掉的主机上的容器服务迁移到其他主机上执行。

### 在Rancher内删除主机

在 Rancher 内删除主机的操作需要进行几个步骤：从 **基础架构** 进入 **主机** 页面，点击需要删除的主机的下拉菜单，选择 **停用**。当主机完成停止以后，将会显示 _Inactive_ 状态。然后点击下拉菜单，选择 **删除**，Rancher 会执行对这台主机的删除操作。当显示 _Removed_ 状态时，就表示这台主机已经被删除了。但是，仍然可以在操作界面上看到这台主机，只有当点击下拉菜单，选择 **清理**后，这台主机才会从操作界面上消失。

如果这台主机是由 Rancher 调用 `docker-machine` 基于云提供商的驱动创建，按照上述的删除操作执行后，被删除的主机也会在云提供商的管理界面中消失。但是，如果是采用 [添加自定义主机]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/) 的方式所添加的云提供商主机，被删除的主机还会在云提供商的管理界面中被查看到。而且这台主机内的容器服务（例如 `rancher/agent`）还是保留着的。可以认为通过自定义添加的云提供商的主机被删除后，只是从Rancher的调度中解离出去，但是它原来的生命周期Rancher不会干涉。

> **注意：** 对自定义主机，包括Rancher Agent在内的全部容器都会保留在该主机上。同时，Rancher网络驱动创建的`docker0`上的IP也将会保留。

### 在Rancher外删除主机

在Rancher外删除主机，也就是意味着不是按照Rancher操作界面或者API来删除主机。最简单的例子就是，在Rancher集群内，有一台云提供商提供的主机。通过云提供商的管理界面删除了这台主机，这个删除行为Rancher是无法感知的。Rancher会一直尝试重新连接这台已经删除的主机，并显示 _Reconnecting_ 的状态，之后主机会显示 _Disconnected_ 状态。 因此，为了同步回删除的状态，还需要从 **基础架构** 进入 **主机** 页面，点击已经删除的主机的下拉菜单，选择 **删除**。 你也可以配置一个延迟用于自动删除失联主机。这个配置叫做`host.remove.delay.seconds`，你可以在`系统` -> `设置` -> `高级选项`中找到这个配置。
