---
title: Load Balancers
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## 负载均衡
---

Rancher支持多种负载均衡驱动，通过在它之上建立代理规则，可以将网络及应用流量分发至指定的容器中。负载均衡的目标服务中的容器都会被Rancher自动注册为负载均衡的目标。在Rancher中，将负载均衡加入到应用中是一件非常容易的事情。

默认情况下，Rancher提供一个基于HAProxy的托管的负载均衡，它可以被手动扩容至多台主机。在接下来的例子中将会涉及到负载均衡中不同的配置项，这些配置项主要以HAProxy为参考。我们计划支持除HAProxy以外的其他负载均衡驱动，但这些配置项都会是相同的。

我们使用round robin算法分发流量至目标服务。这个算法可在[自定义HAProxy.cfg](#自定义haproxycfg)中进行自定义。
另外，你可以配置负载均衡来将流量分发至与负载均衡容器处于相同主机的目标容器。通过给负载均衡设置一个特定的[标签]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/#target-service-labels)，能够将负载均衡的目标限定在同一台主机中的目标容器（例如 `io.rancher.lb_service.target=only-local`），或者优先转发至同一台主机中的目标容器(例如： `io.rancher.lb_service.target=prefer-local`)。

我们将会查看在[UI](#如何在ui上新增一个负载均衡)和[Rancher Compose](#用rancher-compose-添加负载均衡)中的负载均衡的配置项，并且给出[UI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/#adding-a-load-balancer-in-the-ui)和[Rancher Compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/#adding-a-load-balancer-with-rancher-compose)的用例。

### 如何在UI上新增一个负载均衡

我们将为我们在[添加服务部分]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#在ui中添加服务)中创建的“letschat”应用新增一个负载均衡.

首先，我们从添加一个负载均衡服务开始，点击”添加服务“旁边的下拉图标，找到**添加负载均衡**并点击它。

进入添加页面后，容器`数量`默认是1，填入“名称”，如“LetsChatLB”。

`端口规则`下，`访问`选择默认的`公开`，`协议`选择默认的`HTTP`。请求`端口`填入`80`，`目标`选择`letschat`服务， 并且端口填入`8080`。

点击**创建**。

现在，让我们来实际感受一下负载均衡。在应用视图下， 有一个连接到`80`端口的超链接，这是负载均衡中的源端口。如果你点击它，将会在你的浏览器中自动新开一个页签，并指向负载均衡服务所在的主机。请求将会被重定向到其中一个”LetsChat“容器。如果你刷新浏览器，负载均衡服务会把新的请求重定向到“LetsChat”服务下的其他容器中。

### 页面上的负载均衡选项

Rancher提供一个基于HAProxy的容器来重定向流量至目标服务。

> **注意：** 负载均衡只会在那些使用`托管`网络的服务中生效，其他网络模式都不会生效。

点击**添加服务**旁边的下拉图标，找到**添加负载均衡**并点击它。

你能使用滑块选择`数量`，就是负载均衡使用多少个容器。或者，你可以选择`总是在每台主机上运行一个此容器的实例`。使用这一个选项, 你的负载均衡容器数量将会随着你[环境]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/)下的主机数量增减而增减。如果你在**调度**部分设定了调度规则，Rancher将会在满足规则的主机上启动负载均衡。如果你的环境下新增了一台不满足调度规则的主机，负载均衡容器不会在这一台主机中启动。

> **注意：** 负载均衡容器的扩缩容不能超过环境下主机的数量，否则会造成端口冲突，负载容器服务将会被阻碍在`activating`状态。它会不断去尝试寻找可用的主机并开启端口，直到你修改它的数量或者[添加主机]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/).

你需要提供负载均衡的**名称**，如果有需要的话，你可以添加**描述**。

接下来，你可以定义负载均衡的端口规则。有两种规则类型可供创建。用于目标为特定的已存在的服务的`服务规则`和用于匹配一定选择规则的`选择器规则`。

当创建了多条服务和选择器规则的时候，请求头和路径规则将会自顶向下按显示在UI上的顺序匹配。

#### 服务规则

服务规则指的是端口指向目标容器的规则。

在**访问**选项栏中，你可以决定这个负载均衡端口是否可以被公网访问（就是说是否可以从主机以外访问）或者仅仅在环境内部访问。默认情况下，Rancher假定你希望被公网访问，但是如果你希望仅仅在环境内部被访问，你可以选择`内部`。

