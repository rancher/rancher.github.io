---
title: API
layout: rancher-default
---

## serviceConsumeMap

Collection Test Description
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
consumedServiceId | [service]({{site.baseurl}}/rancher/api/service/) | - | - | - | The unique identifier of the consumed service
ports | array[string] | - | - | - | The ports for the serviceConsumeMap
serviceId | [service]({{site.baseurl}}/rancher/api/service/) | - | - | - | The unique identifier of the associated service




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the serviceConsumeMap was created.
description | string | Optional | Yes | - | The description for the serviceConsumeMap
id | int | - | - | - | The unique identifier for the serviceConsumeMap
kind | string | - | - | - | The kind for the serviceConsumeMap
name | string | - | - | - | The name for the serviceConsumeMap
removed | date | - | - | - | The date of when the serviceConsumeMap was removed
state | enum | - | - | - | The current state of the serviceConsumeMap. The options are [activating, active, removed, removing, requested, updating-active].
transitioning | enum | - | - | - | Whether or not the serviceConsumeMap is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the serviceConsumeMap
uuid | string | - | - | - | The universally unique identifier for the serviceConsumeMap. This will always be unique across Rancher installations.




### Actions









​

<span class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${action.remove}</code></span>
</span>
<div class="action-contents">
To remove the serviceConsumeMap
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/serviceConsumeMap/">serviceConsumeMap</a> resource
</span>
</div>
</span>
</span>
</span>

