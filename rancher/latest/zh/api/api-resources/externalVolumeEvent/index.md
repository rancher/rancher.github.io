---
title: API
layout: rancher-default
version: latest
lang: zh
---

## externalVolumeEvent



### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
eventType | string | - | - | - | 
externalId | string | - | - | - | 
id | int | - | - | - | The unique identifier for the externalVolumeEvent
reportedAccountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/account/) | - | - | - | 
volume | [volume]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/volume/) | - | - | - | 


Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.








### Actions

<div class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${actions.remove}</code></span></span>
<div class="action-contents">
To remove the externalVolumeEvent
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>

<br>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/externalEvent/">externalEvent</a> resource</span>
</div>
</div>

