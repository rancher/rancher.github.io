---
title: Rancher API - volumeTemplate
layout: rancher-api-v2-beta-default-v1.4
version: v1.4
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.4/zh/api/v2-beta/api-resources/volumeTemplate/
---

## VolumeTemplate



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
driver | string | Optional | - | - | 
driverOpts | map[string] | Optional | - | - | 
external | boolean | Optional | - | - | 
name | string | Yes | Yes | - | 
perContainer | boolean | Optional | - | - | 
stackId | [stack]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/stack/) | Optional | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
id | int  | The unique identifier for the volumeTemplate


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/volumeTemplates</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"description": "string",
	"driver": "string",
	"driverOpts": {
		"key": "value-pairs"
	},
	"external": false,
	"name": "string",
	"perContainer": false,
	"stackId": "reference[stack]"
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/volumeTemplates'
{% endhighlight %}
</div></div>



