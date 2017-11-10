---
title: Adding External Service
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## 添加外部服务
---

你可能会有一些部署在Rancher之外的服务想要整合进Rancher。你可以通过添加一个外部服务的功能将它添加到Rancher集群中。

### 在UI上添加外部服务

在你的应用上，你可以通过 **添加服务** 旁边的下拉菜单按钮添加外部服务。选择 **外部服务**。 或者你在应用层级的页面查看你的应用，同样存在相同的 **添加服务** 下拉菜单。

你将需要提供一个外部服务的 **名称**，如果需要的话，提供这个服务的 **描述**。

添加你想要的目标。你可以选择外部的IP或者域名。最后点击 **添加**。

外部服务的IP和域名会在服务中呈现。和Rancher的服务一样，你需要去启动一个外部服务。

#### 添加/删除外部服务目标

在任何时候你都可以编辑你外部服务中的服务目标。在外部服务的下拉菜单中点击 **编辑**，你可以添加或者移除目标。

### 使用Rancher Compose添加外部服务

在外部服务中，你可以设置外部IP地址 **或者** 域名。`rancher/external-service` 并不是一个真实的镜像，但在 `docker-compose.yml` 中是必要的。Rancher不会为外部服务创建容器。

#### `docker-compose.yml`例子

```yaml
version: '2'
services:
  db:
    image: rancher/external-service
  redis:
    image: redis
```

#### `rancher-compose.yml` 使用外部IP的例子

```yaml
version: '2'
services:
  db:
    external_ips:
    - 1.1.1.1
    - 2.2.2.2

  # Override any service to become an external service
  redis:
    image: redis
    external_ips:
    - 1.1.1.1
    - 2.2.2.2
```

#### `rancher-compose.yml` 使用域名的例子

```yaml
version: '2'
services:
  db:
    hostname: example.com
```
