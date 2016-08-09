---
title: Rancher API - registrationToken
layout: rancher-api-default
version: latest
lang: en
---

## RegistrationToken



### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
command | string | - | - | - | 
description | string | Optional | Yes | - | 
id | int | - | - | - | The unique identifier for the registrationToken
image | string | - | - | - | 
name | string | Optional | Yes | - | 
registrationUrl | string | - | - | - | 
token | string | - | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/registrationToken</code></span></span>
<div class="action-contents">
{% highlight json %}
{
	"description": "string",
	"name": "string"
}
{% endhighlight %}
</div>
</div>





