---
title: Adding Service Alias
layout: rancher-default-v1.0
version: v1.0
lang: en
---

## Adding Service Alias
---

By adding a service alias, it provides the ability to point to service aliases instead of directly at services. Inside your stack, you add a service alias by clicking on the dropdown icon next to the **Add Service** button. Select **Service Alias**. Alternatively, if you are viewing the stacks at the stack level, the same **Add Service** dropdown is visible for each specific stack.

You will need to provide a **Name** and if desired, **Description** of the service. The **Name** will be the service alias for the service that you select. 

Select the target(s) that you want to add the alias to. The list of available targets is any service that is already created in the stack. Finally, click **Create**.

The list of services that the alias is serving is shown in the service view. Just like our services, you will need to have the service alias started before it is working.

### Adding/Removing services

At any time, you can edit the services in a service alias. Click on the **Edit** within the service's dropdown menu. You will have the ability to add more services to the alias or remove existing services.
