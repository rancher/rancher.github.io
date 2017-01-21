---
title: DNS Service in Rancher
layout: rancher-default-v1.2
version: v1.2
lang: en
redirect_from:
  - /rancher/v1.2/zh/rancher-services/dns-service/
---

## DNS Service
---

Rancher provides an infrastructure service for a distributed DNS service by using its own lightweight DNS server coupled with a highly available control plane. Each healthy container is automatically added to the DNS service when linked to another service or added to a Service Alias. When queried by the service name, the DNS service returns a randomized list of IP addresses of the healthy containers implementing that service.

* By default, all services within the same stack are added to the DNS service without requiring explicit service links, which can be set under **Service Links** in a service.
* You can resolve containers within the same stacks by the service names.
* If you need a custom DNS name for your service, that is different from your service name, you will be required to set a link to get the custom DNS name.
* Links are still required if a Service Alias is used.
* To make services resolvable that are in different stacks, you can use `<service_name>.<stack_name>` and are not required explicit links, which can be set under **Service Links** in a service.

Because Rancher’s overlay networking provides each container with a distinct IP address, you do not need to deal with port mappings and do not need to handle situations like duplicated services listening on different ports. As a result, a simple DNS service is adequate for handling service discovery.

Learn more about the internal DNS service for [Cattle environments]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/internal-dns-service/) and [Kubernetes environments]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/k8s-internal-dns-service/).
