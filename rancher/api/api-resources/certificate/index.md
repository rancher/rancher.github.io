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
id | int | - | - | - | The unique identifier for the certificate
kind | string | - | - | - | 
name | string | Yes | Yes | - | 
state | enum | - | - | - | The current state of the certificate. The options are [activating, active, removed, removing, requested].
CN | string | - | - | - | The common name
algorithm | string | - | - | - | 
cert | string | Yes | Yes | - | 
certChain | string | Optional | Yes | - | 
certFingerprint | string | - | - | - | 
expiresAt | string | - | - | - | The date that the certificate expires at
issuedAt | string | - | - | - | The date that the certificate was issued
issuer | string | - | - | - | The issuer of the certificate
key | string | Yes | - | - | 
keySize | int | - | - | - | 
serialNumber | string | - | - | - | 
subjectAlternativeNames | array[string] | - | - | - | 
version | string | - | - | - | 
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the certificate was created.
description | string | Optional | Yes | - | 
removed | date | - | - | - | The date of when the certificate was removed
transitioning | enum | - | - | - | Whether or not the certificate is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the certificate
uuid | string | - | - | - | The universally unique identifier for the certificate. This will always be unique across Rancher installations.





### Operations



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
### Actions

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

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/certificate/">certificate</a> resource
</span>
</div>
</span>
</span>
</span>

