---
title: Labels
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## 标签
---

Rancher在服务/容器和主机上使用标签来帮助管理Rancher的不同功能。

### Rancher Compose标签使用指南

标签用于帮助Rancher启动服务并利用Rancher的功能。下列的标签索引用于帮助用户使用Rancher Compose来创建服务。 这些标签在UI上有对应关系，不需要额外添加到服务上。

Key | Value |描述
----|-----|---
`io.rancher.sidekicks` |  `服务名称`  | 用来定义哪些服务属于[从容器]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#sidekick-服务)
`io.rancher.loadbalancer.target.SERVICE_NAME` | `REQUEST_HOST:SOURCE_PORT/REQUEST_PATH=TARGET_PORT` |用于判定 [L7 Load Balancing]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/#load-balancer-example-l7)
`io.rancher.container.dns`| `true` | 服务能够使用基于Rancher DNS的服务发现来解析其他服务，并能被其他服务解析。 如果你需要此DNS服务，且网络设置为`主机`，则此标签是必需的.
`io.rancher.container.hostname_override` | `容器名称` | 用于将容器的主机名设置为容器的名称 (例如： StackName_ServiceName_CreateIndex)
`io.rancher.container.start_once` |`true` | 用于设置容器只运行一次，并在容器为停止状态时显示`active`状态。
`io.rancher.container.pull_image` | `always` | 用于在部署容器之前始终拉取新的镜像.
`io.rancher.container.requested_ip` | IP于`10.42.0.0/16`的地址空间 | 允许你选择容器的特定IP。从v1.6.6版本开始，服务内的容器将会使用配置的多个IP地址中的可用地址，直到这些地址全被占用。这些地址要用逗号隔开，例如`10.42.100.100, 10.42.100.101`。 在v1.6.6之前，只有服务中的一个容器可以使用这个特定IP。**注意：如果IP在主机上不可用，则容器将以随机IP开始.**
`io.rancher.container.dns.priority` | `service_last` | 在服务域之前使用主机的DNS搜索路径。 保证主机将从`/etc/resolv.conf`搜索后再对`*.rancher.internal`搜索。
`io.rancher.service.selector.container` |  [_Selector Label_ Values]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/labels/#选择器标签) | 用于服务，以支持选择独立的容器来加入DNS服务。 注意：作为独立容器，任何服务操作都不会影响独立容器（即停用/删除/编辑服务，健康检查等）。
`io.rancher.service.selector.link` | [_Selector Label_ Values]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/labels/#选择器标签) | 用于服务以允许服务基于服务标签链接到服务。 示例：Service1具有标签`io.rancher.service.selector.link：foo = bar`。 任何添加到Rancher的具有`foo=bar`标签的服务将自动链接到Service1。
`io.rancher.scheduler.global` | `true` | 用于设置[全局服务]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/#全局服务)
`io.rancher.scheduler.affinity:host_label` | 主机标签的Key Value配对| 用于根据[主机标签]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/#使用主机标签查找主机)在主机上编排容器
`io.rancher.scheduler.affinity:container_label` | 容器标签的Key Value配对 | 用于根据[容器标签或服务名称]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/#用容器标签查找主机)在主机上编排容器
`io.rancher.scheduler.affinity:container` | 容器名称 | 用于根据[容器名称]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/#查找具有容器名称的主机)在主机上安排容器
`io.rancher.lb_service.target` | [_Target Service Label_ Values](#目标服务标签) | 用于配置负载均衡，以便将流量转发到与负载均衡位于同一主机上的容器。

<br>

> **注意：** 对于以`io.rancher.scheduler.affinity`为前缀的标签，根据你想要匹配的方式（即相等或不相等，hard或soft规则）会有轻微的变化。 更多细节可以在这里找到[这里]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/#table-of-scheduling-labels).

#### 选择器标签

使用 _选择器标签_（即`io.rancher.service.selector.link`, `io.rancher.service.selector.container`），Rancher可以通过标签识别服务/容器，并将它们自动链接到服务。 将在以下两种情况下进行评估。 情景1是将 _选择器标签_ 添加到服务时。 在情景1中，对所有现有标签进行评估，以查看它们是否与 _选择器标签_ 匹配。 情景2是服务已经有 _选择器标签_ 时。 在情景2中，检查添加到Rancher的任何新服务/容器，看看它是否符合链接条件。 _选择器标签_ 可以由多个要求组成，以逗号分隔。 如果有多个要求，则必须满足所有要求，因此逗号分隔符作为** AND **逻辑运算符。

```
# 其中一个容器标签必须具有一个等于`foo1`的键，并且值等于`bar1`
foo1 = bar1
# 其中一个容器标签必须具有一个等于`foo2'的键，值不等于`bar2`
foo2 != bar2
＃其中一个容器标签必须有一个等于`foo3`的键，标签的值不重要
foo3
＃其中一个容器标签必须有一个等于`foo4`的键，值等于`bar1`或`bar2`
foo4 in (bar1, bar2)
＃其中一个容器标签必须有一个等于`foo5'的键和'bar3`或`bar4`以外的值
foo5 notin (bar3, bar4)
```
<br>

> **注意：** 如果标签有中包含逗号的标签，则选择器将无法与标签匹配，因为 _选择器标签_ 可以匹配任何没有关联值的键。 示例：`io.rancher.service.selector.link: foo=bar1,bar2`的标签将转换为任何服务必须具有一个标签为`foo`的键值，并且值等于`bar1` **和**另一个带有等于`bar2`的标签。 它不会选择一个键等于`foo`，并且值等于`bar1，bar2`的标签的服务。

#### 逗号分隔列表的示例

```
service1:
  labels:
    # 添加选择器标签来接收其他服务
    io.rancher.service.selector.link: hello != world, hello1 in (world1, world2), foo = bar
```
在此示例中，将链接到`service1`的服务需要满足以下所有条件：

* 具有键等于`hello`并且值不等于`world`的标签
* 具有键等于“hello1”但值可以等于`world1`或`world2`的标签
* 具有键等于`foo`和值等于`bar`的标签

以下示例，`service2`在部署时会自动链接到`service1`。

```
service2:
   labels:
      hello: test
      hello1: world2
      foo: bar
```

### 服务上的系统标签

除了Rancher Compose可以使用的标签之外，Rancher在启动服务时还会创建一系列系统标签。

Key | 描述
----|---
`io.rancher.stack.name`/`io.rancher.project.name` | 根据应用名称创建
`io.rancher.stack_service.name`/`io.rancher.project_service.name`| 根据服务名称创建
`io.rancher.service.deployment.unit` | 根据部署的从容器服务创建
`io.rancher.service.launch.config` |  基于从容器服务的配置创建。
`io.rancher.service.requested.host.id` | 根据该服务安排在哪个主机上创建

### 主机标签

[主机标签]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#主机标签) 可以在主机注册期间添加到主机，创建后可通过**编辑**在主机中添加。

Key | Value |描述
----|-----|---
`io.rancher.host.external_dns_ip` | 用于[外部DNS]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/external-dns-service/)的IP, 例如： a.b.c.d | 用于外部DNS服务，并需要对DNS记录进行编程[使用主机IP以外的IP]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/external-dns-service/#为外部dns使用特定的ip)

### 自动创建的主机标签

Rancher会自动创建与主机的linux内核版本和Docker Engine版本相关的主机标签。 这些标签可以用于[调度]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/).

Key | Value | 描述
----|----|----
`io.rancher.host.linux_kernel_version` | 主机上的Linux内核版本 (例如`3.19`) | 主机上运行的Linux内核的版本
`io.rancher.host.docker_version` | 主机上的Docker版本（例如`1.10.3`） | 主机上运行的Docker Engine版本
`io.rancher.host.provider` | 云提供商信息 | 云提供商名称（目前仅适用于AWS）
`io.rancher.host.region` | 云提供商区域 | 云提供商区域（目前仅适用于AWS）
`io.rancher.host.zone` | 云提供商可用区 | 云提供商可用区（目前仅适用于AWS）

### 本地Docker标签

`io.rancher.container.network` | `true`| 将此标签添加到`docker run`命令中，以将Rancher网络添加到容器中

#### 目标服务标签

负载均衡可以配置为将流量优先分发于同负载均衡为同一主机的目标容器。 根据标签的值，负载均衡将被配置为将流量定向到指定的容器，或者将流量的优先级设置为某些指定的容器。 默认情况下，负载平衡器以Round-robin算法将流量分发到目标服务下的所有容器。

Key | Value | 描述
----|----|----
`io.rancher.lb_service.target` | `only-local` | 只能将流量转发到与负载均衡为相同主机的容器上。 如果同一主机上没有目标服务的容器，则不会将流量转发到该服务。
`io.rancher.lb_service.target` | `prefer-local` | 将流量优先于同负载均衡容器为同一主机上的容器。 如果在同一主机上没有目标服务的容器，则流量将被路由到其他拥有目标服务容器的宿主机上。
