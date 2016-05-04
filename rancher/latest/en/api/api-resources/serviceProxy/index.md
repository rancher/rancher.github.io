---
title: API
layout: rancher-default
version: latest
lang: en
---

## serviceProxy



### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
port | int | Optional | - | 80 | 
scheme | enum | Optional | - | http | 
service | string | Yes | - | - | 
token | string | - | - | - | 
url | string | - | - | - | 


Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.


### Operations
{::options parse_block_html="true" /}



<div class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/serviceProxy</code></span></span>
<div class="action-contents">
{% highlight json %} 
{

	"port": 80,

	"scheme": "http",

	"service": "string"

} 
{% endhighlight %}
</div>
</div>










