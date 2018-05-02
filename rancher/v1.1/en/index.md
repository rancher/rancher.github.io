---
title: Overview of Rancher
layout: rancher-default-v1.1
version: v1.1
lang: en
redirect_from:
  - /rancher/v1.1/
  - /rancher/v1.1/zh/
---

## Overview of Rancher
---

Rancher is an open source software platform that enables organizations to run containers in production. With Rancher, organizations no longer have to build a container services platform from scratch using a distinct set of open source technologies. Rancher supplies the entire software stack needed to manage containers in production.

Rancher software consists of four major components:

### Infrastructure Orchestration

Rancher takes in raw computing resources from any public or private cloud in the form of Linux [hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/). Each Linux host can be a virtual machine or physical machine. Rancher does not expect more from each host than CPU, memory, local disk storage, and network connectivity. From Rancher’s perspective, a VM instance from a cloud provider and a bare metal server hosted at a colo facility are indistinguishable.

Rancher implements a portable layer of infrastructure services designed specifically to power containerized applications. Rancher infrastructure services include [networking]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/networking), [storage]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/storage-service/), [load balancer]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/load-balancer/), [DNS]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/dns-service/), and security. Rancher infrastructure services are typically deployed as containers themselves, so that the same Rancher infrastructure service can run on any Linux hosts from any cloud.

### Container Orchestration and Scheduling

Many users choose to run containerized applications using a container orchestration and scheduling framework. Rancher includes a distribution of all popular container orchestration and scheduling frameworks today, including [Docker Swarm]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/swarm), [Kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes), and [Mesos]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/mesos/). The same user can create multiple Swarm or Kubernetes clusters. They can then use the native Swarm or Kubernetes tools to manage their applications.

In addition to Swarm, Kubernetes, and Mesos, Rancher supports its own container orchestration and scheduling framework called Cattle. Cattle was originally designed as an extension to Docker Swarm. As Docker Swarm continues to develop, Cattle and Swarm started to diverge. Rancher will therefore support Cattle and Swarm as separate frameworks going forward. Cattle is used extensively by Rancher itself to orchestrate infrastructure services as well as setting up, managing, and upgrading Swarm, Kubernetes, and Mesos clusters.

### Application Catalog

Rancher users can deploy an entire multi-container clustered application from the application [catalog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog) with one click of a button. Users can manage the deployed applications and perform fully automated upgrades when new versions of the application become available. Rancher maintains a public catalog consisting of popular applications contributed by the Rancher community. Rancher users can [create their own private catalogs]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/private-catalog/).

### Enterprise-Grade Control

Rancher supports flexible user authentication plugins and comes with pre-built user [authentication integration]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/) with Active Directory, LDAP, and GitHub. Rancher supports Role-Based Access Control (RBAC) at the level of [environments]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/), allowing users and groups to share or deny access to, for example, development and production environments.

The following figure illustrates Rancher’s major components and features.

<img src="{{site.baseurl}}/one-point-x/img/rancher/rancher_overview_2.png" width="800" alt="Rancher Overview">
