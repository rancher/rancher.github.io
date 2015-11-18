---
title: API
layout: rancher-default
---

## externalDnsEvent

Collection Test Description
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
eventType | string | - | - | - | The eventType for the externalDnsEvent
externalId | string | - | - | - | The externalId for the externalDnsEvent
fqdn | string | - | - | - | The fqdn for the externalDnsEvent
reportedAccountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The reportedAccountId for the externalDnsEvent
serviceName | string | - | - | - | The serviceName for the externalDnsEvent
stackName | string | - | - | - | The stackName for the externalDnsEvent




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the externalDnsEvent was created.
id | int | - | - | - | The unique identifier for the externalDnsEvent
kind | string | - | - | - | The kind for the externalDnsEvent
state | enum | - | - | - | The current state of the externalDnsEvent. The options are [created, creating, removed, removing, requested].
transitioning | enum | - | - | - | Whether or not the externalDnsEvent is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the externalDnsEvent
uuid | string | - | - | - | The universally unique identifier for the externalDnsEvent. This will always be unique across Rancher installations.




### Actions









​

<span class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${action.remove}</code></span>
</span>
<div class="action-contents">
To remove the externalDnsEvent
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

