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
appCookieStickinessPolicy | [loadBalancerAppCookieStickinessPolicy]({{site.baseurl}}/rancher/api/api-resources/loadBalancerAppCookieStickinessPolicy/) | Optional | Yes | - | 
description | string | Optional | Yes | - | 
healthCheck | [loadBalancerHealthCheck]({{site.baseurl}}/rancher/api/api-resources/loadBalancerHealthCheck/) | Optional | Yes | - | The configuration of the health monitoring for managed network services
id | int | - | - | - | The unique identifier for the loadBalancerConfig
lbCookieStickinessPolicy | [loadBalancerCookieStickinessPolicy]({{site.baseurl}}/rancher/api/api-resources/loadBalancerCookieStickinessPolicy/) | Optional | Yes | - | 
name | string | Optional | Yes | - | 
serviceId | [service]({{site.baseurl}}/rancher/api/api-resources/service/) | - | - | - | The unique identifier of the associated service

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.
​

### Operations



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/loadBalancerConfig</code></span>
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
<span class="headerright">POST:  <code>${actions.addlistener}</code></span>
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

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/loadBalancerConfig/">loadBalancerConfig</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${actions.remove}</code></span>
</span>
<div class="action-contents">
To remove the loadBalancerConfig
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/loadBalancerConfig/">loadBalancerConfig</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
removelistener
<span class="headerright">POST:  <code>${actions.removelistener}</code></span>
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

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/loadBalancerConfig/">loadBalancerConfig</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
setlisteners
<span class="headerright">POST:  <code>${actions.setlisteners}</code></span>
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

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/loadBalancerConfig/">loadBalancerConfig</a> resource
</span>
</div>
</span>
</span>
</span>

