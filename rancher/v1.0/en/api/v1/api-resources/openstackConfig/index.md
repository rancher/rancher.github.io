---
title: Rancher API - openstackConfig
layout: rancher-api-v1-default-v1.0
version: v1.0
lang: en
apiVersion: v1
---

## OpenstackConfig



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
activeTimeout | string | Optional | Yes | - | 
authUrl | string | Optional | Yes | - | 
availabilityZone | string | Optional | Yes | - | 
domainId | string | Optional | Yes | - | 
domainName | string | Optional | Yes | - | 
endpointType | string | Optional | Yes | - | 
flavorId | string | Optional | Yes | - | 
flavorName | string | Optional | Yes | - | 
floatingipPool | string | Optional | Yes | - | 
imageId | string | Optional | Yes | - | 
imageName | string | Optional | Yes | - | 
insecure | boolean | Optional | Yes | - | 
ipVersion | string | Optional | Yes | - | 
keypairName | string | Optional | Yes | - | 
netId | string | Optional | Yes | - | 
netName | string | Optional | Yes | - | 
novaNetwork | boolean | Optional | Yes | - | 
password | string | Optional | Yes | - | 
privateKeyFile | string | Optional | Yes | - | 
region | string | Optional | Yes | - | The region to use when launching the host
secGroups | string | Optional | Yes | - | 
sshPort | string | Optional | Yes | - | The port to ssh into the host
sshUser | string | Optional | Yes | - | The ssh username to use to ssh into the host
tenantId | string | Optional | Yes | - | 
tenantName | string | Optional | Yes | - | 
username | string | Optional | Yes | - | 



<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/openstackConfigs</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"activeTimeout": "string",
	"authUrl": "string",
	"availabilityZone": "string",
	"domainId": "string",
	"domainName": "string",
	"endpointType": "string",
	"flavorId": "string",
	"flavorName": "string",
	"floatingipPool": "string",
	"imageId": "string",
	"imageName": "string",
	"insecure": false,
	"ipVersion": "string",
	"keypairName": "string",
	"netId": "string",
	"netName": "string",
	"novaNetwork": false,
	"password": "string",
	"privateKeyFile": "string",
	"region": "string",
	"secGroups": "string",
	"sshPort": "string",
	"sshUser": "string",
	"tenantId": "string",
	"tenantName": "string",
	"username": "string"
}' 'http://${RANCHER_URL}:8080/v1/openstackConfigs'
{% endhighlight %}
</div></div>



