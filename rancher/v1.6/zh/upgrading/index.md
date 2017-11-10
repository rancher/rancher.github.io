---
title: Upgrading Rancher
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## 升级Rancher Server
---

> **注意：** 如果你正准备升级到v1.6.x，请阅读我们相关的版本注解[v1.6.0](https://github.com/rancher/rancher/releases/tag/v1.6.0)。这里面有相关升级需要的注意事项。根据你安装Rancher Server方式的不同，你的升级步骤可能不一样。

* [Rancher服务 - 单个容器(non-HA)](#single-container)
* [Rancher服务 - 单个容器(non-HA) - 外部数据库](#single-container-external-database)
* [Rancher服务 - 单个容器(non-HA) - 绑定挂载MySQL卷](#single-container-bind-mount)
* [Rancher服务 - 多活HA模式](#multi-nodes)
* [Rancher服务 - 无因特网访问](#没有互联网访问的Rancher Server)

> **注意：** 如果你在原始的Rancher服务中设置了任何的环境变量或者传了一个[ldap证书]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#tls认证使用adopenldap)，则需要在任何新的命令中添加这些环境变量或者证书。

### Rancher Server标签

Rancher Server当前版本中有2个不同的标签。对于每一个主要的release标签，我们都会提供对应版本的文档。

* `rancher/server:latest` 此标签是我们的最新一次开发的构建版本。这些构建已经被我们的CI框架自动验证测试。但这些release并不代表可以在生产环境部署。
* `rancher/server:stable` 此标签是我们最新一个稳定的release构建。这个标签代表我们推荐在生产环境中使用的版本。

请不要使用任何带有 `rc{n}` 前缀的release。这些构建都是Rancher团队的测试构建。

### 基础设施服务

当Rancher Server升级之后，你的[基础设施服务]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/)可能也需要升级。我们建议在升级Rancher Server之后检查一下基础设施服务，看是否有可升级的。如果有可升级的，那么按照下面的顺序一个个升级：

1. `network-policy-manager`  (如果安装了，这是一个可选的Rancher组件)
2. `network-services`
3. `ipsec`
4. 剩余的基础设施服务

> **注意：** 确保在升级一个基础设施服务之前，它已经完成了之前的升级，这个是很重要的。升级完成之后，在栈菜单中选择“完成升级”，然后继续。

有时候，Rancher会要求你升级其中的一个或者多个基础设施服务，以便Rancher继续工作。你可以通过API设置来修改升级策略，以防止自动升级，但不推荐。

_从v1.6.1开始_

我们引入了一个API设置，可以允许你控制基础设施服务的升级策略。`upgrade.manager`设置接受3个值。

* `mandatory` - 这个是默认的值。该值只会自动升级必需要升级的基础设施服务，以使Rancher Server正常工作。
* `all` - 任何可用于基础设施服务的更新模版都将会自动升级。如果基础设施服务具有新的模板版本，但是基础设施服务的默认版本仍然较旧，则不会自动升级到最新版本。
* `none` - 没有基础设施服务将会升级。 **警告： 这可能导致你的Rancher Server停止运行，因为它可能阻止了必要的基础设施服务升级**

### Rancher Agents

每个Rancher agent版本都对应于一个固定的Rancher Server版本。如果升级了Rancher服务并且Rancher代理也需要升级，我们将自动将代理升级到最新版本。
<a id="single-container"></a>

### 单独升级一个容器(non-HA)

如果你**没有**使用外部DB或绑定的MySQL卷来启动Rancher Server，则Rancher Server数据库位于Rancher Server容器中。我们将使用正在运行的Rancher Server容器来创建一个数据容器，该数据容器将用于使用`--volumes-from`启动新的Rancher Server容器。或者，你可以将数据库从容器中复制到主机上的目录并绑定挂载数据库。

1. 停掉容器

   ```bash
   $ docker stop <container_name_of_original_server>
   ```

2. 创建一个`rancher-data`容器。注意：如果你已经升级了并且已经有了一个`rancher-data`容器，该步可以跳过。

   ```bash
   $ docker create --volumes-from <container_name_of_original_server> \
    --name rancher-data rancher/server:<tag_of_previous_rancher_server>
   ```

3. 拉取Rancher Server的最新镜像。注意：如果你跳过该步并尝试运行`latest`镜像，这将不会自动拉取最新的镜像。

   ```bash
   $ docker pull rancher/server:latest
   ```

4. 用`rancher-data`中的数据库启动一个Rancher Server容器。启动之后，Rancher中的任何变化将会被保存在`rancher-data`容器中。如果你在服务器中看到有关日志锁的异常，请参考[如何修复日志锁]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/faqs/server/#databaselock)。

    > **注意：** 根据你Rancher Server时间的长短，某些数据库迁移可能需要比预期的更长的时间。 升级过程中请不要停止升级，因为下次升级时会遇到数据库迁移错误。
   ```bash
   $ docker run -d --volumes-from rancher-data --restart=unless-stopped \
     -p 8080:8080 rancher/server:latest
   ```
    <br>

5. 删掉旧的Rancher Server容器。注意：如果你只是停止了容器，当你使用`--restart=always`，并且机器重启之后，该容器将会重启。我们建议使用`--restart=unless-stopped`并且当升级成功之后删除它。
<a id="single-container-external-database"></a>

### 单独升级一个容器(non-HA) - 外部数据库

如果你使用外部数据库启动Rancher Server，你可以先停止原来的Rancher Server容器，并使用相同的[使用外部数据库的安装说明]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#single-container-external-database)。升级你的Rancher Server之前，建议你备份外部数据库。 新服务器启动并运行后，可以删除旧的Rancher Server容器。

<a id="single-container-bind-mount"></a>

### 单独升级一个容器(non-HA) - 绑定挂载的MySQL卷

1. 停掉正在运行的Rancher Server容器

   ```bash
   $ docker stop <container_name_of_original_server>
   ```

2. 将数据库文件从服务器容器中复制出来。注意：如果已经将数据库存储在主机上，则可以跳过此步骤。另外，如果将DB复制出来，根据Docker复制出来的方式，它将会在／`<path>`/mysql/里面。当挂载到容器中时，一定要考虑到这一点。如果你启动的时候绑定挂载，则不需要mysql／

   ```bash
   $ docker cp <container_name_of_original_server>:/var/lib/mysql <path on host>
   ```

3. 现在为文件夹设置UID/GID，以便容器内的mysql用户拥有正确的mysql mount的所有权。

   ```bash
   $ sudo chown -R 102:105 <path on host>
   ```

4. 启动新的服务器容器

   ```bash
   $ docker run -d -v <path_on_host>:/var/lib/mysql -p 8080:8080 \
     --restart=unless-stopped rancher/server:latest
   ```
  <br>

   > **注意：** 如果已经从先前的容器中复制了数据库，那么在主机路径的末尾必需加上'/'，否则，目录的位置会出错。

5. 删掉旧的Rancher Server容器。注意：如果你只是停止了容器，当你使用`--restart=always`，并且机器重启之后，该容器将会重启。我们建议使用`--restart=unless-stopped`并且当升级成功之后删除它。

<a id="multi-nodes"></a>

### 升级HA架构

当以[高可用(HA)]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#multi-nodes)的方式启动Rancher Server，新的Rancher HA设置将继续使用用于安装原始HA设置的外部数据库。

> **注意：** 当升级HA架构的Rancher Server时，Rancher Server在升级过程中将会停止服务。

1. 升级你的Rancher Server之前，建议你备份外部数据库。

2. 在HA架构中的每台Server节点上，停止并删除正在运行的Rancher Server容器，然后按照相同的[安装HA模式的Rancher Server说明]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#multi-nodes)来启动一个新的Rancher服务容器，但是使用的是一个新的Rancher Server镜像版本。

   ```bash
   # On all nodes, stop all Rancher Server containers
   $ docker stop <container_name_of_original_server>
   # Execute the scrip with the latest rancher/server version
   $ docker run -d --restart=unless-stopped -p 8080:8080 -p 9345:9345 rancher/server --db-host myhost.example.com --db-port 3306 --db-user username --db-pass password --db-name cattle --advertise-address <IP_of_the_Node>
   ```
   <br>
   > **注意：** 当你正在一个运行[Rancher Server 1.2之前版本的HA]({{site.baseurl}}/rancher/v1.1/en/installing-rancher/installing-server/multi-nodes/)时，你需要删除所有的正在运行的Rancher HA容器。`$ sudo docker rm -f $(sudo docker ps -a | grep rancher | awk {'print $1'})`

### 没有互联网访问的Rancher Server

在没有互联网的情况下，为了能够升级成功，用户需要下载最新的[基础设施服务]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/)镜像 。
