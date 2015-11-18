---
title: API
layout: rancher-default
---

## environmentUpgrade

Collection Test Description
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
dockerCompose | string | Optional | - | - | The docker-compose.yml file for the stack
environment | map[string] | Optional | - | - | The environment for the environmentUpgrade
externalId | string | Optional | - | - | The externalId for the environmentUpgrade
rancherCompose | string | Optional | - | - | The rancher-compose.yml file for the stack






### Actions



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"dockerCompose": "string",

	"environment": "map[string]",

	"externalId": "string",

	"rancherCompose": "string"

} 
{% endhighlight %}
</div>
</span>













​