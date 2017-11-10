---
title: Using Rancher NFS
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## Rancher NFS
---

Rancher支持将NFS卷作为容器的一个存储选项

### 使用NFS之前的准备工作

在部署Rancher NFS驱动之前，你需要先准备一个NFS服务器。例如，你可以使用如下命令在Ubuntu 16.04上安装NFS服务器。

```bash
sudo apt-get update
sudo apt-get install nfs-kernel-server
```

在这个服务器上，你需要设置一个基础目录。首选，你需要创建一个共享目录。

```bash
sudo mkdir /nfs
sudo chown nobody:nogroup /nfs
```

修改exports文件(`/etc/exports`).

```bash
/nfs    *(rw,sync,no_subtree_check,no_root_squash)
```

在全部修改完成后，你需要重新启动NFS内核服务器。

```bash
sudo systemctl restart nfs-kernel-server
```

### 在Amazon EFS上使用Rancher NFS驱动

Rancher的NFS驱动可以连接Amazon的EFS。当我们在Amazon EFS上使用Rancher NFS驱动时，环境内全部的主机都需要是EC2主机，并且这些主机要部署在与EFS所在区域相同的同一个可用区内。

### 配置Rancher NFS

当设置一个[环境模版]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#什么是环境模版)的时候，你可以选择启用**Rancher NFS**应用，这样以后用这个模版创建的环境都会包括Rancher的NFS服务。

或者，如果你已经设置好了一个环境，你可以在[应用商店]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/)中找到并部署Rancher NFS服务。

> **注意：** 某些存储服务可能与容器编排引擎不兼容(例如 Kubernetes)。环境模版会根据你选择的编排引擎显示其兼容的存储服务。但是在应用商店中可以看到全部的应用，不会按照编排引擎进行过滤。

为了部署Rancher NFS，你需要指定如下配置：

* **NFS Server**: NFS服务器的IP地址或者主机名称
* **Export Base Directory**: NFS服务器输出的共享目录
* **NFS Version**: 你所用的NFS版本，当前使用的是版本4
* **Mount Options**: 用逗号分隔的默认挂载选项， 例如: 'proto=udp'. 不要配置`nfsvers`选项，这个选项会被忽略。
* **On Remove**: 当移除Rancher NFS卷的时候，底层数据是否应该被保留或者清理。选项有`purge`和`retain`，默认值为`purge`。从Rancher 1.6.6开始支持。

### Rancher NFS驱动选项

当通过Rancher NFS驱动创建卷时，你可以通过一些选项来自定义自己的卷。这些选项是一些键值对，可以通过UI的驱动选项添加，也可以通过compose文件的`driver_opts`属性来添加。

#### 驱动选项

* **Host** - (`host`): NFS主机
* **Export** - (`export`): 当一个卷配置了host和export，将不会创建子文件夹，export的根目录将会被挂载。
* **Export Base** - (`exportBase`): 默认情况下，卷可以配置host和export base，这样会在NFS服务器上创建一个名字唯一的子文件夹。
* **Mount Options** - (`mntOptions`): 用逗号分隔的默认挂载选项。
* **On Remove** - (`onRemove`): 当移除Rancher NFS卷的时候，底层数据是否应该被保留或者清理。选项有`purge`和`retain`，默认值为`purge`。从Rancher 1.6.6开始支持。

### 在UI中使用Rancher NFS

#### 创建卷

当**Rancher NFS**在Rancher中部署成功后，你还需要在**基础架构** -> **存储**里创建NFS卷，之后才可以在服务中使用NFS卷。

1. 点击**添加卷**。
2. 输入在服务中使用的卷的名称。
4. 可选: 添加额外的驱动选项。

#### 在服务中使用卷

一旦卷在UI中被创建成功，你可以在[服务]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/)中使用这个共享存储了。当创建一个服务时，在**卷**页签，可以输入**卷**和**卷驱动**。

