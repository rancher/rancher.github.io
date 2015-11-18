---
title: API
layout: rancher-default
---

## loadBalancerConfigListenerMap

Collection Test Description
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
loadBalancerConfigId | [loadBalancerConfig]({{site.baseurl}}/rancher/api/loadBalancerConfig/) | - | - | - | The loadBalancerConfigId for the loadBalancerConfigListenerMap
loadBalancerListenerId | [loadBalancerListener]({{site.baseurl}}/rancher/api/loadBalancerListener/) | - | - | - | The loadBalancerListenerId for the loadBalancerConfigListenerMap




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the loadBalancerConfigListenerMap was created.
description | string | Optional | Yes | - | The description for the loadBalancerConfigListenerMap
id | int | - | - | - | The unique identifier for the loadBalancerConfigListenerMap
kind | string | - | - | - | The kind for the loadBalancerConfigListenerMap
name | string | Optional | Yes | - | The name for the loadBalancerConfigListenerMap
removed | date | - | - | - | The date of when the loadBalancerConfigListenerMap was removed
state | enum | - | - | - | The current state of the loadBalancerConfigListenerMap. The options are [activating, active, removed, removing, requested].
transitioning | enum | - | - | - | Whether or not the loadBalancerConfigListenerMap is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the loadBalancerConfigListenerMap
uuid | string | - | - | - | The universally unique identifier for the loadBalancerConfigListenerMap. This will always be unique across Rancher installations.




### Actions









​

<span class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${action.remove}</code></span>
</span>
<div class="action-contents">
To remove the loadBalancerConfigListenerMap
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/loadBalancerConfigListenerMap/">loadBalancerConfigListenerMap</a> resource
</span>
</div>
</span>
</span>
</span>

