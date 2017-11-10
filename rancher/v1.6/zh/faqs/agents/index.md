---
title: FAQS about Rancher Agents/Hosts
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---
## Rancher Agent的常见问题
---

### 我如何在代理服务器后配置主机？

要在代理服务器后配置主机，你需要配置Docker的守护进程。详细说明参考在代理服务器后[添加自定义主机]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/#添加代理服务器之后的主机)。

### Rancher Agent无法启动的原因是什么？

#### 添加 `--name rancher-agent`

如果你从UI中编辑`docker run .... rancher/agent...`命令并添加`--name rancher-agent`选项，那么Rancher Agent将启动失败。Rancher Agent在初始运行时会启动3个不同容器。最后启动的名为`rancher-agent`的容器是Rancher Agent成功连接到Rancher Server所必需的容器。在`rancher-agent`容器之前，启动的其他两个容器是用来探测主机并且设置状态的。它们会被自动移除。

#### 使用一个克隆的虚拟机。

如果你使用了克隆其他Agent主机的虚拟机并尝试注册它，它将不能工作。在rancher-agent容器的日志中会产生`ERROR: Please re-register this agent.`字样的日志。Rancher主机的唯一ID保存在`/var/lib/rancher/state`，因为新添加和虚拟机和被克隆的主机有相同的唯一ID，所以导致无法注册成功。

解决方法是在克隆的VM上运行以下命令： `rm -rf /var/lib/rancher/state; docker rm -fv rancher-agent; docker rm -fv rancher-agent-state`, 完成后可重新注册。

<a id="agent-logs"></a>

### 我在哪里可以找到Rancher agent容器的详细日志?

从v1.6.0起，在rancher-agent容器上运行`docker logs`将提供agent相关的所有日志。

### 如何验证你的主机注册地址设置是否正确？

如果你正面临Rancher Agent和Rancher　Server的连接问题，请检查主机设置。当你第一次尝试在UI中添加主机时，你需要设置主机注册的URL，该URL用于建立从主机到Rancher Server的连接。这个URL必须可以从你的主机访问到。为了验证它，你需要登录到主机并执行curl命令：

```
curl -i <Host Registration URL you set in UI>/v1
```

你应该得到一个json响应。 如果开启了认证，响应代码应为401。如果认证未打开，则响应代码应为200。

> **注意：** 普通的HTTP请求和websocket连接（ws://）都将被使用。 如果此URL指向代理或负载平衡器，请确保它们可以支持Websocket连接。

### 主机是如何自动探测IP的？我该怎么去修改主机IP？如果主机IP改变了（因为重启），我该怎么办？

当Agent连接Rancher Server时，它会自动检测Agent的IP。有时，自动探测的IP不是你想要使用的IP，或者选择了docker网桥的IP，如. `172.17.x.x`。

或者，你有一个已经注册的主机，当主机重启后获得了一个新的IP, 这个IP将会和Rancher UI中的主机IP不匹配。

你可以重新配置“CATTLE_AGENT_IP”设置，并将主机IP设置为你想要的。

当主机IP地址不正确时，容器将无法访问管理网络。要使主机和所有容器进入管理网络，只需编辑添加自定义主机的命令行，将新的IP指定为环境变量“CATTLE_AGENT_IP”。 在主机上运行编辑后的命令。 不要停止或删除主机上的现有的Rancher Agent容器！

```bash
$ sudo docker run -d -e CATTLE_AGENT_IP=<NEW_HOST_IP> --privileged \
    -v /var/run/docker.sock:/var/run/docker.sock \
    rancher/agent:v0.8.2 http://SERVER_IP:8080/v1/scripts/xxxx
```

### 如果我没有使用Rancher删除主机而是直接删除会发生什么?

如果你的主机直接被删除，Rancher Server会一直显示该主机。
主机会处于`Reconnecting`状态，然后转到`Disconnected`状态，这样你才能够从UI中**删除**这些主机。

如果你有添加了健康检查功能的服务容器部署在`Disconnected`主机上，它们将会被重新调度到其他主机上。

### 为什么同一主机在UI中多次出现?

主机不能持久化`var/lib/rancher`这个文件夹，这是Rancher用来存储用于标识主机的必要信息。请在添加主机前删除这个文件夹。
