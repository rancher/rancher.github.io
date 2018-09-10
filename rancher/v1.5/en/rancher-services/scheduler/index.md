---
title: Scheduling Services in Cattle Environments
layout: rancher-default-v1.5
version: v1.5
lang: en
---

## Scheduling Services
---

Rancher's core scheduling logic is part of Rancher, which handles port conflicts and ability to schedule based on labels on hosts/containers. In addition to the core scheduling logic, Rancher supports additional scheduling policies by using the **Rancher Scheduler** catalog item.

* [Ability to schedule against multiple IPs on a Host](#multiple-ips)
* [Ability to scheduler based on resource constraints (i.e. CPU and memory)](#resource-constraints)
* [Ability to restrict which services can be scheduled on a host](#restrict-services-on-host)

> **Note:** These functionalities are not available for Kubernetes as Kubernetes handles scheduling of their own pods.

### Enabling Rancher scheduler

Rancher scheduler is defaulted to be `required` for any environment template. If you have deleted this stack from your environment, you can add it back into the environment by launching **Rancher Scheduler** in **Catalog** -> **Library**.

<a id="multiple-ips"></a>

### Scheduling onto multiple IPs of a single Host

By default, Rancher assumes that there is only one IP on the host that is available when scheduling services that publishes ports or launching load balancers. If your host has multiple IPs that could be used, the [host needs to be configured to allow the Rancher scheduler to know which IPs are available]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#scheduler-ips).

When there are multiple IPs available on the host for scheduling, Rancher will schedule against all the available scheduler IPs when a port is published through a service or a load balancer. The scheduler will report port conflicts after all available scheduler IPs on the host have been allocated for that port.  

<a id="resource-constraints"></a>

### Scheduling with Resource constraints

When Rancher [hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/) are added into Rancher, they are automatically assigned resource limits based on the size of the host. These limits can be adjusted by editing the host. In **Infrastructure** -> **Hosts**, you  select **Edit** from the dropdown of the host. In the **Resource Limits** section of the host, you can update the **Memory** or **CPU** for the maximum amount that you want to be used on the host.

#### Setting Reservations in the UI

When creating a service, you can specify the **Memory Reservation** and **mCPU Reservation** in the **Security/Host** tab. When these reservations are set, containers of the service are only scheduled onto hosts that have available resources. The maximum limit of these resources on a host are determined based on the **Resource Limits** of the host. If scheduling the container onto the host would force these limits to be over the threshold, then the container will not be scheduled onto the host.

#### Setting Reservations in Rancher Compose

Example `docker-compose.yml`

```
version: '2'
services:
  test:
    image: ubuntu:14.04.3
    stdin_open: true
    tty: true
    # Set the memory reservation of the container
    mem_reservation: 104857600
```

Example `rancher-compose.yml`

```
version: '2'
services:
  test:
    # Set the CPU reservation of the container
    milli_cpu_reservation: 10
    scale: 1
```

<a id="restrict-services-on-host"></a>

### Scheduling only specific services on a host

Typically, most of the container scheduling is defined on the service. The service will have specific rules or restrictions on which host that the container(s) can be scheduled on. For example, a container must be scheduled onto a host that has a specific host label. Rancher has the ability to specify requirements on the host to only allow specific containers to be scheduled onto the host. One example of when you might want to use this feature is if you wanted to dedicate a host to only have database containers scheduled onto the host. By using this feature, you would prevent other containers from other services to be scheduled on the host.

> **Note:** When you add label restrictions for containers on a host, you will be required to include a label in order for our [infrastructure services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/) to be scheduled onto the host. Without these services, containers required to allow networking and other key components of Rancher to work will not be scheduled onto the host.

For any host, you will edit the host to add in what labels a container must have by selecting **Edit** from the dropdown of the host. In the **Require Container Label** section, you can add which labels are required to be on a service in order for those containers to be scheduled onto the host. The UI will automatically have the label (i.e. `io.rancher.container.system=`) as a required label.
