---
title: API
layout: rancher-default
---

## ipAddress

Collection Test Description

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
address | string | - | - | - | 
description | string | Optional | Yes | - | 
id | int | - | - | - | The unique identifier for the ipAddress
name | string | Optional | Yes | - | 
networkId | [network]({{site.baseurl}}/rancher/api/api-resources/network/) | - | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.
​








​
### Actions

<span class="action">
<span class="header">
activate
<span class="headerright">POST:  <code>${actions.activate}</code></span>
</span>
<div class="action-contents">
To activate the ipAddress
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/ipAddress/">ipAddress</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
associate
<span class="headerright">POST:  <code>${actions.associate}</code></span>
</span>
<div class="action-contents">
To associate the ipAddress
<br>

<span class="input">
<strong>Input:</strong>​​​ ipAddressAssociateInput


Field | Type | Required | Default | Notes
---|---|---|---|---
ipAddressId | reference[ipAddress] | No | <no value> | 


<br>
{% highlight json %}{

	"ipAddressId": "reference[ipAddress]"

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/ipPool/">ipPool</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
deactivate
<span class="headerright">POST:  <code>${actions.deactivate}</code></span>
</span>
<div class="action-contents">
To deactivate the ipAddress
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/ipAddress/">ipAddress</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
disassociate
<span class="headerright">POST:  <code>${actions.disassociate}</code></span>
</span>
<div class="action-contents">
To disassociate the ipAddress
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/ipAddress/">ipAddress</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
purge
<span class="headerright">POST:  <code>${actions.purge}</code></span>
</span>
<div class="action-contents">
To purge the ipAddress
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/ipAddress/">ipAddress</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${actions.remove}</code></span>
</span>
<div class="action-contents">
To remove the ipAddress
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/ipAddress/">ipAddress</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
restore
<span class="headerright">POST:  <code>${actions.restore}</code></span>
</span>
<div class="action-contents">
To restore the ipAddress
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/ipAddress/">ipAddress</a> resource
</span>
</div>
</span>
</span>
</span>

