---
title: Network Policy in Rancher
layout: rancher-default-v1.6
version: v1.6
lang: en
---

## Network Policy
---

Rancher allows users to configure a network policy within an [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/). A network policy allows you to define specific networking rules within the environment. By default, all containers are able to communicate with each other, but there may be restrictions that you want to place on your containers.

### Launching the Network Policy Manager

When setting up an [environment template]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#what-is-an-environment-template), you can enable the **Network Policy Manage** item.

Alternatively, if you already have an environment set up, you can select and launch the **Network Policy Manager** from the [Rancher catalog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/).

> **Note:** Network Policy Manager is currently only compatible with an environment using the _Cattle_ container orchestration. Environment templates will restrict which ones are compatible based on orchestration, but all options are available from the catalog.

### Managing Network Policy Rules via UI
Network policy settings can be configured for each environment by navigating to the environment's settings page. You can navigate to the environments's settings page by clicking on **Manage Environments** option from the dropdown menu. Click on the edit icon next to the environment you want to set a network policy on.

There are four options in the UI to control the network traffic between containers. `Allow` permits network traffic to occur where as `Deny` restricts network traffic.  

* **Between Linked Services:** This option is used to control communication between containers of two services that are linked.
* **Within Service**: This option is used to control communication between containers of the same service.
* **Within Stack**: This option is used to control communication between containers of different services in the same stack.
* **Everything Else**: This option is used to control the rest of the traffic that doesn't match any of the definitions in the other options.

A normal use case would be to select `Deny` for **Everything Else** and select `Allow` for the other options.

> **Note:** The rules are applied in the left to right order.


### Managing Network Policy Rules via API

In the [network]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/v2-beta/api-resources/network/) resource, there is a `defaultPolicyAction` and a `policy` field that define how the communication between containers work. The `policy` field is an ordered array of [network policy rules]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/v2-beta/api-resources/networkPolicyRule/). Using Rancher's [API]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/v2-beta/), you can manage the network policy for the environment.

#### Finding the API Endpoint for the Network

In order to manage your network policy, you will need to find the **Network** resource. As a network is part of an environment, the endpoint to find networks will be:

```
http://<RANCHER_SERVER_IP>/v2-beta/projects/<PROJECT_ID>/networks/<NETWORK_ID>`
```

How to find the endpoint for your network:

1. Click on **API** and expand the **Advanced Options**. In the **Environment API Keys**, click on the **Endpoint (v2-beta)**.
  > **Note**: `Environment` in the UI is a `project` in the API.
2. Search for **networks** in the list of links for the environment. Click on the link.
3. Search for the name of the networking driver that you've launched for your environment. For example, it could be `ipsec`. Click on the **self** link for the network.
4. On the right hand side under **Operations**, click on **Edit** for the network. In the `defaultPolicyAction`, you can change the default policy and in the `policy` field, you can manage your network policy rules.


### Default Policy

By default, all containers are enabled and allowed to communicate with each other. In the API, you will see that the `defaultPolicyAction` has been set to `allow`.

To change the default policy to deny communication between all containers, you would need to edit the `defaultPolicyAction` to be `deny`.

### Network Policy Rules

Network policy rules set container communication for specific sets of containers.

#### Containers of services that are linked

Assumption: Service A is linked to service B.

To enable containers of service A to be able to communicate with service B:

```json
{
  "within": "linked",
  "action": "allow"
}
```
> **Note:** Containers of service B will not be able to initiate a connection to service A.

To disable containers of service A to be able to communicate with service B:

```json
{
  "within": "linked",
  "action": "deny"
}
```

Any network policy rule for linked services apply to all linked services in an environment.

#### Containers within a Service

To enable communication between containers only within the same service:

```json
{
  "within": "service",
  "action": "allow"
}
```

To disable communication between containers within the same service:

```json
{
  "within": "service",
  "action": "deny"
}
```

#### Containers within a Stack

To enable communication between containers only within the same stack:

```json
{
  "within": "stack",
  "action": "allow"
}
```

To disable communication between containers within the same stack:

```json
{
  "within": "stack",
  "action": "deny"
}
```

#### Containers based on Labels

To enable communication between containers based on their label values:

```json
{
  "between": {
    "groupBy": "<KEY_OF_LABEL>"
  },
  "action": "allow"
}
```

To disable communication between containers based on their label values:

```json
{
  "between": {
    "groupBy": "<KEY_OF_LABEL>"
  },
  "action": "deny"
}
```

### Examples

#### Container Isolation

No containers can communicate with any other container in the environment.

* Set the `defaultActionPolicy` to `deny`.

#### Stack Isolation

Containers within the same stack are only allowed to communicate with each other, but the container cannot communicate with any containers in other stacks.

* Set the `defaultActionPolicy` to `deny`.
* Add the rule to the `policy`:

```json
{
  "within": "stack",
  "action": "allow"
}
```

#### Label Isolation

Containers with matching labels can communicate with other matching labels. The rule uses the key of the label to group which containers can communicate with each other.

Let's assume we have the following set of stacks in the environment.

```yaml
stack_one:
  service_one:
    label: com.rancher.department = qa
  service_two:
    label: com.rancher.department = engineering
  service_three:
    label: com.rancher.location = cupertino

stack_two:
  service_one:
    label: com.rancher.department = qa
  service_two:
    label: com.rancher.location = cupertino

stack_three:
  service_one:
    label: com.rancher.department = engineering
  service_two:
    label: com.rancher.location = phoenix
```

Communication between only containers of with the same `com.rancher.department` label.

* Set the `defaultActionPolicy` to `deny`.
* Add the rule to the `policy`:

```json
{
  "between": {
    "groupBy": "com.rancher.department"
  },
  "action": "allow"
}
```

There are two distinct label pairs with the same key (i.e. `com.rancher.department`).

* Containers with the `com.rancher.department = engineering` would be able to communicate with each other, but no other container. In our example, any containers from `stack_one.service_two` and `stack_three.service_one` would be able to communicate to each other, but no other containers.
* Containers with the `com.rancher.department = qa` would be able to communicate with each other but no other container. In this example, any containers from `stack_one.service_one` and `stack_two.service_one` would be able to communicate with each other, but no other containers.
* Containers without a label with a key `com.rancher.department` would not be able to communicate with any other containers.
