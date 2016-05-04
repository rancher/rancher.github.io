---
title: API
layout: rancher-default-v1.0
version: v1.0
lang: zh
---

## genericConfig



### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
ipAddress | string | Optional | Yes | - | 
sshKey | string | Optional | Yes | - | 
sshPort | string | Optional | Yes | - | The port to ssh into the host
sshUser | string | Optional | Yes | - | The ssh username to use to ssh into the host


Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.


### Operations
{::options parse_block_html="true" /}



<div class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/genericConfig</code></span></span>
<div class="action-contents">
{% highlight json %} 
{

	"ipAddress": "string",

	"sshKey": "string",

	"sshPort": "string",

	"sshUser": "string"

} 
{% endhighlight %}
</div>
</div>










