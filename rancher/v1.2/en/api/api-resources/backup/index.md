---
title: Rancher API - backup
layout: rancher-api-default
version: v1.2
lang: en
---

## Backup



### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
backupTargetId | [backupTarget]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/backupTarget/) | - | - | - | 
description | string | Optional | Yes | - | 
id | int | - | - | - | The unique identifier for the backup
name | string | Optional | Yes | - | 
snapshotId | [snapshot]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/snapshot/) | - | - | - | 
uri | string | - | - | - | 
volumeId | [volume]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/volume/) | - | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/backups/${ID}</code></span></span>
<div class="action-contents">
{% highlight json %}

{% endhighlight %}
</div>
</div>

