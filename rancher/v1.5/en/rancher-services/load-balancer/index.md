---
title: Load Balancers in Rancher
layout: rancher-default-v1.4
version: v1.4
lang: en
---

## Load Balancer  
---

Rancher provides the ability to use different load balancer drivers within Rancher. A load balancer can be used to distribute network and application traffic to individual containers by adding rules to target services. Any target service will have all its underlying containers automatically registered as load balancer targets by Rancher. .

By default, Rancher has provided a managed load balancer using HAProxy that can be manually scaled to multiple hosts. We are planning to add in additional load balancer providers, and the options for all load balancers will be the same regardless of load balancer provider.

For Cattle envionments, learn more about the options for our load balancer for the [UI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/#load-balancer-options-in-the-UI) and [Rancher Compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/#load-balancer-options-in-rancher-compose) and show examples using the [UI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/#adding-a-load-balancer-in-the-ui) and [Rancher Compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/#adding-a-load-balancer-with-rancher-compose).

For Kubernetes environments, learn more about how to launch external load balancer services based on your [cloud provider]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/providers/) or using [Rancher's load balancers for ingress support in Kubernetes environments]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/ingress/).
