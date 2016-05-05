---
title: API
layout: rancher-default-v1.0
version: v1.0
lang: zh
---

## registryCredential

A registry credential is used to authenticate against a [registry]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/registry).

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
email | string | Yes | Yes | - | The email address of the credential to use with a registry
id | int | - | - | - | The unique identifier for the registryCredential
name | string | Optional | Yes | - | 
publicValue | string | Optional | Yes | - | The public value of the registryCredential
registryId | [registry]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/registry/) | Yes | - | - | The unique identifier of a registry
secretValue | [password]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/password/) | Optional | Yes | - | The secret value of the registryCredential


Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.


### Operations
{::options parse_block_html="true" /}



<div class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/registryCredential</code></span></span>
<div class="action-contents">
{% highlight json %} 
{

	"description": "string",

	"email": "string",

	"name": "string",

	"publicValue": "string",

	"registryId": "reference[registry]",

	"secretValue": "password"

} 
{% endhighlight %}
</div>
</div>













<div class="action">
<span class="header">
Update
<span class="headerright">PUT:  <code>${links.self}</code></span></span>
<div class="action-contents">
{% highlight json %} 
{

	"description": "string",

	"email": "string",

	"name": "string",

	"publicValue": "string",

	"secretValue": "password"

} 
{% endhighlight %}
</div>
</div>







<div class="action">
<span class="header">
Delete
<span class="headerright">DELETE:  <code>${links.self}</code></span></span>
<div class="action-contents">
{% highlight json %} 
 
{% endhighlight %}
</div>
</div>





### Actions

<div class="action">
<span class="header">
activate
<span class="headerright">POST:  <code>${actions.activate}</code></span></span>
<div class="action-contents">
To activate the registryCredential
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>

<br>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/credential/">credential</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
deactivate
<span class="headerright">POST:  <code>${actions.deactivate}</code></span></span>
<div class="action-contents">
To deactivate the registryCredential
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>

<br>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/credential/">credential</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
purge
<span class="headerright">POST:  <code>${actions.purge}</code></span></span>
<div class="action-contents">
To purge the registryCredential
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>

<br>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/credential/">credential</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${actions.remove}</code></span></span>
<div class="action-contents">
To remove the registryCredential
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>

<br>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/credential/">credential</a> resource</span>
</div>
</div>

