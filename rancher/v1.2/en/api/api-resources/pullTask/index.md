---
title: Rancher API - pullTask
layout: rancher-api-default
version: v1.2
lang: en
---

## PullTask



### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
id | int | - | - | - | The unique identifier for the pullTask
image | string | Yes | - | - | 
labels | map[string] | Optional | - | - | A map of key value pairs to be used as labels for the pullTask
mode | enum | Yes | - | all | 
name | string | Optional | Yes | - | 
status | map[string] | - | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/pullTasks</code></span></span>
<div class="action-contents"><figure class="highlight"><pre><code>
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{% highlight json %}
{
	"description": "string",
	"image": "string",
	"labels": {
		"key1": "value1",
		"key2": "value2",
		"keyN": "valueN"
	},
	"mode": "all",
	"name": "string"
}
{% endhighlight %}' \
'http://RANCHER_URL:8080/v1/pullTasks'
</code></pre></figure>
</div></div>



