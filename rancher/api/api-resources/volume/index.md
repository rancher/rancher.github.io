---
title: API
layout: rancher-default
---

## volume

A volume can be associated to containers or storage pools. <br><br> * A container can have many volumes and containers are mapped to volumes the [mount]({{site.baseurl}}/rancher/api/api-resources/mount/) link on a container. <br> * A storage pool owns many volues. The volume is only available to containers deployed on hostst that are part of the storage pool. When a volume is being created, you do not directly associate it to a storage pool. You will only need to specify a driver and during allocation, Rancher will resolve it to a storage pool.

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
driver | string | Yes | - | - | 
driverOpts | map[string] | Optional | - | - | 
externalId | string | - | - | - | 
id | int | - | - | - | The unique identifier for the volume
imageId | [image]({{site.baseurl}}/rancher/api/api-resources/image/) | - | - | - | The ID of the image that will be used for the machine
instanceId | [instance]({{site.baseurl}}/rancher/api/api-resources/instance/) | - | - | - | The unique identifier for the associated instance
isHostPath | boolean | - | - | - | Whether or not the path of the volume is on the host
name | string | Yes | - | - | 
uri | string | - | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.
​

### Operations



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/volume</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"description": "string",

	"driver": "string",

	"driverOpts": {

		"key1": "value1",

		"key2": "value2",

		"keyN": "valueN"

	},

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
activate
<span class="headerright">POST:  <code>${actions.activate}</code></span>
</span>
<div class="action-contents">
To activate the volume
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/volume/">volume</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
allocate
<span class="headerright">POST:  <code>${actions.allocate}</code></span>
</span>
<div class="action-contents">
To allocate the volume
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/volume/">volume</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
deallocate
<span class="headerright">POST:  <code>${actions.deallocate}</code></span>
</span>
<div class="action-contents">
To deallocate the volume
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/volume/">volume</a> resource
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
To purge the volume
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/volume/">volume</a> resource
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
To remove the volume
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/volume/">volume</a> resource
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
To restore the volume
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/volume/">volume</a> resource
</span>
</div>
</span>
</span>
</span>

