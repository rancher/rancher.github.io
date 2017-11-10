---
title: Upgrading using Rancher Compose
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## 升级服务
---

在部署[服务]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/)之后, 你可能想要通过修改服务来升级应用。例如，镜像已经被更新了，你想要部署服务的新版本。由于Docker容器是不可变的，为了修改服务，你需要销毁旧的容器并部署新的容器。Rancher提供了两种升级服务的方法。推荐的方式是[服务内升级](#服务内升级)，这种方式会停掉旧的容器并且在这个服务内启动新的容器。 Rancher[UI](#upgrading-services-in-the-ui)仅支持服务内升级。你也可以通过[Rancher Compose命令行](#通过rancher-compose命令行进行服务升级)进行服务内升级。 另一种升级方式为[替换式升级](#替换式升级)。这种升级方式会删除旧的服务并创建一个新的服务，只有通过[Rancher Compose命令行](#通过rancher-compose命令行进行服务升级)才能进行替换式升级。

> **注意：** 如果你是想对你的服务进行扩容，你可以修改服务页面的数量参数，或者也可以用过Rancher Compose命令行来进行服务扩容。 `rancher-compose scale <服务名>=<新的容器数量>`.

### 服务内升级

#### 通过UI进行升级

任何服务都可以通过UI来进行升级。和[部署服务]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/)类似，你之前选择的全部Docker参数都会被保留，你可以修改这些参数的值。额外还有一些升级专用的选项：

* **批量大小**：服务中的容器升级会被分成几批，批量大小代表每次你想要停掉的旧容器数量和启动的新容器数量。例如一共有10个容器要升级，当批量大小为2时，每次会升级2个容器，停掉2个旧的，启动2个新的，分5批完成升级。
* **批量间隔**：每次批量升级间隔的时间，例如10个容器，每次升级5个，批量时间为5秒。在完成5个容器升级后，在等待5秒后，会升级剩下的5个容器。
* **启动行为**：默认情况下，旧的容器会先停止，然后再启动新的容器。你可以选择先启动新的容器，再停止旧的容器。

在配置好了新的服务参数和升级专用参数以后，点击**升级**。

当全部旧的容器被停掉，新的容器启动成功之后，服务将会变成 _Upgraded_ 状态。在这个阶段，你应该去测试你的新服务来确保服务可以正常工作。然后，可以通过点击**升级完成**来完成升级。如果你的服务出现了异常，你可以点击**回滚**来回退到之前的服务。

#### 通过Rancher Compose命令行进行服务升级

通过Rancher Compose命令行进行服务内升级时，现有服务会按照`docker-compose.yml`中的内容进行升级，服务中旧的容器会被删除。升级相关的参数需要传递给`rancher-compose up`命令。如果命令加上`--upgrade`参数，`docker-compose.yml`内定义的服务如果发生了改变，这个服务会被按照文件中的配置进行升级。和在UI上进行升级操作一样，服务内升级分为两个步骤，需要用户确认来完成升级或者执行回滚。

##### 第一步： 进行升级

升级的时候，你可以通过`docker-compose.yml`文件升级整个应用栈或者升级应用内指定的服务。

```bash
# 升级应用栈内的全部有变化的服务
$ rancher-compose up --upgrade
# 升级应用栈内指定的服务 (例如仅升级service1和service2)
$ rancher-compose up --upgrade service1 service2
# 强制触发服务升级，即使在docker-comopse.yml文件中未被改变的服务，也将被升级。
$ rancher-compose up --force-upgrade
```
**升级选项**

选项 | 描述
---|---
`--pull`, `-p`			|	升级前，在每台运行该容器的主机上执行docker pull操作，尝试获取新镜像
`-d`			|		在后台运行升级
`--upgrade`, `-u`, `--recreate`		| 仅升级在docker-compose.yml中配置有变化的服务
`--force-upgrade`, `--force-recreate` |	不论服务的配置是否有变化，全部进行升级
`--confirm-upgrade`, `-c` |		升级完成后自动确认升级成功，删除旧的容器
`--rollback`, `-r`		|	回滚到之前的版本
`--batch-size` "2"	|		每批升级的容器个数
`--interval` "1000"	|		每批升级的时间间隔

