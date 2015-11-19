---
title: API
layout: rancher-default
---

## externalEvent

Collection Test Description

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
id | int | - | - | - | The unique identifier for the externalEvent
kind | string | - | - | - | 
state | enum | - | - | - | The current state of the externalEvent. The options are [created, creating, removed, removing, requested].
eventType | string | - | - | - | 
externalId | string | - | - | - | 
reportedAccountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | 
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the externalEvent was created.
transitioning | enum | - | - | - | Whether or not the externalEvent is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the externalEvent
uuid | string | - | - | - | The universally unique identifier for the externalEvent. This will always be unique across Rancher installations.












​
### Actions

<span class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${action.remove}</code></span>
</span>
<div class="action-contents">
To remove the externalEvent
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/externalEvent/">externalEvent</a> resource
</span>
</div>
</span>
</span>
</span>

