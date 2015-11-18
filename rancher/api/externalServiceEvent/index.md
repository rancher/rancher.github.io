---
title: API
layout: rancher-default
---

## externalServiceEvent


​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
environment | json | - | - | - | The environment for the externalServiceEvent
eventType | string | - | - | - | The eventType for the externalServiceEvent
externalId | string | - | - | - | The externalId for the externalServiceEvent
reportedAccountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The reportedAccountId for the externalServiceEvent
service | json | - | - | - | The service for the externalServiceEvent




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the externalServiceEvent was created.
id | int | - | - | - | The unique identifier for the externalServiceEvent
kind | string | - | - | - | The kind for the externalServiceEvent
state | enum | - | - | - | The current state of the externalServiceEvent. The options are [created, creating, removed, removing, requested].
transitioning | enum | - | - | - | Whether or not the externalServiceEvent is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the externalServiceEvent
uuid | string | - | - | - | The universally unique identifier for the externalServiceEvent. This will always be unique across Rancher installations.




### Actions









​

<span class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${action.remove}</code></span>
</span>
<div class="action-contents">
To remove the externalServiceEvent
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

