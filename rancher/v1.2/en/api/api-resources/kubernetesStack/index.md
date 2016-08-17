---
title: Rancher API - kubernetesStack
layout: rancher-api-default
version: v1.2
lang: en
---

## KubernetesStack



### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
environment | map[string] | Optional | - | - | 
externalId | string | Optional | Yes | - | 
healthState | string | - | - | - | 
id | int | - | - | - | The unique identifier for the kubernetesStack
name | string | Yes | - | - | 
namespace | string | Yes | - | - | 
previousEnvironment | map[string] | Optional | Yes | - | 
previousExternalId | string | Optional | Yes | - | 
templates | map[string] | Yes | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/kubernetesStacks</code></span></span>
<div class="action-contents">
{% highlight json %}
{
	"description": "string",
	"environment": {
		"key1": "value1",
		"key2": "value2",
		"keyN": "valueN"
	},
	"externalId": "string",
	"name": "string",
	"namespace": "string",
	"previousEnvironment": {
		"key1": "value1",
		"key2": "value2",
		"keyN": "valueN"
	},
	"previousExternalId": "string",
	"templates": {
		"key1": "value1",
		"key2": "value2",
		"keyN": "valueN"
	}
}
{% endhighlight %}
</div>
</div><a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/kubernetesStacks/${ID}</code></span></span>
<div class="action-contents">
{% highlight json %}

{% endhighlight %}
</div>
</div><a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v1/kubernetesStacks/${ID}</code></span></span>
<div class="action-contents">
{% highlight json %}
{
	"description": "string",
	"externalId": "string",
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
cancelrollback
<span class="headerright">POST:  <code>/v1/kubernetesStacks/${ID}?action=cancelrollback</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/environment/">environment</a> resource</span>
</div></div>

<div class="action">
<span class="header">
cancelupgrade
<span class="headerright">POST:  <code>/v1/kubernetesStacks/${ID}?action=cancelupgrade</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/environment/">environment</a> resource</span>
</div></div>

<div class="action">
<span class="header">
error
<span class="headerright">POST:  <code>/v1/kubernetesStacks/${ID}?action=error</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/environment/">environment</a> resource</span>
</div></div>

<div class="action">
<span class="header">
finishupgrade
<span class="headerright">POST:  <code>/v1/kubernetesStacks/${ID}?action=finishupgrade</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/environment/">environment</a> resource</span>
</div></div>

<div class="action">
<span class="header">
rollback
<span class="headerright">POST:  <code>/v1/kubernetesStacks/${ID}?action=rollback</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/environment/">environment</a> resource</span>
</div></div>

<div class="action">
<span class="header">
upgrade
<span class="headerright">POST:  <code>/v1/kubernetesStacks/${ID}?action=upgrade</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> kubernetesStackUpgrade</span>

<br>{% highlight json %}{
	"environment": {
		"key1": "value1",
		"key2": "value2",
		"keyN": "valueN"
	},
	"externalId": "string",
	"templates": {
		"key1": "value1",
		"key2": "value2",
		"keyN": "valueN"
	}
}{% endhighlight %}<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/kubernetesStack/">kubernetesStack</a> resource</span>
</div></div>


