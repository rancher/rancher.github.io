---
title: Kubernets in Rancher
layout: rancher-default
---

## Kubernetes
---

To deploy Kubernetes in Rancher, you'll first need to create a new [environment]({{site.baseurl}}/rancher/configuration/environments/) that has specified the cluster management to be Kubernetes. 

### Creating a Kubernetes Environment

In the dropdown of environments, click on the **Manage Environments**. A list of existing environments will be displayed. The _Default_ environment that is started when you launch Rancher is based on the _Cattle_ cluster management. You can choose to change the cluster management type of the _Default_ environment or  create a new environment that uses _Kubernetes_ as the cluster management.

To create a new environment, click on **Add Environment**, select **Kubernetes** as the cluster management, provide a **Name**, **Description** (Optional). If [access control]({{site.baseurl}}/rancher/configuration/access-control/) is turned on, you can [add members]({{site.baseurl}}/rancher/configuration/environments/#editing-members) and select their [membership role]({{site.baseurl}}/rancher/configuration/environments/#membership-roles). Anyone added to the membership list would have access to your environment. 

If you choose to change an existing environment's cluster management, click on **Edit** in the environment's dropdown. Change the cluster management to _Kubernetes_ and click on **Save**. 

After a Kubernetes environment has been created, you can navigate to the environment by either selecting the name of the environment in the environment's dropdown in the upper right hand corner or by selecting **Switch to this Environment** in the specific environment's drop down. 

### Starting Kubernetes

After a Kubernetes environment has been created, you can start adding hosts to the environment in the **Infrastructure** -> **Hosts** page. [Adding hosts]({{site.baseurl}}/rancher/rancher-ui/infrastructure/hosts) is the same steps for all cluster management types. When a host is added into a Kubernetes environment, it is automatically added to the Kubernetes cluster by starting a series of different containers. 

After you add your first host, in the **Kubernetes** tab, you will see the progress of adding the host to a Kubernetes cluster. A **system stack** will be created, which can be located in the **System** -> **Stacks** page. 

After hosts have been added to your Kubernetes cluster, you could use the Rancher [catalog]({{site.baseurl}}/rancher/rancher-ui/applications/catalog/) to add in templates of tested Kubernetes entries. 

In the **Kubernetes** tab, you can add services, replication controllers (RCs) or pods using a configuration file. We also provide access to the kubectl console. 




