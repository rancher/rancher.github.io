---
title: Scheduling Services in Cattle Environments
layout: rancher-default-v1.2
version: v1.2
lang: en
redirect_from:
  - /rancher/v1.2/zh/cattle/scheduling/
---

## Scheduling Services
---

Rancher supports container scheduling policies that are modeled closely after Docker Swarm.  They include scheduling based on:

* port conflicts
* shared volumes
* host tagging
* shared network stack: --net=container:dependency
* strict and soft affinity/anti-affinity rules by using both env var (Swarm) and labels (Rancher)

In addition, Rancher supports scheduling service triggers that allow users to specify rules, such as on "host add" or "host label", to automatically scale services onto hosts with specific labels.


When launching containers either through a [service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/) or through a [load balancer]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/), we provide the option to create labels for the container(s) and the ability to schedule which host you want the container to be placed on. For the remaining part of this section, we'll use the term service, but these labels also apply to load balancers (i.e. a specific type of service).

The scheduling rules provide flexibility on how you want Rancher to pick which host to use. In Rancher, we use labels to help define scheduling rules. You can create as many labels on a container as you’d like. With multiple scheduling rules, you have complete control on which host you want the container to be created on. You could request that the container to be launched on a host with a specific host label, container label or name, or a specific service. These scheduling rules can help create blacklists and whitelists for your container to host relationships.

### Adding Labels in the UI

For [services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/), labels can be added in the **Labels** tab. For load balancers, labels can be found in the **Labels** tab.

By adding labels to a [load balancer]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/), every load balancer container will receive that label, which is a key value pair. In Rancher, we use these container labels to help define scheduling rules. You can create as many labels on a load balancer as you'd like. By default, Rancher already adds system related labels on every container.

### Scheduling Options in the UI

For [services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/) and [load balancers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/), labels can be found in the **Scheduling** tab.

For [services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/), there are 2 options provided to determine where to launch your container.

#### Option 1: Run _all_ containers on a specific host
By selecting this option, the container/service will be started on a specific host. If your host goes down, then the container will also go down. If you create a container from the container page, even if there is a port conflict, the container will be started. If you create a service of scale greater than 1 and there is a port conflict, your service might get stuck in _Activating_ state until you edit the scale value of the service.

#### Option 2: Automatically pick a host matching scheduling rules
By selecting this option, you have the flexibility to choose your scheduling rules. Any host that follows all the rules is a host that could have the container started on. You can add rules by clicking on the **+** button.

For [load balancers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/), only option 2 is available due to port conflicts. You are only given the choice to add scheduling rules. Click on the **Scheduling** tab. You can add as many scheduling rules as you want by clicking on the **Add Scheduling Rule** button.

For each rule, you select a **condition** of the rule. There are 4 different conditions, which define how strict the rule must be followed. The **field** determines which field you want the rule to be applied to. The **key** and **value** are the values which you want the field to be checked against. If you are launching a service or load balancer, Rancher will spread the distribution of containers on the applicable hosts based on the load of each host. Depending on the condition chosen will determine what the applicable hosts are.

> **Note:** For [services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/)/[load balancers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/), if you have selected the **Always run one instance of this container on every host** option for scale, then only the host labels will appear as a possible field.

#### Conditions

* **must** or **must not**: Rancher will only use hosts that match or do not match the field and value. If Rancher cannot find a host that meets all of the rules with these conditions, your service could get stuck in an _Activating_ state. The service will be continually trying to find a host for the containers. To fix this state, you can either edit the scale value of the service or add/edit another host that would satisfy all of these rules.  
* **should** or **should not**: Rancher will attempt to use hosts that match the field and value. In the case of when there is no  host that matches all the rules, Rancher will remove one by one the soft constraints (should/should not rules) until a host satisfies the remaining constraints.

#### Fields

