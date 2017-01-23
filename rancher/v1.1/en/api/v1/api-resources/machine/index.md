---
title: Rancher API - machine
layout: rancher-api-v1-default-v1.1
version: v1.1
lang: en
apiVersion: v1
redirect_from:
  - /rancher/v1.1/zh/api/v1/api-resources/machine/
---

## Machine

Machines are created whenever Rancher uses `docker-machine` to create hosts in Rancher. Adding any type of host through the UI that is not the custom command option is calling `docker-machine` and a machine entry will be created as well as a [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host).

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
amazonec2Config | [amazonec2Config]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/amazonec2Config/) | Optional | - | - | 
authCertificateAuthority | string | Optional | - | - | 
authKey | string | Optional | - | - | 
azureConfig | [azureConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/azureConfig/) | Optional | - | - | 
description | string | Optional | Yes | - | 
digitaloceanConfig | [digitaloceanConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/digitaloceanConfig/) | Optional | - | - | 
dockerVersion | string | Optional | - | - | 
engineEnv | map[string] | Optional | - | - | 
engineInsecureRegistry | array[string] | Optional | - | - | 
engineInstallUrl | string | Optional | - | - | 
engineLabel | map[string] | Optional | - | - | 
engineOpt | map[string] | Optional | - | - | 
engineRegistryMirror | array[string] | Optional | - | - | 
engineStorageDriver | string | Optional | - | - | 
labels | map[string] | Optional | - | - | A map of key value pairs to be used as labels for the machine
name | string | Yes | - | - | 
packetConfig | [packetConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/packetConfig/) | Optional | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
driver | string  | 
externalId | string  | 
id | int  | The unique identifier for the machine


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/machines</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"amazonec2Config": {
		"accessKey": "",
		"ami": "",
		"deviceName": "/dev/sda1",
		"iamInstanceProfile": "",
		"instanceType": "t2.micro",
		"monitoring": false,
		"privateAddressOnly": false,
		"region": "us-east-1",
		"requestSpotInstance": false,
		"rootSize": "16",
		"secretKey": "",
		"securityGroup": "docker-machine",
		"sessionToken": "",
		"spotPrice": "0.50",
		"sshKeypath": "",
		"sshUser": "ubuntu",
		"subnetId": "",
		"tags": "",
		"useEbsOptimizedInstance": false,
		"usePrivateAddress": false,
		"volumeType": "gp2",
		"vpcId": "",
		"zone": "a"
	},
	"authCertificateAuthority": "string",
	"authKey": "string",
	"azureConfig": {
		"dockerPort": "2376",
		"dockerSwarmMasterPort": "3376",
		"image": "",
		"location": "West US",
		"password": "",
		"publishSettingsFile": "",
		"size": "Small",
		"sshPort": "22",
		"subscriptionCert": "",
		"subscriptionId": "",
		"username": "ubuntu"
	},
	"description": "string",
	"digitaloceanConfig": {
		"accessToken": "",
		"backups": false,
		"image": "ubuntu-15-10-x64",
		"ipv6": false,
		"privateNetworking": false,
		"region": "nyc3",
		"size": "512mb",
		"sshPort": "22",
		"sshUser": "root",
		"userdata": ""
	},
	"dockerVersion": "string",
	"engineEnv": {
		"key": "value-pairs"
	},
	"engineInsecureRegistry": [
		"string1",
		"...stringN"
	],
	"engineInstallUrl": "string",
	"engineLabel": {
		"key": "value-pairs"
	},
	"engineOpt": {
		"key": "value-pairs"
	},
	"engineRegistryMirror": [
		"string1",
		"...stringN"
	],
	"engineStorageDriver": "string",
	"labels": {
		"key": "value-pairs"
	},
	"name": "string",
	"packetConfig": {
		"apiKey": "",
		"billingCycle": "hourly",
		"facilityCode": "ewr1",
		"os": "ubuntu_14_04",
		"plan": "baremetal_1",
		"projectId": ""
	}
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/machines'
{% endhighlight %}
</div></div>
<a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/projects/${PROJECT_ID}/machines/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X DELETE \
'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/machines/${ID}'
{% endhighlight %}
</div></div>



