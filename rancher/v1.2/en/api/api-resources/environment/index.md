---
title: Rancher API - environment
layout: rancher-api-default
version: latest
lang: en
---

## Environment

An "environment" in the API is referred to as a stack in the UI and the Rancher documentation. In the API documentation, we'll use the UI terminology. A Rancher stack mirrors the same concept as a docker-compose project.  It represents a group of services that make up a typical application or workload.

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
dockerCompose | string | Optional | - | - | 
environment | map[string] | Optional | - | - | 
externalId | string | Optional | Yes | - | 
healthState | string | - | - | - | 
id | int | - | - | - | The unique identifier for the environment
name | string | Yes | Yes | - | 
outputs | map[string] | Optional | Yes | - | 
previousEnvironment | map[string] | Optional | Yes | - | 
previousExternalId | string | Optional | Yes | - | 
rancherCompose | string | Optional | - | - | 
startOnCreate | boolean | Optional | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/environments</code></span></span>
<div class="action-contents">
{% highlight json %}
{
	"description": "string",
	"dockerCompose": "string",
	"environment": {
		"key1": "value1",
		"key2": "value2",
		"keyN": "valueN"
	},
	"externalId": "string",
	"name": "string",
	"outputs": {
		"key1": "value1",
		"key2": "value2",
		"keyN": "valueN"
	},
	"previousEnvironment": {
		"key1": "value1",
		"key2": "value2",
		"keyN": "valueN"
	},
	"previousExternalId": "string",
	"rancherCompose": "string",
	"startOnCreate": true
}
{% endhighlight %}
</div>
</div><a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/environments/${ID}</code></span></span>
<div class="action-contents">
{% highlight json %}

{% endhighlight %}
</div>
</div><a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v1/environments/${ID}</code></span></span>
<div class="action-contents">
{% highlight json %}
{
	"description": "string",
	"externalId": "string",
	"name": "string",
	"outputs": {
		"key1": "value1",
		"key2": "value2",
		"keyN": "valueN"
	},
	"previousEnvironment": {
		"key1": "value1",
		"key2": "value2",
		"keyN": "valueN"
	},
	"previousExternalId": "string"
}
{% endhighlight %}
</div>
</div>

### Actions
<div class="action">
<span class="header">
activateservices
<span class="headerright">POST:  <code>/v1/environments/${ID}?action=activateservices</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/environment/">environment</a> resource</span>
</div></div>

<div class="action">
<span class="header">
cancelrollback
<span class="headerright">POST:  <code>/v1/environments/${ID}?action=cancelrollback</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/environment/">environment</a> resource</span>
</div></div>

<div class="action">
<span class="header">
cancelupgrade
<span class="headerright">POST:  <code>/v1/environments/${ID}?action=cancelupgrade</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/environment/">environment</a> resource</span>
</div></div>

<div class="action">
<span class="header">
deactivateservices
<span class="headerright">POST:  <code>/v1/environments/${ID}?action=deactivateservices</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/environment/">environment</a> resource</span>
</div></div>

<div class="action">
<span class="header">
exportconfig
<span class="headerright">POST:  <code>/v1/environments/${ID}?action=exportconfig</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> composeConfigInput</span>

<br>{% highlight json %}{
	"serviceIds": "array[reference[service]]"
}{% endhighlight %}<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/composeConfig/">composeConfig</a> resource</span>
</div></div>

<div class="action">
<span class="header">
finishupgrade
<span class="headerright">POST:  <code>/v1/environments/${ID}?action=finishupgrade</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/environment/">environment</a> resource</span>
</div></div>

<div class="action">
<span class="header">
rollback
<span class="headerright">POST:  <code>/v1/environments/${ID}?action=rollback</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/environment/">environment</a> resource</span>
</div></div>


