---
title: API
layout: rancher-default
---

## certificate

A certificate is used to add in SSL termination to load balancers.
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
CN | string | - | - | - | The common name
algorithm | string | - | - | - | The algorithm for the certificate
cert | string | Yes | Yes | - | The certificate
certChain | string | Optional | Yes | - | The certChain for the certificate
certFingerprint | string | - | - | - | The certFingerprint for the certificate
expiresAt | string | - | - | - | The expiresAt for the certificate
issuedAt | string | - | - | - | The issuedAt for the certificate
issuer | string | - | - | - | The issuer for the certificate
key | string | Yes | - | - | The key for the certificate
keySize | int | - | - | - | The keySize for the certificate
serialNumber | string | - | - | - | The serialNumber for the certificate
subjectAlternativeNames | array[string] | - | - | - | The subjectAlternativeNames for the certificate
version | string | - | - | - | The version for the certificate




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the certificate was created.
description | string | Optional | Yes | - | The description for the certificate
id | int | - | - | - | The unique identifier for the certificate
kind | string | - | - | - | The kind for the certificate
name | string | Yes | Yes | - | The name for the certificate
removed | date | - | - | - | The date of when the certificate was removed
state | enum | - | - | - | The current state of the certificate. The options are [activating, active, removed, removing, requested].
transitioning | enum | - | - | - | Whether or not the certificate is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the certificate
uuid | string | - | - | - | The universally unique identifier for the certificate. This will always be unique across Rancher installations.




### Actions



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>${links.self}</code></span>
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

<span class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${action.remove}</code></span>
</span>
<div class="action-contents">
To remove the certificate
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/certificate/">certificate</a> resource
</span>
</div>
</span>
</span>
</span>