* **host label**: When selecting the hosts to use for the container/service, Rancher will check the labels on the host to see if they match the key/value pair provided. Since every host can have one or more labels, Rancher will compare the key/value pair against all labels on a host. When adding a host to Rancher, you can add labels to the host. You can also edit the labels on the hosts by using the **Edit** option in the host's dropdown menu. The list of labels on active hosts are available from the dropdown in the key field.
* **container with label**: When selecting this field, Rancher will look for hosts that already have containers with labels that match the key/value pair. Since every container can have one or more labels, Rancher will compare the key/value pair against all labels on every container in a host. The container labels are in the **Labels** tab for a container. You will not be able to edit the container labels after the container is started. In order to create a new container with the same settings, you can **Clone** the container/service and add the labels before starting it. The list of user labels on running containers are available from the dropdown in the key field.
* **service with the name**: Rancher will check to see if a host has a container from the specified service running on it. If at a later time, this service has a name change or is inactive/removed, the rule will no longer be valid. If you pick this field, the value will need to be in the format of `stack_name/service_name`. The list of running services are available from the dropdown in the value field.
* **container with the name**: Rancher will check to see if a host has a container with a specific name running on it. If at a later time, the container has a name change or is inactive/removed, the rule will no longer be valid. The list of running containers are available from the dropdown in the value field.

### Adding Labels in Rancher Compose

Rancher determines how to schedule a service's containers based on the `labels` defined in the `docker-compose.yml` file. All of the labels with scheduling would be used in the `docker-compose.yml` file. Rancher defines the scheduling rules with 3 main components: conditions, fields and values. Conditions determine how strictly Rancher follows the rules. Fields are which items that are going to be compared against. Values are what you've defined on the fields. We'll talk broadly about these components before going into some examples.

#### Scheduling Conditions

When we write our scheduling rules, we have conditions for each rule, which dictates how Rancher uses the rule. An affinity condition is when we are trying to find a field that matches our value. An anti-affinity condition is when we are trying to find a field that does not match our value.

To differentiate between affinity and anti-affinity, we add `_ne` to the label name to indicate that the label is **not** matching the field and values.

There are also hard and soft conditions of a rule.

A hard condition is the equivalent of saying **must** or **must not**. Rancher will only use hosts that match or do not match the field and value. If Rancher cannot find a host that meets all of the rules with these conditions, your service could get stuck in an _Activating_ state. The service will be continually trying to find a host for the containers. To fix this state, you can either edit the scale value of the service or add/edit another host that would satisfy all of these rules.

A soft condition is the equivalent of saying **should** or **should not**. Rancher will attempt to use hosts that match the field and value. In the case of when there is no  host that matches all the rules, Rancher will remove one by one the soft constraints (should/should not rules) until a host satisfies the remaining constraints.

To differentiate between the _must_ and _should_ conditions, we add `_soft` to our label name to indicate that the label is **should** try to match the field and values.

#### Fields

Rancher has the ability to compare values against host labels, container labels, container name, or service name. The label prefix is what Rancher uses to define which field will be evaluated.

Field | Label Prefix
---|---
Host Label | `io.rancher.scheduler.affinity:host_label`
Container Label/Service Name | `io.rancher.scheduler.affinity:container_label`
Container Name | `io.rancher.scheduler.affinity:container`

Notice how there is not a specific prefix for service name. When Rancher creates a service, system labels are added to all containers of the service to indicate the stack and service name.

To create the key of our label, we start with a field prefix (e.g. `io.rancher.scheduler.affinity:host_label`) and based on the condition that we are looking for, we append the type of condition we want. For example, if we want the containers to be launched on a host that must not equal (i.e. `_ne`) to a host label value, the label key would be `io.rancher.scheduler.affinity:host_label_ne`.

#### Values

You use the values to define what you want the field to be checked against. If you have a couple of values that you want to compare against for the same condition and field, you'll need to use only one label for the name of the label. For the value of the label, you'll need to use a comma separated list. If there are multiple labels with the same key (e.g. `io.rancher.scheduler.affinity:host_label_ne`), Rancher will overwrite any previous value with the last value that is used with the label key.

```yaml
labels:
  io.rancher.scheduler.affinity:host_label: key1=value1,key2=value2
```

#### Global Service

Making a service into a global service is the equivalent of selecting **Always run one instance of this container on every host** in the UI. This means that a container will be started on any host in the [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/). If a new host is added to the environment, and the host fulfills the global service's host requirements, the service will automatically be started.

