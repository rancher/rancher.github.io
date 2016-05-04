---
title: API
layout: rancher-default
version: latest
lang: zh
---

## dockerBuild



### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
context | string | Optional | - | - | 
dockerfile | string | Optional | - | - | 
forcerm | boolean | Optional | - | - | 
nocache | boolean | Optional | - | - | 
remote | string | Optional | - | - | 
rm | boolean | Optional | - | - | 


Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.


### Operations
{::options parse_block_html="true" /}



<div class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/dockerBuild</code></span></span>
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
</div>










