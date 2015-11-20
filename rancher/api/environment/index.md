---
title: API
layout: rancher-default
---

## environment

An "environment" in the API is referred to as a stack in the UI and the Rancher documentation. In the API documentation, we'll use the UI terminology. A Rancher stack mirrors the same concept as a docker-compose project.  It represents a group of services that make up a typical application or workload.

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
id | int | - | - | - | The unique identifier for the environment
kind | string | - | - | - | 
name | string | Yes | Yes | - | 
state | enum | - | - | - | The current state of the environment. The options are [activating, active, canceled-upgrade, canceling-rollback, canceling-upgrade, error, erroring, finishing-upgrade, removed, removing, requested, rolling-back, updating-active, upgraded, upgrading].
dockerCompose | string | Optional | - | - | The docker-compose.yml file for the stack
environment | map[string] | Optional | - | - | 
externalId | string | Optional | Yes | - | 
outputs | map[string] | Optional | Yes | - | 
previousExternalId | string | Optional | Yes | - | 
rancherCompose | string | Optional | - | - | The rancher-compose.yml file for the stack
startOnCreate | boolean | Optional | - | - | Whether or not the services in the stack should be started after creation
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the environment was created.
description | string | Optional | Yes | - | 
removed | date | - | - | - | The date of when the environment was removed
transitioning | enum | - | - | - | Whether or not the environment is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the environment
uuid | string | - | - | - | The universally unique identifier for the environment. This will always be unique across Rancher installations.





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

	"dockerCompose": "string",

	"environment": "map[string]",

	"externalId": "string",

	"name": "string",

	"outputs": "map[string]",

	"previousExternalId": "string",

	"rancherCompose": "string",

	"startOnCreate": true

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

	"externalId": "string",

	"name": "string",

	"outputs": "map[string]",

	"previousExternalId": "string"

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
activateservices
<span class="headerright">POST:  <code>${action.activateservices}</code></span>
</span>
<div class="action-contents">
To activateservices the environment
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/environment/">environment</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
addoutputs
<span class="headerright">POST:  <code>${action.addoutputs}</code></span>
</span>
<div class="action-contents">
To addoutputs the environment
<br>

<span class="input">
<strong>Input:</strong>​​​ addOutputsInput


Field | Type | Required | Default | Notes
---|---|---|---|---
outputs | map[string] | Yes | <no value> | 


<br>
{% highlight json %}{

	"outputs": "map[string]"

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/environment/">environment</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
cancelrollback
<span class="headerright">POST:  <code>${action.cancelrollback}</code></span>
</span>
<div class="action-contents">
To cancelrollback the environment
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/environment/">environment</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
cancelupgrade
<span class="headerright">POST:  <code>${action.cancelupgrade}</code></span>
</span>
<div class="action-contents">
To cancelupgrade the environment
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/environment/">environment</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
deactivateservices
<span class="headerright">POST:  <code>${action.deactivateservices}</code></span>
</span>
<div class="action-contents">
To deactivateservices the environment
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/environment/">environment</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
error
<span class="headerright">POST:  <code>${action.error}</code></span>
</span>
<div class="action-contents">
To error the environment
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/environment/">environment</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
exportconfig
<span class="headerright">POST:  <code>${action.exportconfig}</code></span>
</span>
<div class="action-contents">
To exportconfig the environment
<br>

<span class="input">
<strong>Input:</strong>​​​ composeConfigInput


Field | Type | Required | Default | Notes
---|---|---|---|---
serviceIds | array[reference[service]] | No | <no value> | The list of Service IDs in the `docker-compose.yml`


<br>
{% highlight json %}{

	"serviceIds": "array[reference[service]]"

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/composeConfig/">composeConfig</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
finishupgrade
<span class="headerright">POST:  <code>${action.finishupgrade}</code></span>
</span>
<div class="action-contents">
To finishupgrade the environment
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/environment/">environment</a> resource
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
To remove the environment
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/environment/">environment</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
rollback
<span class="headerright">POST:  <code>${action.rollback}</code></span>
</span>
<div class="action-contents">
To rollback the environment
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/environment/">environment</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
upgrade
<span class="headerright">POST:  <code>${action.upgrade}</code></span>
</span>
<div class="action-contents">
To upgrade the environment
<br>

<span class="input">
<strong>Input:</strong>​​​ environmentUpgrade


Field | Type | Required | Default | Notes
---|---|---|---|---
dockerCompose | string | No | <no value> | The docker-compose.yml file for the stack
environment | map[string] | No | <no value> | 
externalId | string | No | <no value> | 
rancherCompose | string | No | <no value> | The rancher-compose.yml file for the stack


<br>
{% highlight json %}{

	"dockerCompose": "string",

	"environment": "map[string]",

	"externalId": "string",

	"rancherCompose": "string"

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/environment/">environment</a> resource
</span>
</div>
</span>
</span>
</span>

