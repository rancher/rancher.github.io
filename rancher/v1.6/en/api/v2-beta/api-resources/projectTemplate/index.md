---
title: Rancher API - projectTemplate
layout: rancher-api-v2-beta-default-v1.6
version: v1.6
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.6/zh/api/v2-beta/api-resources/projectTemplate/
---

## ProjectTemplate



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
externalId | string | Optional | Yes | - | 
isPublic | boolean | Optional | Yes | - | 
name | string | Optional | Yes | - | 
stacks | array[[catalogTemplate]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/catalogTemplate/)] | Optional | Yes | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
data | map[json]  | 
id | int  | The unique identifier for the projectTemplate


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/projectTemplates</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"description": "string",
	"externalId": "string",
	"isPublic": false,
	"name": "string",
	"stacks": "array[catalogTemplate]"
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/projectTemplates'
{% endhighlight %}
</div></div>
<a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v2-beta/projects/${PROJECT_ID}/projectTemplates/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X DELETE \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/projectTemplates/${ID}'
{% endhighlight %}
</div></div>
<a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v2-beta/projects/${PROJECT_ID}/projectTemplates/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Content-Type: application/json' \
-d '{
	"description": "string",
	"externalId": "string",
	"isPublic": false,
	"name": "string",
	"stacks": "array[catalogTemplate]"
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/projectTemplates/${ID}'
{% endhighlight %}
</div></div>



