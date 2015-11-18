---
title: API
layout: rancher-default
---

## serviceExposeMap

Collection Test Description
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
instanceId | [instance]({{site.baseurl}}/rancher/api/instance/) | - | - | - | The unique identifier for the associated instance
ipAddress | string | - | - | - | The ip address for an external service
managed | boolean | - | - | - | The managed for the serviceExposeMap
serviceId | [service]({{site.baseurl}}/rancher/api/service/) | - | - | - | The unique identifier of the associated service




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the serviceExposeMap was created.
description | string | Optional | Yes | - | The description for the serviceExposeMap
id | int | - | - | - | The unique identifier for the serviceExposeMap
kind | string | - | - | - | The kind for the serviceExposeMap
name | string | Optional | Yes | - | The name for the serviceExposeMap
removed | date | - | - | - | The date of when the serviceExposeMap was removed
state | enum | - | - | - | The current state of the serviceExposeMap. The options are [activating, active, removed, removing, requested].
transitioning | enum | - | - | - | Whether or not the serviceExposeMap is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the serviceExposeMap
uuid | string | - | - | - | The universally unique identifier for the serviceExposeMap. This will always be unique across Rancher installations.




### Actions









​

<span class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${action.remove}</code></span>
</span>
<div class="action-contents">
To remove the serviceExposeMap
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/serviceExposeMap/">serviceExposeMap</a> resource
</span>
</div>
</span>
</span>
</span>

