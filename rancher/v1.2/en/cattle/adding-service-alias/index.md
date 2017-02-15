---
title: Service Alias
layout: rancher-default-v1.2
version: v1.2
lang: en
redirect_from:
  - /rancher/rancher-ui/applications/stacks/adding-service-alias/
  - /rancher/v1.2/en/rancher-ui/applications/stacks/adding-service-alias/
  - /rancher/v1.2/zh/rancher-ui/applications/stacks/adding-service-alias/
  - /rancher/v1.2/zh/cattle/adding-service-alias/
---

## Service Alias
---

By adding a service alias, it provides the ability to point to service aliases instead of directly at services.

### Adding Service Aliases in the UI

Inside your stack, you add a service alias by clicking on the dropdown icon next to the **Add Service** button. Select **Service Alias**. Alternatively, if you are viewing the stacks at the stack level, the same **Add Service** dropdown is visible for each specific stack.

You will need to provide a **Name** and if desired, **Description** of the service. The **Name** will be the service alias for the service that you select.

Select the target(s) that you want to add the alias to. The list of available targets is any service that is already created in the stack. Finally, click **Create**.

The list of services that the alias is serving is shown in the service view. Just like our services, you will need to have the service alias started before it is working.

#### Adding/Removing services

At any time, you can edit the services in a service alias. Click on the **Edit** within the service's dropdown menu. You will have the ability to add more services to the alias or remove existing services.


### Adding Service Aliases with Rancher Compose

A service alias creates a pointer to service(s). In the example below, `web[.stack-name.rancher.internal]` will resolve to the IPs of the containers of `web1` and `web2`. The `rancher/dns-service` is not an actual image, but is required for the `docker-compose.yml`. There are no containers created for alias services.

#### Example `docker-compose.yml`

```yaml
version: '2'
services:
  web:
    image: rancher/dns-service
    links:
    - web1
    - web2

  web1:
    image: nginx

  web2:
    image: nginx
```
