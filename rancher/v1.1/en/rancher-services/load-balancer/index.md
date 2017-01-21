---
title: Load Balancers in Rancher
layout: rancher-default-v1.1
version: v1.1
lang: en
redirect_from:
  - /rancher/v1.1/zh/rancher-services/load-balancer/
---

## Load Balancer  
---

Rancher implements a managed load balancer using HAProxy that can be manually scaled to multiple hosts.  A load balancer can be used to distribute network and application traffic to individual containers by directly adding them or "linked" to a basic service.  A basic service that is "linked" will have all its underlying containers automatically registered as load balancer targets by Rancher.

Learn more about how to [add load balancers in Cattle environments]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/) or how we use [Rancher's load balancers for ingress support in Kubernetes environments]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/ingress/).
