---
title: API
layout: rancher-default
---

## loadBalancerConfig

Collection Test Description

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
id | int | - | - | - | The unique identifier for the loadBalancerConfig
kind | string | - | - | - | 
name | string | Optional | Yes | - | 
state | enum | - | - | - | The current state of the loadBalancerConfig. The options are [activating, active, removed, removing, requested, updating-active].
appCookieStickinessPolicy | [loadBalancerAppCookieStickinessPolicy]({{site.baseurl}}/rancher/api/loadBalancerAppCookieStickinessPolicy/) | Optional | Yes | - | ALENA
healthCheck | [loadBalancerHealthCheck]({{site.baseurl}}/rancher/api/loadBalancerHealthCheck/) | Optional | Yes | - | 
lbCookieStickinessPolicy | [loadBalancerCookieStickinessPolicy]({{site.baseurl}}/rancher/api/loadBalancerCookieStickinessPolicy/) | Optional | Yes | - | ALENA
serviceId | [service]({{site.baseurl}}/rancher/api/service/) | - | - | - | The unique identifier of the associated service
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the loadBalancerConfig was created.
description | string | Optional | Yes | - | 
removed | date | - | - | - | The date of when the loadBalancerConfig was removed
transitioning | enum | - | - | - | Whether or not the loadBalancerConfig is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the loadBalancerConfig
uuid | string | - | - | - | The universally unique identifier for the loadBalancerConfig. This will always be unique across Rancher installations.





### Operations



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"appCookieStickinessPolicy": {

		"cookie": "string",

		"maxLength": 0,

		"mode": "enum",

		"name": "string",

		"prefix": true,

		"requestLearn": true,

		"timeout": 0

	},

	"description": "string",

	"healthCheck": {

		"healthyThreshold": 0,

		"interval": 0,

		"name": "string",

		"port": 0,

		"requestLine": "string",

		"responseTimeout": 0,

		"unhealthyThreshold": 0

	},

	"lbCookieStickinessPolicy": {

		"cookie": "string",

		"domain": "string",

		"indirect": true,

		"mode": "enum",

		"name": "string",

		"nocache": true,

		"postonly": true

	},

	"name": "string"

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

	"appCookieStickinessPolicy": {

		"cookie": "string",

		"maxLength": 0,

		"mode": "enum",

		"name": "string",

		"prefix": true,

		"requestLearn": true,

		"timeout": 0

	},

	"description": "string",

	"healthCheck": {

		"healthyThreshold": 0,

		"interval": 0,

		"name": "string",

		"port": 0,

		"requestLine": "string",

		"responseTimeout": 0,

		"unhealthyThreshold": 0

	},

	"lbCookieStickinessPolicy": {

		"cookie": "string",

		"domain": "string",

		"indirect": true,

		"mode": "enum",

		"name": "string",

		"nocache": true,

		"postonly": true

	},

	"name": "string"

} 
{% endhighlight %}
</div>
</span>







<span class="action">
<span class="header">
Delete
<span class="headerright">DELETE:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
 
{% endhighlight %}
</div>
</span>






​
### Actions

<span class="action">
<span class="header">
addlistener
<span class="headerright">POST:  <code>${action.addlistener}</code></span>
</span>
<div class="action-contents">
To addlistener the loadBalancerConfig
<br>

<span class="input">
<strong>Input:</strong>​​​ addRemoveLoadBalancerListenerInput


Field | Type | Required | Default | Notes
---|---|---|---|---
loadBalancerListenerId | reference[loadBalancerListener] | Yes | <no value> | 


<br>
{% highlight json %}{

	"loadBalancerListenerId": "reference[loadBalancerListener]"

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/loadBalancerConfig/">loadBalancerConfig</a> resource
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
To remove the loadBalancerConfig
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/loadBalancerConfig/">loadBalancerConfig</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
removelistener
<span class="headerright">POST:  <code>${action.removelistener}</code></span>
</span>
<div class="action-contents">
To removelistener the loadBalancerConfig
<br>

<span class="input">
<strong>Input:</strong>​​​ addRemoveLoadBalancerListenerInput


Field | Type | Required | Default | Notes
---|---|---|---|---
loadBalancerListenerId | reference[loadBalancerListener] | Yes | <no value> | 


<br>
{% highlight json %}{

	"loadBalancerListenerId": "reference[loadBalancerListener]"

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/loadBalancerConfig/">loadBalancerConfig</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
setlisteners
<span class="headerright">POST:  <code>${action.setlisteners}</code></span>
</span>
<div class="action-contents">
To setlisteners the loadBalancerConfig
<br>

<span class="input">
<strong>Input:</strong>​​​ setLoadBalancerListenersInput


Field | Type | Required | Default | Notes
---|---|---|---|---
loadBalancerListenerIds | array[reference[loadBalancerListener]] | No | <no value> | 


<br>
{% highlight json %}{

	"loadBalancerListenerIds": "array[reference[loadBalancerListener]]"

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/loadBalancerConfig/">loadBalancerConfig</a> resource
</span>
</div>
</span>
</span>
</span>

