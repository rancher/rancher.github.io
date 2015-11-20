---
title: API
layout: rancher-default
---

## physicalHost

Collection Test Description

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
id | int | - | - | - | The unique identifier for the physicalHost
kind | string | - | - | - | 
name | string | Optional | Yes | - | 
state | enum | - | - | - | The current state of the physicalHost. The options are [active, bootstrapping, created, creating, error, erroring, removed, removing, requested, updating].
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the physicalHost was created.
description | string | Optional | Yes | - | 
removed | date | - | - | - | The date of when the physicalHost was removed
transitioning | enum | - | - | - | Whether or not the physicalHost is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the physicalHost
uuid | string | - | - | - | The universally unique identifier for the physicalHost. This will always be unique across Rancher installations.












​
### Actions

<span class="action">
<span class="header">
bootstrap
<span class="headerright">POST:  <code>${action.bootstrap}</code></span>
</span>
<div class="action-contents">
To bootstrap the physicalHost
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/physicalHost/">physicalHost</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
error
<span class="headerright">POST:  <code>${action.error}</code></span>
</span>
<div class="action-contents">
To error the physicalHost
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/physicalHost/">physicalHost</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${action.remove}</code></span>
</span>
<div class="action-contents">
To remove the physicalHost
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/physicalHost/">physicalHost</a> resource
</span>
</div>
</span>
</span>
</span>

