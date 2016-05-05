---
title: API
layout: rancher-default-v1.0
version: v1.0
lang: en
---

## hypervConfig



### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
boot2dockerUrl | string | Optional | Yes | - | 
cpuCount | string | Optional | Yes | - | 
diskSize | string | Optional | Yes | - | 
memory | string | Optional | Yes | - | 
virtualSwitch | string | Optional | Yes | - | 


Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.


### Operations
{::options parse_block_html="true" /}



<div class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/hypervConfig</code></span></span>
<div class="action-contents">
{% highlight json %} 
{

	"boot2dockerUrl": "string",

	"cpuCount": "string",

	"diskSize": "string",

	"memory": "string",

	"virtualSwitch": "string"

} 
{% endhighlight %}
</div>
</div>










