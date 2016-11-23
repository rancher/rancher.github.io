---
title: Rancher API - googleConfig
layout: rancher-api-v1-default-v1.0
version: v1.0
lang: en
apiVersion: v1
---

## GoogleConfig



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
address | string | Optional | Yes | - | 
diskSize | string | Optional | Yes | - | 
diskType | string | Optional | Yes | - | 
machineImage | string | Optional | Yes | - | 
machineType | string | Optional | Yes | - | 
preemptible | boolean | Optional | Yes | - | 
project | string | Optional | Yes | - | 
scopes | string | Optional | Yes | - | 
tags | string | Optional | Yes | - | 
useExisting | boolean | Optional | Yes | - | 
useInternalIp | boolean | Optional | Yes | - | 
username | string | Optional | Yes | - | 
zone | string | Optional | Yes | - | 



<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/googleConfigs</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"address": "string",
	"diskSize": "string",
	"diskType": "string",
	"machineImage": "string",
	"machineType": "string",
	"preemptible": false,
	"project": "string",
	"scopes": "string",
	"tags": "string",
	"useExisting": false,
	"useInternalIp": false,
	"username": "string",
	"zone": "string"
}' 'http://${RANCHER_URL}:8080/v1/googleConfigs'
{% endhighlight %}
</div></div>



