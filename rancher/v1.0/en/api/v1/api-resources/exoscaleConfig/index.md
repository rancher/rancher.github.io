---
title: Rancher API - exoscaleConfig
layout: rancher-api-v1-default-v1.0
version: v1.0
lang: en
apiVersion: v1
---

## ExoscaleConfig



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
apiKey | string | Optional | Yes | - | 
apiSecretKey | string | Optional | Yes | - | 
availabilityZone | string | Optional | Yes | - | 
diskSize | string | Optional | Yes | - | 
image | string | Optional | Yes | - | 
instanceProfile | string | Optional | Yes | - | 
securityGroup | array[string] | Optional | Yes | - | 
url | string | Optional | Yes | - | 



<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/exoscaleConfigs</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"apiKey": "string",
	"apiSecretKey": "string",
	"availabilityZone": "string",
	"diskSize": "string",
	"image": "string",
	"instanceProfile": "string",
	"securityGroup": [
		"string1",
		"...stringN"
	],
	"url": "string"
}' 'http://${RANCHER_URL}:8080/v1/exoscaleConfigs'
{% endhighlight %}
</div></div>



