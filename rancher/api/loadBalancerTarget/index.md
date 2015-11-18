---
title: API
layout: rancher-default
---

## loadBalancerTarget

Collection Test Description
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
instanceId | [instance]({{site.baseurl}}/rancher/api/instance/) | Optional | - | - | The unique identifier for the associated instance
ipAddress | string | Optional | - | - | The ip address for an external service
loadBalancerId | [loadBalancer]({{site.baseurl}}/rancher/api/loadBalancer/) | - | - | - | The loadBalancerId for the loadBalancerTarget
ports | array[string] | Yes | - | - | The ports for the loadBalancerTarget




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the loadBalancerTarget was created.
description | string | Optional | Yes | - | The description for the loadBalancerTarget
id | int | - | - | - | The unique identifier for the loadBalancerTarget
kind | string | - | - | - | The kind for the loadBalancerTarget
name | string | Optional | Yes | - | The name for the loadBalancerTarget
removed | date | - | - | - | The date of when the loadBalancerTarget was removed
state | enum | - | - | - | The current state of the loadBalancerTarget. The options are [activating, active, removed, removing, requested, updating-active].
transitioning | enum | - | - | - | Whether or not the loadBalancerTarget is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the loadBalancerTarget
uuid | string | - | - | - | The universally unique identifier for the loadBalancerTarget. This will always be unique across Rancher installations.




### Actions









​

<span class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${action.remove}</code></span>
</span>
<div class="action-contents">
To remove the loadBalancerTarget
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/loadBalancerTarget/">loadBalancerTarget</a> resource
</span>
</div>
</span>
</span>
</span>

