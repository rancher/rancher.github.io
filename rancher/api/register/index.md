---
title: API
layout: rancher-default
---

## register

Collection Test Description
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
accessKey | string | - | - | - | The accessKey for the register
key | string | Yes | - | - | The key for the register
secretKey | string | - | - | - | The secretKey for the register




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the register was created.
description | string | Optional | Yes | - | The description for the register
id | int | - | - | - | The unique identifier for the register
kind | string | - | - | - | The kind for the register
name | string | Optional | Yes | - | The name for the register
removed | date | - | - | - | The date of when the register was removed
state | enum | - | - | - | The current state of the register. The options are [activating, active, deactivating, inactive, purged, purging, registering, removed, removing, requested, restoring, updating-active, updating-inactive].
transitioning | enum | - | - | - | Whether or not the register is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the register
uuid | string | - | - | - | The universally unique identifier for the register. This will always be unique across Rancher installations.




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

	"key": "string",

	"name": "string"

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
To activate the register
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

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
To deactivate the register
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

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
To purge the register
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

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
To remove the register
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

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
To restore the register
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

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
stop
<span class="headerright">POST:  <code>${action.stop}</code></span>
</span>
<div class="action-contents">
To stop the register
<br>

<span class="input">
<strong>Input:</strong>​​​ instanceStop


Field | Type | Required | Default | Description
---|---|---|---|---
remove | boolean | No | <no value> | The remove for the instanceStop
timeout | int | No | <no value> | The timeout for the instanceStop


<br>
{% highlight json %}{

	"remove": true,

	"timeout": 0

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/instance/">instance</a> resource
</span>
</div>
</span>
</span>
</span>

