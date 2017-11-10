---
title: Kubernetes Ingress Support in Rancher
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## Ingress Support
---

在开始使用 [Kubernetes Ingress](http://kubernetes.io/docs/user-guide/ingress/)资源之前，你需要准备一个Kubernetes[环境]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/) 。并且建议在本地电脑上[设置kubectl]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#kubectl) ，以便更容易地将Kubernetes的资源发布到Rancher中。或者，你可以使用Rancher UI提供的shell来启动资源。

Kubernetes Ingress资源可以支持你选择的任何负载均衡器类型，因此，为了利用Rancher的负载均衡功能，我们引入了Rancher Ingress控制器的概念。ingress控制器是ingress-controller服务的一部分，它做为Kubernetes系统栈的组件被部署。

ingress控制器管理着Rancher负载均衡器的创建/迁移/更新。每个负载均衡器的创建/删除/更新都是基于 Kubernetes ingress 资源。

如果一个ingress被更新或服务端点（Service endpoint）被更改，ingress控制器将更新相应的Rancher负载均衡器，使其与ingress的变化相对应。

同理，如果ingress被移除，Rancher负载均衡器也会被移除。如果一个ingress的后端服务发生了变化(例如，当复制控制器被放大或缩小或重新创建一个pod时)，Rancher负载均衡器也将相应地更新。ingress控制器确保了Rancher负载均衡器与Kubernetes的ingress和后端服务相匹配。

### 目前的局限性

* Ingress资源只能通过kubectl工具添加

###  Rancher Ingress 控制器

Rancher ingress控制器利用Rancher中现有的负载均衡功能，将Kubernetes ingress的内容转换到Rancher的负载均衡器。

ingress controller 功能:

* 监听Kubernetes服务器事件;
* 部署负载平衡器，并将其与Ingress中定义的路由规则进行适配;
* 通过配置Ingress `Address` 字段来做为负载均衡器的公共接入地址。

### 在Rancher中创建Ingress资源

#### 设置一个Nginx服务示例

在配置任何ingress之前, 需要在Kubernetes中创建服务. 首先在Kubernetes环境中添加一个服务和复制控制器（Replication Controller）。

这里添加单个的nginx服务到Kubernetes中。

示例：`nginx-service.yml`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
  labels:
    k8s-app: nginx-service
spec:
  ports:
  - port: 90
    targetPort: 80
    protocol: TCP
    name: http
  selector:
    k8s-app: nginx-service
---
apiVersion: v1
kind: ReplicationController
metadata:
  name: nginx-service
spec:
  replicas: 1
  selector:
    k8s-app: nginx-service
  template:
    metadata:
      labels:
        k8s-app: nginx-service
    spec:
      terminationGracePeriodSeconds: 60
      containers:
      - name: nginx-service
        image: nginx:latest
        ports:
        - containerPort: 80
```

让我们使用kubectl将nginx服务发布到Kubernetes。请记住,  你也可以为本地机器配置kubectl ，或者在Kubernetes/kubectl的UI中使用shell。

```bash
$ kubectl create -f nginx-service.yml
service "nginx-service" created
replicationcontroller "nginx-service" created
```

#### 配置单个ingress资源

你可以为单个服务设置单一的ingress资源。

示例：`simple-ingress.yml`

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: simplelb
spec:
  backend:
    serviceName: nginx-service
    servicePort: 90
```

让我们使用kubectl创建ingress。在创建ingress后, ingress 控制器将触发创建一个负载均衡器并且可以在**Kubernetes** -> **System**  标签栏中看到创建的 **kubernetes-ingress-lbs** 应用栈 .

默认情况下，负载均衡器服务只有一个实例被部署。 通过`kubectl`, 可以看到 ingress被创建, 但通过UI只能看到负载均衡器应用.  ingress控制器已经完成了所有ingress转换到Rancher负载均衡器的请求。

```bash
$ kubectl create -f simple-ingress.yml
ingress "simplelb" created
$ kubectl get ingress
NAME          RULE      BACKEND            ADDRESS          AGE
simplelb      -         nginx-service:80   1.2.3.4          5m
```

ingress中的address将是负载均衡器服务启动的公共接入地址。如果负载均衡器被移动到不同的主机并得到不同的公共端点（public endpoint），则ingress地址将被更新。

你可以在缺省端口80(例如：http://1.2.3.4:80)或直接访问地址(例如：http://1.2.3.4)来访问你的应用。

#### 配置多个服务

如果你希望ingress做为多个服务的入口点，那么需要使用主机名路由规则来配置它，它允许将host/path 的路由添加到服务。

让我们添加多个服务到 Kubernetes中.

示例：`multiple-nginx-services.yml`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service-1
  labels:
    k8s-app: nginx-service-1
spec:
  ports:
  - port: 90
    targetPort: 80
    protocol: TCP
    name: http
  selector:
    k8s-app: nginx-service-1
---
apiVersion: v1
kind: ReplicationController
metadata:
  name: nginx-service-1
spec:
  replicas: 1
  selector:
    k8s-app: nginx-service-1
  template:
    metadata:
      labels:
        k8s-app: nginx-service-1
    spec:
      terminationGracePeriodSeconds: 60
      containers:
      - name: nginx-service-1
        image: nginx:latest
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-service-2
  labels:
    k8s-app: nginx-service-2
spec:
  ports:
  - port: 90
    targetPort: 80
    protocol: TCP
    name: http
  selector:
    k8s-app: nginx-service-2
---
apiVersion: v1
kind: ReplicationController
metadata:
  name: nginx-service-2
spec:
  replicas: 1
  selector:
    k8s-app: nginx-service-2
  template:
    metadata:
      labels:
        k8s-app: nginx-service-2
    spec:
      terminationGracePeriodSeconds: 60
      containers:
      - name: nginx-service-2
        image: nginx:latest
        ports:
        - containerPort: 80
```

让我们用kubectl将我们的服务和复制控制器发布到Kubernetes中，请记住，你可以为本地机器配置kubectl，也可以在Kubernetes-kubectl的UI中使用shell。

```bash
$ kubectl create -f multiple-nginx-services.yml
service "nginx-service-1" created
replicationcontroller "nginx-service-1" created
service "nginx-service-2" created
replicationcontroller "nginx-service-2" created
```

#### 基于主机路由配置 Ingress 资源

示例：`host-based-ingress.yml`

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: host-based-ingress
spec:
  rules:
  - host: foo.bar.com
    http:
      paths:
      - backend:
          serviceName: nginx-service-1
          servicePort: 90
  - host: bar.foo.com
    http:
      paths:
      - backend:
          serviceName: nginx-service-2
          servicePort: 90
```

让我们使用kubectl创建ingress。在创建ingress后, ingress 控制器 将触发创建一个负载均衡器并且可以在**Kubernetes** -> **System**  标签栏中看到创建的 **kubernetes-ingress-lbs** 应用栈 .

默认情况下，负载均衡器服务只有一个实例被部署。 通过ingress，负载均衡器将有一个以主机名命名的路由规则被创建。

通过`kubectl`, 可以看到 ingress 被创建, 但通过UI只能看到负载均衡器应用.  ingress控制器已经完成了所有ingress转换到Rancher负载均衡器的请求。


```bash
$ kubectl create -f host-based-ingress.yml
ingress "host-based-ingress" created
$ kubectl get ingress
NAME                    RULE            BACKEND             ADDRESS     AGE
host-based-ingress      -                                   1.2.3.4     20m
                        foo.bar.com
                                        nginx-service-1:80
                        foo1.bar.com
                                        nginx-service-2:80
```

与单个ingress负载均衡器类似，这个负载均衡器将在Kubernetes/System选项卡中位于Kubernetes-lbs的应用栈中。

ingress中的地址将是负载均衡器服务启动的公共接入地址。.如果负载均衡器被移动到不同的主机并得到不同的公共端点，则ingress地址将被更新

 你可以在缺省端口80(例如：http://1.2.3.4:80)或直接访问地址(例如：http://1.2.3.4)。来访问你的应用。

#### 使用基于路径的路由配置Ingress资源

如果有多个想要做负载均衡的服务，那么可以向ingress添加基于路径的路由。

示例：`path-based-ingress.yml`

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: path-based-ingress
spec:
  rules:
  - host: foo.bar.com
    http:
      paths:
      - path: /foo
        backend:
          serviceName: nginx-service-1
          servicePort: 90
      - path: /bar
        backend:
          serviceName: nginx-service-2
          servicePort: 90
```

让我们使用kubectl创建ingress。在创建ingress后, ingress 控制器 将触发创建一个负载均衡器并且可以在**Kubernetes** -> **System**  标签栏中看到创建的 **kubernetes-ingress-lbs** 应用栈。默认情况下，负载均衡器服务只有一个实例被部署。负载均衡器将拥有从ingress创建的主机名路由规则。

通过`kubectl`, 可以看到 ingress 被创建, 但是UI中只能看到负载均衡器应用.  ingress控制器已经完成了所有在ingress中的转换到Rancher负载均衡器的请求。


```bash
$ kubectl create -f path-based-ingress.yml
ingress "path-based-ingress" created
$ kubectl get ingress
NAME                    RULE            BACKEND             ADDRESS            AGE
path-based-ingress      -                                   1.2.3.4             15s
                        foo.bar.com
                        /foo            nginx-service1:80
                        /bar            nginx-service2:80
```

与单个的ingress负载均衡器类似，这个负载均衡器将在Kubernetes-System选项卡中位于Kubernetes-lbs的堆栈中。

ingress中的address将是负载均衡器服务启动的公共接入地址。如果负载均衡器被移动到不同的主机并得到不同的公共端点，则ingress地址将被更新。

要访问你的应用程序，可以在缺省端口80(例如：http://1.2.3.4:80)或地址直接访问地址(例如：http://1.2.3.4)。

### Kubernetes Ingress的负载均衡器选项

默认情况下，Kubernetes ingress将在默认80/443端口上使用http/https部署1个负载均衡器实例。Rancher可支持多组负载均衡，用户可以根据需要自行制定端口。扩展ingress后，Kubernetes 配置的地址将被复制到所有负载均衡器。

#### 示例:

* [多个负载均衡器使用不同的端口](#示例两个负载均衡器使用交替的端口)
* [使用 TLS](#示例使用tls)
* [禁用HTTP](#禁用http)
* [自定义HAProxy](#示例用户定制)
* [所有主机运行负载均衡器](#示例在所有主机上运行负载均衡器)
* [特定主机运行负载均衡器](#示例在特定主机上运行负载均衡器)

> **注意：** 如果增加ingress实例数量，你需要确保在Kubernetes环境中至少有同等数量的主机可用。
>

#### 设置单个服务

在建立任何一个ingress之前，需要在Kubernetes中创建服务。首先在Kubernetes环境中添加一个服务和复制控制器。

这里向Kubernetes添加一个单个的nginx服务。

示例：`nginx-service.yml`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
  labels:
    k8s-app: nginx-service
spec:
  ports:
  - port: 90
    targetPort: 80
    protocol: TCP
    name: http
  selector:
    k8s-app: nginx-service
---
apiVersion: v1
kind: ReplicationController
metadata:
  name: nginx-service
spec:
  replicas: 1
  selector:
    k8s-app: nginx-service
  template:
    metadata:
      labels:
        k8s-app: nginx-service
    spec:
      terminationGracePeriodSeconds: 60
      containers:
      - name: nginx-service
        image: nginx:latest
        ports:
        - containerPort: 80
```

使用kubectl，让我们将nginx服务发布到Kubernetes。请记住，你可以为本地机器配置kubectl，也可以在Kubernetes-kubectl的UI中使用shell。

```bash
$ kubectl create -f nginx-service.yml
service "nginx-service" created
replicationcontroller "nginx-service" created
```
#### *示例：两个负载均衡器使用交替的端口*

你可以在两个不同的主机上运行2个负载均衡器启动一个ingress，它使用一个99端口代替默认的80端口。为了让这个ingress正常工作，你的kubernetes环境至少需要两台拥有99端口的主机。

示例：`scaled-ingress.yml`

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: scaledlb
  annotations:
    # Scaling to 2 load balancer instances
    scale: "2"
    # Using a different port (not 80)
    http.port: "99"
spec:
  backend:
    serviceName: nginx-service
    servicePort: 90
```

让我们使用kubectl创建ingress。在创建ingress之后，ingress控制器将触发在Kubernetes-System选项卡中创建的负载均衡器服务，并在Kubernetes-ingss-lbs堆栈中可见。由于在ingress中`scale` 设置为2，所以在负载均衡器服务中会有两个负载均衡器实例被部署。。

在kubectl中，你可以看到ingress创建，但是UI只显示负载均衡器。ingress控制器已经完成了在ingress转化到Rancher负载均衡器的所有请求。因为有两个负载均衡器，需要在ingress中设置两个地址。


```bash
$ kubectl create -f scaled-ingress.yml
ingress "host-based-ingress" created
$ kubectl get ingress
NAME       RULE      BACKEND            ADDRESS             AGE
simplelb   -         nginx-service:90   1.2.3.4,5.6.7.8     41s
```

#### 示例：使用TLS

***如果你想要在Kubernetes中使用TLS，那么你需要将证书添加到Rancher中。在Rancher中添加的证书可以用于为TLS终端提供一个安全的ingress。***

*假设我们添加了一个名为foo的证书*

示例：`tls-ingress.yml` 使用这个 `foo` 证书。

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: tlslb
  annotations:
    https.port: "444"
spec:
  tls:
   - secretName: foo
  backend:
    serviceName: nginx-service
    servicePort: 90
```

让我们使用kubectl创建ingress。在创建ingress之后，ingress控制器将触发在Kubernetes-System选项卡中创建的负载均衡器服务，并在Kubernetes-ingss-lbs堆栈中可见。默认情况下，负载均衡器服务只有一个负载均衡器的实例被部署。

在kubectl中，你可以看到ingress被创建，但是UI只显示负载均衡器应用。ingress控制器已经完成了在ingress中转换到Rancher负载均衡器所有请求的。

#### **禁用HTTP**

***默认情况下，即使使用了TLS，端口80也是可以访问的。为了阻止80端口，你可以添加额外的参数（annotation） (allow.http: "false")做为ingress模板的一部分。***

示例：`tls-ingress.yml` and 禁用80 端口

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: tlslb
  annotations:
    https.port: "444"
    # Added to block HTTP
    allow.http: "false"
spec:
  tls:
   - secretName: foo
  backend:
    serviceName: nginx-service
    servicePort: 90
```
#### 示例：用户定制

在Rancher中，我们的负载均衡器运行的是HAProxy软件。如果你想要定制负载均衡器配置文件的`global` 和`defaults` 部分，可以通过ingress注释(annotations)来配置它们。

示例：`custom-ingress.yml`

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: customlb
  annotations:
    # Customizing HAProxy in the load balancer
    config: "defaults\nbalance source\ntimeout server 70000\nglobal\nmaxconnrate 60"
spec:
  backend:
    serviceName: nginx-service
    servicePort: 80
```

***在配置中，默认和全局关键字标识可自定义的部分，后面应该紧跟着有新的换行。 这些部分中的每个参数都应该跟着一条新的换行。***

#### 示例:在所有主机上运行负载均衡器

在当前环境中，可以让负载均衡器在所有主机上运行。这些全局负载均衡器可以使用注释（annotations）进行调度，i.e. `io.Rancher.scheduler.global: "true"`.

示例：`global-ingress.yml`

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: globallb
  annotations:
    # Create load balancers on every host in the environment
    io.Rancher.scheduler.global: "true"
spec:
  backend:
    serviceName: nginx-service
    servicePort: 80
```

#### 示例：在特定主机上运行负载均衡器

在当前环境中，你可以将负载均衡器安排到某个特定主机上。为了将负载均衡器安排到特定的主机上，你需要向主机添加标签。主机上的标签是一个键值对，比如你可以给主机设置标签为foo=bar。主机添加标签之后，你需要使用参数annotation，（如Rancher.scheduler.affinity.host_label: "foo=bar"`）以使负载均衡器容器安排到标记的主机上。

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: scheduledlb
  annotations:
    # Search for a host that has label foo=bar and schedule the load balancer on that host.
    io.Rancher.scheduler.affinity.host_label: "foo=bar"
spec:
  backend:
    serviceName: nginx-service
    servicePort: 80
```

#### 例：将流量导向同一主机上的不同容器

*你可以配置负载均衡器，将流量路由到与负载均衡器容器同一主机上的服务容器。如果主机上没有目标服务的容器，那么负载均衡器不会将任何流量路由到目标服务的其他容器，就像它们在其他主机上一样。为了配置负载均衡器，你需要使用annotation参数i.e. `io.Rancher.lb_service.target: "only-local"`.*

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: onlylocallb
  annotations:
    # Direct traffic to only containers that are on the same host as the load balancer container
    io.Rancher.lb_service.target: "only-local"
spec:
  backend:
    serviceName: nginx-service
    servicePort: 80
```

#### 示例：在同一主机上对容器的流量进行优先级排序

对于一个多实例服务，你可以配置负载均衡器，使流量优先分配到与负载均衡器容器相同主机的服务容器中。如果主机上没有目标服务的容器，则负载均衡器将流量引导到目标服务所在的其他主机上。为了配置负载均衡器，你将使用一个annotation， i.e. `io.Rancher.lb_service.target: "prefer-local"`.

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: preferlocallb
  annotations:
    # Prioritize traffic to containers that are on the same host as the load balancer container
    io.Rancher.lb_service.target: "prefer-local"
spec:
  backend:
    serviceName: nginx-service
    servicePort: 80
```

#### 示例：粘滞会话

可以为Rancher负载均衡器中运行的HAProxy软件的配置粘性策略。

**例如，你可以配置负载均衡器使来自相同源的流量路由到相同的容器。**

为了配置负载均衡器,你需要使用一条包括粘性政策的annotation参数 (i.e. `io.Rancher.stickiness.policy`)。

可以设置一个HAProxy软件能够识别的关键参数 \n做为界限值。

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: test
  annotations:
    # Configure stickiness policy
    io.Rancher.stickiness.policy: "name: testname\n cookie: cookie123\ndomain: test.domain"
spec:
  backend:
    serviceName: nginx-service
    servicePort: 80
```
