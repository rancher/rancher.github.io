---
title: API
layout: rancher-default
---

## ipAddress

Collection Test Description
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
address | string | - | - | - | ALENA
networkId | [network]({{site.baseurl}}/rancher/api/network/) | - | - | - | The networkId for the ipAddress




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the ipAddress was created.
description | string | Optional | Yes | - | The description for the ipAddress
id | int | - | - | - | The unique identifier for the ipAddress
kind | string | - | - | - | The kind for the ipAddress
name | string | Optional | Yes | - | The name for the ipAddress
removed | date | - | - | - | The date of when the ipAddress was removed
state | enum | - | - | - | The current state of the ipAddress. The options are [activating, active, associated, associating, deactivating, disassociating, inactive, purged, purging, registering, removed, removing, requested, restoring, updating-active, updating-inactive].
transitioning | enum | - | - | - | Whether or not the ipAddress is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the ipAddress
uuid | string | - | - | - | The universally unique identifier for the ipAddress. This will always be unique across Rancher installations.




### Actions









​

<span class="action">
<span class="header">
activate
<span class="headerright">POST:  <code>${action.activate}</code></span>
</span>
<div class="action-contents">
To activate the ipAddress
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/ipAddress/">ipAddress</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
associate
<span class="headerright">POST:  <code>${action.associate}</code></span>
</span>
<div class="action-contents">
To associate the ipAddress
<br>

<span class="input">
<strong>Input:</strong>​​​ ipAddressAssociateInput


Field | Type | Required | Default | Description
---|---|---|---|---
ipAddressId | reference[ipAddress] | No | <no value> | ALENA


<br>
{% highlight json %}{

	"ipAddressId": "reference[ipAddress]"

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/ipPool/">ipPool</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
deactivate
<span class="headerright">POST:  <code>${action.deactivate}</code></span>
</span>
<div class="action-contents">
To deactivate the ipAddress
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/ipAddress/">ipAddress</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
disassociate
<span class="headerright">POST:  <code>${action.disassociate}</code></span>
</span>
<div class="action-contents">
To disassociate the ipAddress
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/ipAddress/">ipAddress</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
purge
<span class="headerright">POST:  <code>${action.purge}</code></span>
</span>
<div class="action-contents">
To purge the ipAddress
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/ipAddress/">ipAddress</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${action.remove}</code></span>
</span>
<div class="action-contents">
To remove the ipAddress
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/ipAddress/">ipAddress</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
restore
<span class="headerright">POST:  <code>${action.restore}</code></span>
</span>
<div class="action-contents">
To restore the ipAddress
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/ipAddress/">ipAddress</a> resource
</span>
</div>
</span>
</span>
</span>

