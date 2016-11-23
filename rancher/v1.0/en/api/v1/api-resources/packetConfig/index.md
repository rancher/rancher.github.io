---
title: Rancher API - packetConfig
layout: rancher-api-v1-default-v1.0
version: v1.0
lang: en
apiVersion: v1
---

## PacketConfig

The configuration to launch an instance in Packet.

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
apiKey | string | Optional | Yes | - | 
billingCycle | string | Optional | Yes | - | 
facilityCode | string | Optional | Yes | - | 
os | string | Optional | Yes | - | 
plan | string | Optional | Yes | - | 
projectId | string | Optional | Yes | - | 



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
	"apiKey": "string",
	"billingCycle": "string",
	"facilityCode": "string",
	"os": "string",
	"plan": "string",
	"projectId": "string"
}' 'http://${RANCHER_URL}:8080/v1/packetConfigs'
{% endhighlight %}
</div></div>



