---
title: API
layout: rancher-default
---

## password

Collection Test Description
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
publicValue | string | Optional | - | - | The public value of the password
secretValue | string | Optional | - | - | The secret value of the password




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the password was created.
description | string | Optional | Yes | - | The description for the password
id | int | - | - | - | The unique identifier for the password
kind | string | - | - | - | The kind for the password
name | string | Optional | Yes | - | The name for the password
removed | date | - | - | - | The date of when the password was removed
state | enum | - | - | - | The current state of the password. The options are [activating, active, deactivating, inactive, purged, purging, registering, removed, removing, requested, updating-active, updating-inactive].
transitioning | enum | - | - | - | Whether or not the password is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the password
uuid | string | - | - | - | The universally unique identifier for the password. This will always be unique across Rancher installations.




### Actions



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"description": "string",

	"name": "string",

	"publicValue": "string",

	"secretValue": "string"

} 
{% endhighlight %}
</div>
</span>















<span class="action">
<span class="header">
Update
<span class="headerright">PUT:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"description": "string",

	"name": "string"

} 
{% endhighlight %}
</div>
</span>







<span class="action">
<span class="header">
Delete
<span class="headerright">DELETE:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
 
{% endhighlight %}
</div>
</span>





​

<span class="action">
<span class="header">
activate
<span class="headerright">POST:  <code>${action.activate}</code></span>
</span>
<div class="action-contents">
To activate the password
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/credential/">credential</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
changesecret
<span class="headerright">POST:  <code>${action.changesecret}</code></span>
</span>
<div class="action-contents">
To changesecret the password
<br>

<span class="input">
<strong>Input:</strong>​​​ changeSecretInput


Field | Type | Required | Default | Description
---|---|---|---|---
newSecret | string | Yes | <no value> | Value of the new secret
oldSecret | string | Yes | <no value> | Value of the old secret


<br>
{% highlight json %}{

	"newSecret": "string",

	"oldSecret": "string"

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/changeSecretInput/">changeSecretInput</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
deactivate
<span class="headerright">POST:  <code>${action.deactivate}</code></span>
</span>
<div class="action-contents">
To deactivate the password
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/credential/">credential</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
purge
<span class="headerright">POST:  <code>${action.purge}</code></span>
</span>
<div class="action-contents">
To purge the password
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/credential/">credential</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${action.remove}</code></span>
</span>
<div class="action-contents">
To remove the password
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/credential/">credential</a> resource
</span>
</div>
</span>
</span>
</span>

