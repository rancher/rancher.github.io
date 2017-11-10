---
title: Adding Custom Hosts
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## 添加Custom主机
---

如果你已经部署了Linux主机，并且希望将它们添加到Rancher中。在点击**Custom**图标之后会，Rancher会自动生成一个`docker`命令脚本，将其拷贝到每一台主机上并运行这条命令来启动`rancher/agent`容器。

如果你在使用不同的[环境]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/)，不同环境生成的添加主机命令是不一样的。

确保你所在的环境就是你想要添加主机的环境。你所在的环境显示在UI的左上角。当你第一次登录进去之后，你是处于名称为**默认**的环境里。

一旦你的主机添加到Rancher之后，你就可以开始[添加服务]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/)了。

> **注意：** 确保运行Rancher Server的主机和你所添加的主机的时钟是一样的并且能够正常访问主机上的容器。更多信息，请参考[在Rancher中访问容器的命令行和日志]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/faqs/troubleshooting/#求助-我不能通过-rancher的界面打开-shell-或查看日志--rancher-是如何去访问容器的-shell和日志)。

### 主机标签

你可以给每台主机添加标签，以帮助你组织你的主机。在启动rancher/agent容器时，你所添加的标签会以环境变量的形式添加到主机上。添加的标签是一组键值对，并且键值必须是唯一的。如果你添加了两个具有相同键不同值的标签，那么将会以你后面添加的值为准作为标签值。

增加标签之后，你可以使用这些标签来[调度服务/负载均衡器]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/)，并且可以为你主机上的[服务]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/)创建黑白名单。

添加自定义主机的时候，你可以在UI上添加标签，之后将会自动将带有键值对的环境变量(`CATTLE_HOST_LABELS`)添加到UI上出现的命令里。

_例子_

```bash
# Adding one host label to the rancher/agent command
$  sudo docker run -e CATTLE_HOST_LABELS='foo=bar' -d --privileged \
-v /var/run/docker.sock:/var/run/docker.sock rancher/agent:v0.8.2 \
http://<rancher-server-ip>:8080/v1/projects/1a5/scripts/<registrationToken>

# Adding more than one host label requires joining the additional host labels with an `&`
$  sudo docker run -e CATTLE_HOST_LABELS='foo=bar&hello=world' -d --privileged \
-v /var/run/docker.sock:/var/run/docker.sock rancher/agent:v0.8.2 \
http://<rancher-server-ip>:8080/v1/projects/1a5/scripts/<registrationToken>
```

### 安全组／防火墙

对于添加的任何主机，请确保安全组或者防火墙允许流量经过，否则Rancher的功能将会受限。

* 如果你正在使用IPsec[网络驱动]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/networking/)，要开放所有主机上的UDP端口500和4500。
* 如果你正在使用VXLAN[网络驱动]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/networking/)，要开放所有主机上的UDP端口`4789`。
* _k8s主机_ ：用作K8s的主机需要开放`10250`和`10255`端口来为`kubectl`使用。为了访问外部的服务，NodePort使用的端口也需要开放，默认的是TCP端口`30000` - `32767`。

<a id="samehost"></a>

### 在运行Rancher Server的机器上添加主机

如果你想将正在运行Rancher Server的主机同时添加为Agent主机，你必须修改UI上提供的命令行。在UI上，你需要指定这台主机的注册IP，它将会作为环境变量自动添加到命令行中。

```bash
$ sudo docker run -d -e CATTLE_AGENT_IP=<IP_OF_RANCHER_SERVER> -v /var/run/docker....
```

如果你已经把运行Rancher Server的主机同时添加为了Agent主机，请注意由于Rancher Server需要暴露`8080`端口，所以同一台主机上那些绑定`8080`端口的容器将无法创建，否则将会出现端口冲突的情况，造成Rancher Server停止运行。如果你一定要使用`8080`端口，那么你需要在启用Rancher Server的时候用另一个端口。

### 添加代理服务器之后的主机

为了在HTTP代理服务器后面添加主机， 需要通过配置docker deamon将docker指向这个代理。在添加自定义主机之前，修改文件`/etc/default/docker`，指向你的代理并重新启动docker。

```bash
$ sudo vi /etc/default/docker
```

在文件里，编辑`#export http_proxy="http://127.0.0.1:3128/"`，使其指向你的代理。保存你的修改并且重启docker。在不同的系统上重启docker的方式是不一样的。

> **注意：** 如果是用systemd启动的docker, 那么修改http代理的方式请参考docker [介绍](https://docs.docker.com/articles/systemd/#http-proxy)。

为了在代理后添加主机，你不用在命令行中添加其他环境变量来启动Rancher Agent。你只需要保证你的docker daemon配置正确就可以了。

如果你想要在Rancher Agent内使用该代理，你需要修改这个自定义命令，并添加相关的环境变量。

### 同时包含私有IP和公共IP的虚拟机

默认情况下，对于同时包含私有IP和公共IP的虚拟机，IP地址将会根据主机注册地址中指定的地址来确定。例如，如果注册地址中使用的是私有IP，那么就会使用主机的私有IP。如果你想修改主机的IP地址，你需要编辑UI中提供的命令行。为了使Rancher Agent中的容器能够正常启动，需要将环境变量`CATTLE_AGENT_IP`设置成期望的IP地址。Rancher中所有的主机都需要和Rancher Serve在同一个网络。

```bash
$ sudo docker run -d -e CATTLE_AGENT_IP=<PRIVATE_IP> -v /var/run/docker....
```
如果在Agent已经连接之后需要修改主机的IP，那么请重新运行添加自定义主机的命令行。

> **注意：** 当设置成私有地址之后，Rancher中已经存在的容器将不在同一个托管网络内。
