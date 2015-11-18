---
title: API
layout: rancher-default
---

## globalLoadBalancer

Collection Test Description
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
globalLoadBalancerHealthCheck | array[globalLoadBalancerHealthCheck] | Optional | - | - | The globalLoadBalancerHealthCheck for the globalLoadBalancer
globalLoadBalancerPolicy | array[globalLoadBalancerPolicy] | Optional | - | - | The globalLoadBalancerPolicy for the globalLoadBalancer




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the globalLoadBalancer was created.
description | string | Optional | Yes | - | The description for the globalLoadBalancer
id | int | - | - | - | The unique identifier for the globalLoadBalancer
kind | string | - | - | - | The kind for the globalLoadBalancer
name | string | Optional | Yes | - | The name for the globalLoadBalancer
removed | date | - | - | - | The date of when the globalLoadBalancer was removed
state | enum | - | - | - | The current state of the globalLoadBalancer. The options are [activating, active, removed, removing, requested, updating-active].
transitioning | enum | - | - | - | Whether or not the globalLoadBalancer is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the globalLoadBalancer
uuid | string | - | - | - | The universally unique identifier for the globalLoadBalancer. This will always be unique across Rancher installations.




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


Field | Type | Required | Default | Description
---|---|---|---|---
loadBalancerId | reference[loadBalancer] | Yes | <no value> | The loadBalancerId for the addLoadBalancerInput
weight | int | Yes | <no value> | The weight for the addLoadBalancerInput


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
{% highlight json %}{}{% endhighlight %}

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


Field | Type | Required | Default | Description
---|---|---|---|---
loadBalancerId | reference[loadBalancer] | Yes | <no value> | The loadBalancerId for the removeLoadBalancerInput


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

