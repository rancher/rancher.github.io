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

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.
​

### Operations



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/dockerBuild</code></span>
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