<br>
**拉取镜像**

在升级时，你可能需要在部署容器之前执行`docker pull`，因为主机上可能已经有了该镜像的缓存。你可以通过`--pull`参数，在部署容器之前拉取最新的镜像。

```bash
# 在升级时，强制每台主机在部署容器之前，执行docker pull更新镜像
$ rancher-compose up --upgrade --pull
```

**批量大小**

在默认的情况下，每批升级服务的2个容器。你可以通过`--batch-size`参数来设置每批所更新的镜像数量。

```bash
# 升级服务时每次会启动3个新的容器
# 直到新的容器达到设置的数量
$ rancher-compose up --upgrade --batch-size 3
```

**批量间隔**

在默认的情况下，每次新的容器启动和旧的容器停止之间有2秒的时间间隔。你可以通过`--interval`来覆盖这个时间间隔，参数后面跟着的时间间隔是以毫秒为单位的。

```bash
# 将服务的升级间隔设置为30秒。
# service1和service2的新容器启动和他们的旧容器停止之间为30s
$ rancher-compose up --upgrade service1 service2 --interval "30000"
```

**在停止旧的容器前启动新的容器**

在默认的情况下，服务内升级会先停掉旧的容器，再启动新的容器。如果想要先启动新的容器，再停止旧的容器，你需要在`rancher-compose.yml`文件中写入如下内容。

```yaml
version: '2'
services:
  myservice:
    upgrade_strategy:
      start_first: true
```

<br>

```bash
# 通过上面的rancher-compose.yml配置，会先启动myservice服务中的新容器，然后再停掉旧容器。
$ rancher-compose up --upgrade myservice
```

##### 第二步：确认升级

在你验证该服务升级成了并且可以正常工作了之后，你需要在Rancher里确认升级成功。这种设计是因为有时候你可能想要回滚你的服务。**当你点击完成升级后，就不能再进行回滚操作了**

```bash
# 下面的命令可以确认升级成功，不需要在UI上点击完成升级。
$ rancher-compose up --upgrade --confirm-upgrade
```

**回滚**

在升级过程完成之后，你的服务可能发生了问题不能正常工作。Rancher支持回滚功能，可以把服务回滚到升级之前的状态。回滚操作只能在**点击完成升级之前**进行。

```bash
# 回滚到之前的版本
$ rancher-compose up --upgrade --rollback
```

### 替换式升级

替换式升级会通过创建一个新的服务来替换旧的服务，而不是在同一个服务内停止旧的容器并启动新的容器。只有Rancher Compose命令行才支持这种升级方式，UI上不可以。替换式升级操作非常简单：

```bash
$ rancher-compose upgrade service1 service2
```
`service2`是你想要在Rancher里启动的新服务的名字。`service1`是你想要在Rancher里停止并替换的服务。当`service2`被部署之后，`service1`里面的容器会被删除，但是服务本身并不会从Rancher里删除，只是容器的数量会变为0。

这两个服务名都需要被定义在`docker-compose.yml`里面。`service1`只需要把服务名在yml文件中定义即可，Rancher Compose会用这个名字来找到相应的服务。`service2`则需要在yml文件中定义全部需要的配置，Rancher Compose命令行会根据文件中的配置来部署`service2`。

#### 示例 `docker-compose.yml`

```yaml
version: '2'
services:
  service1:
  # 这里不需要额外的参数，因为service1已经在运行中了。
  service2:
    image: wordpress
    links:
    - db:mysql
```

默认情况下，全部的指向`service1`的负载均衡或者是服务连接都会被自动更新并指向`service2`。如果你不想创建这些连接，你可以通过设置来[禁止连接创建]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/upgrading/#更新连接)。

> **注意：** 升级服务时并不需要`rancher-compose.yml`文件。 在默认情况下，新服务中的容器数量和旧服务中的容器数量相同。你可以通过传递`--scale`参数来设置容器的数量。

#### 升级过程中的容器数量

直到新的服务中的容器数量和旧的服务中的容器数量达到你设定的数量时，旧服务中的容器才会被删除。

#### 示例:

```bash
$ rancher-compose upgrade service1 service2 --scale 5
```

