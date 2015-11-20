---
title: API
layout: rancher-default
---

## pullTask

Collection Test Description

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
id | int | - | - | - | The unique identifier for the pullTask
kind | string | - | - | - | 
name | string | Optional | Yes | - | 
state | enum | - | - | - | The current state of the pullTask. The options are [activating, active, deactivating, inactive, purged, purging, registering, removed, removing, requested, restoring, updating-active, updating-inactive].
image | string | Yes | - | - | 
labels | map[string] | Optional | - | - | 
mode | enum | Yes | - | all | 
status | map[string] | - | - | - | 
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the pullTask was created.
description | string | Optional | Yes | - | 
removed | date | - | - | - | The date of when the pullTask was removed
transitioning | enum | - | - | - | Whether or not the pullTask is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the pullTask
uuid | string | - | - | - | The universally unique identifier for the pullTask. This will always be unique across Rancher installations.





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

	"image": "string",

	"labels": "map[string]",

	"mode": "all",

	"name": "string"

} 
{% endhighlight %}
</div>
</span>












​
### Actions

<span class="action">
<span class="header">
activate
<span class="headerright">POST:  <code>${action.activate}</code></span>
</span>
<div class="action-contents">
To activate the pullTask
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/genericObject/">genericObject</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
deactivate
<span class="headerright">POST:  <code>${action.deactivate}</code></span>
</span>
<div class="action-contents">
To deactivate the pullTask
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/genericObject/">genericObject</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
purge
<span class="headerright">POST:  <code>${action.purge}</code></span>
</span>
<div class="action-contents">
To purge the pullTask
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/genericObject/">genericObject</a> resource
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
To remove the pullTask
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/genericObject/">genericObject</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
restore
<span class="headerright">POST:  <code>${action.restore}</code></span>
</span>
<div class="action-contents">
To restore the pullTask
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/genericObject/">genericObject</a> resource
</span>
</div>
</span>
</span>
</span>

