---
title: Rancher API - volume
layout: rancher-api-v1-default-v1.5
version: v1.5
lang: en
apiVersion: v1
#redirect_from:
#  - /rancher/v1.5/zh/api/v1/api-resources/volume/
---

## Volume

A volume can be associated to containers or storage pools. <br><br> * A container can have many volumes and containers are mapped to volumes the [mount]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/mount/) link on a container. <br> * A storage pool owns many volumes. The volume is only available to containers deployed on hosts that are part of the storage pool. When a volume is being created, you do not directly associate it to a storage pool. You will only need to specify a driver and during allocation, Rancher will resolve it to a storage pool.

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
driver | string | Yes | - | - | 
driverOpts | map[string] | Optional | - | - | 
name | string | Yes | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
accessMode | string  | 
externalId | string  | 
id | int  | The unique identifier for the volume
imageId | [image]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/image/)  | 
instanceId | [instance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instance/)  | The unique identifier for the associated instance
isHostPath | boolean  | 
uri | string  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/volumes</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"description": "string",
	"driver": "string",
	"driverOpts": {
		"key": "value-pairs"
	},
	"name": "string"
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/volumes'
{% endhighlight %}
</div></div>
<a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/projects/${PROJECT_ID}/volumes/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X DELETE \
'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/volumes/${ID}'
{% endhighlight %}
</div></div>



### Actions

<div class="action" id="restorefrombackup">
<span class="header">
restorefrombackup
<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/volumes/${ID}?action=restorefrombackup</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/restoreFromBackupInput/">RestoreFromBackupInput</a></span>

Field | Type | Required | Default | Notes
---|---|---|---|---
backupId | [backup]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/backup/) | Yes |  | 


<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"backupId": "reference[backup]"
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/volumes/${ID}?action=restorefrombackup'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/volume/">volume</a> resource</span>
</div></div>

<div class="action" id="reverttosnapshot">
<span class="header">
reverttosnapshot
<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/volumes/${ID}?action=reverttosnapshot</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/revertToSnapshotInput/">RevertToSnapshotInput</a></span>

Field | Type | Required | Default | Notes
---|---|---|---|---
snapshotId | [snapshot]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/snapshot/) | Yes |  | 


<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"snapshotId": "reference[snapshot]"
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/volumes/${ID}?action=reverttosnapshot'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/volume/">volume</a> resource</span>
</div></div>

<div class="action" id="snapshot">
<span class="header">
snapshot
<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/volumes/${ID}?action=snapshot</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/volumeSnapshotInput/">VolumeSnapshotInput</a></span>

Field | Type | Required | Default | Notes
---|---|---|---|---
name |  | No |  | 


<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"name": "string"
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/volumes/${ID}?action=snapshot'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/snapshot/">snapshot</a> resource</span>
</div></div>


