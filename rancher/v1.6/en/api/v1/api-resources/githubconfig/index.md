---
title: Rancher API - githubconfig
layout: rancher-api-v1-default-v1.6
version: v1.6
lang: en
apiVersion: v1
#redirect_from:
#  - /rancher/v1.6/zh/api/v1/api-resources/githubconfig/
---

## Githubconfig



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
accessMode | enum | Yes | - | unrestricted | The options are `restricted`, `unrestricted`, `required`.
allowedIdentities | array[[identity]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/identity/)] | Optional | - | - | 
clientId | string | Optional | - | - | 
clientSecret | string | Optional | - | - | 
enabled | boolean | Optional | - | - | 
hostname | string | Optional | - | - | 
name | string | Optional | Yes | - | 
scheme | string | Optional | - | - | 



<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/githubconfigs</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"accessMode": "unrestricted",
	"allowedIdentities": "array[identity]",
	"clientId": "string",
	"clientSecret": "string",
	"enabled": false,
	"hostname": "string",
	"name": "string",
	"scheme": "string"
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/githubconfigs'
{% endhighlight %}
</div></div>
<a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v1/projects/${PROJECT_ID}/githubconfigs/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Content-Type: application/json' \
-d '{
	"name": "string"
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/githubconfigs/${ID}'
{% endhighlight %}
</div></div>



