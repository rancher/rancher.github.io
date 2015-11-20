---
title: API
layout: rancher-default
---

## configItemStatus

Collection Test Description
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
agentId | [agent]({{site.baseurl}}/rancher/api/agent/) | - | - | - | The unique identifier of the associated agent
appliedUpdated | date | - | - | - | The appliedUpdated for the configItemStatus
appliedVersion | int | - | Yes | - | The appliedVersion for the configItemStatus
requestedUpdated | date | - | - | - | The requestedUpdated for the configItemStatus
requestedVersion | int | - | - | - | The requestedVersion for the configItemStatus
sourceVersion | string | - | - | - | The sourceVersion for the configItemStatus




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
id | int | - | - | - | The unique identifier for the configItemStatus
name | string | Optional | Yes | - | The name for the configItemStatus




### Actions









<span class="action">
<span class="header">
Update
<span class="headerright">PUT:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"appliedVersion": 0,

	"name": "string"

} 
{% endhighlight %}
</div>
</span>







​