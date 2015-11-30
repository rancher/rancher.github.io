---
title: API
layout: rancher-default
---

## cluster

Collection Test Description

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
agentState | string | - | - | - | The state of the agent
computeTotal | int | - | - | - | 
description | string | Optional | Yes | - | 
discoverySpec | string | - | - | - | 
id | int | - | - | - | The unique identifier for the cluster
info | json | - | - | - | 
labels | map[string] | - | Yes | - | 
name | string | Optional | Yes | - | 
physicalHostId | [physicalHost]({{site.baseurl}}/rancher/api/api-resources/physicalHost/) | - | - | - | The unique identifier of the physical host
port | int | Optional | Yes | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.
​

### Operations



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/cluster</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"description": "string",

	"name": "string",

	"port": 0

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

	"labels": {

		"key1": "value1",

		"key2": "value2",

		"keyN": "valueN"

	},

	"name": "string",

	"port": 0

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
<span class="headerright">POST:  <code>${actions.activate}</code></span>
</span>
<div class="action-contents">
To activate the cluster
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/host/">host</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
addhost
<span class="headerright">POST:  <code>${actions.addhost}</code></span>
</span>
<div class="action-contents">
To addhost the cluster
<br>

<span class="input">
<strong>Input:</strong>​​​ addRemoveClusterHostInput


Field | Type | Required | Default | Notes
---|---|---|---|---
hostId | reference[host] | No | <no value> | The unique identifier for the associated host


<br>
{% highlight json %}{

	"hostId": "reference[host]"

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/cluster/">cluster</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
deactivate
<span class="headerright">POST:  <code>${actions.deactivate}</code></span>
</span>
<div class="action-contents">
To deactivate the cluster
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/host/">host</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
dockersocket
<span class="headerright">POST:  <code>${actions.dockersocket}</code></span>
</span>
<div class="action-contents">
To dockersocket the cluster
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/hostAccess/">hostAccess</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
purge
<span class="headerright">POST:  <code>${actions.purge}</code></span>
</span>
<div class="action-contents">
To purge the cluster
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/host/">host</a> resource
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
To remove the cluster
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/host/">host</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
removehost
<span class="headerright">POST:  <code>${actions.removehost}</code></span>
</span>
<div class="action-contents">
To removehost the cluster
<br>

<span class="input">
<strong>Input:</strong>​​​ addRemoveClusterHostInput


Field | Type | Required | Default | Notes
---|---|---|---|---
hostId | reference[host] | No | <no value> | The unique identifier for the associated host


<br>
{% highlight json %}{

	"hostId": "reference[host]"

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/cluster/">cluster</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
restore
<span class="headerright">POST:  <code>${actions.restore}</code></span>
</span>
<div class="action-contents">
To restore the cluster
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/host/">host</a> resource
</span>
</div>
</span>
</span>
</span>