`service1`中有两个容器，你想要把它升级为`service2`，`service2`中想要启动5个容器。

`service1` | `service2` | 备注
---|---|---
2 | 0 |  `service1`在运行中，并且有两个容器。
2 | 2 | `service2`每批启动两个容器(默认[批量数量](#批量大小))。
2 | 4 | `service2`第二批时，再启动两个容器。
1 | 4 | 在上一步，新旧容器的数量总和为6个，已经超过目标数量的5个。这时会停掉`service1`里的一个容器，使新旧容器数量为5个。
1 | 5 | `service2`再启动一个容器，达到目标的5个容器。
0 | 5 | `service1`删除最后一个容器。

#### `Upgrade`命令的参数

`upgrade`命令，可以接受几个参数来自定义升级行为。

参数 | 描述
---|---
`--batch-size` "2" |	每批升级的容器个数
`--scale` "-1"	|		最终要运行的容器数量
`--interval` "2000" |		每批升级的时间间隔
`--update-links` |	更新指定服务的连接
`--wait`, `-w`	|		等待升级完成
`--pull`, `-p`	|		升级前，在每台运行该容器的主机上执行docker pull操作，尝试获取新镜像
`--cleanup`, `-c` |		在升级完毕后，删除旧的服务

##### 批量大小

在默认情况下，升级的时候每次启动2个新服务的容器。你可以通过`--batch-size`参数来设置每批启动的容器个数。

```bash
# 升级的过程中，每批将会启动3个service2的容器，直到service2的容器数量达到设定的值。
$ rancher-compose upgrade service1 service2 --batch-size 3
```

##### 最终数量

在默认情况下，新服务的容器数量和旧服务之前运行的容器数量相同。你可以通过传递`--scale`参数，来设置新服务所运行容器的数量。

```bash
#设置service2升级后的容器数量为8个
$ rancher-compose upgrade service1 service2 --scale 8
```

<br>

> **注意：** 旧服务中的容器并不根据批量大小的数量来删除。当新旧服务中的容器数量和，达到设置的最终数量时，旧服务中的容器将会被停止并删除。

##### 批量间隔

在默认的情况下，每次新的容器启动和旧的容器停止之间有2秒的时间间隔。你可以通过`--interval`来覆盖这个时间间隔，参数后面跟着的时间间隔是以毫秒为单位的。

```bash
# 将服务的升级间隔设置为30秒。
# service1和service2的新容器启动和他们的旧容器停止之间为30s
$ rancher-compose upgrade service1 service2 --interval "30000"
```

##### 更新连接

在默认情况下，全部**指向**旧服务的连接会被设置到新服务上。如果你不想让那些服务连接到新的服务的话，你可以通过`--update-links="false"`参数来禁止这些连接的创建。

```bash
# 不把指向service1中的连接设置到service2上
$ rancher-compose upgrade service1 service2 --update-links="false"
```

##### 等待升级完毕

在默认情况下，Rancher Compose命令行在向Rancher发出升级命令后就会立刻退出。退出的时候升级可能还没执行完毕。通过传递`--wait`或者`-w`到`upgrade`命令，Rancher Compose命令行将在旧的容器被停止且新容器启动后才退出。

```bash
# 等待升级完成
$ rancher-compose upgrade service1 service2 --wait
```

##### 拉取新镜像

在升级时，你可能想在部署容器之前执行`docker pull`，因为主机上可能已经有了该镜像的缓存。你可以通过`--pull`或者`-p`参数，在部署容器之前拉取最新的镜像。

```bash
# 在启动容器时，先执行docker pull获取最新镜像
$ rancher-compose upgrade service1 service2 --pull
```

##### 清除旧的服务

在默认情况下，升级完成后旧的服务不会被删除，只是旧服务中容器的数量为0。如果你觉得并不需要回滚，也不需要保留旧的服务配置。你可以通过传递`--cleanup`或者`-c`参数到`upgrade`命令。这个参数会同时应用`--wait`参数，因为Rancher Compose命令行需要等待升级完成，然后才能删掉旧的服务。

```bash
# 升级完成后删除service1
$ rancher-compose upgrade service1 service2 --cleanup
```
