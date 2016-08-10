---
title: API
layout: rancher-default
version: latest
lang: zh
---

## loadBalancerConfig



### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
haproxyConfig | [haproxyConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/haproxyConfig/) | Optional | Yes | - | 
lbCookieStickinessPolicy | [loadBalancerCookieStickinessPolicy]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/loadBalancerCookieStickinessPolicy/) | Optional | Yes | - | 


Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.


### Operations
{::options parse_block_html="true" /}



<div class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/loadBalancerConfig</code></span></span>
<div class="action-contents">
{% highlight json %} 
{

	"haproxyConfig": {

		"defaults": "string",

		"global": "string"

	},

	"lbCookieStickinessPolicy": {

		"cookie": "string",

		"domain": "string",

		"indirect": true,

		"mode": "enum",

		"name": "string",

		"nocache": true,

		"postonly": true

	}

} 
{% endhighlight %}
</div>
</div>













<div class="action">
<span class="header">
Update
<span class="headerright">PUT:  <code>${links.self}</code></span></span>
<div class="action-contents">
{% highlight json %} 
{

	"haproxyConfig": {

		"defaults": "string",

		"global": "string"

	},

	"lbCookieStickinessPolicy": {

		"cookie": "string",

		"domain": "string",

		"indirect": true,

		"mode": "enum",

		"name": "string",

		"nocache": true,

		"postonly": true

	}

} 
{% endhighlight %}
</div>
</div>







<div class="action">
<span class="header">
Delete
<span class="headerright">DELETE:  <code>${links.self}</code></span></span>
<div class="action-contents">
{% highlight json %} 
 
{% endhighlight %}
</div>
</div>




