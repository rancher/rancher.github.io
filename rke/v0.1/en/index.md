---
title: rke Documentation
description: Rancher Kubernetes Engine, an extremely simple, lightning fast Kubernetes installer that works everywhere.
---

## Overview of rke
---
rke is the easiest way to install a Kubernetes cluster. The only things you need are the `rke` binary, a `cluster.yml` file describing your cluster and one or more machines. After running `rke up`, your cluster will be built and only a few mins later it is ready to be used.

rke can use any machine to build a Kubernetes cluster. You can provide any machine (in the cloud, local virtual machines or on-premise), as long as it is reachable through SSH, and has a supported version of Docker installed. After assigning one or more roles to one or more machines, rke will build your cluster accordingly.

### Requirements

* a Linux or MacOS machine to run the `rke` binary
* one or more Linux machines to be used in your Kubernetes cluster with Docker installed and at least 1 core and 1GB of RAM
* Port TCP/6443 opened between the machine running `rke` and the machine functioning as `controlplane`.

### Getting started

To find out more about using rke, jump to our [Quick Start Guide]({{page.rkebaseurl}}/quick-start-guide/).

### Latest Release

Please check our repository for the [latest release](https://github.com/rancher/rke/releases).

<br>
<br>
