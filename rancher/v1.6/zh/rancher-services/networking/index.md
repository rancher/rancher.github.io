---
title: Networking in Rancher
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## 网络
---
Rancher实现了一个CNI框架，用户可以在Rancher中选择不同的网络驱动。为了支持CNI框架，每个Rancher环境中都需要部署网络服务，默认情况下，每个环境模版都会启用网络服务。除了网络服务这个基础设施服务之外，你还需要选择相关的CNI驱动。在默认的环境模版中，IPSec驱动是默认启用的，它是一种简单且有足够安全性的隧道网络模型。当你一个网络驱动在环境中运行时，它会自动创建一个默认网络，任何使用托管网络的服务其实就是在使用这个默认网络。这些服务运行着内部DNS服务器并且负责管理路由来暴露主机端口（通过iptable实现）。

### 与先前版本的区别
当使用1.2版本之前的IPsec网络时，容器使用托管网络将会被分配两个IP，分别是Docker网桥IP（172.17.0.0/16）和Rancher托管IP（10.42.0.0/16）。之后的版本中，则集成了CNI网络框架的标准，容器只会被分配Rancher托管IP（10.42.0.0/16）。

### 使用CNI的影响
Rancher托管IP不会显示在Docker元数据中，这意味着通过`docker inspect`无法查到IP。因为Rancher使用IPtables来管理端口映射, 任何端口映射也无法通过`docker ps`显示出来。

### 容器间连通性
默认情况下，同一环境下的托管网络之间的容器是可达的。如果你想要控制这个行为，你可以部署网络策略服务。
如果你在跨主机容器通信中碰到问题，可以移步常见的故障排查与修复方法。

### 网络类型
在UI上创建服务时，切换到“网络”页签上可以选择网络类型，但是UI上默认不提供“Container”网络类型，如果要使用“Container”类型，则需要通过Rancher CLI/Rancher Compose/Docker CLI来创建。

#### 托管网络
默认情况下，通过UI创建容器会使用托管网络，在容器中使用ip addr或者ifconfig可以看到eth0和lo设备，eth0的IP从属于Rancher托管子网中，默认的子网是10.42.0.0/16，当然你也可以修改这个子网。
注意：如果在基础设施服务中删除了网络驱动服务，那么容器的网络设置将会失效。

##### 通过Docker CLI创建容器
任何通过Docker CLI创建的容器，只要添加--label io.rancher.container.network=true的标签，那么将会自动使用托管网络。不用这个标签，大部分情况下使用的是bridge网络。
如果容器只想使用托管网络，你需要使用--net=none和--label io.rancher.container.network=true。

#### None
当容器使用none网络类型，基本上等同于Docker中的—net=none。在容器中也不会看到任何网络设备除了lo设备。

#### Host
当容器使用host网络类型，基本上等同于Docker中的—net=host。在容器中能够看到主机的网络设备。

#### Bridge
当容器使用bridge网络类型，基本上等同于Docker中的—net=bridge。默认情况下，容器中可以看到172.17.0.0/16的网段IP。

#### Container
当容器使用container网络类型，基本上等同于Docker中—net=container:<CONTAINER>。在容器中可以看到指定容器的网络配置。

### Rancher IPSEC使用例子
通过编写YAML文件，利用CNI框架来驱动，就可以构建Rancher的网络基础服务。下面是IPSEC网络驱动的YAML文件样例：
```
ipsec:
  network_driver:
    name: Rancher IPsec
    default_network:
      name: ipsec
      host_ports: true
      subnets:
      - network_address: $SUBNET
      dns:
      - 169.254.169.250
      dns_search:
      - rancher.internal
    cni_config:
      '10-rancher.conf':
        name: rancher-cni-network
        type: rancher-bridge
        bridge: $DOCKER_BRIDGE
        bridgeSubnet: $SUBNET
        logToFile: /var/log/rancher-cni.log
        isDebugLevel: ${RANCHER_DEBUG}
        isDefaultGateway: true
        hostNat: true
        hairpinMode: true
        mtu: ${MTU}
        linkMTUOverhead: 98
        ipam:
          type: rancher-cni-ipam
          logToFile: /var/log/rancher-cni.log
          isDebugLevel: ${RANCHER_DEBUG}
          routes:
          - dst: 169.254.169.250/32
```

#### Name
网络驱动的名字

#### Default Network
默认网络定义的是当前环境的网络配置

##### Host Ports
默认情况下，可以在主机上开放端口，当然你可以选择不开放

##### Subnets
你可以给Overlay网络定义一个子网

##### DNS && DNS Search
这两个配置Rancher会自动放到容器的DNS配置中

#### CNI 配置
你可以将CNI的具体配置放在`cni_config`下面，具体的配置将会依赖你选择的CNI插件

##### bridge
Rancher IPSEC实际上利用了CNI的bridge插件，所以你会看到这个设置，默认是docker0

##### bridgeSubnet
这个配置可以理解为主机上容器的子网，对于Rancher IPSEC就是10.42.0.0/16

##### mtu

不同的云厂商在网络中配置了不同的MTU值。这个选项可以根据你的需要进行修改。这个选项也是Rancher需要的选项。需要明确的是MTU的配置需要在每一个网络组件上进行设置；在主机上，在Docker Deamon上，在IPsec或者VXLAN的基础服务里都要进行设置。同时同一个环境中的全部主机都需要有相同的设置。如果同一个环境中的全部主机，有着不同的MTU值，那么将会有随机的网络错误发生。

> Rancher的IPsec Overlay网络有一个98字节的开销
> `容器网络接口的MTU = 网络的MTU - 98`

> 例如，你有一个云厂商的MTU值为1200字节，那么如果你在容器中输入`ip addr`或者`ifconfig`时，你将会看到1102 (= 1200 - 98)字节的MTU值。

##### 修改MTU

MTU的配置需要在每一个网络组件上进行设置；在主机上，在Docker Deamon上，在IPsec或者VXLAN的基础服务里都要进行设置（需要创建一个新的环境模版）。同时同一个环境中的全部主机都需要有相同的设置。你可以按照下面的步骤来修改MTU。

* 修改主机的MTU
  * 我们应该在主机的网络接口上修改这个值，请参考你使用的Linux发行版的文档，来了解如何修改MTU。
* 修改Docker网桥的MTU
  * 在大多数情况下，这将会是docker0。如下列，你可以通过在`/etc/docker/daemon.json`中设置MTU。更多详情，请参考Docker的官方文档[自定义网桥docker0](https://docs.docker.com/engine/userguide/networking/default_network/custom-docker0/)

```json
{
  "mtu": 1450
}
```

* 创建一个新的[环境模版]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#什么是环境模版)来设置IPsec或者VXLAN基础设施服务所需的MTU值。
* 使用这个新建的环境模版来创建一个新的环境。

> MTU只能在环境模版中进行配置。不建议在已有的环境中配置一个不同的MTU值，因为这个值仅会在新创建的容器中生效。
