---
title: API
layout: rancher-default
---

## serviceConsumeMap

Collection Test Description

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
consumedServiceId | [service]({{site.baseurl}}/rancher/api/api-resources/service/) | - | - | - | The unique identifier of the consumed service
description | string | Optional | Yes | - | 
id | int | - | - | - | The unique identifier for the serviceConsumeMap
name | string | - | - | - | 
ports | array[string] | - | - | - | 
serviceId | [service]({{site.baseurl}}/rancher/api/api-resources/service/) | - | - | - | The unique identifier of the associated service

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
To remove the serviceConsumeMap
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/serviceConsumeMap/">serviceConsumeMap</a> resource
</span>
</div>
</span>
</span>
</span>

