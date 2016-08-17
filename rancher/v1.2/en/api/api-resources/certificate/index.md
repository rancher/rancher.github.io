---
title: Rancher API - certificate
layout: rancher-api-default
version: v1.2
lang: en
---

## Certificate

A certificate is used to add in SSL termination to load balancers.

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
CN | string | - | - | - | 
algorithm | string | - | - | - | 
cert | string | Yes | Yes | - | 
certChain | string | Optional | Yes | - | 
certFingerprint | string | - | - | - | 
description | string | Optional | Yes | - | 
expiresAt | string | - | - | - | 
id | int | - | - | - | The unique identifier for the certificate
issuedAt | string | - | - | - | 
issuer | string | - | - | - | 
key | string | Yes | Yes | - | 
keySize | int | - | - | - | 
name | string | Yes | Yes | - | 
serialNumber | string | - | - | - | 
subjectAlternativeNames | array[string] | - | - | - | 
version | string | - | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/certificates</code></span></span>
<div class="action-contents">
{% highlight json %}
{
	"cert": "string",
	"certChain": "string",
	"description": "string",
	"key": "string",
	"name": "string"
}
{% endhighlight %}
</div>
</div><a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/certificates/${ID}</code></span></span>
<div class="action-contents">
{% highlight json %}

{% endhighlight %}
</div>
</div><a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v1/certificates/${ID}</code></span></span>
<div class="action-contents">
{% highlight json %}
{
	"cert": "string",
	"certChain": "string",
	"description": "string",
	"key": "string",
	"name": "string"
}
{% endhighlight %}
</div>
</div>

