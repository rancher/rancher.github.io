---
title: Rancher API - certificate
layout: rancher-api-default
version: v1.2
lang: en
---

## Certificate

A certificate is used to add in SSL termination to load balancers.

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
CN | string | - | - | - | 
algorithm | string | - | - | - | 
cert | string | Yes | Yes | - | 
certChain | string | Optional | Yes | - | 
certFingerprint | string | - | - | - | 
description | string | Optional | Yes | - | 
expiresAt | string | - | - | - | 
id | int | - | - | - | The unique identifier for the certificate
issuedAt | string | - | - | - | 
issuer | string | - | - | - | 
key | string | Yes | Yes | - | 
keySize | int | - | - | - | 
name | string | Yes | Yes | - | 
serialNumber | string | - | - | - | 
subjectAlternativeNames | array[string] | - | - | - | 
version | string | - | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/certificates</code></span></span>
<div class="action-contents">
{% highlight json %}
{
	"cert": "string",
	"certChain": "string",
	"description": "string",
	"key": "string",
	"name": "string"
}
{% endhighlight %}
</div>
</div>

<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/certificates</code></span></span>
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
	"cert": "string",
	"certChain": "string",
	"description": "string",
	"key": "string",
	"name": "string"
}
{% endhighlight %}' \
'http://RANCHER_URL:8080/v1/certificates'
</code></pre></figure>

</div>
</div>

<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/certificates</code></span></span>
<div class="action-contents">
<figure class="highlight">
<pre>
<code>
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{
	"cert": "string",
	"certChain": "string",
	"description": "string",
	"key": "string",
	"name": "string"
}' \
'http://RANCHER_URL:8080/v1/certificates'
</code></pre></figure>

</div>
</div>


<a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/certificates/${ID}</code></span></span>
<div class="action-contents">
{% highlight json %}

{% endhighlight %}
</div>
</div>

<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/certificates/${ID}</code></span></span>
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
'http://RANCHER_URL:8080/v1/certificates/${ID}'
</code></pre></figure>

</div>
</div>

<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/certificates/${ID}</code></span></span>
<div class="action-contents">
<figure class="highlight">
<pre>
<code>
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X DELETE \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '' \
'http://RANCHER_URL:8080/v1/certificates/${ID}'
</code></pre></figure>

</div>
</div>


<a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v1/certificates/${ID}</code></span></span>
<div class="action-contents">
{% highlight json %}
{
	"cert": "string",
	"certChain": "string",
	"description": "string",
	"key": "string",
	"name": "string"
}
{% endhighlight %}
</div>
</div>

<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v1/certificates/${ID}</code></span></span>
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
	"cert": "string",
	"certChain": "string",
	"description": "string",
	"key": "string",
	"name": "string"
}
{% endhighlight %}' \
'http://RANCHER_URL:8080/v1/certificates/${ID}'
</code></pre></figure>

</div>
</div>

<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v1/certificates/${ID}</code></span></span>
<div class="action-contents">
<figure class="highlight">
<pre>
<code>
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{
	"cert": "string",
	"certChain": "string",
	"description": "string",
	"key": "string",
	"name": "string"
}' \
'http://RANCHER_URL:8080/v1/certificates/${ID}'
</code></pre></figure>

</div>
</div>




