---
title: Rancher API - instance
layout: rancher-api-default
version: latest
lang: en
---

## Instance



### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
externalId | string | - | - | - | 
hostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/host/) | - | - | - | The unique identifier for the associated host
id | int | - | - | - | The unique identifier for the instance
name | string | Optional | Yes | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.



### Actions
<div class="action">
<span class="header">
console
<span class="headerright">POST:  <code>/v1/instances/${ID}?action=console</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> instanceConsoleInput</span>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instanceConsole/">instanceConsole</a> resource</span>
</div></div>

<div class="action">
<span class="header">
restart
<span class="headerright">POST:  <code>/v1/instances/${ID}?action=restart</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource</span>
</div></div>

<div class="action">
<span class="header">
start
<span class="headerright">POST:  <code>/v1/instances/${ID}?action=start</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource</span>
</div></div>

<div class="action">
<span class="header">
stop
<span class="headerright">POST:  <code>/v1/instances/${ID}?action=stop</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> instanceStop</span>

<br>{% highlight json %}{
	"remove": true,
	"timeout": 0
}{% endhighlight %}<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource</span>
</div></div>


