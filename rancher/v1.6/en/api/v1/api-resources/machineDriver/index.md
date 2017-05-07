---
title: Rancher API - machineDriver
layout: rancher-api-v1-default-v1.6
version: v1.6
lang: en
apiVersion: v1
#redirect_from:
#  - /rancher/v1.6/zh/api/v1/api-resources/machineDriver/
---

## MachineDriver



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
activateOnCreate | boolean | Optional | - | - | 
builtin | boolean | Optional | - | - | 
checksum | string | Optional | Yes | - | 
description | string | Optional | Yes | - | 
externalId | string | Optional | Yes | - | 
uiUrl | string | Optional | Yes | - | 
url | string | Yes | Yes | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
data | map[json]  | 
defaultActive | boolean  | 
id | int  | The unique identifier for the machineDriver
name | string  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/machineDrivers</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"activateOnCreate": false,
	"builtin": false,
	"checksum": "string",
	"description": "string",
	"externalId": "string",
	"uiUrl": "string",
	"url": "string"
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/machineDrivers'
{% endhighlight %}
</div></div>
<a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/projects/${PROJECT_ID}/machineDrivers/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X DELETE \
'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/machineDrivers/${ID}'
{% endhighlight %}
</div></div>
<a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v1/projects/${PROJECT_ID}/machineDrivers/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Content-Type: application/json' \
-d '{
	"checksum": "string",
	"description": "string",
	"externalId": "string",
	"uiUrl": "string",
	"url": "string"
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/machineDrivers/${ID}'
{% endhighlight %}
</div></div>



### Actions

<div class="action" id="activate">
<span class="header">
activate
<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/machineDrivers/${ID}?action=activate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/machineDrivers/${ID}?action=activate'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/machineDriver/">machineDriver</a> resource</span>
</div></div>

<div class="action" id="deactivate">
<span class="header">
deactivate
<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/machineDrivers/${ID}?action=deactivate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/machineDrivers/${ID}?action=deactivate'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/machineDriver/">machineDriver</a> resource</span>
</div></div>

<div class="action" id="reactivate">
<span class="header">
reactivate
<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/machineDrivers/${ID}?action=reactivate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/machineDrivers/${ID}?action=reactivate'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/machineDriver/">machineDriver</a> resource</span>
</div></div>