选择`协议`选项栏。获取更多关于我们[协议选项](#协议)的信息。如果你选择了需要SSL终端（如 `https` or `tls`），你将需要在`SSL终端`标签页中新增你的认证信息。

接下来，你可以针对流量的来源填写**请求头信息**, **端口** 和 **路径**。

> **注意：** `42` 端口不能被用作负载均衡的源端口，因为它被用于[健康检查]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/health-checks)。

##### 请求头信息／路径

请求头信息是HTTP请求头中的host的属性。请求路径可以是一段特殊的路径。你可以任意设置其中一个或者两者都设置。

###### 例子:

```
domain1.com -> Service1
domain2.com -> Service2

domain3.com -> Service1
domain3.com/admin -> Service2
```

###### 通配符

当基于HOST值设置路由时，Rancher支持通配符。所支持的语法如下。

```
*.domain.com -> hdr_end(host) -i .domain.com
domain.com.* -> hdr_beg(host) -i domain.com.
```

##### 目标服务和端口

每一个服务规则，你都可以选择你想要的**目标**服务。这些服务列表是基于该环境下所有的服务清单的。每一个服务，你还能选择与之配套的端口。服务上的私有端口通常就是镜像所暴露的端口。

#### 选择器规则

在选择器规则中，你需要填写一个[选择器标签]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/labels/#选择器标签)而不是特定的服务。选择器基于服务的标签来选择目标服务。当负载均衡被创建的时候，选择器规则将会针对环境下现有的任意一个服务来计算看是否为可匹配的服务。后面新增的服务或者对标签进行修改都会拿来与选择器标签进行匹配。

对于每一个**源端口**，你都可以添加相应的**请求头信息**或**路径**。[选择器标签]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/labels/#选择器标签)是基于**目标**的，你能指定一个特定的**端口**接收转发到服务上的流量。服务上的私有端口通常就是镜像所暴露的端口。

##### 例子: 2 选择器规则

1. 源端口: `100`; 选择器: `foo=bar`; 端口: `80`
2. 源端口: `200`; 选择器: `foo1=bar1`; 端口: `80`

* 服务A有一个 `foo=bar` 标签，它将会匹配第一条规则. 任何指向`100`的流量都会被转发到服务A。
* 服务B有一个`foo1=bar` 标签，它将会匹配第二条规则. 任何指向`200`的流量都会被转发到服务B。
* 服务C有`foo=bar`和`foo1=bar1`两个标签，它将会匹配两条规则. 任何指向`200`和`100`的流量都会被转发到服务C.

> **注意：** 目前，如果你想要将一条选择器规则应用于多个主机名／路径上，你需要使用[Rancher Compose](#selector)在目标服务上去设置主机名／路径。

#### SSL会话终止

**SSL会话终止**标签提供了添加用于`https`和`tls`协议证书的能力。在**证书**下拉框中，你可以为负载均衡选择主证书。

添加证书前，请阅读[如何添加证书]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/certificates/).

