---
title: Kubernetes Cloud Providers
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## Kubernetes - Cloud Providers
---

在Kubernetes中, 有一个[cloud providers](https://kubernetes.io/docs/getting-started-guides/scratch/#cloud-provider)的概念, cloud provider是Kubernetes的一个模块，提供接口用于管理负载均衡、节点(也就是主机)以及网络路由。

目前, Rancher在 [设置Kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#设置kubernetes) 时支持以下两种类型的cloud provider。 你可以选择使用哪种cloud provider。

### Rancher

  * **节点:** 支持任何可以被加入Rancher的[主机]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/)。
  * **负载均衡:** 启动Rancher的负载均衡, 使用HAproxy和`rancher/lb-service-haproxy`镜像作为负载均衡服务。 默认情况下, 负载均衡将请求以轮询方式发送给pods。

默认情况下, Kubernetes的cloud proivder被设置为`rancher`。

### AWS

  * **节点:** 仅支持以[自定义主机]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/)方式添加AWS主机。
  * **负载均衡:** 启动一个AWS Elastic Load Balancer (ELB)作为负载均衡服务。 同时，你仍然可以通过使用[ingress]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/ingress/)对象来创建Rancher负载均衡。
  * **持久化卷(PV)**: 能够使用AWS Elastic Block Stores (EBS)用于[persistent volumes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/storage/).

#### 添加主机

在设置Kubernetes以`aws` cloud provider运行后，任何加入环境的主机都必须是一个AWS EC2实例并且至少具有以下IAM策略：


```json
{
  "Effect": "Allow",
  "Action": "ec2:Describe*",
  "Resource": "*"
}
```

为了在Kubernetes中使用Elastic Load Balancers (ELBs)和EBS, 主机需要拥有一个具备合适权限的IAM角色。

##### IAM角色策略示例:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:Describe*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "ec2:AttachVolume",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "ec2:DetachVolume",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": ["ec2:*"],
      "Resource": ["*"]
    },
    {
      "Effect": "Allow",
      "Action": ["elasticloadbalancing:*"],
      "Resource": ["*"]
    }
  ]
}
```

#### Elastic Load Balancer (ELB)作为一个Kubernetes服务

在[设置Kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#设置kubernetes)中选择`aws`作为cloud provider并确保主机拥有配置ELB的相应IAM策略后，你可以开始创建负载均衡。

##### `lb.yml`文件示例

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-lb
  labels:
    app: nginx
spec:
  type: LoadBalancer
  selector:
    app: nginx
  ports:
  - name: http
    port: 80
    protocol: TCP
```

通过使用`kubectl`客户端, 让我们在Kubernetes中启动我们的负载均衡服务。 记住, 你可以通过[为本地主机配置`kubectl`]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#kubectl)在本机使用kubectl客户端或者通过UI界面中的**Kubernetes** -> **kubectl** 命令行界面使用kubectl客户端。

```bash
$ kubectl create -f lb.yml
service "nginx-lb" created
$ kubectl describe services nginx-lb
Name:			nginx-lb
Namespace:		default
Labels:			app=nginx
Selector:		name=nginx
Type:			LoadBalancer
IP:			10.43.137.5
LoadBalancer Ingress:	a4c7d4290f48011e690470275ac52fef-1158549671.us-west-2.elb.amazonaws.com
Port:			http	80/TCP
NodePort:		http	32166/TCP
Endpoints:		<none>
Session Affinity:	None
Events:
  FirstSeen	LastSeen	Count	From			SubObjectPath	Type		Reason			Message
  ---------	--------	-----	----			-------------	--------	------			-------
  17s		17s		1	{service-controller }			Normal		CreatingLoadBalancer	Creating load balancer
  14s		14s		1	{service-controller }			Normal		CreatedLoadBalancer	Created load balancer
```

#### 使用EBS卷

在设置Kubernetes使用`aws`作为cloud provider并确保主机拥有配置EBS的相应IAM策略后，你可以开始[使用EBS卷]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/storage/#persistent-volumes---ebs).
