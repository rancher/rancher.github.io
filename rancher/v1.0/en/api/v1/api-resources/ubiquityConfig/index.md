---
title: Rancher API - ubiquityConfig
layout: rancher-api-v1-default-v1.0
version: v1.0
lang: en
apiVersion: v1
---

## UbiquityConfig



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
apiToken | string | Optional | Yes | - | 
apiUsername | string | Optional | Yes | - | 
clientId | string | Optional | Yes | - | 
flavorId | string | Optional | Yes | - | 
imageId | string | Optional | Yes | - | 
zoneId | string | Optional | Yes | - | 



<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/ubiquityConfigs</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"apiToken": "string",
	"apiUsername": "string",
	"clientId": "string",
	"flavorId": "string",
	"imageId": "string",
	"zoneId": "string"
}' 'http://${RANCHER_URL}:8080/v1/ubiquityConfigs'
{% endhighlight %}
</div></div>