为负载均衡添加多个证书是可以实现的。这样相应的证书会基于请求主机名(查看 [服务器名称指示](https://en.wikipedia.org/wiki/Server_Name_Indication))展示给客户端。这个功能可能在那些不支持SNI(它会获取主要证书)的老客户端上失效。对于现代客户端，我们会在能匹配到的列表中提供证书，如果没有匹配成功，就会提供主证书。

#### 负载均衡的会话粘性

你可以点击选择负载均衡的**会话粘性**。会话粘性就是你的cookie策略。

Rancher支持以下两种选项：

* **无**: 这个选项意味着不会设置cookie策略
* **创建新的Cookie**: 这个选项意味着在你的应用之外会创建cookie。这个cookie是由负载均衡设置在请求与响应中的。这就是会话粘性策略。

#### 自定义haproxy.cfg

由于Rancher基于HAProxy来搭建负载均衡，所以你能自定义HAproxy的配置。你在这里定义的配置都会被添加到Rancher生成的配置的最后面。

##### 自定义HAProxy配置的例子

```
global
    maxconn 4096
    maxpipes 1024

defaults
    log global
    mode    tcp
    option  tcplog

frontend 80
    balance leastconn

frontend 90
    balance roundrobin

backend mystack_foo
    cookie my_cookie insert indirect nocache postonly
    server $IP <server parameters>

backend customUUID
    server $IP <server parameters>
```

#### 标签／调度负载均衡

我们支持向负载均衡添加标签并且调度负载均衡在哪启动。点击[这里]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/#在ui中调度选项)查看更多关于标签和调度的信息。

### 用Rancher Compose 添加负载均衡

在这，我们将一步步为我们之前在[创建服务章节]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#使用-rancher-compose-添加服务)创建的"letschat"应用设置一个负载均衡。

点击[这里]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/rancher-compose/)查看更多关于如何配置一个Rancher Compose。

> **注意：**: 在我们的例子中，我们会使用`<version>`作为负载均衡镜像的标签。每一个Rancher版本都有特定的，被负载均衡所支持的`lb-service-haproxy`版本。

我们将会建立一个和我们上面在UI中所使用到的例子一样范例。首先你需要创建一个`docker-compose.yml`文件和一个`rancher-compose.yml`文件。使用Rancher Compose，我们可以启动一个负载均衡

#### Example `docker-compose.yml`

```yaml
version: '2'
services:
  letschatlb:
    ports:
    - 80
    image: rancher/lb-service-haproxy:<version>
```

#### Example `rancher-compose.yml`

```yaml
version: '2'
services:
  letschatlb:
    scale: 1
    lb_config:
      port_rules:
      - source_port: 80
        target_port: 8080
        service: letschat
    health_check:
      port: 42
      interval: 2000
      unhealthy_threshold: 3
      healthy_threshold: 2
      response_timeout: 2000
```

### Rancher Compose 中的负载均衡配置

Rancher 提供一个基于HAProxy的容器来做负载均衡。

> **注意：** 负载均衡仅仅在使用托管网络的服务中生效。其他的网络选择都不会生效。

负载均衡可以像其他任何一个服务一样被调度。点击[这里]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/#在rancher-compose中添加标签)获取更多关于在Rancher Compose中使用负载均衡的例子。

负载均衡由暴露在主机上的端口和负载均衡配置组成，这些配置包括针对不同目标服务的特定端口规则，自定义配置和会话粘性策略。

当与含有[从容器]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#sidekick-服务)的服务一起使用的时候，你需要将[主服务]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#主服务)作为目标服务，就是那些含有`sidekick`标签的服务。

### 源端口

当创建一个负载均衡的时候，你可以将任意一个你想要的端口暴露在主机上。这些端口都可以被用做负载均衡的源端口。如果你想要一个内部的负载均衡，就不要暴露任何端口在负载均衡上，只需要在负载均衡配置中添加端口规则。

> **注意：** `42` 端口 不能被用作负载均衡的源端口，因为它被用于[健康检查]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/health-checks)。

#### Example `docker-compose.yml`

```yaml
version: '2'
services:
  lb1:
    image: rancher/lb-service-haproxy:<version>
    # Any ports listed will be exposed on the host that is running the load balancer
    # To direct traffic to specific service, a port rule will need to be added.
    ports:
    - 80
    - 81
    - 90
```

### Load Balancer configuration

所有负载均衡的配置项都被定义在`rancher-compose.yml`的`lb_config`字段中

```yaml
version: '2'
services:
  lb1:
    scale: 1
    # All load balancer options are configured in this key
    lb_config:
      port_rules:
      - source_port: 80
        target_port: 80
        service: web1
    health_check:
      port: 42
      interval: 2000
      unhealthy_threshold: 3
      healthy_threshold: 2
      response_timeout: 2000
  web1:
    scale: 2
```

#### 端口规则

端口规则是定义在`rancher-compose.yml`中的。因为端口规则是单独定义的，会有许多不同的端口指向同一个服务。默认情况下，Rancher将会优先使用那些基于特定的优先级顺序的端口。如果你想要改变这些优先级顺序，你需要设定特定的优先级规则。

#### 默认优先级顺序

1. 没有通配符和URL的主机名
2. 没有通配符的主机名
3. 有通配符和URL的主机名
4. 有通配符的主机名
5. URL
6. 默认(没有主机名，没有URL)

##### 源端口

源端口是值暴露在主机上的某个端口（也就是定义在`docker-compose.yml`中的端口）。

