---
title: Rancher API - vmwarevsphereConfig
layout: rancher-api-v1-default-v1.0
version: v1.0
lang: en
apiVersion: v1
---

## VmwarevsphereConfig



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
boot2dockerUrl | string | Optional | Yes | - | 
cpuCount | string | Optional | Yes | - | 
datacenter | string | Optional | Yes | - | 
datastore | string | Optional | Yes | - | 
diskSize | string | Optional | Yes | - | 
hostsystem | string | Optional | Yes | - | 
memorySize | string | Optional | Yes | - | 
network | string | Optional | Yes | - | 
password | string | Optional | Yes | - | 
pool | string | Optional | Yes | - | 
username | string | Optional | Yes | - | 
vcenter | string | Optional | Yes | - | 
vcenterPort | string | Optional | Yes | - | 



<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/vmwarevsphereConfigs</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"boot2dockerUrl": "string",
	"cpuCount": "string",
	"datacenter": "string",
	"datastore": "string",
	"diskSize": "string",
	"hostsystem": "string",
	"memorySize": "string",
	"network": "string",
	"password": "string",
	"pool": "string",
	"username": "string",
	"vcenter": "string",
	"vcenterPort": "string"
}' 'http://${RANCHER_URL}:8080/v1/vmwarevsphereConfigs'
{% endhighlight %}
</div></div>



