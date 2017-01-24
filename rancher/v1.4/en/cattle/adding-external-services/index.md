---
title: Adding External Service
layout: rancher-default-v1.4
version: v1.4
lang: en
---

## Adding External Services
---

You may have services hosted outside of Rancher that you want integrated with Rancher. You can add these services into Rancher by adding an external service.

### Adding External Services in the UI

Inside your stack, you add an external service by clicking on the dropdown icon next to the **Add Service** button. Select **External Service**. Alternatively, if you are viewing the stacks at the stack level, the same **Add Service** dropdown is visible for each specific stack.

You will need to provide a **Name** and if desired, **Description** of the service.

Add the target(s) that you want. You can select either an external IP(s) or a hostname (i.e. CNAME). Finally, click **Create**.

The external service IP(s) and hostname will be shown in the service. Just like our services, you will need to start the external services.

#### Adding/Removing targets

At any time, you can edit the targets in an external service. Click on the **Edit** within the external service's dropdown menu. You will have the ability to add more targets or remove existing targets.

### Adding External Services with Rancher Compose

With external services, you can set either external IP(s) **OR** a domain name. The `rancher/external-service` is not an actual image, but is required for the `docker-compose.yml`. There are no containers created for external services.

#### Example `docker-compose.yml`

```yaml
version: '2'
services:
  db:
    image: rancher/external-service
  redis:
    image: redis
```

#### Example `rancher-compose.yml` using external IPs

```yaml
version: '2'
services:
  db:
    external_ips:
    - 1.1.1.1
    - 2.2.2.2

  # Override any service to become an external service
  redis:
    image: redis
    external_ips:
    - 1.1.1.1
    - 2.2.2.2
```

#### Example `rancher-compose.yml` using hostname

```yaml
version: '2'
services:
  db:
    hostname: example.com
```
