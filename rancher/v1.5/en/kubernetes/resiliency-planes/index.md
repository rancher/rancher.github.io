---
title: Kubernetes - Resiliency Planes
layout: rancher-default-v1.5
version: v1.5
lang: en
---

## Kubernetes - Resiliency Planes
---

For production deployments, it is best practice that each plane runs on dedicated physical or virtual hosts. For development, multi-tenancy may be used to simplify management and reduce costs.

#### Data Plane

This plane is comprised of one or more **etcd** containers. Etcd is a distributed reliable key-value store which stores all Kubernetes state. This plane may be referred to as stateful, meaning the software comprising the plane maintains application state.

#### Orchestration Plane

This plane is comprised of stateless components that power our Kubernetes distribution.

#### Compute Plane

This plane is comprised of the Kubernetes [pods](https://kubernetes.io/docs/user-guide/pods/).

### Planning

Before installation, it is important to consider your specific use case. Rancher provides two different deployment types. At a high level, the major distinction between deployment types may be described by answering the following questions:

1. Is the system performant?
2. Is the system fault-tolerant?
3. Is the system low cost?

If you're looking for a quick way to launch Kubernetes to start testing out Kubernetes, we recommend launching Kubernetes with [overlapping planes](#overlapping-planes). By default, this is the setting in the default Kubernetes template.

For production environments, Rancher recommends launching Kubernetes using [separated planes](#separated-planes).

### Installation

#### Overlapping Planes

By default, Kubernetes is configured to deploy on overlapping planes. All planes overlap and all services could run on a single host. Services are scheduled randomly. Add at least three hosts to make the data plane (i.e. etcd) resilient.

1. Create a Kubernetes environment.
2. Add 1 or more hosts with at least 1 CPU, 2GB RAM. Resource requirements vary depending on workload.

#### Separated Planes

This deployment allows the user to separate the planes by dedicating specific hosts for each plane type. It provides data plane resiliency and compute plane performance guarantees. You will need to configure Kubernetes before adding the hosts.

##### Kubernetes Configuration  

When [configuring Kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#configuring-kubernetes), select `required` for **Plane Isolation**.

##### Adding Hosts with Host Labels

All hosts added into a Kubernetes environment must be labeled so Rancher could separate the planes. A minimum of five hosts is required for this deployment type.

1. Data Plane: Add 3 or more hosts with 1 CPU, >=1.5GB RAM, >=20GB DISK. When adding the host, [label these hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#host-labels) with `etcd=true`.
2. Orchestration Plane: Add 1 or more hosts with >=1 CPU and >=2GB RAM. When adding the host, [label these hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#host-labels) with `orchestration=true`.
3. Compute Plane: Add 1 or more hosts. When adding the host, [label these hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#host-labels) with `compute=true`.

> **Note:** Host labels can be added to existing hosts to add them to a plane, but we do not support attempting to change a host from one plane type to another plane type by changing labels. In order to change plane types, you can either delete the old plane label and delete all existing services on the host before adding a new plane label or update the labels and [upgrade Kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubneretes/upgrading/) to rebalance the containers based on the new plane labels.
