---
title: Rancher API - certificate
layout: rancher-api-v2-beta-default-v1.4
version: v1.4
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.4/zh/api/v2-beta/api-resources/certificate/
---

## Certificate

A certificate is used to add in SSL termination to load balancers.

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
cert | string | Yes | Yes | - | 
certChain | string | Optional | Yes | - | 
description | string | Optional | Yes | - | 
key | string | Yes | Yes | - | 
name | string | Yes | Yes | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
CN | string  | 
algorithm | string  | 
certFingerprint | string  | 
expiresAt | string  | 
id | int  | The unique identifier for the certificate
issuedAt | string  | 
issuer | string  | 
keySize | int  | 
serialNumber | string  | 
subjectAlternativeNames | array[string]  | 
version | string  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/certificates</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"cert": "string",
	"certChain": "string",
	"description": "string",
	"key": "string",
	"name": "string"
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/certificates'
{% endhighlight %}
</div></div>
<a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v2-beta/projects/${PROJECT_ID}/certificates/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X DELETE \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/certificates/${ID}'
{% endhighlight %}
</div></div>
<a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v2-beta/projects/${PROJECT_ID}/certificates/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Content-Type: application/json' \
-d '{
	"cert": "string",
	"certChain": "string",
	"description": "string",
	"key": "string",
	"name": "string"
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/certificates/${ID}'
{% endhighlight %}
</div></div>



