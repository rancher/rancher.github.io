---
title: API
layout: rancher-default
---

## localAuthConfig

Collection Test Description
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
accessMode | string | Optional | - | unrestricted | The accessMode for the localAuthConfig
enabled | boolean | Optional | - | - | The enabled for the localAuthConfig
password | [password]({{site.baseurl}}/rancher/api/password/) | Yes | - | - | The password for the localAuthConfig
username | string | Yes | - | - | azureConfig




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
name | string | Optional | - | admin | The name for the localAuthConfig




### Actions



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"accessMode": "unrestricted",

	"enabled": true,

	"name": "admin",

	"password": {

		"accountId": "reference[account]",

		"created": "date",

		"data": "map[json]",

		"description": "string",

		"id": 0,

		"kind": "string",

		"name": "string",

		"publicValue": "string",

		"removeTime": "date",

		"removed": "date",

		"secretValue": "string",

		"state": "enum",

		"transitioning": "enum",

		"transitioningMessage": "string",

		"transitioningProgress": 0,

		"uuid": "string"

	},

	"username": "string"

} 
{% endhighlight %}
</div>
</span>













​