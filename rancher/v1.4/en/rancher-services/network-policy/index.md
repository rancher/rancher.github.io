---
title: Network Policy in Rancher
layout: rancher-default-v1.4
version: v1.4
lang: en
---

## Network Policy
---

Rancher allows users to configure a network policy within an [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/). A network policy allows you to define specific networking rules within the environment. By default, all containers are able to communicate with each other, but there may be restrictions that you want to place on your containers. 

### Launching the Network Policy Manager

When setting up an [environment template]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#what-is-an-environment-template), you can enable the **Network Policy Manage** item. 

Alternatively, if you already have an environment set up, you can select and launch the **Network Policy Manager** from the [Rancher catalog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/).

> **Note:** Network Policy Manager is currently only compatible with an environment using the _Cattle_ container orchestration. Environment templates will restrict which ones are compatible based on orchestration, but all options are available from the catalog.

### 

In this release, there are two different kinds of rules available for configuration of the network policy along with the default action if there is no specific match. [ Note: More rule types are coming soon in the next releases]

**Rule Type 1:**

```json
{
  "within": "stack",
  "action": "allow"
}
```
This type of rule is used to define the policy for all the containers within a stack.


**Rule Type 2:**

```json
{
  "between": {
    "groupBy": "com.company.somelabel"
  },
  "action": "allow"
}
```
This type of rule is used to select groups of containers within which the action is either allow/deny.

The above two rules are available to be configured under 'policy' array under the 'network' object in the REST API.

*Example:* `http://{your_rancher_server_ip}/v2-beta/projects/{project_id}/networks/{network_id}`

**Default Rule Type:**

```
"defaultPolicyAction": "allow"
```

This type of rules specifies the default action if there are no other matching rules. This rule is available directly on the 'network' object in the REST API.

**Examples:**

*Example 1:* No two containers in the environment cannot communicate with each other.

```json
"defaultPolicyAction": "deny"
```

*Example 2:* Containers within the same stack are allowed to communicate but not across different stacks.

```json
"defaultPolicyAction": "deny"
{
  "within": "stack",
  "action": "allow"
}
```

*Example 3:* Containers with specific label and values can communicate with eachother.

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

If we want to allow communication between services of the same department and restrict all others, the policy configured would be:

```json
"defaultPolicyAction": "deny"
{
  "between": {
    "groupBy": "com.rancher.department"
  },
  "action": "allow"
}
```

Containers of `stack_one.service_one` and `stack_two.service_two` would be able to communicate with each other but not with others because they have the same value for the specified label(`com.rancher.department`). Similarly containers of `stack_one.service_two` and `stack_three.service_one` would be able to communicate with each other. Note: Apart from these, no other containers would be able to communicate with any others.
