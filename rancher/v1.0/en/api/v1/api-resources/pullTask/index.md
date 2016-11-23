---
title: Rancher API - pullTask
layout: rancher-api-v1-default-v1.0
version: v1.0
lang: en
apiVersion: v1
---

## PullTask



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
image | string | Yes | - | - | 
labels | map[string] | Optional | - | - | A map of key value pairs to be used as labels for the pullTask
mode | enum | Yes | - | all | The options are `all`, `cached`.
name | string | Optional | Yes | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
id | int  | The unique identifier for the pullTask
status | map[string]  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/pullTasks</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"description": "string",
	"image": "string",
	"labels": {
		"key": "value-pairs"
	},
	"mode": "all",
	"name": "string"
}' 'http://${RANCHER_URL}:8080/v1/pullTasks'
{% endhighlight %}
</div></div>



