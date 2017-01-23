---
title: Environments in Rancher
layout: rancher-default-v1.1
version: v1.1
lang: en
redirect_from:
  - /rancher/v1.1/en/configuration/environments/
  - /rancher/v1.1/zh/configuration/environments/
  - /rancher/v1.1/zh/environments/
---

## Environments
---

### What is an Environment?

Environments are a fundamental construct in Rancher. For example, you may want to create a “dev” environment and a separate “production” environment with its own set of resources and limited user access for your application deployment.

All hosts and any Rancher resources, such as containers, load balancers, and so on are created in and belong to an environment. In addition, you choose what container orchestration and scheduling frameworks you would like to use in this environment, and Rancher automatically sets up the right framework for you. Access control permissions for viewing and managing these resources are then defined by the owner of the environment. Rancher currently supports the capability for each user to manage and invite other users to their environment and allows for the ability to create multiple environments for different workloads.

We recommend setting up [access control]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/) before you share environments with users. By adding users to your environment, they will also have the ability to create deployments and manage resources.

> **Note:** Infrastructure resources cannot be shared across multiple environments. [Registries]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/registries/), [certificates]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/certificates/) and [API keys]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-keys/) are also environment specific.  

### Types of Environments

Rancher supports different cluster management frameworks when creating environments.

* **Cattle** is the default Rancher managed environment.
* **Kubernetes** will automatically plumb in the network for container communication and all hosts that are added into Rancher will automatically be added to Kubernetes.
* **Mesos** allows any Rancher added hosts to automatically be added to the Mesos cluster.
* **Swarm** allows any Rancher added hosts to automatically be added to the Swarm cluster.

The first time that you log in to Rancher, you are working in a **Default** Cattle environment. This environment can be renamed, shared with others, or you can create additional environments to share with users. The environment that you're working in is always displayed in the upper right corner of the screen.

> **Note:** As Rancher adds support for multiple cluster management frameworks, Rancher currently does not support the ability to switch between environments that already have services running in it.

### Adding Environments

To add new environments, you'll need to navigate to the **Manage Environments** page by clicking on the environment name, which provides a drop down of available environments as well a link to **Manage Environments**.

After navigating to the **Environments** page, you will see a list of environments. If you are an [admin]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/accounts/#admin) of Rancher, you will see a list of everyone's environment, even if you are not invited to be a [member]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#membership-roles) of that environment.

Click on **Add Environment**. Select which **Cluster Management** environment that you want use. Each environment will have its own name, description, and members.

> **Note:** If you have not configured [Access Control]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/), all environments will be available to anyone accessing Rancher. There will be no restriction of membership for any environments.

There are two ways to add members to an environment. Provide the username and click on the **+** to add the name to the list of members. If the name is not on the list, then they will not be added to the environment. Alternatively, there is a dropdown button on the right side of the **+** button, which will show organizations/teams for certain authentication types.

For each member (i.e. individual, team, or organization), you can define the role to be either an [owner]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#owners), [member]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#members), [restricted user]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#restricted) or [read only user]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#read-only). By default, they are added to the list as a member. You can change their role in the dropdown next to their name. As an owner, you can always change the list of members and their roles at any time, but only owners have the ability to change the membership and membership roles of the environment.

Click on **Create** and the environment will immediately be available to anyone on the member list.

### Deactivating and Deleting Environments

After creating environments, owners might want to deactivate or delete the environment.

Deactivating an environment will remove the viewing ability from any members of the environment. All owners will still be able to view and activate the environment. You will not be able to change the membership of the environment until it's been re-activated. Nothing will change with your services or infrastructure. Therefore, if you want to make any changes to your services/infrastructure, you'll need to make these changes before your environment is deactivated.

In order to delete an environment, you will need to first deactivate it. All registries, balancers and API keys created in the environment will be removed from Rancher. Any hosts created through the Rancher UI, which launches hosts using `docker-machine`, will also be removed from the cloud provider. If you have added a host using the [custom]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/) option, then the host will not be removed from the cloud provider.

### Editing Members

Only owners can change the membership to an environment. If an environment is in a deactivated state, owners can still edit the membership of it. In the **Manage Environments** page, they will be able to **Edit** the environment. In the edit page, they will be able to add additional members by finding their names and clicking on the **+** button or selecting a name from the dropdown menu.

If there are any members that you want to delete, click on the **X** next to their name in the list of members. Remember that if you delete an individual user, they could still have access to the environment if they are part of a team or organization that is a member of the environment.  

Owners can also change the roles of anyone on the member list. Just select the role that you want for the particular user.

### Membership Roles

#### Owners

An owner of an environment has the ability to change the status of an environment and change the membership of an environment. Within the membership list, the owner can also change the roles of other members of the environment.

Any actions available within the **Stacks** or **Infrastructure** tabs are available to owners.

#### Members

A member of an environment can perform any action available within the **Stacks** or **Infrastructure** tabs. The only difference from an owner and member is that members cannot change the membership of the environment. They will not be able to add/remove members or change the membership roles of existing members.

#### Restricted

A restricted role of an environment is able to perform all actions on the **Stacks** tab, i.e. adding/editing/removing stacks/services. For any container of a service, they can perform all actions, i.e. start, stop, delete, upgrade, clone, and edit. There is nothing restricted regarding actions related to stacks, services, and containers.

The restriction of their role is regarding **Hosts**. They are only able to view hosts of an environment and will not be able to add/edit/remove hosts in the environment.

> **Note:** Restricted users will not be able to add/remove host labels and will need to request a member/owner to make any changes to host labels.

#### Read Only

A read only role of an environment is only able to view all resources in the environment. They can view hosts, stacks, services, containers, but they will be unable to perform any actions to create, edit, or remove them.

> **Note:** With this role, they will still be able to view logs of a container.
