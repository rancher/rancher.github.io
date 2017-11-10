---
title: Using Rancher EBS
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## Rancher EBS
---

Rancher提供对AWS EBS卷的支持，用户可以选择为容器选择AWS EBS存储。

### 使用EBS的限制

一个AWS EBS卷只可以挂载到一个AWS EC2实例中。因此，所有使用同一个AWS EBS卷的所有容器将会被调度到同一台主机上。

### 配置Rancher EBS

当配置一个[环境模板]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#什么是环境模版)时，你可以选择启用**Rancher EBS**。这样从该环境模板创建的环境都会自动启动该存储驱动。

又或者，你已经创建了一个环境，你可以选择从[应用商店]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/)中直接启动Rancher EBS。

> **注意：** 某些存储服务可能无法和一些容器或编排调度系统（例如，kubernetes）所兼容。环境模板可以根据当前的编排调度系统限定可以使用的存储服务，而应用商店中则会显示全部的存储服务。

要启动Rancher EBS，你需要一个AWS Access Key以及Secret Key 以确保你有权限创建AWS EBS卷。同时，不同的驱动选项可能还需要其他额外的权限。

### Rancher EBS 驱动选项

当创建AWS EBS卷时，有一些其他的选项可以用于自定义卷。这些选项是一些键值对，可以通过UI的驱动选项添加，也可以通过compose文件的`driver_opts`属性来添加。

#### 必填驱动选项

* **大小** - (`size`): EBS卷大小

#### 可选驱动选项

* **卷类型** - (`volumeType`):  卷类型
* **IOPS** - (`iops`): IOPS 选项
* **指定的可用区** (`ec2_az`): 在指定的可用区中创建容器以及EBS卷。(比如. `us-west-1a`)

对于以下选项，你**必须**指定和ID绑定的可用区(`ec2_az`)

* **Encrypted** (`encrypted`): 卷是否需要被加密。注：如果需要启动此选项，则需要提供AWS KMS ID。
* **AWS KMS ID** (`kmsKeyId`): 用于创建加密卷的AWS Key Management Service customer master key (CMK) 的完整资源名称-ARN（Amazon Resource Name）
* **Snapshot ID** (`snapshotID`): 用于创建卷的快照。
* **Volume ID** (`volumeID`): 已创建的卷ID。

### 在界面中使用Rancher EBS

#### 创建卷

当 **Rancher EBS**在Rancher中启动后，需要先从 **基础架构** -> **存储**中创建EBS卷，然后才可以在服务中使用EBS卷。

1. 点击**添加卷**
2. 填写卷名称
3. 必填：填写 `size`选项
4. 可选：添加其他额外的驱动选项。注：如果要使用加密，快照ID或者卷ID，你需要指定对应的可用区。

#### 在服务中使用卷

一旦卷在UI中被创建，[服务]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/)就可以使用该共享存储。创建一个服务时，在 **卷**选项卡中，填写**卷**以及**卷驱动**信息。
**卷** 语法和Docker语法相同，`<volume_name>:</path/in/container>`。Docker卷默认挂载为读写模式，但是你可以通过在卷的末尾添加`:ro`将其挂载为只读模式。
**卷驱动**和存储驱动的名字一致，为存储驱动的应用名。默认情况下，**Rancher EBS** 存储驱动名称为`rancher-ebs`。

### 在Compose文件中使用Rancher EBS

在基础设施应用中的**Rancher EBS**启动后，你可以开始在Compose文件中创建卷了。
在Docker Compose文件中`volumes`下可以定义卷。在同一个Docker Compose中每个卷可以和多个服务关联。

> **注意：** 此功能只在Compose v2格式下生效。

#### 举例：应用级别存储卷，指定size、卷类型以及IOPS
在这里例子中，我们将创建一个使用[应用级别的存储卷]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/storage-service/#应用级别)的服务。所有该应用中的服务将共享同一个卷。

```yaml
version: '2'
services:
  foo1:
    image: busybox
    stdin_open: true
    volumes:
    - bar:/var/lib/storage
  foo2:
    image: busybox
    volumes:
    - bar:/var/lib/storage

volumes:
  bar:
    driver: rancher-ebs
    driver_opts:
      size: 10
      volumeType: gp2
      iops: 1000
```

#### 举例：指定可用区的应用级别的存储卷

在这里例子中，我们将创建一个使用[应用级别的存储卷]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/storage-service/#应用级别)的服务。所有该应用中的服务将共享同一个卷。
我们将指定卷的可用区，使用该AWS EBS卷的所有容器将会被调度到同一台主机上。


```yaml
version: '2'
services:
  foo:
    image: busybox
    stdin_open: true
    volumes:
    - bar:/var/lib/storage

volumes:
  bar:
    driver: rancher-ebs
    driver_opts:
      size: 10
      ec2_az: us-west-2a
```

#### 举例：应用级别加密卷

在这里例子中，我们将创建一个使用[应用级别的存储卷]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/storage-service/#应用级别)的服务。所有该应用中的服务将共享同一个卷。
为了加密该卷，你需要在驱动选项中启用加密并指定加密密钥的ID以及该密钥所在的可用区。
使用该AWS EBS卷的所有容器将会被调度到同一台主机上。

```yaml
version: '2'
services:
  foo:
    image: busybox
    stdin_open: true
    volumes:
    - bar:/var/lib/storage

volumes:
  bar:
    driver: rancher-ebs
    driver_opts:
      size: 10
      encrypted: true
      kmsKeyId: <KMS_KEY_ID>
      # Specifying the availability zone is required when using encryption and kmsKeyId
      ec2_az: <AVAILABILITY_ZONE_WHERE_THE_KMS_KEY_IS>
```

#### 举例：基于快照的应用级别的存储卷

在这里例子中，我们将创建一个使用[应用级别的存储卷]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/storage-service/#应用级别)的服务。所有该应用中的服务将共享同一个卷。
该卷将基于一个已有的AWS快照被创建出来。你需要指定快照ID以及该快照所在的可用区。
使用该AWS EBS卷的所有容器将会被调度到同一台主机上。


```yaml
version: '2'
services:
  foo:
    image: busybox
    stdin_open: true
    volumes:
    - bar:/var/lib/storage

volumes:
  bar:
    driver: rancher-ebs
    driver_opts:
      size: 10
      snapshotID: <SNAPSHOT_ID>
      # Specifying the availability zone is required when using snapshotID
      ec2_az: <AVAILABILITY_ZONE_WHERE_THE_SNAPSHOT_IS>
```

#### 举例：基于已有EBS卷的的应用级别的存储卷

在这里例子中，我们将创建一个使用[应用级别的存储卷]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/storage-service/#应用级别)的服务。所有该应用中的服务将共享同一个卷。
你需要指定卷ID以及改卷所在的可用区。
使用该AWS EBS卷的所有容器将会被调度到同一台主机上。


```yaml
version: '2'
services:
  foo:
    image: busybox
    stdin_open: true
    volumes:
    - bar:/var/lib/storage

volumes:
  bar:
    driver: rancher-ebs
    driver_opts:
      size: 10
      volumeID: <VOLUME_ID>
      # Specifying the availability zone is required when using volumeID
      ec2_az: <AVAILABILITY_ZONE_WHERE_THE_VOLUME_IS>
```
