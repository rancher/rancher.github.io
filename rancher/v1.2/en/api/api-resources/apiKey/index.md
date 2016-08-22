---
title: Rancher API - apiKey
layout: rancher-api-default
version: v1.2
lang: en
---

## ApiKey

An API Key provides access to the Rancher API if access control has been turned on. The access key and secret key pair are created per environment and can be used to directly call the API or used with [rancher-compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-compose).

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
id | int | - | - | - | The unique identifier for the apiKey
name | string | Optional | Yes | - | 
publicValue | string | - | - | - | The public value of the apiKey
secretValue | [password]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/password/) | - | - | - | The secret value of the apiKey

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/apiKeys</code></span></span>
<div class="action-contents">
{% highlight json %}
{
	"description": "string",
	"name": "string"
}
{% endhighlight %}
</div>
</div>

<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/apiKeys</code></span></span>
<div class="action-contents">
<figure class="highlight">
<pre>
<code>
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{% highlight json %}
{
	"description": "string",
	"name": "string"
}
{% endhighlight %}' \
'http://RANCHER_URL:8080/v1/apiKeys'
</code></pre></figure>

</div>
</div>

<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/apiKeys</code></span></span>
<div class="action-contents">
<figure class="highlight">
<pre>
<code>
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{
	"description": "string",
	"name": "string"
}' \
'http://RANCHER_URL:8080/v1/apiKeys'
</code></pre></figure>

</div>
</div>


<a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/apiKeys/${ID}</code></span></span>
<div class="action-contents">
{% highlight json %}

{% endhighlight %}
</div>
</div>

<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/apiKeys/${ID}</code></span></span>
<div class="action-contents">
<figure class="highlight">
<pre>
<code>
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X DELETE \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{% highlight json %}

{% endhighlight %}' \
'http://RANCHER_URL:8080/v1/apiKeys/${ID}'
</code></pre></figure>

</div>
</div>

<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/apiKeys/${ID}</code></span></span>
<div class="action-contents">
<figure class="highlight">
<pre>
<code>
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X DELETE \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '' \
'http://RANCHER_URL:8080/v1/apiKeys/${ID}'
</code></pre></figure>

</div>
</div>


<a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v1/apiKeys/${ID}</code></span></span>
<div class="action-contents">
{% highlight json %}
{
	"description": "string",
	"name": "string"
}
{% endhighlight %}
</div>
</div>

<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v1/apiKeys/${ID}</code></span></span>
<div class="action-contents">
<figure class="highlight">
<pre>
<code>
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{% highlight json %}
{
	"description": "string",
	"name": "string"
}
{% endhighlight %}' \
'http://RANCHER_URL:8080/v1/apiKeys/${ID}'
</code></pre></figure>

</div>
</div>

<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v1/apiKeys/${ID}</code></span></span>
<div class="action-contents">
<figure class="highlight">
<pre>
<code>
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{
	"description": "string",
	"name": "string"
}' \
'http://RANCHER_URL:8080/v1/apiKeys/${ID}'
</code></pre></figure>

</div>
</div>




### Actions
<div class="action">
<span class="header">
activate
<span class="headerright">POST:  <code>/v1/apiKeys/${ID}?action=activate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/credential/">credential</a> resource</span>
</div></div>

<div class="action">
<span class="header">
deactivate
<span class="headerright">POST:  <code>/v1/apiKeys/${ID}?action=deactivate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/credential/">credential</a> resource</span>
</div></div>


