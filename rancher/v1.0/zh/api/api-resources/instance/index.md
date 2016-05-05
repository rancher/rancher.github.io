---
title: API
layout: rancher-default-v1.0
version: v1.0
lang: zh
---

## instance



### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
externalId | string | - | - | - | 
hostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/host/) | - | - | - | The unique identifier for the associated host
id | int | - | - | - | The unique identifier for the instance
name | string | Optional | Yes | - | 


Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.








### Actions

<div class="action">
<span class="header">
allocate
<span class="headerright">POST:  <code>${actions.allocate}</code></span></span>
<div class="action-contents">
To allocate the instance
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>

<br>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
console
<span class="headerright">POST:  <code>${actions.console}</code></span></span>
<div class="action-contents">
To console the instance
<br>

<span class="input">
<strong>Input:</strong> instanceConsoleInput
</span>

<br>

<br>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instanceConsole/">instanceConsole</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
deallocate
<span class="headerright">POST:  <code>${actions.deallocate}</code></span></span>
<div class="action-contents">
To deallocate the instance
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>

<br>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
error
<span class="headerright">POST:  <code>${actions.error}</code></span></span>
<div class="action-contents">
To error the instance
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>

<br>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
migrate
<span class="headerright">POST:  <code>${actions.migrate}</code></span></span>
<div class="action-contents">
To migrate the instance
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>

<br>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
purge
<span class="headerright">POST:  <code>${actions.purge}</code></span></span>
<div class="action-contents">
To purge the instance
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>

<br>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${actions.remove}</code></span></span>
<div class="action-contents">
To remove the instance
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>

<br>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
restart
<span class="headerright">POST:  <code>${actions.restart}</code></span></span>
<div class="action-contents">
To restart the instance
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>

<br>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
restore
<span class="headerright">POST:  <code>${actions.restore}</code></span></span>
<div class="action-contents">
To restore the instance
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>

<br>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
start
<span class="headerright">POST:  <code>${actions.start}</code></span></span>
<div class="action-contents">
To start the instance
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>

<br>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
stop
<span class="headerright">POST:  <code>${actions.stop}</code></span></span>
<div class="action-contents">
To stop the instance
<br>

<span class="input">
<strong>Input:</strong> instanceStop
</span>

Field | Type | Required | Default | Notes
---|---|---|---|---
remove | boolean | No |  | 
timeout | int | No |  | 


<br>
{% highlight json %}{

	"remove": true,

	"timeout": 0

}{% endhighlight %}

<br>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
updatehealthy
<span class="headerright">POST:  <code>${actions.updatehealthy}</code></span></span>
<div class="action-contents">
To updatehealthy the instance
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>

<br>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
updatereinitializing
<span class="headerright">POST:  <code>${actions.updatereinitializing}</code></span></span>
<div class="action-contents">
To updatereinitializing the instance
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>

<br>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
updateunhealthy
<span class="headerright">POST:  <code>${actions.updateunhealthy}</code></span></span>
<div class="action-contents">
To updateunhealthy the instance
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>

<br>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource</span>
</div>
</div>

