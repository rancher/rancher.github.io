---
title: Rancher Compose
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## Rancher Compose
---

Rancher Compose是一个多主机版本的Docker Compose。它运行于Rancher UI里属于一个[环境]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/)多个[主机]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/)的[应用]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/stacks/)里。Rancher Compose启动的容器会被部署在满足[调度规则]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/)的同一环境中的任意主机里。如果没有设置调度规则，那么这些服务容器会被调度至最少容器运行的主机上运行。这些被Rancher Compose启动的容器的运行效果是和在UI上启动的效果是一致的.

Rancher Compose工具的工作方式是跟Docker Compose的工作方式是相似的，并且兼容版本V1和V2的 `docker-compose.yml` 文件。为了启用Rancher的特性，你需要额外一份`rancher-compose.yml`文件，这份文件扩展并覆盖了`docker-compose.yml`文件。例如，服务缩放和健康检查这些功能就会在`rancher-compose.yml`中体现。

在阅读这份Rancher Compose文档之前，我们希望你已经懂得 `Docker Compose` 了。如果你还不认识 Docker Compose，请先阅读 [Docker Compose](https://docs.docker.com/compose/)文档。

### 安装

Rancher Compose的可执行文件下载链接可以在UI的右下角中找到，我们为你提供了Windows, Mac 以及 Linux 版本供你使用。

另外，你也可以到[Rancher Compose的发布页](https://github.com/rancher/rancher-compose/releases)找到可执行二进制文件的下载链接。

### 为 Rancher Compose 设置 Rancher Server

为了让Rancher Compose可以在Rancher实例中启动服务，你需要设置一些环境变量或者在Rancher Compose命令中送一些参数。必要的环境变量分别是 `RANCHER_URL`, `RANCHER_ACCESS_KEY`, 以及 `RANCHER_SECRET_KEY`。 access key和secret key是一个环境API Keys, 可以在**API** -> **高级选项**菜单中创建得到。

> **注意：** 默认情况下，在**API**菜单下创建的是账号API Keys, 所以你需要在**高级选项**中创建环境API Keys.

```bash
# Set the url that Rancher is on
$ export RANCHER_URL=http://server_ip:8080/
# Set the access key, i.e. username
$ export RANCHER_ACCESS_KEY=<username_of_environment_api_key>
# Set the secret key, i.e. password
$ export RANCHER_SECRET_KEY=<password_of_environment_api_key>
```

如果你不想设置环境变量，那么你需要在Rancher Compose 命令中手动送入这些变量：

```bash
$ rancher-compose --url http://server_ip:8080 --access-key <username_of_environment_api_key> --secret-key <password_of_environment_api_key> up
```

<br>

现在你可以使用Rancher Compose 配合`docker-compose.yml`文件来[启动服务]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#使用-rancher-compose-添加服务)了。这些服务会在环境API keys对应的[环境]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/)中启动服务的。

就像Docker Compose，你可以在命令后面加上服务名称来选择启动全部或者仅启动指定某些`docker-compose.yml`中服务

```baseurl
$ rancher-compose up servicename1 servicename2
$ rancher-compose stop servicename2
```

### 调试 Rancher Compose

你可以设置环境变量`RANCHER_CLIENT_DEBUG`的值为`true`来让Rancher Compose输出所有被执行的CLI命令。

```bash
# Print verbose messages for all CLI calls
$ export RANCHER_CLIENT_DEBUG=true
```

<br>

如果你不需要所有的 CLI 命令信息，你可以在命令后上`--debug`来指定输出哪些可视化CLI命令。

```bash
$ rancher-compose --debug up -d
```

### 删除服务或容器

在缺省情况下，Rancher Compose不会删除任何服务或者容器。这意味着如果你在一行命令里执行两次 `up` 命令，那么第二个 `up` 命令不会起任何作用。这是因为第一个 `up` 命令会创建出所有东西后让他们自己运行。即使你没有在 `up` 中使用 `-d` 参数，Rancher Compose 也不会删除你任何服务。为了删除服务，你只能使用 `rm` 命令。

### 构建

构建docker镜像可以有两种方法。第一种方法是通过给build命令一个git或者http URL参数来利用远程资源构建，另一种方法则是让 build 利用本地目录，那么会上传构建上下文到 S3 并在需要时在各个节点执行

为了可以基于S3来创建，你需要[设置 AWS 认证](https://github.com/aws/aws-sdk-go/#configuring-credentials)。我们提供了一个说明怎样利用在Rancher Compose 里使用S3[详细例子]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/rancher-compose/build/)供你参考
