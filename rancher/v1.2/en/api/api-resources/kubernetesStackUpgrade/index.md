---
title: Rancher API - kubernetesStackUpgrade
layout: rancher-api-default
version: v1.2
lang: en
---

## KubernetesStackUpgrade



### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
environment | map[string] | Optional | - | - | 
externalId | string | Optional | - | - | 
templates | map[string] | Optional | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/kubernetesStackUpgrades</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"environment": {
		"key": "value-pairs"
	},
	"externalId": "string",
	"templates": {
		"key": "value-pairs"
	}
}' 'http://${RANCHER_URL}:8080/v1/kubernetesStackUpgrades'
{% endhighlight %}
</div></div>





