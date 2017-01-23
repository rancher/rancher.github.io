---
title: Rancher API - network
layout: rancher-api-v2-beta-default-v1.3
version: v1.3
lang: en
apiVersion: v2-beta
redirect_from:
  - /rancher/v1.3/zh/api/v2-beta/api-resources/network/
---

## Network

The networks available within Rancher that containers could be launched on.

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
dns | array[string] | Optional | - | - | 
dnsSearch | array[string] | Optional | - | - | 
hostPorts | boolean | Optional | - | - | 
metadata | map[json] | Optional | Yes | - | 
name | string | Optional | Yes | - | 
networkDriverId | [networkDriver]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/networkDriver/) | Yes | - | - | 
subnets | array[[subnet]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/subnet/)] | Optional | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
id | int  | The unique identifier for the network


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/networks</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"description": "string",
	"dns": [
		"string1",
		"...stringN"
	],
	"dnsSearch": [
		"string1",
		"...stringN"
	],
	"hostPorts": false,
	"metadata": {
		"key": "value-pairs"
	},
	"name": "string",
	"networkDriverId": "reference[networkDriver]",
	"subnets": "array[subnet]"
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/networks'
{% endhighlight %}
</div></div>
<a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v2-beta/projects/${PROJECT_ID}/networks/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X DELETE \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/networks/${ID}'
{% endhighlight %}
</div></div>
<a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v2-beta/projects/${PROJECT_ID}/networks/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Content-Type: application/json' \
-d '{
	"description": "string",
	"metadata": {
		"key": "value-pairs"
	},
	"name": "string"
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/networks/${ID}'
{% endhighlight %}
</div></div>



