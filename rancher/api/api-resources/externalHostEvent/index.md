---
title: API
layout: rancher-default
---

## externalHostEvent



​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
deleteHost | boolean | Optional | - | - | 
eventType | string | Optional | - | - | 
externalId | string | - | - | - | 
hostId | [host]({{site.baseurl}}/rancher/api/api-resources/host/) | Optional | - | - | The unique identifier for the associated host
hostLabel | string | Optional | - | - | 
id | int | - | - | - | The unique identifier for the externalHostEvent
reportedAccountId | [account]({{site.baseurl}}/rancher/api/api-resources/account/) | - | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.
​

### Operations



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/externalHostEvent</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"deleteHost": false,

	"eventType": "string",

	"hostId": "reference[host]",

	"hostLabel": "string"

} 
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
To remove the externalHostEvent
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/externalEvent/">externalEvent</a> resource
</span>
</div>
</span>
</span>
</span>

