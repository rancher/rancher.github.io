---
title: API
layout: rancher-default
version: latest
lang: en
---

## subscribe



### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
eventNames | array[string] | Optional | - | - | 


Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.


### Operations
{::options parse_block_html="true" /}



<div class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/subscribe</code></span></span>
<div class="action-contents">
{% highlight json %} 
{

	"eventNames": [

		"string1",

		"string2",

		"...stringN"

	]

} 
{% endhighlight %}
</div>
</div>










