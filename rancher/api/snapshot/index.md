---
title: API
layout: rancher-default
---

## snapshot

Collection Test Description

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
id | int | - | - | - | The unique identifier for the snapshot
kind | string | - | - | - | 
name | string | Optional | Yes | - | 
state | enum | - | - | - | The current state of the snapshot. The options are [backed-up, backing-up, created, creating, removed, removing, requested].
managedVolumeUUID | string | - | - | - | The unique identifier of the managed volume
volumeId | [volume]({{site.baseurl}}/rancher/api/volume/) | Yes | - | - | 
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the snapshot was created.
description | string | Optional | Yes | - | 
removed | date | - | - | - | The date of when the snapshot was removed
transitioning | enum | - | - | - | Whether or not the snapshot is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the snapshot
uuid | string | - | - | - | The universally unique identifier for the snapshot. This will always be unique across Rancher installations.





### Operations



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"description": "string",

	"name": "string",

	"volumeId": "reference[volume]"

} 
{% endhighlight %}
</div>
</span>












​
### Actions

<span class="action">
<span class="header">
backup
<span class="headerright">POST:  <code>${action.backup}</code></span>
</span>
<div class="action-contents">
To backup the snapshot
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/snapshot/">snapshot</a> resource
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
To remove the snapshot
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/snapshot/">snapshot</a> resource
</span>
</div>
</span>
</span>
</span>

