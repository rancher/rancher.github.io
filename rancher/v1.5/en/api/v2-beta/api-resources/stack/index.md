---
title: Rancher API - stack
layout: rancher-api-v2-beta-default-v1.5
version: v1.5
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.5/zh/api/v2-beta/api-resources/stack/
---

## Stack



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
binding | [binding]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/binding/) | Optional | Yes | - | 
description | string | Optional | Yes | - | 
dockerCompose | string | Optional | - | - | 
environment | map[string] | Optional | - | - | 
externalId | string | Optional | Yes | - | 
group | string | Optional | Yes | - | 
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
id | int  | The unique identifier for the stack
serviceIds | array[[service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/)]  | 
system | boolean  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/stacks</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"binding": {
		"services": "map[serviceBinding]"
	},
	"description": "string",
	"dockerCompose": "string",
	"environment": {
		"key": "value-pairs"
	},
	"externalId": "string",
	"group": "string",
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
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/stacks'
{% endhighlight %}
</div></div>
<a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v2-beta/projects/${PROJECT_ID}/stacks/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X DELETE \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/stacks/${ID}'
{% endhighlight %}
</div></div>
<a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v2-beta/projects/${PROJECT_ID}/stacks/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Content-Type: application/json' \
-d '{
	"binding": {
		"services": "map[serviceBinding]"
	},
	"description": "string",
	"externalId": "string",
	"group": "string",
	"name": "string",
	"outputs": {
		"key": "value-pairs"
	},
	"previousEnvironment": {
		"key": "value-pairs"
	},
	"previousExternalId": "string"
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/stacks/${ID}'
{% endhighlight %}
</div></div>



### Actions

<div class="action" id="activateservices">
<span class="header">
activateservices
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/stacks/${ID}?action=activateservices</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/stacks/${ID}?action=activateservices'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/stack/">stack</a> resource</span>
</div></div>

<div class="action" id="addoutputs">
<span class="header">
addoutputs
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/stacks/${ID}?action=addoutputs</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/addOutputsInput/">AddOutputsInput</a></span>

Field | Type | Required | Default | Notes
---|---|---|---|---
outputs | map[string] | Yes |  | 


<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"outputs": {
		"key": "value-pairs"
	}
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/stacks/${ID}?action=addoutputs'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/stack/">stack</a> resource</span>
</div></div>

<div class="action" id="cancelupgrade">
<span class="header">
cancelupgrade
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/stacks/${ID}?action=cancelupgrade</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/stacks/${ID}?action=cancelupgrade'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/stack/">stack</a> resource</span>
</div></div>

<div class="action" id="deactivateservices">
<span class="header">
deactivateservices
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/stacks/${ID}?action=deactivateservices</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/stacks/${ID}?action=deactivateservices'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/stack/">stack</a> resource</span>
</div></div>

<div class="action" id="error">
<span class="header">
error
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/stacks/${ID}?action=error</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/stacks/${ID}?action=error'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/stack/">stack</a> resource</span>
</div></div>

<div class="action" id="exportconfig">
<span class="header">
exportconfig
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/stacks/${ID}?action=exportconfig</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/composeConfigInput/">ComposeConfigInput</a></span>

Field | Type | Required | Default | Notes
---|---|---|---|---
serviceIds | array[[service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/)] | No |  | 


<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"serviceIds": "array[reference[service]]"
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/stacks/${ID}?action=exportconfig'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/composeConfig/">composeConfig</a> resource</span>
</div></div>

<div class="action" id="finishupgrade">
<span class="header">
finishupgrade
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/stacks/${ID}?action=finishupgrade</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/stacks/${ID}?action=finishupgrade'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/stack/">stack</a> resource</span>
</div></div>

<div class="action" id="rollback">
<span class="header">
rollback
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/stacks/${ID}?action=rollback</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/stacks/${ID}?action=rollback'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/stack/">stack</a> resource</span>
</div></div>

<div class="action" id="upgrade">
<span class="header">
upgrade
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/stacks/${ID}?action=upgrade</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/stackUpgrade/">StackUpgrade</a></span>

Field | Type | Required | Default | Notes
---|---|---|---|---
dockerCompose |  | No |  | 
environment | map[string] | No |  | 
externalId |  | No |  | 
rancherCompose |  | No |  | 


<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"dockerCompose": "string",
	"environment": {
		"key": "value-pairs"
	},
	"externalId": "string",
	"rancherCompose": "string"
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/stacks/${ID}?action=upgrade'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/stack/">stack</a> resource</span>
</div></div>