如果你想要创建一个内部负载均衡，那么源端口酒不需要与`docker-compose.yml`中定义的任意一个匹配。

##### 目标端口

目标端口是服务内部端口。这个端口就是用于启动你容器的镜像所暴露的端口。

##### 协议

Rancher的负载均衡支持多种协议类型。

* `http` - 默认情况下，如果没有设置任何协议，负载均衡就会使用`http`。HAProxy 不会对流量做任何解析，仅仅是转发。
* `tcp` - HAProxy 不会对流量做任何解析，仅仅是转发。
* `https` - 需要设置SSL会话终结。流量将会被HAProxy使用[证书]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/certificates/)解密，这个证书必须在设定负载均衡之前被添加入Rancher。被流量负载均衡所转发的流量是没有加密的。
* `tls` - 需要设置SSL会话终结。流量将会被HAProxy使用[证书]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/certificates/)解密，这个证书必须在设定负载均衡之前被添加入Rancher。被流量负载均衡所转发的流量是没有加密的。
* `sni` - 流量从负载均衡到服务都是被加密的。多个证书将会被提供给负载均衡,这样负载均衡就能将合适的证书基于主机名展示给客户端。 点击[服务器名称指示](https://en.wikipedia.org/wiki/Server_Name_Indication)）查看更多详情。
* `udp` - Rancher 的HAProxy不支持.

其他的负载均衡驱动可能只支持以上的几种。

##### 主机名路由

主机名路由只支持`http`, `https` 和 `sni`，只有`http` 和 `https`同时支持路径路由。

##### 服务

服务名就是你的负载均衡的目标。如果服务在同一个应用下，你可以使用服务名。如果服务在不同的应用下，你需要使用`<应用名>/<服务名>`。

###### Example `rancher-compose.yml`

```yaml
version: '2'
services:
  lb1:
    scale: 1
    lb_config:
      port_rules:
      - source_port: 81
        target_port: 2368
        # Service in the same stack
        service: ghost
      - source_port: 80
        target_port: 80
        # Target a service in a different stack
        service: differentstack/web1
    health_check:
      port: 42
      interval: 2000
      unhealthy_threshold: 3
      healthy_threshold: 2
      response_timeout: 2000
  ghost:
    scale: 2
```

##### 主机名和路径

Rancher基于HAProxy的负载均衡支持七层路由，可以在端口规则下通过设定指定的主机头和路径来使用它。

###### Example `rancher-compose.yml`

```yaml
version: '2'
services:
  lb1:
    scale: 1
    lb_config:
      port_rules:
      - source_port: 81
        target_port: 2368
        service: ghost
        protocol: http
        hostname: example.com
        path: /path/a
    health_check:
      port: 42
      interval: 2000
      unhealthy_threshold: 3
      healthy_threshold: 2
      response_timeout: 2000
  ghost:
    scale: 2
```

##### 通配符

当设置基于主机名的路由规则时，Rancher支持通配符。所支持的语法如下。

```
*.domain.com -> hdr_end(host) -i .domain.com
domain.com.* -> hdr_beg(host) -i domain.com.
```

##### 优先级

默认情况下，Rancher 针对同一个服务遵循[默认优先级顺序](#默认优先级顺序)，但是你也可以定制化你自己的优先级规则（数字越小，优先级越高）

###### Example `rancher-compose.yml`

```yaml
version: '2'
services:
  lb1:
    scale: 1
    lb_config:
      port_rules:
      - source_port: 88
        target_port: 2368
        service: web1
        protocol: http
        hostname: foo.com
        priority: 2
      - source_port: 80
        target_port: 80
        service: web2
        protocol: http
        priority: 1
    health_check:
      port: 42
      interval: 2000
      unhealthy_threshold: 3
      healthy_threshold: 2
      response_timeout: 2000
  web1:
    scale: 2
```

##### 选择器

你可以通过设定[选择器]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/labels/#选择器标签)来指定多个服务。通过使用选择器，你可以在目标服务上定义服务连接和主机名路由规则，那些标签匹配了选择器的服务将成为负载均衡的目标。

当使用选择器的时候，`lb_config`可以设定在负载均衡和任意一个匹配选择器的服务上。

在负载均衡器中。[选择器标签]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/labels/#选择器标签) 设置在`selector`下的`lb_config`中。负载均衡的`lb_config`端口规则不能有服务，并且也不能有目标端口。目标端口是设置在目标服务的端口规则中的。如果你需要使用主机名路由，主机名和路径是设置在目标服务下的。

>**注意:** 对于那些在v1版本yaml中使用了的选择器标签字段的负载均衡，这不会被转化成v2版本的负载均衡。因为服务上的端口规则不会更新。

###### Example `docker-compose.yml`

```yaml
version: '2'
services:
  lb1:
    image: rancher/lb-service-haproxy:<version>
    ports:
    - 81
  # These services (web1 and web2) will be picked up by the load balancer as a target
  web1:
    image: nginx
    labels:
      foo: bar
  web2:
    image: nginx
    labels:
      foo: bar
```

###### Example `rancher-compose.yml`

```yaml
version: '2'
services:
  lb1:
    scale: 1
    lb_config:
      port_rules:
      - source_port: 81
        # Target any service that has foo=bar as a label
        selector: foo=bar
        protocol: http
    health_check:
      port: 42
      interval: 2000
      unhealthy_threshold: 3
      healthy_threshold: 2
      response_timeout: 2000
  # web1 and web2 are targeted with the same source port but with the different hostname and path rules
  web1:
    scale: 1
    lb_config:
      port_rules:
      - target_port: 80
        hostname: test.com
  web2:
    scale: 1
    lb_config:
      port_rules:
      - target_port: 80
        hostname: example.com/test
```

##### 后台名称

如果你想要清晰地在负载均衡配置中标明你的后台，你需要使用`backend_name`。如果你想要为一个某个后台自定义配置参数，这就会用得上。

#### 证书

如果你需要使用`https` 或者 `tls` [协议](#协议), 你可以使用[直接加入Rancher]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/certificates)或者挂载在负载均衡容器中的证书。

##### 引用在Rancher中添加的证书

证书可以在负载均衡容器的`lb_config`中被引用。

```yaml
version: '2'
services:
  lb:
    scale: 1
    lb_config:
      certs:
      - <certName>
      default_cert: <defaultCertName>
```

##### 将证书挂载进负载均衡容器

_仅仅在Compose文件中支持_

证书可以作为卷直接挂载进负载均衡容器。证书需要按照特定的目录结构挂载入容器。如果你使用LetsEncrypt客户端生存证书，那么它就已经满足Rancher的要求。否则，你需要手动设置目录结构，使他与LetsEncrypt客户端生成的一致。

Rancher的负载均衡将会检测证书目录来实现更新。任何对证书的新增／删除操作都将每30秒同步一次。

所以的证书都位于同一个基础的证书目录下。这个文件名将会作为负载均衡服务的一个标签，用于通知负载均衡证书的所在地。

在这个基础目录下，相同域名的证书被放置在同一个子目录下。文件名就是证书的域名。并且每一个文件夹都需要包含`privkey.pem`和
`fullchain.pem`。对于默认证书，可以被放置在任意一个子目录名下，但是下面的文件命名规则必须保持一致。

```bash
-- certs
  |-- foo.com
  |   |-- privkey.pem
  |   |-- fullchain.pem
  |-- bar.com
  |   |-- privkey.pem
  |   |-- fullchain.pem
  |-- default_cert_dir_optional
  |   |-- privkey.pem
  |   |-- fullchain.pem
...
```
当启动一个负载均衡的时候，你必须用标签声明证书的路径（包括默认证书的路径）。这样以来，负载均衡将忽略设置在`lb_config`中的证书。

> **注意：** 你不能同时使用在Rancher中添加的证书和挂载在负载均衡容器中的证书

```yaml
labels:
  io.rancher.lb_service.cert_dir: <CERTIFICATE_LOCATION>
  io.rancher.lb_service.default_cert_dir: <DEFAULT_CERTIFICATE_LOCATION>
```

证书可以通过绑定主机的挂载目录或者通过命名卷来挂在入负载均衡容器，命名卷可以以我们的[storage drivers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/storage-service/)为驱动。

###### Example `docker-compose.yml`

```yaml
version: '2'
services:
  lb:
    image: rancher/lb-service-haproxy:<TAG_BASED_ON_RELEASE>
    volumes:
    - /location/on/hosts:/certs
    ports:
    - 8087:8087/tcp
    labels:
      io.rancher.container.agent.role: environmentAdmin
      io.rancher.container.create_agent: 'true'
      io.rancher.lb_service.cert_dir: /certs
      io.rancher.lb_service.default_cert_dir: /certs/default.com
  myapp:
    image: nginx:latest
    stdin_open: true
    tty: true
```

###### Example `rancher-compose.yml`

```yaml
version: '2'
services:
  lb:
    scale: 1
    start_on_create: true
    lb_config:
      certs: []
      port_rules:
      - priority: 1
        protocol: https
        service: myapp
        source_port: 8087
        target_port: 80
    health_check:
      healthy_threshold: 2
      response_timeout: 2000
      port: 42
      unhealthy_threshold: 3
      interval: 2000
      strategy: recreate
  myapp:
    scale: 1
    start_on_create: true
```

#### 自定义配置

高阶用户可以在`rancher-compose.yml`中声明自定义的配置。点击[HAProxy配置文档](http://cbonte.github.io/haproxy-dconv/configuration-1.5.html)查看更多详情。

##### Example `rancher-compose.yml`

```yaml
version: '2'
services:
  lb:
    scale: 1
    lb_config:
      config: |-
        global
            maxconn 4096
            maxpipes 1024

        defaults
            log global
            mode    tcp
            option  tcplog

        frontend 80
            balance leastconn

        frontend 90
            balance roundrobin

        backend mystack_foo
            cookie my_cookie insert indirect nocache postonly
            server $$IP <server parameters>

        backend customUUID
  health_check:
    port: 42
    interval: 2000
    unhealthy_threshold: 3
    healthy_threshold: 2
    response_timeout: 2000
```

#### 会话粘性策略

如果你需要使用会话粘性策略，你可以更新`rancher-compose.yml`中的策略。

##### Example `rancher-compose.yml`

```yaml
version: '2'
services:
  lb:
    scale: 1
    lb_config:
      stickiness_policy:
        name: <policyName>
        cookie: <cookieInfo>
        domain: <domainName>
        indirect: false
        nocache: false
        postonly: false
        mode: <mode>
  health_check:
    port: 42
    interval: 2000
    unhealthy_threshold: 3
    healthy_threshold: 2
    response_timeout: 2000
```

### Rancher Compose Examples

#### Load Balancer Example (L7)

##### Example `docker-compose.yml`

```yaml
version: '2'
services:
  web:
    image: nginx
  lb:
    image: rancher/lb-service-haproxy
  ports:
  - 80
  - 82
```

##### Example `rancher-compose.yml`

```yaml
version: '2'
services:
  lb:
    scale: 1
    lb_config:
      port_rules:
      - source_port: 80
        target_port: 8080
        service: web1
        hostname: app.example.com
        path: /foo
      - source_port: 82
        target_port: 8081
        service: web2
        hostname: app.example.com
        path: /foo/bar
  health_check:
    port: 42
    interval: 2000
    unhealthy_threshold: 3
    healthy_threshold: 2
    response_timeout: 2000
```

#### 内部负载均衡例子

设置内部负载均衡不需要列举端口，但是你仍然可以设置端口规则来转发流量。

##### Example `docker-compose.yml`

```yaml
version: '2'
services:
  lb:
    image: rancher/lb-service-haproxy
  web:
    image: nginx
```

<br>

##### Example  `rancher-compose.yml`

```yaml
version: '2'
services:
  lb:
    scale: 1
    lb_config:
      port_rules:
      - source_port: 80
        target_port: 80
        service: web
    health_check:
      port: 42
      interval: 2000
      unhealthy_threshold: 3
      healthy_threshold: 2
      response_timeout: 2000
  web:
    scale: 1
```

#### SSL会话终止 Example

在`rancher-compose.yml`中使用的证书必须被加入到Rancher中。

##### Example `docker-compose.yml`

```yaml
version: '2'
services:
  lb:
    image: rancher/lb-service-haproxy
    ports:
    - 443
  web:
    image: nginx
```

<br>

##### Example `rancher-compose.yml`

```yaml
version: '2'
services:
  lb:
    scale: 1
    lb_config:
      certs:
      - <certName>
      default_cert: <defaultCertName>
      port_rules:
      - source_port: 443
        target_port: 443
        service: web
        protocol: https
  web:
    scale: 1
```
