---
title: Rancher API - environment
layout: rancher-api-v1-default-v1.0
version: v1.0
lang: en
apiVersion: v1
---

## Environment

An "environment" in the API is referred to as a stack in the UI and the Rancher documentation. In the API documentation, we'll use the UI terminology. A Rancher stack mirrors the same concept as a docker-compose project.  It represents a group of services that make up a typical application or workload.

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
dockerCompose | string | Optional | - | - | 
environment | map[string] | Optional | - | - | 
externalId | string | Optional | Yes | - | 
name | string | Yes | Yes | - | 
outputs | map[string] | Optional | Yes | - | 
previousEnvironment | map[string] | Optional | Yes | - | 
previousExternalId | string | Optional | Yes | - | 
rancherCompose | string | Optional | - | - | 
startOnCreate | boolean | Optional | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
healthState | string  | 
id | int  | The unique identifier for the environment


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/environments</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"description": "string",
	"dockerCompose": "string",
	"environment": {
		"key": "value-pairs"
	},
	"externalId": "string",
	"name": "string",
	"outputs": {
		"key": "value-pairs"
	},
	"previousEnvironment": {
		"key": "value-pairs"
	},
	"previousExternalId": "string",
	"rancherCompose": "string",
	"startOnCreate": false
}' 'http://${RANCHER_URL}:8080/v1/environments'
{% endhighlight %}
</div></div>
<a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/environments/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X DELETE \
'http://${RANCHER_URL}:8080/v1/environments/${ID}'
{% endhighlight %}
</div></div>
<a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v1/environments/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Content-Type: application/json' \
-d '{
	"description": "string",
	"externalId": "string",
	"name": "string",
	"outputs": {
		"key": "value-pairs"
	},
	"previousEnvironment": {
		"key": "value-pairs"
	},
	"previousExternalId": "string"
}' 'http://${RANCHER_URL}:8080/v1/environments/${ID}'
{% endhighlight %}
</div></div>



### Actions

<div class="action" id="activateservices">
<span class="header">
activateservices
<span class="headerright">POST:  <code>/v1/environments/${ID}?action=activateservices</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/environments/${ID}?action=activateservices'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/environment/">environment</a> resource</span>
</div></div>

<div class="action" id="cancelrollback">
<span class="header">
cancelrollback
<span class="headerright">POST:  <code>/v1/environments/${ID}?action=cancelrollback</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/environments/${ID}?action=cancelrollback'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/environment/">environment</a> resource</span>
</div></div>

<div class="action" id="cancelupgrade">
<span class="header">
cancelupgrade
<span class="headerright">POST:  <code>/v1/environments/${ID}?action=cancelupgrade</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/environments/${ID}?action=cancelupgrade'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/environment/">environment</a> resource</span>
</div></div>

<div class="action" id="deactivateservices">
<span class="header">
deactivateservices
<span class="headerright">POST:  <code>/v1/environments/${ID}?action=deactivateservices</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/environments/${ID}?action=deactivateservices'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/environment/">environment</a> resource</span>
</div></div>

<div class="action" id="exportconfig">
<span class="header">
exportconfig
<span class="headerright">POST:  <code>/v1/environments/${ID}?action=exportconfig</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/composeConfigInput/">ComposeConfigInput</a></span>

Field | Type | Required | Default | Notes
---|---|---|---|---
serviceIds | array[[service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/)] | No |  | <br>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"serviceIds": "array[reference[service]]"
}' 'http://${RANCHER_URL}:8080/v1/environments/${ID}?action=exportconfig'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/composeConfig/">composeConfig</a> resource</span>
</div></div>

<div class="action" id="finishupgrade">
<span class="header">
finishupgrade
<span class="headerright">POST:  <code>/v1/environments/${ID}?action=finishupgrade</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/environments/${ID}?action=finishupgrade'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/environment/">environment</a> resource</span>
</div></div>

<div class="action" id="rollback">
<span class="header">
rollback
<span class="headerright">POST:  <code>/v1/environments/${ID}?action=rollback</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/environments/${ID}?action=rollback'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/environment/">environment</a> resource</span>
</div></div>


