---
title: Scheduling
layout: rancher-default-v1.0
version: v1.0
lang: en
redirect_from:
  - rancher/rancher-ui/scheduling/
---

## Labels and Scheduling in Rancher
---

When launching containers either through a [service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/adding-services/), through a [load balancer]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/adding-balancers/), or through the [container page]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/infrastructure/containers/), we provide the option to create labels for the container(s) and the ability to schedule which host you want the container to be placed on. For the remaining part of this section, we'll use the term container/service, but these labels apply load balancers (i.e. a specific type of service).

The scheduling rules provide flexibility on how you want Rancher to pick which host to use. In Rancher, we use labels to help define scheduling rules. You can create as many labels on a container as you’d like. With multiple scheduling rules, you have complete control on which host you want the container to be created on. You could request that the container to be launched on a host with a specific host label, container label or name, or a specific service. These scheduling rules can help create blacklists and whitelists for your container to host relationships.

### Labels

For [services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/adding-services/)/[containers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/infrastructure/containers/), labels can be added in the **Labels** tab. For load balancers, labels can be found in the **Labels** tab.

By adding labels to a [load balancer]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/adding-balancers/), every load balancer container will receive that label, which is a key value pair. In Rancher, we use these container labels to help define scheduling rules. You can create as many labels on a load balancer as you'd like. By default, Rancher already adds system related labels on every container.

### Scheduling Options  

For [services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/adding-services/)/[containers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/infrastructure/containers/), labels can be found in the **Scheduling** tab. For load balancers, labels can be found in the **Scheduling** tab.

For [services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/adding-services/)/[containers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/infrastructure/containers/), there are 2 options provided to determine where to launch your container.

**Option 1: Run _all_ containers on a specific host**
By selecting this option, the container/service will be started on a specific host. If your host goes down, then the container will also go down. If you create a container from the container page, even if there is a port conflict, the container will be started. If you create a service of scale greater than 1 and there is a port conflict, your service might get stuck in _Activating_ state until you edit the scale value of the service.

**Option 2: Automatically pick a host matching scheduling rules**
By selecting this option, you have the flexibility to choose your scheduling rules. Any host that follows all the rules is a host that could have the container started on. You can add rules by clicking on the **+** button.

For [load balancers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/adding-balancers/), only option 2 is available due to port conflicts. You are only given the choice to add scheduling rules. Click on the **Scheduling** tab. You can add as many scheduling rules as you want by clicking on the **Add Scheduling Rule** button.

For each rule, you select a **condition** of the rule. There are 4 different conditions, which define how strict the rule must be followed. The **field** determines which field you want the rule to be applied to. The **key** and **value** are the values which you want the field to be checked against. If you are launching a service or load balancer, Rancher will spread the distribution of containers on the applicable hosts based on the load of each host. Depending on the condition chosen will determine what the applicable hosts are.

> **Note:** For [services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/adding-services/)/[load balancers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/adding-balancers/), if you have selected the **Always run one instance of this container on every host** option for scale, then only the host labels will appear as a possible field.

_Conditions_

* **must** or **must not**: Rancher will only use hosts that match or do not match the field and value. If Rancher cannot find a host that meets all of the rules with these conditions, your service could get stuck in an _Activating_ state. The service will be continually trying to find a host for the containers. To fix this state, you can either edit the scale value of the service or add/edit another host that would satisfy all of these rules.  
* **should** or **should not**: Rancher will attempt to use hosts that match the field and value. In the case of when there is no  host that matches all the rules, Rancher will remove one by one the soft constraints (should/should not rules) until a host satisfies the remaining constraints.

_Fields_

* **host label**: When selecting the hosts to use for the container/service, Rancher will check the labels on the host to see if they match the key/value pair provided. Since every host can have one or more labels, Rancher will compare the key/value pair against all labels on a host. When adding a host to Rancher, you can add labels to the host. You can also edit the labels on the hosts by using the **Edit** option in the host's dropdown menu. The list of labels on active hosts are available from the dropdown in the key field.
* **container with label**: When selecting this field, Rancher will look for hosts that already have containers with labels that match the key/value pair. Since every container can have one or more labels, Rancher will compare the key/value pair against all labels on every container in a host. The container labels are in the **Labels** tab for a container. You will not be able to edit the container labels after the container is started. In order to create a new container with the same settings, you can **Clone** the container/service and add the labels before starting it. The list of user labels on running containers are available from the dropdown in the key field.
* **service with the name**: Rancher will check to see if a host has a container from the specified service running on it. If at a later time, this service has a name change or is inactive/removed, the rule will no longer be valid. If you pick this field, the value will need to be in the format of `stack_name/service_name`. The list of running services are available from the dropdown in the value field.
* **container with the name**: Rancher will check to see if a host has a container with a specific name running on it. If at a later time, the container has a name change or is inactive/removed, the rule will no longer be valid. The list of running containers are available from the dropdown in the value field.
