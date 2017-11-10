---
title: FAQS about Rancher Server
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## Rancher Server的常见问题
---

### 我正在运行的Rancher是什么版本的?

Rancher的版本位于UI的页脚的左侧。 如果你点击该版本，你将可以查看其他组件的详细版本。

### 我怎么样在代理服务器后运行Rancher Server?

请参照[在HTTP代理后方启动Rancher Server]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#在http代理后方启动-rancher-server).

<a id="server-logs"></a>

### 我在哪能找到 Rancher Server 容器的详细日志？

运行`docker logs`可以查看在Rancher Server容器的基本日志。要获取更详细的日志，你可以进入到Rancher Server容器内部并查看日志文件。

```bash
# 进入 Rancher　Server　容器内部
$ docker exec -it <container_id> bash

# 跳转到 Cattle 日志所在的目录下
$ cd /var/lib/cattle/logs/
$ cat cattle-debug.log
```

在这个目录里面会出现`cattle-debug.log`和`cattle-error.log`。 如果你长时间使用此Rancher Server，你会发现我们每天都会创建一个新的日志文件。

#### 将Rancher Server的日志复制到主机上。

以下是将Rancher Server日志从容器复制到主机的命令。

```bash
$ docker cp <container_id>:/var/lib/cattle/logs /local/path
```

### 如何导出Rancher Server容器的内部数据库？

你可以通过简单的Docker命令从Rancher Server容器导出数据库。

```
$ docker exec <CONTAINER_ID_OF_SERVER> mysqldump cattle > dump.sql
```

### 如果Rancher Server的IP改变了会怎么样？

如果更改了Rancher Server的IP地址，你需要用新的IP重新关联主机。

在Rancher中，点击**系统管理**->**系统设置**更新 Rancher Server的**主机注册地址**。注意必须包括Rancher Server暴露的端口号。默认情况下我们建议按照安装手册中使用8080端口。

主机注册更新后，进入**基础架构**->**添加主机**->**自定义**。 添加主机的`docker run`命令将会更新。 使用更新的命令，在Rancher Server的所有环境中的所有主机上运行该命令。

### 为什么在日志中看到Go-Machine-Service在不断重新启动？ 我该怎么办？

Go-machine-service是一种通过websocket连接到Rancher API服务器的微服务。如果无法连接，则会重新启动并再次尝试。

如果你运行的是单节点的Rancher Server，它将使用你为主机注册地址来连接到Rancher API服务。 检查从Rancher Sever容器内部是否可以访问主机注册地址。

```bash
$ docker exec -it <rancher-server_container_id> bash
# 在 Rancher-Server 容器内
$ curl -i <Host Registration URL you set in UI>/v1
```
你应该得到一个json响应。 如果认证开启，响应代码应为401。如果认证未打开，则响应代码应为200。

验证Rancher API Server 能够使用这些变量，通过登录go-machine-service容器并使用你提供给容器的参数进行`curl`命令来验证连接:

```bash
$ docker exec -it <go-machine-service_container_id> bash
# 在go-machine-service 容器内
$ curl -i -u '<value of CATTLE_ACCESS_KEY>:<value of CATTLE_SECRET_KEY>' <value of CATTLE_URL>
```

你应该得到一个json响应和200个响应代码。

如果curl命令失败，那么在`go-machine-service`和Rancher API server之间存在连接问题。

如果curl命令没有失败，则问题可能是因为go-machine-service尝试建立websocket连接而不是普通的http连接。 如果在go-machine-service和Rancher API服务器之间有代理或负载平衡，请验证代理是否支持websocket连接。

### Rancher Server在运行中变的极慢，怎么去恢复它？

很可能有一些任务由于某些原因而处于僵死状态，如果你能够用界面查看**系统管理** -> **系统进程**，你将可以看到`Running`中的内容，如果这些任务长时间运行（并且失败），则Rancher会最终使用太多的内存来跟踪任务。这使得Rancher Server处于了内存不足的状态。

为了使服务器变为可响应状态，你需要添加更多内存。通常4GB的内存就够了。

你需要再次运行Rancher Server命令并且添加一个额外的选项`-e JAVA_OPTS="-Xmx4096m"`

```bash
$ docker run -d -p 8080:8080 --restart=unless-stopped -e JAVA_OPTS="-Xmx4096m" rancher/server
```

根据MySQL数据库的设置方式的不同，你可能需要进行升级才能添加该选项。

如果是由于缺少内存而无法看到**系统管理** -> **系统进程**的话，那么在重启Rancher Server之后，已经有了更多的内存。你现在应该可以看到这个页面了，并可以开始对运行时间最长的进程进行故障分析。

###  Rancher Server数据库数据增长太快.

Rancher Server会自动清理几个数据库表，以防止数据库增长太快。如果对你来说这些表没有被及时清理，请使用API来更新清理数据的时间间隔。

在默认情况下，产生在2周以前的`container_event`和`service_event`表中的数据则数据会被删除。在API中的设置是以秒为单位的(`1209600`)。API中的设置为`events.purge.after.seconds`.

默认情况下，`process_instance`表在1天前产生的数据将会被删除，在API中的设置是以秒为单位的(`86400`)。API中的设置为`process_instance.purge.after.seconds`.

为了更新API中的设置，你可以跳转到`http://<rancher-server-ip>:8080/v1/settings`页面， 搜索要更新的设置，点击`links -> self`跳转到你点击的链接去设置，点击侧面的“编辑”更改'值'。 请记住，值是以秒为单位。

<a id="databaselock"></a>

### 为什么Rancher Server升级失败或被冻结？

如果你刚开始运行Rancher并发现它被永久冻结，可能是liquibase数据库上锁了。在启动时，liquibase执行模式迁移。它的竞争条件可能会留下一个锁定条目，这将阻止后续的流程。

如果你刚刚升级，在Rancher　Server日志中，MySQL数据库可能存在尚未释放的日志锁定。

```bash
....liquibase.exception.LockException: Could not acquire change log lock. Currently locked by <container_ID>
```

#### 释放数据库锁

> **注意：** 请不要释放数据库锁，除非有相关日志锁的**异常**。如果是由于数据迁移导致升级时间过长，在这种情况下释放数据库锁，可能会使你遇到其他迁移问题。

如果你已根据升级文档创建了Rancher Server的数据容器，你需要`exec`到`rancher-data`容器中升级`DATABASECHANGELOGLOCK`表并移除锁，如果你没有创建数据容器，你用`exec`到包含有你数据库的容器中。

```bash
$ sudo docker exec -it <container_id> mysql
```

一旦进入到 Mysql 数据库, 你就要访问`cattle`数据库。

```bash
mysql> use cattle;

#检查表中是否有锁
mysql> select * from DATABASECHANGELOGLOCK;

# 更新移除容器的锁
mysql> update DATABASECHANGELOGLOCK set LOCKED="", LOCKGRANTED=null, LOCKEDBY=null where ID=1;


# 检查锁已被删除
mysql> select * from DATABASECHANGELOGLOCK;
+----+--------+-------------+----------+
| ID | LOCKED | LOCKGRANTED | LOCKEDBY |
+----+--------+-------------+----------+
|  1 |        | NULL        | NULL     |
+----+--------+-------------+----------+
1 row in set (0.00 sec)
```
