---
title: Rancher Documentation
layout: rancher-default
version: latest
lang: en
redirect_from:
  - /
  - rancher/
  - rancher/latest/
---

## Overview of Rancher
---

Rancher is an open source software platform that implements a purpose-built infrastructure for running containers in production. Docker containers, as an increasingly popular application workload, create new requirements in infrastructure services such as networking, storage, load balancer, security, service discovery, and resource management.

### Computing Resources

Rancher takes in raw computing resources from any public or private cloud in the form of Linux hosts. Each Linux host can be a virtual machine or a physical machine. Rancher does not expect more from each host than CPU, memory, local disk storage, and network connectivity. From Rancher's perspective, a VM instance from a cloud provider and a bare metal server hosted at a colo facility are indistinguishable.

### Key Features

Key product features of Rancher include: 

1. Cross-host networking. Rancher creates a private software defined network for each environment, allowing secure communication between containers across hosts and clouds.

2. Container load balancing. Rancher provides an integrated, elastic load balancing service to distribute traffic between containers or services. The load balancing service works across multiple clouds.

3. Persistent Storage Services. Rancher supports orchestrating Persistent Storage Services for Docker, making it possible for developers to deploy storage reliably in conjunction with containerized applications. The new feature builds on Docker 1.9 volume plugin capabilities, and makes it easier for developers to run applications that require stateful databases and persistent storage.

4.	Service discovery: Rancher implements a distributed DNS-based service discovery function with integrated health checking that allows containers to automatically register themselves as services, as well as services to dynamically discover each other over the network.

5.	Service upgrades: Rancher makes it easy for users to upgrade existing container services, by allowing service cloning and redirection of service requests.  This makes it possible to ensure services can be validated against their dependencies before live traffic is directed to the newly upgraded services. 

6.	Resource management: Rancher supports Docker Machine, a powerful tool for provisioning hosts directly from cloud providers. Rancher then monitors host resources and manages container deployment.

7. Multi-tenancy & user management: Rancher is designed for multiple users and allows organizations to collaborate throughout the application lifecycle. By connecting with existing directory services, Rancher allows users to create separate development, testing, and production environments and invite their peers to collaboratively manage resources and applications.

8. Multi Orchestration Engines. Rancher supports the ability for users to select the default Cattle, Kubernetes, or Docker Swarm as their container orchestration engine of choice when creating environments.  This will allow users to select market leading scheduling frameworks while still leveraging Rancher features such as the app catalog, enterprise user management, container networking, and storage technologies.

### Primary Consumption Interfaces

There are three primary ways for users to interact with Rancher:

1. Users can interact with Rancher through native Docker CLI or API. Rancher is not another orchestration or management layer that shields users from the native Docker experience. As Docker platform grows over time, a wrapper layer will likely be superseded by native Docker features. Rancher instead works in the background so that users can continue to use native Docker CLI and Docker Compose templates. Rancher uses Docker labels--a Docker 1.6 feature contributed by Rancher Labs--to pass additional information through the native Docker CLI.  Because Rancher supports native Docker CLI and API, third-party tools like Kubernetes work on Rancher automatically.
2. Users can interact with Rancher using a command-line tool called `rancher-compose`. The `rancher-compose` tool enables users to stand up multiple containers and services based on the Docker Compose templates on Rancher infrastructure. The `rancher-compose` tool supports the standard `docker-compose.yml` file format. An optional `rancher-compose.yml` file can be used to extend and overwrite service definitions in `docker-compose.yml`.
3. Users can interact with Rancher using the Rancher UI. Rancher UI is required for one-time configuration tasks such as setting up access control, managing environments, and adding Docker registries. Rancher UI additionally provides a simple and intuitive experience for managing infrastructure and services.

The following figure illustrates Rancher's major features, its ability to run any clouds, and the three primary ways to interact with Rancher.

<img src="{{site.baseurl}}/img/rancher/rancher_overview.png" width="800" alt="Rancher Overview">

### Outline of This Guide

It is easy to get Rancher up and running. If you have access to a Linux VM on your laptop or in a cloud, go to the [Quick Start Guide]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/quick-start-guide/) to get started right away.

If you are ready to set up a production-grade Rancher installation, follow the instructions in the [Installing Rancher]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/) to setup a Rancher server and add hosts into the Rancher installation.

Before you start using Rancher, make sure to read through the [Concepts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/concepts/) section to understand how Rancher works.

The [Configuration]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/) section documents how you perform various one-time tasks after you complete installation of Rancher and start using Rancher.

The next three sections--[Using Rancher Through Native Docker CLI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/native-docker/), [Rancher Compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-compose), and [Rancher UI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/adding-services/)--covers three primary ways you can consume Rancher features.

The [Upgrading Rancher]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/upgrading) section is essential if you run Rancher in production.

The [Contributing to Rancher]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/contributing) section contains information on how you can participate in the Rancher open source community.


