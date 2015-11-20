---
title: API
layout: rancher-default
---

## dockerBuild

Collection Test Description

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
context | string | Optional | - | - | 
dockerfile | string | Optional | - | - | 
forcerm | boolean | Optional | - | - | 
nocache | boolean | Optional | - | - | 
remote | string | Optional | - | - | 
rm | boolean | Optional | - | - | 





### Operations



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