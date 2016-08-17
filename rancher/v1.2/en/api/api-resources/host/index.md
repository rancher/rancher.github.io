---
title: Rancher API - host
layout: rancher-api-default
version: v1.2
lang: en
---

## Host

Hosts are the most basic unit of resource within Rancher and is represented as any Linux server, virtual or physical, with the following minimum requirements. <br> <br> * Any modern Linux distribution that supports Docker 1.10.3+. <br> * Must be able to communicate with the Rancher server via http or https through the pre-configured port (Default is 8080). <br> * Must be routable to any other hosts belonging to the same environment to leverage Rancher's cross-host networking for Docker containers.<br> <br> Rancher also supports Docker Machine and allows you to add your host via any of its supported drivers.

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
agentState | string | - | - | - | 
computeTotal | int | - | - | - | 
description | string | Optional | Yes | - | 
hostname | string | - | - | - | 
id | int | - | - | - | The unique identifier for the host
info | json | - | - | - | 
labels | map[string] | - | Yes | - | A map of key value pairs to be used as labels for the host
name | string | Optional | Yes | - | 
physicalHostId | [physicalHost]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/physicalHost/) | - | - | - | 
publicEndpoints | array[[publicEndpoint]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/publicEndpoint/)] | - | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/hosts/${ID}</code></span></span>
<div class="action-contents">
{% highlight json %}

{% endhighlight %}
</div>
</div><a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v1/hosts/${ID}</code></span></span>
<div class="action-contents">
{% highlight json %}
{
	"description": "string",
	"labels": {
		"key1": "value1",
		"key2": "value2",
		"keyN": "valueN"
	},
	"name": "string"
}
{% endhighlight %}
</div>
</div>

### Actions
<div class="action">
<span class="header">
activate
<span class="headerright">POST:  <code>/v1/hosts/${ID}?action=activate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/host/">host</a> resource</span>
</div></div>

<div class="action">
<span class="header">
deactivate
<span class="headerright">POST:  <code>/v1/hosts/${ID}?action=deactivate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/host/">host</a> resource</span>
</div></div>

<div class="action">
<span class="header">
dockersocket
<span class="headerright">POST:  <code>/v1/hosts/${ID}?action=dockersocket</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/hostAccess/">hostAccess</a> resource</span>
</div></div>


