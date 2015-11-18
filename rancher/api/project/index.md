---
title: API
layout: rancher-default
---

## project

A "project" in the API is referred to as an environment in the UI and the Rancher documentation. In the API documentation, we'll use the UI terminology.  All hosts and any Rancher resources (i.e. containers, load balancers, etc.) are created and belong to an [environment]({{site.baseurl}}/rancher/configuration/environments/).  Access control to who can view and manage these resources are then defined by the owner of the environment.  Rancher currently supports the capability for each user to manage and invite other users to their environment and allows for the ability to create multiple environments for different workloads.  For example, you may want to create a "dev" environment and a separate "production" environment with its own set of resources and limited user access for your application deployment.
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
kubernetes | boolean | Optional | Yes | - | The kubernetes for the project
members | array[projectMember] | Optional | - | - | The members for the project
swarm | boolean | Optional | Yes | - | The swarm for the project




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
created | date | - | - | - | The date of when the project was created.
description | string | Optional | Yes | - | The description for the project
id | int | - | - | - | The unique identifier for the project
kind | string | - | - | user | The kind for the project
name | string | Optional | Yes | - | The name for the project
removed | date | - | - | - | The date of when the project was removed
state | enum | - | - | - | The current state of the project. The options are [activating, active, deactivating, inactive, purged, purging, registering, removed, removing, requested, restoring, updating-active, updating-inactive].
transitioning | enum | - | - | - | Whether or not the project is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the project
uuid | string | - | - | - | The universally unique identifier for the project. This will always be unique across Rancher installations.




### Actions









​

<span class="action">
<span class="header">
activate
<span class="headerright">POST:  <code>${action.activate}</code></span>
</span>
<div class="action-contents">
To activate the project
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/account/">account</a> resource
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
To deactivate the project
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/account/">account</a> resource
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
To purge the project
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/account/">account</a> resource
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
To remove the project
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/account/">account</a> resource
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
To restore the project
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/account/">account</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
setmembers
<span class="headerright">POST:  <code>${action.setmembers}</code></span>
</span>
<div class="action-contents">
To setmembers the project
<br>

<span class="input">
<strong>Input:</strong>​​​ setProjectMembersInput


Field | Type | Required | Default | Description
---|---|---|---|---
members | array[projectMember] | Yes | <no value> | The members for the setProjectMembersInput


<br>
{% highlight json %}{

	"members": "array[projectMember]"

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/setProjectMembersInput/">setProjectMembersInput</a> resource
</span>
</div>
</span>
</span>
</span>

