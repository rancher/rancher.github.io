---
title: Rancher API - azureadconfig
layout: rancher-api-v1-default-v1.6
version: v1.6
lang: en
apiVersion: v1
#redirect_from:
#  - /rancher/v1.6/zh/api/v1/api-resources/azureadconfig/
---

## Azureadconfig



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
accessMode | string | Yes | - | unrestricted | 
adminAccountPassword | string | Yes | - | - | 
adminAccountUsername | string | Yes | - | - | 
clientId | string | Optional | - | - | 
domain | string | Optional | - | - | 
enabled | boolean | Optional | - | - | 
name | string | Optional | Yes | - | 
tenantId | string | Optional | - | - | 



<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/azureadconfigs</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"accessMode": "unrestricted",
	"adminAccountPassword": "string",
	"adminAccountUsername": "string",
	"clientId": "string",
	"domain": "string",
	"enabled": false,
	"name": "string",
	"tenantId": "string"
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/azureadconfigs'
{% endhighlight %}
</div></div>
<a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v1/projects/${PROJECT_ID}/azureadconfigs/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Content-Type: application/json' \
-d '{
	"name": "string"
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/azureadconfigs/${ID}'
{% endhighlight %}
</div></div>



