---
title: API
layout: rancher-default
---

## serviceProxy



​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
port | int | Optional | - | 80 | 
scheme | enum | Optional | - | http | 
service | string | Yes | - | - | 
token | string | - | - | - | 
url | string | - | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.
​

### Operations



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/serviceProxy</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"port": 80,

	"scheme": "http",

	"service": "string"

} 
{% endhighlight %}
</div>
</span>












​