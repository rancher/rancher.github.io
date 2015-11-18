---
title: API
layout: rancher-default
---

## loadBalancerListener

Collection Test Description
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
algorithm | enum | Optional | - | roundrobin | The algorithm for the loadBalancerListener
privatePort | int | Optional | - | - | The private port
serviceId | [service]({{site.baseurl}}/rancher/api/service/) | - | - | - | The unique identifier of the associated service
sourcePort | int | Optional | - | - | The sourcePort for the loadBalancerListener
sourceProtocol | enum | Yes | - | - | The sourceProtocol for the loadBalancerListener
targetPort | int | - | - | - | The targetPort for the loadBalancerListener
targetProtocol | enum | - | - | - | The targetProtocol for the loadBalancerListener




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the loadBalancerListener was created.
description | string | Optional | Yes | - | The description for the loadBalancerListener
id | int | - | - | - | The unique identifier for the loadBalancerListener
kind | string | - | - | - | The kind for the loadBalancerListener
name | string | Optional | Yes | - | The name for the loadBalancerListener
removed | date | - | - | - | The date of when the loadBalancerListener was removed
state | enum | - | - | - | The current state of the loadBalancerListener. The options are [activating, active, removed, removing, requested].
transitioning | enum | - | - | - | Whether or not the loadBalancerListener is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the loadBalancerListener
uuid | string | - | - | - | The universally unique identifier for the loadBalancerListener. This will always be unique across Rancher installations.




### Actions



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"algorithm": "roundrobin",

	"description": "string",

	"name": "string",

	"privatePort": 0,

	"sourcePort": 0,

	"sourceProtocol": "enum"

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
remove
<span class="headerright">POST:  <code>${action.remove}</code></span>
</span>
<div class="action-contents">
To remove the loadBalancerListener
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/loadBalancerListener/">loadBalancerListener</a> resource
</span>
</div>
</span>
</span>
</span>

