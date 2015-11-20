---
title: API
layout: rancher-default
---

## externalHandler

Collection Test Description
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
data | map[json] | - | - | - | The data for the externalHandler
priority | int | Optional | Yes | - | The priority for the externalHandler
processConfigs | array[externalHandlerProcessConfig] | Yes | - | - | The processConfigs for the externalHandler
retries | int | Optional | Yes | - | The retries for the externalHandler
timeoutMillis | int | Optional | Yes | - | The timeoutMillis for the externalHandler




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
created | date | - | - | - | The date of when the externalHandler was created.
description | string | Optional | Yes | - | The description for the externalHandler
id | int | - | - | - | The unique identifier for the externalHandler
kind | string | - | - | - | The kind for the externalHandler
name | string | Optional | Yes | - | The name for the externalHandler
removeTime | date | - | - | - | The date and time of when the externalHandler was removed
removed | date | - | - | - | The date of when the externalHandler was removed
state | enum | - | - | - | The current state of the externalHandler. The options are [activating, active, deactivating, inactive, purged, purging, registering, removed, removing, requested, restoring, updating-active, updating-inactive].
transitioning | enum | - | - | - | Whether or not the externalHandler is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the externalHandler
uuid | string | - | - | - | The universally unique identifier for the externalHandler. This will always be unique across Rancher installations.




### Actions



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

	"priority": 0,

	"processConfigs": "array[externalHandlerProcessConfig]",

	"retries": 0,

	"timeoutMillis": 0

} 
{% endhighlight %}
</div>
</span>











<span class="action">
<span class="header">
Update
<span class="headerright">PUT:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"description": "string",

	"name": "string",

	"priority": 0,

	"retries": 0,

	"timeoutMillis": 0

} 
{% endhighlight %}
</div>
</span>









​

<span class="action">
<span class="header">
activate
<span class="headerright">POST:  <code>${action.activate}</code></span>
</span>
<div class="action-contents">
To activate the externalHandler
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/externalHandler/">externalHandler</a> resource
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
To deactivate the externalHandler
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/externalHandler/">externalHandler</a> resource
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
To purge the externalHandler
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/externalHandler/">externalHandler</a> resource
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
To remove the externalHandler
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/externalHandler/">externalHandler</a> resource
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
To restore the externalHandler
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/externalHandler/">externalHandler</a> resource
</span>
</div>
</span>
</span>
</span>

