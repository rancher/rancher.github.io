---
title: 在Rancher中搭配Kubernetes使用私有仓库
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## 在Rancher中搭配Kubernetes使用私有仓库
---

如果你在 [离线环境]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/no-internet-access/) 运行Rancher，或者Rancher不能够访问DockerHub (亦即 `docker.io`) 以及Google容器仓库 (亦即 `gcr.io`)，那么Pod的基础容器镜像和Kubernetes的插件将无法正常安装。你需要 [配置 Kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#设置kubernetes) 来指定一个私有仓库以安装Kubernetes的插件以及Pod的基础容器镜像。

#### 对私有仓库的要求

Rancher 期望私有仓库能映射（mirror）DockerHub (亦即 `docker.io`) 和 Google 容器仓库 (亦即 `gcr.io`).

##### Pod 基础容器镜像

在 [配置 Kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#设置kubernetes)Rancher使用一个 Pod 基础容器镜像。每一个Pod会用它来共享 network/ipc 命名空间。

```yml
# 配置为k8s模版中的默认值
Image: gcr.io/google_containers/pause-amd64:3.0
```

##### Kubernetes 插件

镜像的 `namespace/name:tag` 需要和 [Rancher 插件模版](https://github.com/rancher/kubernetes-package/tree/master/addon-templates)中的镜像保持一致

下列是目前支持的插件的镜像列表，你需要 [查看 Github 仓库找具体的版本号](https://github.com/rancher/kubernetes-package/tree/master/addon-templates) 然后复制具体版本号到每个镜像。

##### Helm的镜像

```yml
# 位于 helm/tiller-deploy.yaml
image: <$PRIVATE_REGISTRY>/kubernetes-helm/tiller:<VERSION>
```

##### Dashboard的镜像

```yml
# 位于 dashboard/dashboard-controller.yaml
image: <$PRIVATE_REGISTRY>/google_containers/kubernetes-dashboard-amd64:<VERSION>
```

##### Heapster的镜像

```yml
# 位于 heapster/heapster-controller.yaml
image: <$PRIVATE_REGISTRY>/google_containers/heapster:<VERSION>

# 位于 heapster/influx-grafana-controller.yaml
image: <$PRIVATE_REGISTRY>/kubernetes/heapster_influxdb:<VERSION>
image: <$PRIVATE_REGISTRY>/google_containers/heapster_grafana:<VERSION>
```
