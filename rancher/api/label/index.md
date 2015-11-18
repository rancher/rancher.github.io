---
title: API
layout: rancher-default
---

## label

Collection Test Description
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
key | string | - | - | - | The key for the label
value | string | - | - | - | The value for the label




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the label was created.
description | string | Optional | Yes | - | The description for the label
id | int | - | - | - | The unique identifier for the label
kind | string | - | - | - | The kind for the label
name | string | Optional | Yes | - | The name for the label
removed | date | - | - | - | The date of when the label was removed
state | enum | - | - | - | The current state of the label. The options are [created, creating, removed, removing, requested].
transitioning | enum | - | - | - | Whether or not the label is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the label
uuid | string | - | - | - | The universally unique identifier for the label. This will always be unique across Rancher installations.




### Actions









​

<span class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${action.remove}</code></span>
</span>
<div class="action-contents">
To remove the label
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/label/">label</a> resource
</span>
</div>
</span>
</span>
</span>

