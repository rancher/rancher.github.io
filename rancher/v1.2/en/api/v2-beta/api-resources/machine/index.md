---
title: Rancher API - machine
layout: rancher-api-v2-beta-default-v1.2
version: v1.2
lang: en
apiVersion: v2-beta
redirect_from:
  - /rancher/v1.2/zh/api/v2-beta/api-resources/machine/
---

## Machine

Machines are created whenever Rancher uses `docker-machine` to create hosts in Rancher. Adding any type of host through the UI that is not the custom command option is calling `docker-machine` and a machine entry will be created as well as a [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host).

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
amazonec2Config | [amazonec2Config]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/amazonec2Config/) | Optional | Yes | - | 
authCertificateAuthority | string | Optional | Yes | - | 
authKey | string | Optional | Yes | - | 
azureConfig | [azureConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/azureConfig/) | Optional | Yes | - | 
description | string | Optional | Yes | - | 
digitaloceanConfig | [digitaloceanConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/digitaloceanConfig/) | Optional | Yes | - | 
dockerVersion | string | Optional | Yes | - | 
engineEnv | map[string] | Optional | Yes | - | 
engineInsecureRegistry | array[string] | Optional | Yes | - | 
engineInstallUrl | string | Optional | Yes | - | 
engineLabel | map[string] | Optional | Yes | - | 
engineOpt | map[string] | Optional | Yes | - | 
engineRegistryMirror | array[string] | Optional | Yes | - | 
engineStorageDriver | string | Optional | Yes | - | 
labels | map[string] | Optional | Yes | - | A map of key value pairs to be used as labels for the machine
name | string | Optional | Yes | - | 
packetConfig | [packetConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/packetConfig/) | Optional | Yes | - | 


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
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/machines</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"amazonec2Config": {
		"accessKey": "",
		"ami": "",
		"deviceName": "/dev/sda1",
		"endpoint": "",
		"iamInstanceProfile": "",
		"insecureTransport": false,
		"instanceType": "t2.micro",
		"keypairName": "",
		"monitoring": false,
		"openPort": [
			"string1",
			"...stringN"
		],
		"privateAddressOnly": false,
		"region": "us-east-1",
		"requestSpotInstance": false,
		"retries": "5",
		"rootSize": "16",
		"secretKey": "",
		"securityGroup": [
			"docker-machine"
		],
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
		"availabilitySet": "docker-machine",
		"clientId": "",
		"clientSecret": "",
		"customData": "",
		"dns": "",
		"dockerPort": "2376",
		"environment": "AzurePublicCloud",
		"image": "canonical:UbuntuServer:16.04.0-LTS:latest",
		"location": "westus",
		"noPublicIp": false,
		"openPort": [
			"string1",
			"...stringN"
		],
		"privateIpAddress": "",
		"resourceGroup": "docker-machine",
		"size": "Standard_A2",
		"sshUser": "docker-user",
		"staticPublicIp": false,
		"storageType": "Standard_LRS",
		"subnet": "docker-machine",
		"subnetPrefix": "192.168.0.0/16",
		"subscriptionId": "",
		"usePrivateIp": false,
		"vnet": "docker-machine-vnet"
	},
	"description": "string",
	"digitaloceanConfig": {
		"accessToken": "",
		"backups": false,
		"image": "ubuntu-16-04-x64",
		"ipv6": false,
		"privateNetworking": false,
		"region": "nyc3",
		"size": "512mb",
		"sshKeyFingerprint": "",
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
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/machines'
{% endhighlight %}
</div></div>
<a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v2-beta/projects/${PROJECT_ID}/machines/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X DELETE \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/machines/${ID}'
{% endhighlight %}
</div></div>
<a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v2-beta/projects/${PROJECT_ID}/machines/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Content-Type: application/json' \
-d '{
	"amazonec2Config": {
		"accessKey": "",
		"ami": "",
		"deviceName": "/dev/sda1",
		"endpoint": "",
		"iamInstanceProfile": "",
		"insecureTransport": false,
		"instanceType": "t2.micro",
		"keypairName": "",
		"monitoring": false,
		"openPort": [
			"string1",
			"...stringN"
		],
		"privateAddressOnly": false,
		"region": "us-east-1",
		"requestSpotInstance": false,
		"retries": "5",
		"rootSize": "16",
		"secretKey": "",
		"securityGroup": [
			"docker-machine"
		],
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
		"availabilitySet": "docker-machine",
		"clientId": "",
		"clientSecret": "",
		"customData": "",
		"dns": "",
		"dockerPort": "2376",
		"environment": "AzurePublicCloud",
		"image": "canonical:UbuntuServer:16.04.0-LTS:latest",
		"location": "westus",
		"noPublicIp": false,
		"openPort": [
			"string1",
			"...stringN"
		],
		"privateIpAddress": "",
		"resourceGroup": "docker-machine",
		"size": "Standard_A2",
		"sshUser": "docker-user",
		"staticPublicIp": false,
		"storageType": "Standard_LRS",
		"subnet": "docker-machine",
		"subnetPrefix": "192.168.0.0/16",
		"subscriptionId": "",
		"usePrivateIp": false,
		"vnet": "docker-machine-vnet"
	},
	"description": "string",
	"digitaloceanConfig": {
		"accessToken": "",
		"backups": false,
		"image": "ubuntu-16-04-x64",
		"ipv6": false,
		"privateNetworking": false,
		"region": "nyc3",
		"size": "512mb",
		"sshKeyFingerprint": "",
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
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/machines/${ID}'
{% endhighlight %}
</div></div>



