---
title: Rancher API - machine
layout: rancher-api-default
version: latest
lang: en
---

## Machine

Machines are created whenever Rancher uses `docker-machine` to create hosts in Rancher. Adding any type of host through the UI that is not the custom command option is calling `docker-machine` and a machine entry will be created as well as a [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/host).

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
amazonec2Config | [amazonec2Config]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/amazonec2Config/) | Optional | - | - | 
authCertificateAuthority | string | Optional | - | - | 
authKey | string | Optional | - | - | 
azureConfig | [azureConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/azureConfig/) | Optional | - | - | 
description | string | Optional | Yes | - | 
digitaloceanConfig | [digitaloceanConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/digitaloceanConfig/) | Optional | - | - | 
dockerVersion | string | Optional | - | - | 
driver | string | - | - | - | 
engineEnv | map[string] | Optional | - | - | 
engineInsecureRegistry | array[string] | Optional | - | - | 
engineInstallUrl | string | Optional | - | - | 
engineLabel | map[string] | Optional | - | - | 
engineOpt | map[string] | Optional | - | - | 
engineRegistryMirror | array[string] | Optional | - | - | 
engineStorageDriver | string | Optional | - | - | 
externalId | string | - | - | - | 
id | int | - | - | - | The unique identifier for the machine
labels | map[string] | Optional | - | - | A map of key value pairs to be used as labels for the machine
name | string | Yes | - | - | 
packetConfig | [packetConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/packetConfig/) | Optional | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/machine</code></span></span>
<div class="action-contents">
{% highlight json %}
{
	"amazonec2Config": {
		"accessKey": "",
		"ami": "",
		"deviceName": "/dev/sda1",
		"iamInstanceProfile": "",
		"instanceType": "t2.micro",
		"monitoring": true,
		"privateAddressOnly": true,
		"region": "us-east-1",
		"requestSpotInstance": true,
		"rootSize": "16",
		"secretKey": "",
		"securityGroup": "docker-machine",
		"sessionToken": "",
		"spotPrice": "0.50",
		"sshKeypath": "",
		"sshUser": "ubuntu",
		"subnetId": "",
		"tags": "",
		"useEbsOptimizedInstance": true,
		"usePrivateAddress": true,
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
		"backups": true,
		"image": "ubuntu-15-10-x64",
		"ipv6": true,
		"privateNetworking": true,
		"region": "nyc3",
		"size": "512mb",
		"sshPort": "22",
		"sshUser": "root",
		"userdata": ""
	},
	"dockerVersion": "string",
	"engineEnv": {
		"key1": "value1",
		"key2": "value2",
		"keyN": "valueN"
	},
	"engineInsecureRegistry": [
		"string1",
		"string2",
		"...stringN"
	],
	"engineInstallUrl": "string",
	"engineLabel": {
		"key1": "value1",
		"key2": "value2",
		"keyN": "valueN"
	},
	"engineOpt": {
		"key1": "value1",
		"key2": "value2",
		"keyN": "valueN"
	},
	"engineRegistryMirror": [
		"string1",
		"string2",
		"...stringN"
	],
	"engineStorageDriver": "string",
	"labels": {
		"key1": "value1",
		"key2": "value2",
		"keyN": "valueN"
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
}
{% endhighlight %}
</div>
</div>





<a id="delete"></a>
<div class="action">
<span class="header">Delete
<span class="headerright">DELETE:  <code>${links.self}</code></span></span>
<div class="action-contents">
{% highlight json %}

{% endhighlight %}
</div>
</div>