Currently, we only support global services with host labels fields that are using the hard condition. This means that only labels that are related to `host_labels` will be adhered to when scheduling and it **must** or **must not** equal the values. Any other label types will be ignored.

##### Example `docker-compose.yml`

```yaml
version: '2'
services:
  wordpress:
    labels:
      # Make wordpress a global service
      io.rancher.scheduler.global: 'true'
      # Make wordpress only run containers on hosts with a key1=value1 label
      io.rancher.scheduler.affinity:host_label: key1=value1
      # Make wordpress only run on hosts that do not have a key2=value2 label
      io.rancher.scheduler.affinity:host_label_ne: key2=value2
    image: wordpress
    links:
    - db: mysql
    stdin_open: true
```

#### Finding Hosts with Host Labels

When adding hosts to Rancher, you can add [host labels]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#host-labels). When scheduling a service, you can leverage these labels to create rules to pick the hosts you want your service to be deployed on.

##### Example using Host Labels

```yaml
labels:
  # Host MUST have the label `key1=value1`
  io.rancher.scheduler.affinity:host_label: key1=value1
  # Host MUST NOT have the label `key2=value2`
  io.rancher.scheduler.affinity:host_label_ne: key2=value2
  # Host SHOULD have the label `key3=value3`
  io.rancher.scheduler.affinity:host_label_soft: key3=value3
  # Host SHOULD NOT have the label `key4=value4`
  io.rancher.scheduler.affinity:host_label_soft_ne: key4=value4
```

##### Automatically Applied Host Labels

Rancher automatically creates host labels related to linux kernel version and Docker Engine version of the host.

Key | Value | Description
----|----|----
`io.rancher.host.linux_kernel_version` | Linux Kernel Version on Host (e.g, `3.19`) |  Version of the Linux kernel running on the host
`io.rancher.host.docker_version` | Docker Engine Version on the host (e.g. `1.10.3`) | Docker Engine Version on the host

<br>

```yaml
labels:
# Host MUST be running Docker version 1.10.3
io.rancher.scheduler.affinity:host_label: io.rancher.host.docker_version=1.10.3
# Host MUST not be running Docker version 1.6
io.rancher.scheduler.affinity:host_label_ne: io.rancher.host.docker_version=1.6
```

<br>

> **Note:** Rancher does not support the concept of scheduling containers on a host that has `>=` a specific version. You can create specific whitelists and blacklists by using the host scheduling rules to determine if a specific version of Docker Engine is required for your services.

#### Finding Hosts with Container Labels

When adding containers or services to Rancher, you can add container labels. These labels can be used for the field that you want a rule to compare against. Reminder: This cannot be used if you set global service to true.

> **Note:** If there are multiple values for container labels, Rancher will look at all labels on all containers on the host to check the container labels. The multiple values do not need to be on the same container on a host.

##### Example using Container Labels

```yaml
labels:
  # Host MUST have a container with the label `key1=value1`
  io.rancher.scheduler.affinity:container_label: key1=value1
  # Host MUST NOT have a container with the label `key2=value2`
  io.rancher.scheduler.affinity:container_label_ne: key2=value2
  # Host SHOULD have a container with the label `key3=value3`
  io.rancher.scheduler.affinity:container_label_soft: key3=value3
  # Host SHOULD NOT have a container with the label `key4=value4
  io.rancher.scheduler.affinity:container_label_soft_ne: key4=value4
```

##### Service Name

When Rancher Compose starts containers for a service, it also automatically creates several container labels. Since checking for a specific container label is looking for a `key=value`, we can use these system labels as the key of our rules. Here are the system labels created on the containers when Rancher starts a service:

Label | Value
----|-----
io.rancher.stack.name | `$${stack_name}`
io.rancher.stack_service.name | `$${stack_name}/$${service_name}`

<br>

> **Note:** When using the `io.rancher.stack_service.name`, the value must be in the format of `stack name/service name`.

The macros `$${stack_name}` and `$${service_name}` can also be used in the `docker-compose.yml` file in any other `label` and will be evaluated when the service is started.

##### Example using Service Name

```yaml
labels:
  # Host MUST have a container from service name `value1`
  io.rancher.scheduler.affinity:container_label: io.rancher.stack_service.name=stackname/servicename
