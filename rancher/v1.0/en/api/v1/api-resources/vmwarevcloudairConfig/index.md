---
title: Rancher API - vmwarevcloudairConfig
layout: rancher-api-v1-default-v1.0
version: v1.0
lang: en
apiVersion: v1
---

## VmwarevcloudairConfig



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
catalog | string | Optional | Yes | - | 
catalogitem | string | Optional | Yes | - | 
computeid | string | Optional | Yes | - | 
cpuCount | string | Optional | Yes | - | 
dockerPort | string | Optional | Yes | - | 
edgegateway | string | Optional | Yes | - | 
memorySize | string | Optional | Yes | - | 
orgvdcnetwork | string | Optional | Yes | - | 
password | string | Optional | Yes | - | 
publicip | string | Optional | Yes | - | 
sshPort | string | Optional | Yes | - | The port to ssh into the host
username | string | Optional | Yes | - | 
vdcid | string | Optional | Yes | - | 



<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/vmwarevcloudairConfigs</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"catalog": "string",
	"catalogitem": "string",
	"computeid": "string",
	"cpuCount": "string",
	"dockerPort": "string",
	"edgegateway": "string",
	"memorySize": "string",
	"orgvdcnetwork": "string",
	"password": "string",
	"publicip": "string",
	"sshPort": "string",
	"username": "string",
	"vdcid": "string"
}' 'http://${RANCHER_URL}:8080/v1/vmwarevcloudairConfigs'
{% endhighlight %}
</div></div>



