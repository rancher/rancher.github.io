---
title: Load Balancers in Rancher
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## 负载均衡器
---

Rancher支持在Rancher内使用不同负载均衡器驱动。你可以通过向目标服务添加规则使负载均衡器将网络和应用程序流量分配到容器中。Rancher将自动将目标服务的容器自动注册为Rancher的负载平衡目标。

默认情况下，Rancher提供了一个基于HAProxy的托管负载均衡器，你可以手动扩容到多个主机上。我们计划添加额外的负载均衡器驱动，所有负载均衡器的选项将是相同的，不管负载均衡器种类。

对于Cattle引擎的环境，可以参考[UI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/#如何在ui上新增一个负载均衡)和[Rancher Compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/#用rancher-compose-添加负载均衡)了解更多信息，并且在[UI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/#adding-a-load-balancer-in-the-ui)和[Rancher Compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/#adding-a-load-balancer-with-rancher-compose)中有相关的例子。

对于Kubernetes的环境，详细了解如何启动[云厂商提供的]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/providers/)外部负载均衡器服务，或者使用Rancher负载均衡器实现Kubernetes环境中的[Ingress]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/ingress/)支持。