```

#### Finding Hosts with Container Names

When adding containers to Rancher, you give each container a name. You can use this name as a field that you want a rule to compare against. Reminder: This cannot be used if you set global service to true.

##### Example using Container Names

```yaml
labels:
  # Host MUST have a container with the name `value1`
  io.rancher.scheduler.affinity:container: value1
  # Host MUST NOT have a container with the name `value2`
  io.rancher.scheduler.affinity:container_ne: value2
  # Host SHOULD have a container with the name `value3`
  io.rancher.scheduler.affinity:container_soft: value3
  # Host SHOULD NOT have a container with the name `value4
  io.rancher.scheduler.affinity:container_soft_ne: value4
```

### Examples

#### Example 1:

A typical scheduling policy may be to try to spread the containers of a service across the different available hosts.  One way to achieve this is to use an anti-affinity rule to itself:

```yaml
labels:
  io.rancher.scheduler.affinity:container_label_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
```

Since this is a hard anti-affinity rule, we may run into problems if the scale is larger than the number of hosts available.  In this case, we might want to use a soft anti-affinity rule so that the scheduler is still allowed to deploy a container to a host that already has that container running.  Basically, this is a soft rule so it can be ignored if no better alternative exists.

```yaml
labels:
  io.rancher.scheduler.affinity:container_label_soft_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
```

#### Example 2:

Another example may be to deploy all the containers on the same host regardless of which host that may be.  In this case, a soft affinity to itself can be used.

```yaml
labels:
  io.rancher.scheduler.affinity:container_label_soft: io.rancher.stack_service.name=$${stack_name}/$${service_name}
```

If a hard affinity rule to itself was chosen instead, the deployment of the first container would fail since there would be no host that currently has that service running.

### Table of Scheduling Labels

Label | Value | Description
----|-----|-----
io.rancher.scheduler.global | true | Specifies this service to be a global service
io.rancher.scheduler.affinity:host_label | key1=value1,key2=value2, etc... | Containers **must** be deployed to a host with the labels `key1=value1` and `key2=value2`
io.rancher.scheduler.affinity:host_label_soft | key1=value1,key2=value2 | Containers **should** be deployed to a host with the labels `key1=value1` and `key2=value2`
io.rancher.scheduler.affinity:host_label_ne | key1=value1,key2=value2 | Containers **must not** be deployed to a host with the label `key1=value1` or `key2=value2`
io.rancher.scheduler.affinity:host_label_soft_ne | key1=value1,key2=value2 | Containers **should not** be deployed to a host with the label `key1=value1` or `key2=value2`
io.rancher.scheduler.affinity:container_label | key1=value1,key2=value2 | Containers **must** be deployed to a host that has containers running with the labels `key1=value1` and `key2=value2`.  NOTE: These labels do not have to be on the same container.  The can be on different containers within the same host.
io.rancher.scheduler.affinity:container_label_soft | key1=value1,key2=value2 | Containers **should** be deployed to a host that has containers running with the labels `key1=value1` and `key2=value2`
io.rancher.scheduler.affinity:container_label_ne | key1=value1,key2=value2 | Containers **must not** be deployed to a host that has containers running with the label `key1=value1` or `key2=value2`
io.rancher.scheduler.affinity:container_label_soft_ne | key1=value1,key2=value2 | Containers **should not** be deployed to a host that has containers running with the label `key1=value1` or `key2=value2`
io.rancher.scheduler.affinity:container | container_name1,container_name2 | Containers **must** be deployed to a host that has containers with the names `container_name1` and `container_name2` running
io.rancher.scheduler.affinity:container_soft | container_name1,container_name2 | Containers **should** be deployed to a host that has containers with the names `container_name1` and `container_name2` running
io.rancher.scheduler.affinity:container_ne | container_name1,container_name2 | Containers **must not** be deployed to a host that has containers with the names `container_name1` or `container_name2` running
io.rancher.scheduler.affinity:container_soft_ne | container_name1,container_name2 | Containers **should not** be deployed to a host that has containers with the names `container_name1` or `container_name2` running
