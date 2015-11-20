---
title: API
layout: rancher-default
---

## externalHandlerExternalHandlerProcessMap

Collection Test Description
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
data | map[json] | - | - | - | The data for the externalHandlerExternalHandlerProcessMap
externalHandlerId | [externalHandler]({{site.baseurl}}/rancher/api/externalHandler/) | - | - | - | The externalHandlerId for the externalHandlerExternalHandlerProcessMap
externalHandlerProcessId | [externalHandlerProcess]({{site.baseurl}}/rancher/api/externalHandlerProcess/) | - | - | - | The externalHandlerProcessId for the externalHandlerExternalHandlerProcessMap
onError | string | - | - | - | The onError for the externalHandlerExternalHandlerProcessMap




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
created | date | - | - | - | The date of when the externalHandlerExternalHandlerProcessMap was created.
description | string | Optional | Yes | - | The description for the externalHandlerExternalHandlerProcessMap
id | int | - | - | - | The unique identifier for the externalHandlerExternalHandlerProcessMap
kind | string | - | - | - | The kind for the externalHandlerExternalHandlerProcessMap
name | string | Optional | Yes | - | The name for the externalHandlerExternalHandlerProcessMap
removeTime | date | - | - | - | The date and time of when the externalHandlerExternalHandlerProcessMap was removed
removed | date | - | - | - | The date of when the externalHandlerExternalHandlerProcessMap was removed
state | enum | - | - | - | The current state of the externalHandlerExternalHandlerProcessMap. The options are [activating, active, deactivating, inactive, purged, purging, registering, removed, removing, requested, restoring, updating-active, updating-inactive].
transitioning | enum | - | - | - | Whether or not the externalHandlerExternalHandlerProcessMap is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the externalHandlerExternalHandlerProcessMap
uuid | string | - | - | - | The universally unique identifier for the externalHandlerExternalHandlerProcessMap. This will always be unique across Rancher installations.




### Actions









​

<span class="action">
<span class="header">
activate
<span class="headerright">POST:  <code>${action.activate}</code></span>
</span>
<div class="action-contents">
To activate the externalHandlerExternalHandlerProcessMap
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/externalHandlerExternalHandlerProcessMap/">externalHandlerExternalHandlerProcessMap</a> resource
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
To deactivate the externalHandlerExternalHandlerProcessMap
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/externalHandlerExternalHandlerProcessMap/">externalHandlerExternalHandlerProcessMap</a> resource
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
To purge the externalHandlerExternalHandlerProcessMap
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/externalHandlerExternalHandlerProcessMap/">externalHandlerExternalHandlerProcessMap</a> resource
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
To remove the externalHandlerExternalHandlerProcessMap
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/externalHandlerExternalHandlerProcessMap/">externalHandlerExternalHandlerProcessMap</a> resource
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
To restore the externalHandlerExternalHandlerProcessMap
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/externalHandlerExternalHandlerProcessMap/">externalHandlerExternalHandlerProcessMap</a> resource
</span>
</div>
</span>
</span>
</span>

