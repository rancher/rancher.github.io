---
title: API
layout: rancher-default
version: latest
lang: en
---

## environmentUpgrade



### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
dockerCompose | string | Optional | - | - | The docker-compose.yml file for the stack
environment | map[string] | Optional | - | - | 
externalId | string | Optional | - | - | 
rancherCompose | string | Optional | - | - | The rancher-compose.yml file for the stack


Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.


### Operations
{::options parse_block_html="true" /}



<div class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/environmentUpgrade</code></span></span>
<div class="action-contents">
{% highlight json %} 
{

	"dockerCompose": "string",

	"environment": {

		"key1": "value1",

		"key2": "value2",

		"keyN": "valueN"

	},

	"externalId": "string",

	"rancherCompose": "string"

} 
{% endhighlight %}
</div>
</div>










