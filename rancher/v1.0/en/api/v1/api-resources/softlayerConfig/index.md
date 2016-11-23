---
title: Rancher API - softlayerConfig
layout: rancher-api-v1-default-v1.0
version: v1.0
lang: en
apiVersion: v1
---

## SoftlayerConfig



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
apiEndpoint | string | Optional | Yes | - | 
apiKey | string | Optional | Yes | - | 
cpu | string | Optional | Yes | - | 
diskSize | string | Optional | Yes | - | 
domain | string | Optional | Yes | - | 
hostname | string | Optional | Yes | - | 
hourlyBilling | boolean | Optional | Yes | - | 
image | string | Optional | Yes | - | 
localDisk | boolean | Optional | Yes | - | 
memory | string | Optional | Yes | - | 
privateNetOnly | boolean | Optional | Yes | - | 
privateVlanId | string | Optional | Yes | - | 
publicVlanId | string | Optional | Yes | - | 
region | string | Optional | Yes | - | The region to use when launching the host
user | string | Optional | Yes | - | 



<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/softlayerConfigs</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"apiEndpoint": "string",
	"apiKey": "string",
	"cpu": "string",
	"diskSize": "string",
	"domain": "string",
	"hostname": "string",
	"hourlyBilling": false,
	"image": "string",
	"localDisk": false,
	"memory": "string",
	"privateNetOnly": false,
	"privateVlanId": "string",
	"publicVlanId": "string",
	"region": "string",
	"user": "string"
}' 'http://${RANCHER_URL}:8080/v1/softlayerConfigs'
{% endhighlight %}
</div></div>



