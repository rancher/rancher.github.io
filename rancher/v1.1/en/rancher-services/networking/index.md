---
title: Networking in Rancher
layout: rancher-default-v1.1
version: v1.1
lang: en
redirect_from:
  - /rancher/v1.1/zh/rancher-services/networking/
---

## Networking
---

Rancher supports cross-host container communication by implementing a simple and secure overlay network using IPsec tunneling.  To leverage this capability, a container launched through Rancher must select "Managed" for its network mode or if launched through Docker, provide an extra label `--label io.rancher.container.network=true`.  Most of Rancher's network features, such as load balancer or DNS service, require the container to be in the managed network.

Under Rancher's network, a container will be assigned both a Docker bridge IP (172.17.0.0/16) and a Rancher managed IP (10.42.0.0/16) on the default docker0 bridge.  Containers within the same environment are then routable and reachable via the managed network.

> **Note:** The Rancher managed IP address will not be present in Docker meta-data and as such will not appear in the result of a Docker "inspect." This sometimes causes incompatibilities with certain tools that require a Docker bridge IP. We are already working with the Docker community to make sure a future version of Docker can handle overlay networks more cleanly.

If you are facing issues with cross host communication, please refer to our troubleshooting [documentation]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/faqs/troubleshooting/#cross-host-communication).
