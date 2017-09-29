---
title: Rancher v2.0 FAQ
layout: rancher-default-v2.0
version: v2.0
lang: en
---

## Rancher v2.0 FAQ
---

This FAQ is a work in progress designed to answers the questions our users most frequently ask about Rancher v2.0.

### Kubernetes

#### What does it mean when you say Rancher v2.0 is built on Kubernetes?

Rancher v2.0 is a complete container management platform built on Kubernetes, which means that:

*	The Rancher-Kubernetes distribution powers the embedded Kubernetes master and enables easy setup and operations of Kubernetes clusters.
*	Rancher imports existing Kubernetes clusters built using other tools, like kops, or operated by cloud providers, like GKE.
*	Rancher manages Kubernetes clusters across any infrastructure, including public cloud, private cloud, virtualization clusters, and bare metal servers.
*	Rancher enables multi-cluster management across both embedded clusters and imported clusters.
*	In addition to the native Kubernetes UX via `kubectl` or dashboard, Rancher also offers a compelling user experience built on Kubernetes.

#### Do you plan to implement upstream Kubernetes, or continue to work on your own fork?

 We're still going to provide our distribution when you select the default option of having us manage your Kubernetes cluster, but it will be very close to upstream. We're adding a few enhancements, like integration with a MySQL database and making the Kubernetes master multi-tenant to support multiple clusters.

#### Does this release mean that we need to re-train our support staff in Kubernetes?

No. You don't need to learn Kubernetes, but you'll have it as an option if you want to leverage any integrations that work directly with the Kubernetes API. However, nothing from a UI or operations perspective is changing with the move to Kubernetes. Operations remain the same.

#### So, wait. Is a Rancher compose going to make a Kubernetes pod? Do we have to learn both now? We usually use the filesystem layer of files, not the UI.

You do not need to learn both, but you'll have access to both and can easily use either depending on what makes most sense.

### Cattle

#### How does Rancher v2.0 affect Cattle? Does this release mean that my knowledge and experience invested in Cattle is about to become deprecated?

We definitely are NOT deprecating Cattle. On the contrary, we improved it. In v2.0, Rancher now bases its architecture and every cluster/environment on Kubernetes. While v1.0 already supported installing, operating, and managing Kubernetes environments, we've always felt that it didn't mesh with the rest of the Rancher user experience (UX). We remedied that in v2.0. Not only do you get access to the native Kubernetes dashboard UI and `kubectl`, but now the Rancher UX, formerly known as the Cattle UX (CLI, API, and Docker compose) works directly with Kubernetes.

Think of v2.0 as an enhanced add-on to the Kubernetes platform in which you can continue to use all of the existing Rancher features you know and love, while leveraging the rich Kubernetes ecosystem and its rapid innovations.

#### Can I migrate/import existing Cattle clusters into Kubernetes?

Yes. You can run the exact same Rancher compose and Docker compose files against a new cluster and recreate all of your deployments identically.

### Environments & Clusters

#### Can I still create templates for environments and clusters?

Yes. This feature still exists, except that you can no longer select Swarm or Mesos.

#### Can you still add an existing host to an environment? (i.e. not provisioned directly from Rancher)

Yes. We still provide you with the same way of executing our Rancher agents directly on hosts.

#### Can you showcase how you share host between rancher environments?

We've introduced the concept of a cluster in v2.0, which is a group of hosts. Rancher allows you to create multiple environments, which translates to a Kubernetes namespace, on a single cluster. [Watch this demo](https://www.youtube.com/watch?v=Ma6FsuWI2Nc&feature=youtu.be) for more information.

### Support

#### What about Rancher v1.6? Are you planning some long-term support releases?

That is definitely the focus of the v1.6 stream. We're continuing to improve that release, fix bugs, and maintain it for the next 12 months at a minimum.

#### Are you planning to drop Mesos and Swarm?

While we're focusing on Kubernetes and the Cattle UX in Rancher v2.0, both Mesos and Swarm will continue to be available as Catalog applications. However, Mesos and Swarm will no longer be an option you can select when creating a v2.0 environment.

#### Which databases does Rancher v2.0 support?

The Rancher database remains MySQL.

#### What about Windows support?

We plan to provide Windows support for v2.0 based on Microsoft’s new approach to providing an overlay network using Kubernetes and CNI. This new approach matches well with what we are doing in v2.0 and, once that is complete, you will be able to leverage the same Rancher UX, or Kubernetes UX, but with Windows. We are in the middle of discussing how we can make this happen with Microsoft, and we will provide more information before the end of this year.

### General

#### How does this architectural change impact how we start Rancher?

Unlike Rancher v1.0, Rancher v2.0 includes an embedded Kubernetes master. Therefore, as soon as you start Rancher using this command, for example, you immediately have a Kubernetes cluster up and running:

```bash
$ docker run -d -p 8080:8080 rancher/server
```

You simply need to add compute nodes to complete your first Kubernetes cluster.

#### Can I export all of the configuration performed in the UI to config files, to serve as a source for (re)building "infrastructure-as-code"?

Yes. As in v1.x, all configuration performed in the UI always creates a compose file that you can export for reuse.

#### Can we still add our own infrastructure services, which had a separate view/filter in 1.6.x?

Yes. We plan to eventually enhance this feature so you can manage Kubernetes storage, networking, and its vast ecosystem of add-ons.

#### Can you share some thoughts on how you plan to integrate the CI/CD process into the mix?

Rancher will add a CI/CD pipeline soon after v2.0 launches. We plan to showcase it at our monthly Meetup in November.

#### Will the networking options in Rancher v2.0 change?

With 2.0, our users continue to have the option of using either Rancher’s IPSec or VXLAN overlay solutions, or using any of the third-party CNI networking plugins in embedded clusters. Because an imported cluster already has a networking plugin plugged in, Rancher supports it by default and doesn't force users to install our networking solutions. Users can continue to make their own networking choices.

#### Are you going to integrate Longhorn?

Yes. Longhorn was on a bit of a hiatus while we were working on v2.0. We plan to re-engage on the project once v2.0 reaches GA (general availability).

#### How would the migration from v1.x to v2.0 work?

The migration of v1.x workloads to v2.0 will require you to “replay” the same compose files you used in v1.x into a v2.0 environment.

#### Will the API reflect differences as well?

Yes. Everything in the Rancher UI is always built on the API.

#### Are there changes to default roles available now or going forward? Will the Kubernetes alignment impact plans for roles/RBAC?

The default roles remain the same in v2.0, but we now take advantage of the Kubernetes RBAC (Role-Based Access Control) capabilities to give you more flexibility.
