---
title: API
layout: rancher-default
---

## loadBalancerConfig

Collection Test Description

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
haproxyConfig | [haproxyConfig]({{site.baseurl}}/rancher/api/api-resources/haproxyConfig/) | Optional | Yes | - | 
lbCookieStickinessPolicy | [loadBalancerCookieStickinessPolicy]({{site.baseurl}}/rancher/api/api-resources/loadBalancerCookieStickinessPolicy/) | Optional | Yes | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.
​

### Operations



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/loadBalancerConfig</code></span>
</span>
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
</span>













<span class="action">
<span class="header">
Update
<span class="headerright">PUT:  <code>${links.self}</code></span>
</span>
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
</span>







<span class="action">
<span class="header">
Delete
<span class="headerright">DELETE:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
 
{% endhighlight %}
</div>
</span>






​