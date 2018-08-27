---
title: Environments in Rancher
layout: rancher-default-v1.3
version: v1.3
lang: en
redirect_from:
  - /rancher/v1.3/zh/environments/
---

## Environments
---

### What is an Environment?

Rancher supports grouping resources into multiple environments. Each environment starts with a set of [infrastructure services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/) defined by the [environment template](#what-is-an-environment-template) used to create the environment. Each environment has its own set of resources, and is owned by one or more users or groups. For example, you might create separate "dev", "test", and "production" environments to keep things isolated from each other, and give "dev" access to your entire organization but restrict the "production" environment to a smaller team.

All hosts and any Rancher resources, such as containers, infrastructure services, and so on are created in and belong to an environment.

### Adding Environments

To add new environments, hover over the name of your current environment that you are in, which is in the upper left hand corner. A drop down of all available environments as well a link to **Manage Environments** will appear. Click on **Manage Environments**.

After navigating to the **Environments** page, you will see a list of environments and a list of environment templates. If you are an [admin]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/accounts/#admin) of Rancher, you will see a list of everyone's environment, even if you are not invited to be a [part of]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#membership-roles) of that environment. For all users, all environment templates will be available.

Click on **Add Environment**. Each environment will have its own name and description. You will select which environment template to use. In each environment template, you will be able to see which infrastructure services are enabled in the template.

> **Note:** If you have not configured [Access Control]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/), all environments will be available to anyone accessing Rancher. There will be no restriction of membership for any environments.

There are two ways to add members to an environment. Provide the username and click on the **+** to add the name to the list of members. If the name is not on the list, then they will not be added to the environment. Alternatively, there is a dropdown button on the right side of the **+** button, which will show organizations/teams for certain authentication types.

For each member (i.e. individual, team, or organization), you can define the role to be either an [owner](#owners), [member](#members), [restricted user](#restricted) or [read only user](#read-only). By default, they are added to the list as a member. You can change their role in the dropdown next to their name. As an owner, you can always change the list of members and their roles at any time, but only owners have the ability to change the membership and membership roles of the environment.

> **Note:** Only owners and admins will be able to see [infrastructure services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/) of an environment.

Click on **Create** and the environment will immediately be available to anyone on the member list. After the environment is created and hosts added, the infrastructure services enabled for the environment will begin to deploy.

### Deactivating and Deleting Environments

After creating environments, owners might want to deactivate or delete the environment.

Deactivating an environment will remove the viewing ability from any members of the environment. All owners will still be able to view and activate the environment. You will not be able to change the membership of the environment until it's been re-activated. Nothing will change with your services or infrastructure. Therefore, if you want to make any changes to your infrastructure services, you'll need to make these changes before your environment is deactivated.

In order to delete an environment, you will need to first deactivate it. All registries, balancers and API keys created in the environment will be removed from Rancher. Any hosts created through the Rancher UI, which launches hosts using Docker Machine, will also be removed from the cloud provider by using Docker Machine. If you have added a host using the [custom]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/) option, then the host will not be removed from the cloud provider.

### Editing Members

Only owners can change the membership to an environment. If an environment is in a deactivated state, owners can still edit the membership of it. In the **Manage Environments** page, they will be able to **Edit** the environment. In the edit page, they will be able to add additional members by finding their names and clicking on the **+** button or selecting a name from the dropdown menu.

If there are any members that you want to delete, click on the **X** next to their name in the list of members. Remember that if you delete an individual user, they could still have access to the environment if they are part of a team or organization that is a member of the environment.  

Owners can also change the roles of anyone on the member list. Just select the role that you want for the particular user.

### Membership Roles

#### Owners

An owner of an environment has the ability to change the status or the membership of an environment. Within the membership list, the owner can also change the roles of other members of the environment.

Owners have the ability to change [infrastructure services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/) of an environment through the [catalog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog), as there is no method to edit environment templates. Environment templates are only used when creating an environment.

#### Members

A member of an environment can perform any actions in Rancher that do not affect the environment. They will not be able to add/remove members or change the membership roles of existing members or view any of the [infrastructure services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/).

#### Restricted

A restricted role of an environment is able to perform all actions related to stacks/services. For any container of a service, they can perform all actions, i.e. start, stop, delete, upgrade, clone, and edit. There is nothing restricted regarding actions related to stacks, services, and containers.

The restriction of their role is regarding **Hosts**. They are only able to view hosts of an environment and will not be able to add/edit/remove hosts in the environment.

> **Note:** Restricted users will not be able to add/remove host labels and will need to request a member/owner to make any changes to host labels.

#### Read Only

A read only role of an environment is only able to view all resources in the environment. They can view hosts, stacks, services, containers, but they will be unable to perform any actions to create, edit, or remove them.

> **Note:** With this role, they will still be able to view logs of a container.

### What is an Environment Template

An environment template allows users to define a different combination of infrastructure services to be deployed. The infrastructure services includes but not limited to container orchestration (i.e. cattle, [kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/), [mesos]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/mesos/), [swarm]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/swarm/)), [networking]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/networking/), rancher services (i.e [healthcheck]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/health-checks), [dns]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/dns-service/), [metadata]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/metadata-service/), [scheduling]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/), service discovery and [storage]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/storage-service/).

In Rancher, there are a set of default templates provided to leverage the various container orchestration options with the recommended infrastructure services. Some of these infrastructure services like our Rancher scheduler, will only be applicable to a cattle environment, but are required for other orchestration types as these services are used for launching other infrastructure services. Besides the default templates, you can create your own templates to choose what combination of infrastructure services that you would like to use in an environment. Only [owners](#owners) or [admins]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/#admin) can view and manage these infrastructure resources in an environment.

We recommend setting up [access control]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/) before you share environments with users. By adding users to your environment, they will also have the ability to create services and manage resources.

> **Note:** Infrastructure resources cannot be shared across multiple environments. [Registries]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/registries/), [certificates]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/certificates/) and [environment API keys]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-keys/) are also environment specific.  

### Adding Environment Templates

To add new environments, hover over the name of your current environment that you are in, which is in the upper left hand corner. A drop down of all available environments as well a link to **Manage Environments** will appear. Click on **Manage Environments**.

After navigating to the **Environments** page, you will see a list of environments and a list of environment templates. Click on **Add Template**

Pick a **Name** and **Description** for the template. Select how you want to share your template. Templates can either be private (i.e. only visible to yourself) or public (i.e. visible to admins).

[Infrastructure services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/) include but not limited to selecting container orchestration, [storage]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/storage-service/), and [networking]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/networking). The default infrastructure services required to have a working environment are automatically enabled.

### Editing & Deleting Environment Templates

After creating an environment template, you can edit which infrastructure services are enabled in the template. Even though environment templates can be changed, the existing environments based on the templates will not be updated to the new template. They will continue to have the original infrastructure services enabled in the environment.

At any time, you can delete the environment templates as they are only used when launching environments to indicate which infrastructure services should be launched. The templates are not directly tied to the environment so deleting them will not affect any environments.
