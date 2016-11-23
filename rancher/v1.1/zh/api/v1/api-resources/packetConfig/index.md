---
title: Rancher API - packetConfig
layout: rancher-api-v1-default-v1.1
version: v1.1
lang: zh
apiVersion: v1
---

## PacketConfig

The configuration to launch an instance in Packet.

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
apiKey | string | Optional | - | - | 
billingCycle | string | Optional | - | hourly | 
facilityCode | string | Optional | - | ewr1 | 
os | string | Optional | - | ubuntu_14_04 | 
plan | string | Optional | - | baremetal_1 | 
projectId | string | Optional | - | - | 



<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/packetConfigs</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"apiKey": "",
	"billingCycle": "hourly",
	"facilityCode": "ewr1",
	"os": "ubuntu_14_04",
	"plan": "baremetal_1",
	"projectId": ""
}' 'http://${RANCHER_URL}:8080/v1/packetConfigs'
{% endhighlight %}
</div></div>



