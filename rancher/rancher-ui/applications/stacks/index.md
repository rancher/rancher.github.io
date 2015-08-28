---
title: Stacks
layout: rancher-default
---

## Stacks
---

### Adding Stacks

In the **Applications** -> **Stacks** page, click on **Add Stack**. You will need to provide a **Name** and click **Create**. 

You will immediately be brought to the stack and can begin [adding services]({{site.baseurl}}/rancher/rancher-ui/applications/stacks/adding-services/), [adding load balancers]({{site.baseurl}}/rancher/rancher-ui/applications/stacks/adding-balancers/), [adding service aliases]({{site.baseurl}}/rancher/rancher-ui/applications/stacks/adding-service-alias), or [adding external services]({{site.baseurl}}/rancher/rancher-ui/applications/stacks/adding-external-services).

> **Note:** Before deploying any services, you'll need to have a least 1 host launched in Rancher. Please follow our [documentation]({{site.baseurl}}/rancher/rancher-ui/infrastructure/hosts) to learn how to add hosts to Rancher.

### Viewing Services in a Stack 

From the stacks page, you can easily monitor all your stacks in your [environment]({{site.baseurl}}/rancher/configuration/environments/). From each stack, you can expand the stack to show the individual services by clicking on the carat next to the dropdown menu.

This will expand to show you any services within the stack as well as all the containers that are part of the service. You can click on any individual container or service to go to the detailed page.

## Stack Configuration
---

As services are created, we simultaneously create a `docker-compose.yml` and `rancher-compose.yml` file of your stack. The `docker-compose` yaml file could be used outside of Rancher to start the same set of services using the `docker-compose` commands. Read [here](https://docs.docker.com/compose/) for more information on `docker-compose`. 

The `rancher-compose.yml` file is used to manage the additional information used by Rancher to start services. These fields are not supported inside the docker-compose file.

With these files, you can also use `rancher-compose` to start services that will be included in Rancher. For more details, please read about [rancher-compose]({{site.baseurl}}/rancher/rancher-compose/).

### Viewing Configurations

In the stack dropdown, you can select **View Config** or click on the **file icon**.

### Exporting Configurations

There are a couple of options to export the files. 

Option 1: Download a zip file that contains both files by selecting **Export Config** in the stack dropdown menu.

Option 2: Copy the file to your clipboard by clicking on the icon next to the file name that you want to copy. You can copy either the `docker-compose.yml` file or the `rancher-compose.yml` file. 

![Services Options on Rancher 1]({{site.baseurl}}/img/rancher/rancher_stacks_1.png)

## Graph View 
---

We can view the stack in another view, which shows how all services/balancers are related to each other. If they are linked together, there is a connection between the service names. 

Clicking on the **graph icon** will show this view.

### Editing Services
---

All of our services are created differently, but after creation, they all have the same options within their dropdown menu. All options for the services and balancers are the same. 

### Scaling

For services and load balancers, you can quickly increase the number of containers in the service by clicking on **+ Scale Up** link. This link is located as an additional container in the service.

> **Note:** For load balancers, if you scale up to a quantity that is higher than the number of hosts with available public ports, the balancer will be stuck in **Updating-Active** state. You will need to start a new service if you need any of those type of changes. If it is stuck, the workaround is to **Stop** the balancer and change the scale back to the number of available hosts.

You can also increase or decrease the number of containers in a service by selecting **Edit** on the dropdown menu for the service. The dropdown menu is visible when hovering over the service. Move the slider for **Scale** to change the number containers in the service.

### Editing 
There are limited options for editing a service as Docker containers are immutable (not changeable) after creation. Rhe only things you can edit are things that we store that aren't really part of the Docker container. This includes restarting, it's still the same container if you stop and start it. You will need to remove and recreate a service to change anything else. An easy way to make changes to a service is to **Clone** the service. 

To see what you can change, you select **Edit** on the dropdown menu of the service. The name, description and scale can be changed for all services. If you forgot to link your service when you had set it up, you will have the ability to link services through this option for any of our services (i.e. services, load balancers, service alias and external service).

For services, the advanced options and port mapping do not have the ability to change dynamically. Docker containers are immutable (not changeable) after creation. To get around this limitation, you can **Clone** a service. This will set up launching a service with the same parameters. You'll be able to make changes before creating a new service or container. 

### Cloning

You can clone any service, which will have saved all the configuration. Any linking **to** the original service will not be cloned. You would need to edit the services that are linking **to** the original service and add the newly cloned service so that those services would now also link to the new service.

Example:

AppA is linked to AppB. If I clone AppB and create AppC, then AppA will not be linked to AppC. The only way to link is to edit AppA to link to AppC.

### Stopping 

You can stop individual services or all services in a stack at once. If you want to stop an individual service, select **Stop** from the service dropdown menu. If you decide to stop all services in the stack, you can select **Stop Services** from the stack dropdown menu.

### Deleting

You can delete individual services/balancers or delete an entire stack. When you select **Delete** for the individual service/balancer, it will stop the containers before removing them from the host. There might be a slight delay as we clean up the containers before they are deleted from the UI.

