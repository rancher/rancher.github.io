---
title: Rancher CLI Commands and Options
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## 命令和选项
---

Rancher CLI 可以用于操作Rancher中的环境、主机、应用、服务和容器。

### Rancher CLI 命令

名字 | 描述
----|-----
`catalog`      |     [操作应用商店](#rancher-catalog-说明)
`config`     |       [设置客户端配置](#rancher-config-说明)
`docker`      |        [在主机上运行docker命令](#rancher-docker-说明)
`environment`, `env`  | [操作环境](#rancher-environment-说明)
`events`, `event`   |        [展示资源变更事件](#rancher-events-说明)
`exec`       |       [在容器上运行命令](#rancher-exec-说明)
`export`     |      [将应用的yml配置文件导出为tar或者本地文件](#rancher-export-说明)
`hosts`, `host`    |   [操作主机](#rancher-hosts-说明)
`logs`           |   [抓取容器的日志](#rancher-logs-说明)
`ps`            |    [展示服务／容器](#rancher-ps-说明)
`restart`       |   [重启服务／容器](#rancher-restart-说明)
`rm`          |      [删除服务、容器、应用、主机、卷](#rancher-rm-说明)
`run`         |     [运行服务](#rancher-run-说明)
`scale`       |      [设置一个服务运行的容器数量](#rancher-scale-说明)
`ssh`         |      [SSH到主机](#rancher-ssh-说明)
`stacks`, `stack`  |   [操作应用](#rancher-stacks-说明)
`start`, `activate`  | [启动服务、容器、主机、应用](#rancher-startactivate-说明)
`stop`, `deactivate` | [停止服务、容器、主机、应用](#rancher-stopdeactivate-说明)
`up`           |     [启动所有服务](#rancher-up-说明)
`volumes`, `volume` |   [操作卷](#rancher-volumes-说明)
`inspect`      |     [查看服务、容器、主机、环境、应用、卷的详情](#rancher-inspect-说明)
`wait`        |      [等待服务、容器、主机、应用栈、机器、项目模版](#rancher-wait-说明)
`help`        |    展示命令列表或者某个命令的说明

<br>

### Rancher CLI 全局参数

当使用`rancher`时，可以使用不同的全局参数。

名字 | 描述
--- | ---
`--debug`         |                  调试日志
`--config` value, `-c` value    |    客户端配置文件 (缺省为 ${HOME}/.rancher/cli.json) [$RANCHER_CLIENT_CONFIG]
`--environment` value, `--env` value | 环境名字或ID [$RANCHER_ENVIRONMENT]
`--url` value                    |   指定Rancher API接口链接 [$RANCHER_URL]
`--access-key` value             |   指定Rancher API访问密钥 [$RANCHER_ACCESS_KEY]
`--secret-key` value             |   指定Rancher API安全密钥 [$RANCHER_SECRET_KEY]
`--host` value                   |   执行docker命令的主机[$RANCHER_DOCKER_HOST]
`--wait`, `-w`                   |   等待资源到达最终状态
`--wait-timeout` value           |   等待的超时时间(缺省值: 600秒)
`--wait-state` value             |   等待的状态(正常, 健康等)
`--help`, `-h`                   |     展示帮助说明
`--version`, `-v`                |     打印版本信息

<br>

#### 等待资源

全局的选项如`--wait` 或 `-w` 可以用于需逐渐到达最终状态的命令。当编辑Rancher命令的脚本时，使用`-w`选项可以让脚本等待资源就绪后再执行下一个命令。等待的超时时间默认时十分钟，但如果你想要改变超时时间，可以使用`--wait-timeout`选项。你还可以使用`--wait-state`选项来指定资源必须到达某个特定状态后，命令才结束返回。

### Rancher Catalog 说明

`rancher catalog` 命令提供了操作应用商店模版的相关操作。

#### 选项

名字 | 描述
----|-----
`--quiet`, `-q`   |  只展示IDs
`--format` value  | `json`格式或自定义格式: {% raw %}'{{.ID}} {{.Template.Id}}'{% endraw %}
`--system`, `-s`  |  展示系统模版

#### 子命令

名字 | 描述
----|-----
`ls` | 列出应用商店模版
`install` |  安装应用商店模版
`help`    |  展示命令列表或某个命令的说明

#### Rancher Catalog Ls

`rancher catalog ls`  命令列出环境下的所有模版。

##### 选项

名字 | 描述
-----|-----
`--quiet`, `-q` |     只展示IDs
`--format` value  | `json`格式或自定义格式: {% raw %}'{{.ID}} {{.Template.Id}}'{% endraw %}
`--system`, `-s` |   展示系统模版

<br>

```bash
# 列出所有应用商店模版
$ rancher catalog ls
# 列出运行kubernetes环境中的所有应用商店模版
$ rancher --env k8sEnv catalog ls
# 列出系统应用商店模版
$ rancher catalog ls --system
```

#### Rancher Catalog install

`rancher catalog install`命令在你的环境中安装应用商店模版。

##### 选项

名字 | 描述
----|-----
`-answers` value, `-a` value |  模版的参数文件。格式应为`yaml`或者`json`，并且确保文件有正确的后缀名。
`--name` value              |  创建的应用的名字
`--system`, `-s`              |  安装一个系统模版

<br>

```bash
# 安装一个应用模版
$ rancher catalog install library/route53:v0.6.0-rancher1 --name route53
# 安装一个应用模版并将其标识为系统模版
$ rancher catalog install library/route53:v0.6.0-rancher1 --name route53 --system
```

### Rancher Config 说明

`rancher config` 命令用于设置你的[Rancher Server的配置]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cli/#configuring-the-rancher-command-line-interface).

```bash
$ rancher config
URL []: http://<server_ip>:8080
Access Key []: <accessKey_of_account_api_key>
Secret Key []:  <secretKey_of_account_api_key>
# 如果超过一个环境，你需要指定一个环境
Environments:
[1] Default(1a5)
[2] k8s(1a10)
Select: 1
INFO[0017] Saving config to /Users/<username>/.rancher/cli.json
```

#### 选项

名字 | 描述
----|-----
`--print` | `打印当前的配置`

如果你想要打印当前配置，可以使用`----print`。

```bash
# 显示当前的Rancher的配置
$ rancher config --print
```

### Rancher Docker 说明

`rancher docker` 命令允许你在某台机器上运行任何Docker命令。 使用 `$RANCHER_DOCKER_HOST` 来运行Docker命令. 使用 `--host <hostID>` 或者 `--host <hostName>` 来选择其他主机。


```bash
$ rancher --host 1h1 docker ps
```

#### 选项

名字 | 描述
----|-----
`--help-docker` |  显示 `docker --help`

<br>

> **注意：** 如果环境变量`RANCHER_DOCKER_HOST`没有设置，你需要通过`--host`指定运行Docker命令的主机。

### Rancher Environment 说明

`rancher environment`命令让你可以操作环境。如果你使用账户API key, 你可以创建和更新环境。如果你使用环境API key，你不能创建和更新其他环境，只能看到你当前的环境。

#### 选项

名字 | 描述
----|-----
`--all`, `-a`    |   显示暂停／无效和最近移除的资源
`--quiet`, `-q`  |  只显示IDs
`--format` value | `json` 或者自定义格式: {% raw %}'{{.ID}} {{.Environment.Name}}'{% endraw %}

#### 子命令

名字 | 描述
----|-----
`ls`                    | 列出所有环境
`create`                | 创建一个环境
`templates`, `template` | 操作环境模版
`rm`                    | 删除环境
`deactivate`            | 停用环境
`activate`              | 启用环境
`help`                  | 显示命令列表或者某个命令的帮助


#### Rancher Env Ls

`rancher env ls`命令显示Rancher中的所有环境。

##### 选项

名字 | 描述
----|-----
`--all`, `-a`    |   显示暂停／无效和最近移除的资源
   `--quiet`, `-q` |     只显示IDs
   `--format` value  | `json` 或者自定义格式: {% raw %}'{{.ID}} {{.Environment.Name}}'{% endraw %}

<br>

```bash
$ rancher env ls
ID        NAME      ORCHESTRATION   STATE     CREATED
1a5       Default   Cattle          active    2016-08-15T19:20:46Z
1a6       k8sEnv    Kubernetes      active    2016-08-17T03:25:04Z
# 只列出环境ID
$ rancher env ls -q
1a5
1a6
```

#### Rancher Env Create

`rancher env create`命令用于创建一个新的环境，环境的缺省的编排引擎使用cattle。

##### 选项

名字 | 描述
---|----
`--template` value, `-t` value | 创建环境的模版（缺省: "Cattle"）

<br>

```bash
# 创建一个环境
$ rancher env create newCattleEnv
# 创建一个kubernetes 环境
$ rancher env create -t kubernetes newk8sEnv
```

#### Rancher Env Template

`rancher env template` 命令用于导出或者导入环境模版。

##### 选项

名字 | 描述
---|----
`--all`, `-a`    |   显示暂停／无效和最近移除的资源
`--quiet`, `-q`  |  只显示IDs
`--format` value | `json` 或者自定义格式: {% raw %}'{{.ID}} {{.ProjectTemplate.Name}}'{% endraw %}

##### 子命令

名字 | 描述
---|----
`export` | 将一个环境模版导出到标准输出
`import` | 从一个文件中导入环境模版
`help`    | 显示命令列表或者某个命令的帮助

#### Rancher Env Rm

`rancher env rm`命令用于删除环境。可以使用环境名字或者ID来删除。
```bash
# 使用名字删除环境
$ rancher env rm newk8sEnv
# 使用ID删除环境
$ rancher env rm 1a20
```

#### Rancher Env Deactivate

`rancher env deactivate`命令停用一个环境。用环境名字或者ID来指定停用的环境。
#### Rancher Env Activate

`rancher env activate` 命令启用一个环境。用环境名字或者ID来指定启用的环境。

### Rancher Events 说明

`rancher events` 命令列出Rancher Server中所有出现的事件。

#### 选项

名字 | 描述
---|----
`--format` value  |  `json` 或者自定义格式: {% raw %}'{{.Name}} {{.Data.resource.kind}}'{% endraw %}
`--reconnect`, `-r` | 出错时重连接


### Rancher Exec 说明

`rancher exec` 命令可以用于执行进入在Rancher的容器。 用户不需要知道容器在哪个宿主机，只需要知道Rancher中的容器ID（如 `1i1`, `1i788`）。

```bash
# 执行进入一个容器
$ rancher exec -i -t 1i10
```

#### 选项

名字 | 描述
----|-----
`--help-docker` |  显示`docker exec --help`

在`rancher exec` 命令找到容器后，它在指定的主机和容器执行 `docker exec`命令。 可以通过使用`--help-docker`来显示 `docker exec`的说明。

```bash
# 显示docker exec --help
$ rancher exec --help-docker
```

### Rancher Export 说明

`rancher export` 命令将一个应用的 `docker-compose.yml` 和 `rancher-compose.yml`文件导出为tar包。

#### 选项

名字 | 描述
---|----
`--file` value, `-f` value |  输出到一个指定文件中。使用 - 可以输出到标准输出流
`--system`, `-s`   |        是否导出整个环境，包括系统应用。

<br>

```bash
# 将一个应用中所有服务的docker-compose.yml和 rancher-compose.yml导出为tar包。
$ rancher export mystack > files.tar
$ rancher export -f files.tar mystack
```

### Rancher hosts 说明

`rancher hosts`命令可用于操作环境中的主机。

#### 选项

名字 | 描述
----|-----
  `--all`, `-a`    |    显示暂停／无效和最近移除的资源
  `--quiet`, `-q`  |   只显示IDs
  `--format` value | `json` 或者自定义格式: {% raw %}'{{.ID}} {{.Host.Hostname}}'{% endraw %}

#### 子命令

名字 | 描述
----|-----
`ls`    |  显示主机列表
`create` | 创建一个主机

#### Rancher Hosts Ls

`rancher hosts ls` 命令列出所有主机。

##### 选项

名字 | 描述
----|-----
`--all`, `-a` |       显示暂停／无效和最近移除的资源
    `--quiet`, `-q` |     只显示IDs
   `--format` value  | `json` 或者自定义格式: {% raw %}'{{.ID}} {{.Host.Hostname}}'{% endraw %}

<br>

```bash
$ rancher hosts ls
ID        HOSTNAME      STATE     IP
1h1       host-1        active    111.222.333.444
1h2       host-3        active    111.222.333.555
1h3       host-2        active    111.222.333.666
1h4       host-4        active    111.222.333.777
1h5       host-5        active    111.222.333.888
1h6       host-6        active    111.222.333.999
# 只显示主机ID
$ rancher hosts ls -q
1h1
1h2
1h3
1h4
1h5
1h6
```

#### Rancher Hosts Create

`rancher hosts create`命令用于创建 [主机]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/). 当创建主机时，需要调用Docker Machine命令，因此需要提供该命令所需要的选项。

### Rancher Logs 说明

`rancher logs` 用于抓取指定容器名或容器ID的容器的日志。

#### 选项

名字 | 描述
----|-----
`--service`, `-s`    | 显示服务日志
`--sub-log`       |  显示服务副日志
`--follow`, `-f` |     设置日志继续输出
`--tail` value  |    显示日志的最后的几行 (缺省: 100)
`--since` value  |   显示自某个时间戳后的日志
`--timestamps`, `-t`  | 显示时间戳

<br>

```bash
# 获取某个容器ID对应容器的最后50行日志
$ rancher logs --tail 50 <ID>
# 使用容器名来查看日志
$ rancher logs -f <stackName>/<serviceName>
```

### Rancher ps 说明

`rancher ps` 命令显示Rancher中的所有服务或者容器。如果不附加任何选项，该命令会返回环境中所有的服务。

#### 选项

名字 | 描述
---|----
`--all`, `-a`        |  显示暂停／无效和最近移除的资源
`--system`, `-s`     |  显示系统资源
`--containers`, `-c` |  显示容器
`--quiet`, `-q` |		只显示IDs
`--format` value |	`json` 或者自定义格式: {% raw %}'{{.Service.Id}} {{.Service.Name}} {{.Service.LaunchConfig.ImageUuid}}'{% endraw %}

<br>

```bash
# 列出所有服务
$ rancher ps
ID        TYPE      NAME           IMAGE     STATE        SCALE     ENDPOINTS   DETAIL
1s1       service   Default/blog   ghost     activating   3                     Waiting for [instance:Default_blog_3]. Instance status: Storage : Downloading
# 列出所有容器
$ rancher ps -c
ID        NAME             IMAGE                           STATE     HOST      DETAIL
1i1       Default_blog_1   ghost                           running   1h1
1i2       Default_blog_2   ghost                           running   1h2
1i3       Default_blog_3   ghost                           running   1h3
```

`detail` 一列提供了服务的当前状态。

### Rancher restart 说明

`rancher restart`可以用于重启任何主机、服务和容器。

#### 选项

名字 | 描述
---|----
`--type` value	| 指定重启的类型 (服务, 容器)
`--batch-size` value |	一次中重启的容器数量 (缺省值: 1)
`--interval` value |	两次重启的间隔时间，单位ms (缺省值: 1000)

<br>

```bash
# 通过服务、容器、主机的ID重启
$ rancher restart <ID>
# 通过服务、容器、主机的名字重启
$ rancher restart <stackName>/<serviceName>
```

<br>

> **注意：** 服务里中需要包含了应用的名字，以保证指定了正确的服务。

### Rancher rm 说明

`rancher rm` 命令用于删除资源，比如主机、应用栈、服务、容器或者卷。

#### 选项

名字 | 描述
---|----
`--type` value	| 指定删除的特定类型
`--stop`, `-s`  |  在删除前首先暂停资源

<br>

```bash
$ rancher rm <ID>
```

### Rancher run 说明

`run` 命令以1个容器的规模来部署一个服务。当创建服务时，如果想将其置于某个应用栈中， 需要提供`--name`和`stackName/serviceName`。如果`--name` 没有提供，那么新建的服务的名字是Docker提供的容器名，且处于 `Default` 应用中。

```bash
$ rancher run --name App2/app nginx
# CLI返回新建服务的ID
1s3
$ rancher -i -t --name serviceA ubuntu:14.04.3
1s4
```
如果要在主机上公开一个端口，那么该主机的端口必须可用。Rancher会自动调度容器到端口可用的主机上。

```bash
$ rancher -p 2368:2368 --name blog ghost
1s5
```

### Rancher scale 说明

当你使用`rancher run`创建一个服务时，服务的规模缺省是1。可以使用`rancher scale`命令来扩容某个服务。可以通过名字或者ID来指定服务。

```bash
$ rancher scale <stackName>/<serviceName>=5 <serviceID>=3
```

### Rancher ssh 说明

`rancher ssh` 用于ssh到UI创建的某个主机中。它无法ssh通过[自定义]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/) 命令添加的主机。

```bash
$ rancher ssh <hostID>
```

### Rancher stacks 说明

`rancher stacks`命令可以操作环境中的应用。

#### 选项

名字 | 描述
----|-----
`--system`, `-s`  |  显示系统资源
 `--quiet`, `-q` |     只显示ID
   `--format` value  | `json` 或者自定义格式: {% raw %}'{{.ID}} {{.Stack.Name}}'{% endraw %}

#### 命令

名字 | 描述
----|-----
`ls` |     列出应用
`create` |   创建一个应用

#### Rancher Stacks Ls

`rancher stacks ls` 命令列出指定环境中的应用。

##### 选项

名字 | 描述
----|-----
`--system`, `-s` |    显示系统资源
`--quiet`, `-q`     | 只显示IDs
`--format` value | `json` 或者自定义格式: {% raw %}'{{.ID}} {{.Stack.Name}}'{% endraw %}

<br>

```bash
#列出所有应用栈
$ rancher stacks ls
ID        NAME        STATE      CATALOG                           SYSTEM    DETAIL
1e1       zookeeper   healthy    catalog://community:zookeeper:1   false
1e2       Default     degraded                                     false
1e3       App1        healthy                                      false
# 只列出应用栈IDs
$ rancher stacks ls -q
1e1
1e2
1e3
```

#### Rancher Stacks Create

`rancher stacks create` 命令用于创建新的应用。应用可以为空的或者从`docker-compose.yml` 和 `rancher-compose.yml`文件中创建。

##### 选项

名字 | 描述
----|-----
`--start`                     |       在创建后启动应用
`--system`, `-s`              |       创建一个系统应用
`--empty`, `-e`               |       创建一个空的应用
`--quiet`, `-q`               |        只展示IDs
`--docker-compose` value, `-f` value  |  Docker Compose 文件 (缺省: "docker-compose.yml")
`--rancher-compose` value, `-r` value |  Rancher Compose 文件 (缺省: "rancher-compose.yml")

<br>

```bash
# 创建一个空的应用
$ rancher stacks create NewStack -e
# 从一个docker-compose和rancher-compose文件创建应用
# 以及在创建后运行应用
$ rancher stacks create NewStack -f dc.yml -r rc.yml --start
```

### Rancher start/activate 说明

`rancher start` 或 `rancher activate` 命令启动指定的资源类型，如主机、服务或容器。

#### 选项

名字 | 描述
---|----
`--type` value	| 启动指定的类型 (服务, 容器, 主机, 应用)

<br>

```bash
# 用资源ID来启动
$ rancher start <ID>
# 用资源名字来启动
$ rancher start <stackName>/<serviceName>
```

<br>

> **注意：** 为了保证指定了正确的服务，服务名中需要包含应用的名字。

### Rancher stop/deactivate 说明

`rancher stop` 或 `rancher deactivate` 命令用于停止指定的资源类型，如主机、服务和容器。

#### 选项

名字 | 描述
---|----
`--type` value	| 停止指定的资源类型 (服务, 容器, 主机, 应用)

<br>

```bash
# 用ID来停止
$ rancher stop <ID>
# 用名字来停止
$ rancher stop <stackName>/<serviceName>
```

<br>

> **注意：** 为了保证指定了正确的服务，服务名中需要包含应用的名字。

### Rancher up 说明

`rancher up`命令类似于 Docker Compose的`up` 命令。

#### 选项

名字 | 描述
---|----
`--pull`, `-p` |                      在升级前在所有主机上先拉取镜像
`-d`                             |    不阻塞和记录日志
`--upgrade`, `-u`, `--recreate` |      如果服务发生变更则升级
`--force-upgrade`, `--force-recreate` |  不管服务有无变更，都进行升级
`--confirm-upgrade`, `-c`    |         确认升级成功和删除旧版本的容器
`--rollback`, `-r`            |        回滚到之前部署的版本
`--batch-size` value          |       一次升级的容器数量 (缺省: 2)
`--interval` value            |       更新的间隔，单位毫秒 (缺省: 1000)
`--rancher-file` value        |       指定一个新的Rancher compose文件 (缺省: rancher-compose.yml)
`--env-file` value, `-e` value     |    指定一个包含了环境变变量的文件。格式应为`yaml`或者`json`，并且确保文件有正确的后缀名。
`--file` value, `-f` value       |      指定一个或多个新的compose文件 (缺省: docker-compose.yml) [$COMPOSE_FILE]
`--stack` value, `-s` value       |     指定一个新的项目名字(缺省: 目录名)


```bash
# 在末尾还上 -d，防止阻塞和记录日志
$ rancher up -s <stackName> -d
```

### Rancher volumes 说明

`rancher volumes` 命令用于操作卷。

#### 选项

名字 | 描述
---|----
`--all`, `-a`    |   显示暂停／无效和最近移除的资源
`--quiet`, `-q`  |  只显示IDs
`--format` value | `json` 或者自定义格式: {% raw %}'{{.ID}} {{.Volume.Name}}'{% endraw %}

#### 命令

名字 | 描述
---|----
  `ls`  |     列出卷
  `rm`   |   删除一个卷
  `create` | 创建一个卷

#### Rancher Volume LS

`rancher volume ls`命令列出环境中的所有卷。

##### 选项

名字 | 描述
---|----
`--all`, `-a`    |   显示暂停／无效和最近移除的资源
`--quiet`, `-q`  |  只显示IDs
`--format` value | `json` 或者自定义格式: {% raw %}'{{.ID}} {{.Volume.Name}}'{% endraw %}

<br>

```bash
$ rancher volumes ls
ID        NAME                       STATE      DRIVER        DETAIL
1v1                                  active
1v2                                  active
1v3                                  detached
1v4                                  active
1v5                                  detached
1v6                                  detached
1v7       rancher-agent-state        active     local
```

#### Rancher Volume Rm

`rancher volume rm` 命令用于删除卷。

```bash
$ rancher volumes rm <VOLUME_ID>
```

#### Rancher Volume Create

`rancher volume create` 用于创建卷。

##### 选项

名字 | 描述
---|----
`--driver` value |  指定卷驱动
`--opt` value    |  设置驱动特定的 key/value 选项

 <br>

```bash
# 使用 Rancher NFS 驱动创建新的卷
$ rancher volume create NewVolume --driver rancher-nfs
```

### Rancher inspect 说明

`rancher inspect` 用于查看资源的详情。

#### 选项

名字 | 描述
---|----
`--type` value  |  查看指定的类型 (服务, 容器, 主机)
`--links`       |  在资源详情中包含操作和链接的URL
`--format` value  | `json` 或者自定义格式: {% raw %}'{{.kind}}'{% endraw %} (默认: "json")

<br>

```bash
# 用ID来查看详情
$ rancher inspect <ID>
# 用名字来查看详情
$ rancher inspect <stackName>/<serviceName>
```

<br>

> **注意：** 为了保证指定了正确的服务，服务名中需要包含应用的名字。

### Rancher wait 说明

`rancher wait` 命令用于等待资源完成操作。 它对自动化Rancher命令十分有用，可以在脚本中用于等待某个资源就绪后再执行更多操作。

```bash
$ rancher start 1i1
$ rancher wait 1i1
```
