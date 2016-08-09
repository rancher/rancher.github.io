---
title: Rancher API - backupTarget
layout: rancher-api-default
version: latest
lang: en
---

## BackupTarget



### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
id | int | - | - | - | The unique identifier for the backupTarget
name | string | Yes | Yes | - | 
nfsConfig | [nfsConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/nfsConfig/) | Optional | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/backupTarget</code></span></span>
<div class="action-contents">
{% highlight json %}
{
	"description": "string",
	"name": "string",
	"nfsConfig": {
		"mountOptions": "string",
		"server": "string",
		"share": "string"
	}
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

