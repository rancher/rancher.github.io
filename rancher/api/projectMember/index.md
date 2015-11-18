---
title: API
layout: rancher-default
---

## projectMember

An environment member is how a user can be a part of an environment.
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
externalId | string | Optional | - | - | The externalId for the projectMember
externalIdType | enum | Optional | - | rancher_id | The externalIdType for the projectMember
projectId | [project]({{site.baseurl}}/rancher/api/project/) | - | - | - | The projectId for the projectMember
role | enum | Optional | - | member | The role for the projectMember




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
created | date | - | - | - | The date of when the projectMember was created.
description | string | Optional | Yes | - | The description for the projectMember
id | int | - | - | - | The unique identifier for the projectMember
kind | string | - | - | - | The kind for the projectMember
name | string | - | - | - | The name for the projectMember
removed | date | - | - | - | The date of when the projectMember was removed
state | enum | - | - | - | The current state of the projectMember. The options are [activating, active, deactivating, inactive, purged, purging, registering, removed, removing, requested, restoring, updating-active, updating-inactive].
transitioning | enum | - | - | - | Whether or not the projectMember is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the projectMember
uuid | string | - | - | - | The universally unique identifier for the projectMember. This will always be unique across Rancher installations.




### Actions









​

<span class="action">
<span class="header">
activate
<span class="headerright">POST:  <code>${action.activate}</code></span>
</span>
<div class="action-contents">
To activate the projectMember
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/projectMember/">projectMember</a> resource
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
To deactivate the projectMember
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/projectMember/">projectMember</a> resource
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
To purge the projectMember
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/projectMember/">projectMember</a> resource
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
To remove the projectMember
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/projectMember/">projectMember</a> resource
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
To restore the projectMember
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/projectMember/">projectMember</a> resource
</span>
</div>
</span>
</span>
</span>

