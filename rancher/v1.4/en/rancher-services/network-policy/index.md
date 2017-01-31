---
title: Network Policy in Rancher
layout: rancher-default-v1.4
version: v1.4
lang: en
#redirect_from:
#  - /rancher/latest/en/rancher-services/network-policy/
---

## Network Policy
---

Rancher allows users to configure a network policy within an [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments). Currently the ability to edit the network policy is available only through the REST API and support to edit it from the UI will be added in the next release. For the configured network policy to take effect, "Network Policy Manager" catalog item needs to be deployed from the [Rancher Infrastructure Services]({{site.baseurl}}/rancher/v1.4/en/rancher-services/). This service is not enabled by default in the templates. Either the stack is installed manually in the existing environment or a new environment template has to be created with the stack enabled.

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