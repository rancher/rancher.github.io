---
title: API
layout: rancher-default
---

## serviceEvent

Collection Test Description
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
externalTimestamp | int | - | - | - | The externalTimestamp for the serviceEvent
healthcheckUuid | string | - | - | - | The universal unique identifier of the healthcheck
hostId | [host]({{site.baseurl}}/rancher/api/host/) | - | - | - | The unique identifier for the associated host
instanceId | [instance]({{site.baseurl}}/rancher/api/instance/) | - | - | - | The unique identifier for the associated instance
reportedHealth | string | - | - | - | The reported health




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the serviceEvent was created.
description | string | Optional | Yes | - | The description for the serviceEvent
id | int | - | - | - | The unique identifier for the serviceEvent
kind | string | - | - | - | The kind for the serviceEvent
name | string | Optional | Yes | - | The name for the serviceEvent
removed | date | - | - | - | The date of when the serviceEvent was removed
state | enum | - | - | - | The current state of the serviceEvent. The options are [created, creating, removed, removing, requested].
transitioning | enum | - | - | - | Whether or not the serviceEvent is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the serviceEvent
uuid | string | - | - | - | The universally unique identifier for the serviceEvent. This will always be unique across Rancher installations.




### Actions









​

<span class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${action.remove}</code></span>
</span>
<div class="action-contents">
To remove the serviceEvent
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/serviceEvent/">serviceEvent</a> resource
</span>
</div>
</span>
</span>
</span>

