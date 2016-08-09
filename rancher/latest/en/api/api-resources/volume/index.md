---
title: Rancher API - volume
layout: rancher-api-default
version: latest
lang: en
---

## Volume

A volume can be associated to containers or storage pools. <br><br> * A container can have many volumes and containers are mapped to volumes the [mount]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/mount/) link on a container. <br> * A storage pool owns many volues. The volume is only available to containers deployed on hostst that are part of the storage pool. When a volume is being created, you do not directly associate it to a storage pool. You will only need to specify a driver and during allocation, Rancher will resolve it to a storage pool.

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
accessMode | string | - | - | - | 
description | string | Optional | Yes | - | 
driver | string | Yes | - | - | 
driverOpts | map[string] | Optional | - | - | 
externalId | string | - | - | - | 
id | int | - | - | - | The unique identifier for the volume
imageId | [image]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/image/) | - | - | - | 
instanceId | [instance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/instance/) | - | - | - | The unique identifier for the associated instance
isHostPath | boolean | - | - | - | 
name | string | Yes | - | - | 
uri | string | - | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/volume</code></span></span>
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
</div>





<a id="delete"></a>
<div class="action">
<span class="header">Delete
<span class="headerright">DELETE:  <code>${links.self}</code></span></span>
<div class="action-contents">
{% highlight json %}

{% endhighlight %}
</div>
</div>
### Actions
<div class="action">
<span class="header">
restorefrombackup
<span class="headerright">POST:  <code>/v1/volumes/${ID}/?action=restorefrombackup</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> restoreFromBackupInput</span>

<br>{% highlight json %}{
	"backupId": "reference[backup]"
}{% endhighlight %}<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/volume/">volume</a> resource</span>
</div></div>

<div class="action">
<span class="header">
reverttosnapshot
<span class="headerright">POST:  <code>/v1/volumes/${ID}/?action=reverttosnapshot</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> revertToSnapshotInput</span>

<br>{% highlight json %}{
	"snapshotId": "reference[snapshot]"
}{% endhighlight %}<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/volume/">volume</a> resource</span>
</div></div>

<div class="action">
<span class="header">
snapshot
<span class="headerright">POST:  <code>/v1/volumes/${ID}/?action=snapshot</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> volumeSnapshotInput</span>

<br>{% highlight json %}{
	"name": "string"
}{% endhighlight %}<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/snapshot/">snapshot</a> resource</span>
</div></div>


