---
title: Kubernetes - Private Registry
layout: rancher-default-v1.5
version: v1.5
lang: en
---

## Kubernetes - Private Registry
---

While setting up kubernetes, it is possible to instruct Kubernetes to pull images from private registry mirrors, instead of pulling images from the standard registries. This is useful in airgapped setups, typically in enterprises. 

#### Private Registry Requirements
---

The private registry is expected to mirror both `docker.io` and `gcr.io`

You can verify this by pulling images from `docker.io` and `gcr.io` from the private registry

`docker pull $PRIV_REGISTRY:library/ubuntu:latest`  (exists only in dockerhub, this should work) 

`docker pull $PRIV_REGISTRY:google_containers/heapster:v1.2.0` (exists only in gcr.io, this should also work)
