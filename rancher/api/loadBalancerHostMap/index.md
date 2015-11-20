---
title: API
layout: rancher-default
---

## loadBalancerHostMap

Collection Test Description

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
id | int | - | - | - | The unique identifier for the loadBalancerHostMap
kind | string | - | - | - | 
name | string | Optional | Yes | - | 
state | string | - | - | - | The current state of the loadBalancerHostMap. The options are [].
hostId | [host]({{site.baseurl}}/rancher/api/host/) | - | - | - | The unique identifier for the associated host
loadBalancerId | [loadBalancer]({{site.baseurl}}/rancher/api/loadBalancer/) | - | - | - | 
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the loadBalancerHostMap was created.
description | string | Optional | Yes | - | 
removed | date | - | - | - | The date of when the loadBalancerHostMap was removed
uuid | string | - | - | - | The universally unique identifier for the loadBalancerHostMap. This will always be unique across Rancher installations.












​