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
description | string | Optional | Yes | - | 
globalLoadBalancerHealthCheck | array[globalLoadBalancerHealthCheck] | Optional | - | - | 
globalLoadBalancerPolicy | array[globalLoadBalancerPolicy] | Optional | - | - | 
id | int | - | - | - | The unique identifier for the globalLoadBalancer
name | string | Optional | Yes | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.
​

### Operations



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/globalLoadBalancer</code></span>
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
<span class="headerright">POST:  <code>${actions.addloadbalancer}</code></span>
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

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/globalLoadBalancer/">globalLoadBalancer</a> resource
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
To remove the globalLoadBalancer
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/globalLoadBalancer/">globalLoadBalancer</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
removeloadbalancer
<span class="headerright">POST:  <code>${actions.removeloadbalancer}</code></span>
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

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/globalLoadBalancer/">globalLoadBalancer</a> resource
</span>
</div>
</span>
</span>
</span>

