---
title: API
layout: rancher-default
---

## loadBalancer



​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
id | int | - | - | - | The unique identifier for the loadBalancer
kind | string | - | - | - | 
name | string | Optional | Yes | - | 
state | enum | - | - | - | The current state of the loadBalancer. The options are [activating, active, deactivating, inactive, removed, removing, requested, updating-active].
certificateIds | array[[certificate]({{site.baseurl}}/rancher/api/certificate/)] | Optional | Yes | - | The ID of a certificate
defaultCertificateId | [certificate]({{site.baseurl}}/rancher/api/certificate/) | Optional | Yes | - | The ID of a default certificate
globalLoadBalancerId | [globalLoadBalancer]({{site.baseurl}}/rancher/api/globalLoadBalancer/) | - | - | - | 
loadBalancerConfigId | [loadBalancerConfig]({{site.baseurl}}/rancher/api/loadBalancerConfig/) | Yes | - | - | 
serviceId | [service]({{site.baseurl}}/rancher/api/service/) | - | - | - | The unique identifier of the associated service
weight | int | - | - | - | 
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the loadBalancer was created.
description | string | Optional | Yes | - | 
removed | date | - | - | - | The date of when the loadBalancer was removed
transitioning | enum | - | - | - | Whether or not the loadBalancer is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the loadBalancer
uuid | string | - | - | - | The universally unique identifier for the loadBalancer. This will always be unique across Rancher installations.





### Operations



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"certificateIds": "array[reference[certificate]]",

	"defaultCertificateId": "reference[certificate]",

	"description": "string",

	"loadBalancerConfigId": "reference[loadBalancerConfig]",

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

	"certificateIds": "array[reference[certificate]]",

	"defaultCertificateId": "reference[certificate]",

	"description": "string",

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
activate
<span class="headerright">POST:  <code>${action.activate}</code></span>
</span>
<div class="action-contents">
To activate the loadBalancer
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/loadBalancer/">loadBalancer</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
addhost
<span class="headerright">POST:  <code>${action.addhost}</code></span>
</span>
<div class="action-contents">
To addhost the loadBalancer
<br>

<span class="input">
<strong>Input:</strong>​​​ addRemoveLoadBalancerHostInput


Field | Type | Required | Default | Notes
---|---|---|---|---
hostId | reference[host] | Yes | <no value> | The unique identifier for the associated host


<br>
{% highlight json %}{

	"hostId": "reference[host]"

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/loadBalancer/">loadBalancer</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
addtarget
<span class="headerright">POST:  <code>${action.addtarget}</code></span>
</span>
<div class="action-contents">
To addtarget the loadBalancer
<br>

<span class="input">
<strong>Input:</strong>​​​ addRemoveLoadBalancerTargetInput


Field | Type | Required | Default | Notes
---|---|---|---|---
loadBalancerTarget | loadBalancerTarget | Yes | <no value> | 


<br>
{% highlight json %}{

	"loadBalancerTarget": {

		"accountId": "reference[account]",

		"created": "date",

		"description": "string",

		"id": 0,

		"instanceId": "reference[instance]",

		"ipAddress": "string",

		"kind": "string",

		"loadBalancerId": "reference[loadBalancer]",

		"name": "string",

		"ports": "[string, string, string...]",

		"removed": "date",

		"state": "enum",

		"transitioning": "enum",

		"transitioningMessage": "string",

		"transitioningProgress": 0,

		"uuid": "string"

	}

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/loadBalancer/">loadBalancer</a> resource
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
To deactivate the loadBalancer
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/loadBalancer/">loadBalancer</a> resource
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
To remove the loadBalancer
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/loadBalancer/">loadBalancer</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
removehost
<span class="headerright">POST:  <code>${action.removehost}</code></span>
</span>
<div class="action-contents">
To removehost the loadBalancer
<br>

<span class="input">
<strong>Input:</strong>​​​ addRemoveLoadBalancerHostInput


Field | Type | Required | Default | Notes
---|---|---|---|---
hostId | reference[host] | Yes | <no value> | The unique identifier for the associated host


<br>
{% highlight json %}{

	"hostId": "reference[host]"

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/loadBalancer/">loadBalancer</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
removetarget
<span class="headerright">POST:  <code>${action.removetarget}</code></span>
</span>
<div class="action-contents">
To removetarget the loadBalancer
<br>

<span class="input">
<strong>Input:</strong>​​​ addRemoveLoadBalancerTargetInput


Field | Type | Required | Default | Notes
---|---|---|---|---
loadBalancerTarget | loadBalancerTarget | Yes | <no value> | 


<br>
{% highlight json %}{

	"loadBalancerTarget": {

		"accountId": "reference[account]",

		"created": "date",

		"description": "string",

		"id": 0,

		"instanceId": "reference[instance]",

		"ipAddress": "string",

		"kind": "string",

		"loadBalancerId": "reference[loadBalancer]",

		"name": "string",

		"ports": "[string, string, string...]",

		"removed": "date",

		"state": "enum",

		"transitioning": "enum",

		"transitioningMessage": "string",

		"transitioningProgress": 0,

		"uuid": "string"

	}

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/loadBalancer/">loadBalancer</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
sethosts
<span class="headerright">POST:  <code>${action.sethosts}</code></span>
</span>
<div class="action-contents">
To sethosts the loadBalancer
<br>

<span class="input">
<strong>Input:</strong>​​​ setLoadBalancerHostsInput


Field | Type | Required | Default | Notes
---|---|---|---|---
hostIds | array[reference[host]] | No | <no value> | 


<br>
{% highlight json %}{

	"hostIds": "array[reference[host]]"

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/loadBalancer/">loadBalancer</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
settargets
<span class="headerright">POST:  <code>${action.settargets}</code></span>
</span>
<div class="action-contents">
To settargets the loadBalancer
<br>

<span class="input">
<strong>Input:</strong>​​​ setLoadBalancerTargetsInput


Field | Type | Required | Default | Notes
---|---|---|---|---
loadBalancerTargets | array[loadBalancerTarget] | No | <no value> | 


<br>
{% highlight json %}{

	"loadBalancerTargets": "array[loadBalancerTarget]"

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/loadBalancer/">loadBalancer</a> resource
</span>
</div>
</span>
</span>
</span>