**volume**的语法格式与Docker相同，`<volume_name>:</path/in/container>`。Docker的卷默认是以读写模式进行挂载的，但是你可以通过在卷结尾处添加`:ro`使其以只读的模式进行挂载。

**卷驱动**和存储驱动的名字一致，为存储驱动的应用名。默认情况下，**Rancher NFS** 存储驱动名称为`rancher-nfs`。

### 在Compose文件中使用Rancher NFS

在基础设施应用中的**Rancher NFS**启动后，你可以开始在Compose文件中创建卷了。

在Docker Compose文件中`volumes`下可以定义卷。在同一个Docker Compose中每个卷可以和多个服务关联。

> **注意：** 此功能只在Compose v2格式下生效。

#### NFS卷示例

在这里例子中，我们将创建一个NFS卷同时创建使用这个卷的服务。所有该应用中的服务将共享同一个卷。

```yaml
version: '2'
services:
  foo:
    image: alpine
    stdin_open: true
    volumes:
    - bar:/data
volumes:
  bar:
    driver: rancher-nfs
```

#### 使用host，exportBase和export的示例

下面的例子展示了如何在某个服务中，覆盖`host`和`exportBase`。

```yaml
version: '2'
services:
  foo:
    image: alpine
    stdin_open: true
    volumes:
    - bar:/data
volumes:
  bar:
    driver: rancher-nfs
    driver_opts:
      host: 192.168.0.1
      exportBase: /thisisanothershare
```

你也可以给每个卷使用不同的`exportBase`，请看下面的例子。

```yaml
version: '2'
services:
  foo:
    image: alpine
    stdin_open: true
    volumes:
    - bar:/bardata
    - baz:/bazdata
volumes:
  bar:
    driver: rancher-nfs
    driver_opts:
      host: 192.168.0.1
      exportBase: /thisisanothershare
  baz:
    driver: rancher-nfs
    driver_opts:
      host: 192.168.0.1
      exportBase: /evenanothershare
```

### Rancher NFS使用AWS EFS

在AWS上创建EFS文件系统之后，你可以部署Rancher NFS驱动来使用这个EFS文件系统。因为亚马逊EFS只在内部可达，所以只有与EFS在同一个可用区内的EC2主机可以访问EFS。因此，在创建存储驱动之前，你需要先添加EC2主机到Rancher环境中。

你可以使用下面的选项来部署Rancher NFS:

* **NFS Server**: `xxxxxxx.efs.us-west-2.amazonaws.com`
* **Export Base Directory**: `/`
* **NFS Version**: `nfsvers=4`

### 在移除卷时保留数据

驱动选项`onRemove`的默认值为`purge`。这意味着，当从Rancher中删除这个卷的时候，底层的数据也会被删除。如果你想要保留底层数据，你可以将这个选项设置为`retain`。你也可以给每个卷设置不同的`onRemove`值。如果nfs-driver选项`onRemove`被设置为`retain`，但是你想要在某个卷在Rancher中被删除时清理掉这个卷的底层数据，你可以通过`docker-compose.yml`在这个卷的`driver_opts`下面设置`onRemove: purge`。示例入下。

```yaml
services:
  foo:
    image: alpine
    stdin_open: true
    volumes:
    - bar:/data
volumes:
  bar:
    driver: rancher-nfs
    driver_opts:
      onRemove: purge
```

如果nfs-driver选项`onRemove`被设置为`purge`，你可以在卷的`driver_opts`里设置`onRemove: retain`来保留数据，这样当这个卷在Rancher中被移除时，数据将会被保留下来。

```yaml
services:
  foo:
    image: alpine
    stdin_open: true
    volumes:
    - bar:/data
volumes:
  bar:
    driver: rancher-nfs
    driver_opts:
      onRemove: retain
```

> **注意：** 创建一个外部卷的时候，如果卷的名称和之前被删除的卷的名称相同，并且这个被删除的卷的数据被保留着，这时使用这个卷的容器可以访问被先前保留的数据。
