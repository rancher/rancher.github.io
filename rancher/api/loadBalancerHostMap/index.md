---
title: API
layout: rancher-default
---

## loadBalancerHostMap

Collection Test Description
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
hostId | [host]({{site.baseurl}}/rancher/api/host/) | - | - | - | The unique identifier for the associated host
loadBalancerId | [loadBalancer]({{site.baseurl}}/rancher/api/loadBalancer/) | - | - | - | The loadBalancerId for the loadBalancerHostMap




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the loadBalancerHostMap was created.
description | string | Optional | Yes | - | The description for the loadBalancerHostMap
id | int | - | - | - | The unique identifier for the loadBalancerHostMap
kind | string | - | - | - | The kind for the loadBalancerHostMap
name | string | Optional | Yes | - | The name for the loadBalancerHostMap
removed | date | - | - | - | The date of when the loadBalancerHostMap was removed
state | string | - | - | - | The current state of the loadBalancerHostMap. The options are [].
uuid | string | - | - | - | The universally unique identifier for the loadBalancerHostMap. This will always be unique across Rancher installations.












​