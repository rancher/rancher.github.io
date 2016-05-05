---
title: API
layout: rancher-default-v1.0
version: v1.0
lang: en
---

## snapshot



### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
id | int | - | - | - | The unique identifier for the snapshot
managedVolumeUUID | string | - | - | - | The unique identifier of the managed volume
name | string | Optional | Yes | - | 
volumeId | [volume]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/volume/) | Yes | - | - | 


Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.


### Operations
{::options parse_block_html="true" /}



<div class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/snapshot</code></span></span>
<div class="action-contents">
{% highlight json %} 
{

	"description": "string",

	"name": "string",

	"volumeId": "reference[volume]"

} 
{% endhighlight %}
</div>
</div>











### Actions

<div class="action">
<span class="header">
backup
<span class="headerright">POST:  <code>${actions.backup}</code></span></span>
<div class="action-contents">
To backup the snapshot
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>

<br>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/snapshot/">snapshot</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${actions.remove}</code></span></span>
<div class="action-contents">
To remove the snapshot
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>

<br>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/snapshot/">snapshot</a> resource</span>
</div>
</div>

