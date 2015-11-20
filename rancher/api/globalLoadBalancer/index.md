---
title: API
layout: rancher-default
---

## globalLoadBalancer

Collection Test Description

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
id | int | - | - | - | The unique identifier for the globalLoadBalancer
kind | string | - | - | - | 
name | string | Optional | Yes | - | 
state | enum | - | - | - | The current state of the globalLoadBalancer. The options are [activating, active, removed, removing, requested, updating-active].
globalLoadBalancerHealthCheck | array[globalLoadBalancerHealthCheck] | Optional | - | - | 
globalLoadBalancerPolicy | array[globalLoadBalancerPolicy] | Optional | - | - | 
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the globalLoadBalancer was created.
description | string | Optional | Yes | - | 
removed | date | - | - | - | The date of when the globalLoadBalancer was removed
transitioning | enum | - | - | - | Whether or not the globalLoadBalancer is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the globalLoadBalancer
uuid | string | - | - | - | The universally unique identifier for the globalLoadBalancer. This will always be unique across Rancher installations.





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

	"globalLoadBalancerHealthCheck": "array[globalLoadBalancerHealthCheck]",

	"globalLoadBalancerPolicy": "array[globalLoadBalancerPolicy]",

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
addloadbalancer
<span class="headerright">POST:  <code>${action.addloadbalancer}</code></span>
</span>
<div class="action-contents">
To addloadbalancer the globalLoadBalancer
<br>

<span class="input">
<strong>Input:</strong>​​​ addLoadBalancerInput


Field | Type | Required | Default | Notes
---|---|---|---|---
loadBalancerId | reference[loadBalancer] | Yes | <no value> | 
weight | int | Yes | <no value> | 


<br>
{% highlight json %}{

	"loadBalancerId": "reference[loadBalancer]",

	"weight": 0

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/globalLoadBalancer/">globalLoadBalancer</a> resource
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
To remove the globalLoadBalancer
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/globalLoadBalancer/">globalLoadBalancer</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
removeloadbalancer
<span class="headerright">POST:  <code>${action.removeloadbalancer}</code></span>
</span>
<div class="action-contents">
To removeloadbalancer the globalLoadBalancer
<br>

<span class="input">
<strong>Input:</strong>​​​ removeLoadBalancerInput


Field | Type | Required | Default | Notes
---|---|---|---|---
loadBalancerId | reference[loadBalancer] | Yes | <no value> | 


<br>
{% highlight json %}{

	"loadBalancerId": "reference[loadBalancer]"

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/globalLoadBalancer/">globalLoadBalancer</a> resource
</span>
</div>
</span>
</span>
</span>

