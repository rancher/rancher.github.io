---
title: Rancher API - snapshot
layout: rancher-api-default
version: v1.2
lang: en
---

## Snapshot



### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
id | int | - | - | - | The unique identifier for the snapshot
name | string | Optional | Yes | - | 
volumeId | [volume]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/volume/) | - | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/snapshots/${ID}</code></span></span>
<div class="action-contents">
{% highlight json %}

{% endhighlight %}
</div>
</div>

### Actions
<div class="action">
<span class="header">
backup
<span class="headerright">POST:  <code>/v1/snapshots/${ID}?action=backup</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> snapshotBackupInput</span>

<br>{% highlight json %}{
	"backupTargetId": "reference[backupTarget]",
	"name": "string"
}{% endhighlight %}<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/backup/">backup</a> resource</span>
</div></div>


