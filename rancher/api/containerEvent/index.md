---
title: API
layout: rancher-default
---

## containerEvent

Collection Test Description

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
id | int | - | - | - | The unique identifier for the containerEvent
kind | string | - | - | - | 
state | enum | - | - | - | The current state of the containerEvent. The options are [created, creating, removed, removing, requested].
dockerInspect | json | - | - | - | 
externalFrom | string | - | - | - | 
externalId | string | - | - | - | 
externalStatus | string | - | - | - | 
externalTimestamp | int | - | - | - | 
hostId | [host]({{site.baseurl}}/rancher/api/host/) | - | - | - | The unique identifier for the associated host
reportedHostUuid | string | - | - | - | 
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the containerEvent was created.
transitioning | enum | - | - | - | Whether or not the containerEvent is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the containerEvent












​
### Actions

<span class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${action.remove}</code></span>
</span>
<div class="action-contents">
To remove the containerEvent
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/containerEvent/">containerEvent</a> resource
</span>
</div>
</span>
</span>
</span>

