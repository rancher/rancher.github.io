---
title: API
layout: rancher-default
version: latest
lang: en
---

## googleConfig



### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
address | string | Optional | Yes | - | 
diskSize | string | Optional | Yes | - | 
diskType | string | Optional | Yes | - | 
machineImage | string | Optional | Yes | - | 
machineType | string | Optional | Yes | - | 
preemptible | boolean | Optional | Yes | - | 
project | string | Optional | Yes | - | 
scopes | string | Optional | Yes | - | 
tags | string | Optional | Yes | - | 
useExisting | boolean | Optional | Yes | - | 
useInternalIp | boolean | Optional | Yes | - | 
username | string | Optional | Yes | - | 
zone | string | Optional | Yes | - | 


Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.


### Operations
{::options parse_block_html="true" /}



<div class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/googleConfig</code></span></span>
<div class="action-contents">
{% highlight json %} 
{

	"address": "string",

	"diskSize": "string",

	"diskType": "string",

	"machineImage": "string",

	"machineType": "string",

	"preemptible": true,

	"project": "string",

	"scopes": "string",

	"tags": "string",

	"useExisting": true,

	"useInternalIp": true,

	"username": "string",

	"zone": "string"

} 
{% endhighlight %}
</div>
</div>










