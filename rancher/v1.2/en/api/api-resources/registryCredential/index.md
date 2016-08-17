---
title: Rancher API - registryCredential
layout: rancher-api-default
version: v1.2
lang: en
---

## RegistryCredential

A registry credential is used to authenticate against a [registry]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/registry).

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
email | string | Yes | Yes | - | 
id | int | - | - | - | The unique identifier for the registryCredential
name | string | Optional | Yes | - | 
publicValue | string | Optional | Yes | - | The public value of the registryCredential
registryId | [registry]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/registry/) | Yes | - | - | 
secretValue | [password]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/password/) | Optional | Yes | - | The secret value of the registryCredential

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/registryCredentials</code></span></span>
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
</div><a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/registryCredentials/${ID}</code></span></span>
<div class="action-contents">
{% highlight json %}

{% endhighlight %}
</div>
</div><a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v1/registryCredentials/${ID}</code></span></span>
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

### Actions
<div class="action">
<span class="header">
activate
<span class="headerright">POST:  <code>/v1/registryCredentials/${ID}?action=activate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/credential/">credential</a> resource</span>
</div></div>

<div class="action">
<span class="header">
deactivate
<span class="headerright">POST:  <code>/v1/registryCredentials/${ID}?action=deactivate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/credential/">credential</a> resource</span>
</div></div>


