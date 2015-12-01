---
title: Environments within Rancher
layout: rancher-default
---

## Sharing Environments
---

### What is an Environment?

An environment is a way to share deployments and resources with different sets of users. Within each environment, you have the ability to invite others so it makes it easy to collaborate with others. By adding users to your environment, they will have the also have the ability to create deployments and manage resources. 

> **Note:** Infrastructure resources cannot be shared across multiple environments. [Registries]({{site.baseurl}}/rancher/configuration/registries/) and [API-Keys]({{site.baseurl}}/rancher/configuration/api-keys/) are also environment specific.  

The first time that you log in to Rancher, you are working in a **Default** environment. This environment can be renamed, shared with others, or you can create additional environments to share with users. The environment that you're working in is always displayed in the upper right corner of the screen.

### Adding Environments

To add new environments, you'll need to navigate to the **Manage Environments** page. There are a couple of ways to get to the page.

* In the environment drop down, the **Manage Environments** link is at the bottom of the list of environments. 
* In the account drop down, the **Environments** link is under the **Settings** section.

After navigating to the **Environments** page, you will see a list of environments.

Click on **Add Environment**. Each environment will have its own name, description, and members. Depending on the authentication type, the members can be any individual user. 

> **Note:** If you have not configured [Access Control]({{site.baseurl}}/rancher/configuration/access-control/), all environments will be available to anyone accessing Rancher. There will be no restriction of membership for any environments.

There are two ways to add members to an environment. Provide username for the authentication. Click on the **+** to add the name to the list of members. If the name is not on the list, then they will not be added to the environment. Alternatively, there is a dropdown button on the right side of the **+** button, which will show organizations/teams for certain authentication types. 

For each member (i.e. individual, team, or organization), you can define the role to be either an owner, a member or read only user. By default, they are added to the list as a member. You can change their role in the dropdown next to their name. As an owner, you can always change the list of members and their roles at any time, but only owners have the ability to change the membership and membership roles of the environment.

Click on **Create** and the environment will immediately be available to all members and owners. At this point, anyone, that the environment is shared with, can start adding [services]({{site.baseurl}}/rancher/services/)!. adding [hosts]({{site.baseurl}}/rancher/rancher-ui/infrastructure/hosts/) and anything else that a member can do.

### Deactivating and Deleting Environments

After creating environments, owners might want to deactivate or delete the environment. 

Deactivating an environment will remove the viewing ability from any members of the environment. All owners will still be able to view and activate the environment. You will not be able to change the membership of the environment until it's been re-activated. Nothing will change with your services or infrastructure. Therefore, if you want to make any changes to your services/infrastructure, you'll need to make these changes before your environment is deactivated.

In order to delete an environment, you will need to first deactivate it. All registries, balancers and API keys created in the environment will be removed from Rancher.

> **Note:** When deleting an environment, as of v0.37.0, the hosts **will** be removed from the cloud providers. Prior to v0.37.0, the hosts were **not** removed, so please make sure to check your cloud provider after deleting an environment.

### Editing Members

Only owners can change the membership to an environment at any time. If an environment is a deactivated state, owners can still edit the membership of it. In the **Manage Environments** page, they will be able to **Edit** the environment. In the edit page, they will be able to add additional members by finding their names and clicking on the **+** button or selecting a name from the dropdown menu. 

If there are any members that you want to delete, click on the **X** next to their name in the list of members. Remember that if you delete an individual user, they could still have access to the environment if they are part of a team or organization that is a member of the environment.  

Owners can also change the roles of anyone on the member list. Just select the role that you want for the particular user.

### Membership Roles 

#### Owners

An owner of an environment has the ability to change the status of an environment and change the membership of an environment. Within the membership list, the owner can also change the roles of other members of the environment. 

Any actions available within the **Applications** or **Infrastructure** tabs are available to owners. 

#### Members

A member of an environment can perform any action available within the **Applications** or **Infrastructure** tabs. The only difference from an owner and member is that members cannot change the membership of the environment. They will not be able to add/remove members or change the membership roles of existing members. 

#### Restricted

A restricted role of an environment is able to perform all actions on the **Applications** tab, i.e. adding/editing/removing stacks/services. For any container of a service, they can perform all actions, i.e. start, stop, delete, upgrade, clone, and edit. There is nothing restricted regarding actions related to stacks, services, and containers. 

The restriction of their role is regarding **Hosts. They are only able to view hosts of an environment and will not be able to add/edit/remove hosts in the environment.

> **Note:** Restricted users will not be able to add/remove host labels and will need to request a member/owner to make any changes to host labels. 

#### Read Only 

A read only role of an environment is only able to view all resources in the environment. They can view hosts, stacks, services, containers, but they will be unable to perform any actions to create, edit, or remove them. 

> **Note:** With this role, they will be able to view logs of a container.




