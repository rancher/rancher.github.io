---
title: API
layout: rancher-default
---

## host

Hosts are the most basic unit of resource within Rancher and is represented as any Linux server, virtual or physical, with the following minimum requirements. <br> <br> * Any modern Linux distribution that supports Docker 1.6+. <br> * Must be able to communicate with the Rancher server via http or https through the pre-configured port (Default is 8080). <br> * Must be routable to any other hosts belonging to the same environment to leverage Rancher's cross-host networking for Docker containers.<br> <br> Rancher also supports Docker Machine and allows you to add your host via any of its supported drivers.

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
id | int | - | - | - | The unique identifier for the host
kind | string | - | - | - | 
name | string | Optional | Yes | - | 
state | enum | - | - | - | The current state of the host. The options are [activating, active, deactivating, inactive, purged, purging, registering, removed, removing, requested, restoring, updating-active, updating-inactive].
agentState | string | - | - | - | The state of the agent
computeTotal | int | - | - | - | 
info | json | - | - | - | 
labels | map[string] | - | Yes | - | 
physicalHostId | [physicalHost]({{site.baseurl}}/rancher/api/physicalHost/) | - | - | - | 
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the host was created.
description | string | Optional | Yes | - | 
removed | date | - | - | - | The date of when the host was removed
transitioning | enum | - | - | - | Whether or not the host is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the host
uuid | string | - | - | - | The universally unique identifier for the host. This will always be unique across Rancher installations.





### Operations











<span class="action">
<span class="header">
Update
<span class="headerright">PUT:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"description": "string",

	"labels": "map[string]",

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
To activate the host
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/host/">host</a> resource
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
To deactivate the host
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/host/">host</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
dockersocket
<span class="headerright">POST:  <code>${action.dockersocket}</code></span>
</span>
<div class="action-contents">
To dockersocket the host
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/hostAccess/">hostAccess</a> resource
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
To purge the host
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/host/">host</a> resource
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
To remove the host
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/host/">host</a> resource
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
To restore the host
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/host/">host</a> resource
</span>
</div>
</span>
</span>
</span>
