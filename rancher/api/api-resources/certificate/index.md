---
title: API
layout: rancher-default
---

## certificate

A certificate is used to add in SSL termination to load balancers.

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
CN | string | - | - | - | The common name
algorithm | string | - | - | - | 
cert | string | Yes | Yes | - | 
certChain | string | Optional | Yes | - | 
certFingerprint | string | - | - | - | 
description | string | Optional | Yes | - | 
expiresAt | string | - | - | - | The date that the certificate expires at
id | int | - | - | - | The unique identifier for the certificate
issuedAt | string | - | - | - | The date that the certificate was issued
issuer | string | - | - | - | The issuer of the certificate
key | string | Yes | Yes | - | 
keySize | int | - | - | - | 
name | string | Yes | Yes | - | 
serialNumber | string | - | - | - | 
subjectAlternativeNames | array[string] | - | - | - | 
version | string | - | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.
​

### Operations



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/certificate</code></span>
</span>
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
</span>













<span class="action">
<span class="header">
Update
<span class="headerright">PUT:  <code>${links.self}</code></span>
</span>
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
### Actions

<span class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${actions.remove}</code></span>
</span>
<div class="action-contents">
To remove the certificate
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/certificate/">certificate</a> resource
</span>
</div>
</span>
</span>
</span>

