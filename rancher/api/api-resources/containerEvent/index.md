---
title: API
layout: rancher-default
---

## containerEvent

Collection Test Description

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
dockerInspect | json | - | - | - | 
externalFrom | string | - | - | - | 
externalId | string | - | - | - | 
externalStatus | string | - | - | - | 
externalTimestamp | int | - | - | - | 
hostId | [host]({{site.baseurl}}/rancher/api/api-resources/host/) | - | - | - | The unique identifier for the associated host
id | int | - | - | - | The unique identifier for the containerEvent
reportedHostUuid | string | - | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.
​








​
### Actions

<span class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${actions.remove}</code></span>
</span>
<div class="action-contents">
To remove the containerEvent
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/containerEvent/">containerEvent</a> resource
</span>
</div>
</span>
</span>
</span>

