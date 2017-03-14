---
title: Stacks in Cattle Environments
layout: rancher-default-v1.5
version: v1.5
lang: en
---

## Stacks
---

A stack is a group of services. Stacks can be used to group together services that together implement an application.

### Adding Stacks

In the **Stacks** page, click **Add Stack**. You will need to provide a **Name** and click **Create**.

You will immediately be brought to the stack and can begin [adding services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/), [adding load balancers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/), [adding service aliases]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-service-alias), or [adding external services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-external-services).

> **Note:** Before starting any services, you'll need to have a least one host launched in Rancher. For more information on adding hosts to Rancher, see [documentation]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/).

Rancher also provides an option to import `compose` files. The `docker-compose.yml` and `rancher-compose.yml` files can be imported directly into the creation page of a stack. Files can either be uploaded into Rancher or pasted directly into the text box. Once you click the **Create** button, the stack is formed with associated services. The services from the `docker-compose.yml` will only be created, but not started. You will have to start them individually.

### Viewing Services in a Stack

From the stacks page, you can easily monitor all the stacks in your [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/). From each stack, you can expand the stack to show the individual services by clicking the carat next to the drop-down menu.

This will expand to show you any services within the stack as well as all the containers that are part of the service. You can click any individual container or service to go to the detailed page.

### Stack Configuration

As services are created, Rancher simultaneously creates a `docker-compose.yml` and `rancher-compose.yml` file of your stack. The `docker-compose` yaml file could be used outside of Rancher to start the same set of services using the `docker-compose` commands. For more information, see [docker-compose](https://docs.docker.com/compose/).

The `rancher-compose.yml` file is used to manage the additional information used by Rancher to start services. These fields are not supported inside the docker-compose file.

With these files, you can also use Rancher Compose to start services that will be included in Rancher. For more information, see [Rancher Compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/rancher-compose/).

#### Viewing Configurations

In the stack drop-down, you can select **View Config** or click the **file icon**.

#### Exporting Configurations

The following are the options to export the configuration files.

Option 1: Download a zip file that contains both `docker-compose.yml` and `rancher-compose.yml` by selecting **Export Config** in the stack drop-down menu.

Option 2: Copy the file to your clipboard by clicking the icon next to the filename that you want to copy. You can copy either the `docker-compose.yml` file or the `rancher-compose.yml` file.

### Graph View

You can view the stack in another view, which shows how all the services/balancers are related to each other. If they are linked together, there is a connection between the service names.

Clicking the **graph icon** shows this view.

#### Editing Services

All of Rancher services are created differently, but after creation, they all have the same options within their drop-down menu. All the options for the services and load balancers are the same.

#### Scaling

For services and load balancers, you can quickly increase the number of containers in the service by clicking the **+ Scale Up** link. This link is located as an additional container in the service.

> **Note:** For load balancers, if you scale up to a quantity that is higher than the number of hosts with available public ports, the balancer will be stuck in **Updating-Active** state. You will need to start a new service if you need any of those type of changes. If it is stuck, the workaround is to **Stop** the balancer and change the scale back to the number of available hosts.

You can also increase or decrease the number of containers in a service by selecting **Edit** option in the drop-down menu for the service. The drop-down menu is visible when hovering over the service. Move the slider for **Scale** to change the number containers in the service.

#### Editing

There are limited options for editing a service because Docker containers are immutable (not changeable) after creation. The only artifacts you can edit are the things that Rancher stores that aren't really part of the Docker container. This includes restarting; it's still the same container if you stop and start it. You will need to remove and recreate a service to change anything else. An easy way to make changes to a service is to **Clone** the service.

To see what you can change, select **Edit** in the drop-down menu of the service. The name, description, and scale can be changed for all services. If you forgot to link your service when you had set it up, you will have the ability to link services through this option for any of our services. For example, services, load balancers, service alias, and external service.

For services, most of the options do not have the ability to change dynamically. Docker containers are immutable (not changeable) after creation. To get around this limitation, you can **Clone** a service. This will set up launching a service with the same parameters. You'll be able to make changes before creating a new service or container.

#### Cloning

You can clone any service, which will have saved all the configuration. Any linking to the original service will not be cloned. You need to edit the services that are linking to the original service and add the newly cloned service so that those services would now link to the new service.

Example:

AppA is linked to AppB. If you clone AppB and create AppC, then AppA will not be linked to AppC. The only way to link is to edit AppA to link to AppC.

#### Stopping

You can stop individual services or all services in a stack at once. If you want to stop an individual service, select **Stop** from the service drop-down menu. If you decide to stop all the services in the stack, you can select **Stop Services** from the stack drop-down menu.

#### Deleting

You can delete individual services/balancers or delete an entire stack. When you select **Delete** for the individual service/balancer, it will stop the containers before removing them from the host. There might be a slight delay because Rancher cleans up the containers before they are deleted from the UI.
