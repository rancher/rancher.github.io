---
title: API
layout: rancher-default
---

## password

Collection Test Description

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
id | int | - | - | - | The unique identifier for the password
name | string | Optional | Yes | - | 
publicValue | string | Optional | - | - | The public value of the password
secretValue | [password]({{site.baseurl}}/rancher/api/api-resources/password/) | Optional | - | - | The secret value of the password

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.
​

### Operations



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/password</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"description": "string",

	"name": "string",

	"publicValue": "string",

	"secretValue": "password"

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
### Actions

<span class="action">
<span class="header">
activate
<span class="headerright">POST:  <code>${actions.activate}</code></span>
</span>
<div class="action-contents">
To activate the password
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/credential/">credential</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
changesecret
<span class="headerright">POST:  <code>${actions.changesecret}</code></span>
</span>
<div class="action-contents">
To changesecret the password
<br>

<span class="input">
<strong>Input:</strong>​​​ changeSecretInput


Field | Type | Required | Default | Notes
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

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/changeSecretInput/">changeSecretInput</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
deactivate
<span class="headerright">POST:  <code>${actions.deactivate}</code></span>
</span>
<div class="action-contents">
To deactivate the password
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/credential/">credential</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
purge
<span class="headerright">POST:  <code>${actions.purge}</code></span>
</span>
<div class="action-contents">
To purge the password
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/credential/">credential</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${actions.remove}</code></span>
</span>
<div class="action-contents">
To remove the password
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/credential/">credential</a> resource
</span>
</div>
</span>
</span>
</span>

