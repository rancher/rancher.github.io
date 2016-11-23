---
title: Rancher API - amazonec2Config
layout: rancher-api-v1-default-v1.0
version: v1.0
lang: en
apiVersion: v1
---

## Amazonec2Config

The configuration to launch an EC2 instance in Amazon Web Services using [machine]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/machine). Rancher is calling `docker-machine`, so any available options in `docker-machine` for specific drivers are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation. The notes on which fields are **required** are from the `docker-machine` documentation.

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
accessKey | string | Optional | Yes | - | 
ami | string | Optional | Yes | - | 
deviceName | string | Optional | Yes | - | 
iamInstanceProfile | string | Optional | Yes | - | 
instanceType | string | Optional | Yes | - | 
monitoring | boolean | Optional | Yes | - | 
privateAddressOnly | boolean | Optional | Yes | - | 
region | string | Optional | Yes | - | The region to use when launching the host
requestSpotInstance | boolean | Optional | Yes | - | 
rootSize | string | Optional | Yes | - | 
secretKey | string | Optional | Yes | - | 
securityGroup | string | Optional | Yes | - | 
sessionToken | string | Optional | Yes | - | 
spotPrice | string | Optional | Yes | - | 
sshKeypath | string | Optional | Yes | - | 
sshUser | string | Optional | Yes | - | The ssh username to use to ssh into the host
subnetId | string | Optional | Yes | - | 
tags | string | Optional | Yes | - | 
useEbsOptimizedInstance | boolean | Optional | Yes | - | 
usePrivateAddress | boolean | Optional | Yes | - | 
volumeType | string | Optional | Yes | - | 
vpcId | string | Optional | Yes | - | 
zone | string | Optional | Yes | - | 



<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/amazonec2Configs</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"accessKey": "string",
	"ami": "string",
	"deviceName": "string",
	"iamInstanceProfile": "string",
	"instanceType": "string",
	"monitoring": false,
	"privateAddressOnly": false,
	"region": "string",
	"requestSpotInstance": false,
	"rootSize": "string",
	"secretKey": "string",
	"securityGroup": "string",
	"sessionToken": "string",
	"spotPrice": "string",
	"sshKeypath": "string",
	"sshUser": "string",
	"subnetId": "string",
	"tags": "string",
	"useEbsOptimizedInstance": false,
	"usePrivateAddress": false,
	"volumeType": "string",
	"vpcId": "string",
	"zone": "string"
}' 'http://${RANCHER_URL}:8080/v1/amazonec2Configs'
{% endhighlight %}
</div></div>



