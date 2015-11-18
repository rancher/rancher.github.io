---
title: API
layout: rancher-default
---

## externalHostEvent


​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
deleteHost | boolean | Optional | - | - | The deleteHost for the externalHostEvent
eventType | string | Optional | - | - | The eventType for the externalHostEvent
externalId | string | - | - | - | The externalId for the externalHostEvent
hostId | [host]({{site.baseurl}}/rancher/api/host/) | Optional | - | - | The unique identifier for the associated host
hostLabel | string | Optional | - | - | The hostLabel for the externalHostEvent
reportedAccountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The reportedAccountId for the externalHostEvent




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the externalHostEvent was created.
id | int | - | - | - | The unique identifier for the externalHostEvent
kind | string | - | - | - | The kind for the externalHostEvent
state | enum | - | - | - | The current state of the externalHostEvent. The options are [created, creating, removed, removing, requested].
transitioning | enum | - | - | - | Whether or not the externalHostEvent is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the externalHostEvent
uuid | string | - | - | - | The universally unique identifier for the externalHostEvent. This will always be unique across Rancher installations.




### Actions



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"deleteHost": false,

	"eventType": "string",

	"hostId": "reference[host]",

	"hostLabel": "string"

} 
{% endhighlight %}
</div>
</span>













​

<span class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${action.remove}</code></span>
</span>
<div class="action-contents">
To remove the externalHostEvent
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/externalEvent/">externalEvent</a> resource
</span>
</div>
</span>
</span>
</span>

