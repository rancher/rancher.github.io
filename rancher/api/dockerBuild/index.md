---
title: API
layout: rancher-default
---

## dockerBuild

Collection Test Description
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
context | string | Optional | - | - | The context for the dockerBuild
dockerfile | string | Optional | - | - | The dockerfile for the dockerBuild
forcerm | boolean | Optional | - | - | The forcerm for the dockerBuild
nocache | boolean | Optional | - | - | The nocache for the dockerBuild
remote | string | Optional | - | - | The remote for the dockerBuild
rm | boolean | Optional | - | - | The rm for the dockerBuild






### Actions



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"context": "string",

	"dockerfile": "string",

	"forcerm": true,

	"nocache": true,

	"remote": "string",

	"rm": true

} 
{% endhighlight %}
</div>
</span>













​