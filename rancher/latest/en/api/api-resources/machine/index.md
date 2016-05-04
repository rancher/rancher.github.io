---
title: API
layout: rancher-default
version: latest
lang: en
---

## machine

Machines are created whenever Rancher uses `docker-machine` to create hosts in Rancher. Adding any type of host through the UI that is not the custom command option is calling `docker-machine` and a machine entry will be created as well as a [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/host).

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
amazonec2Config | [amazonec2Config]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/amazonec2Config/) | Optional | - | - | Configuration for launching a host in Amazon EC2
authCertificateAuthority | string | Optional | - | - | 
authKey | string | Optional | - | - | 
azureConfig | [azureConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/azureConfig/) | Optional | - | - | Configuration for launching a host in Microsoft Azure
description | string | Optional | Yes | - | 
digitaloceanConfig | [digitaloceanConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/digitaloceanConfig/) | Optional | - | - | Configuration for launching a host in DigitalOcean
dockerVersion | string | Optional | - | - | 
driver | string | - | - | - | 
engineEnv | map[string] | Optional | - | - | 
engineInsecureRegistry | array[string] | Optional | - | - | 
engineInstallUrl | string | Optional | - | - | 
engineLabel | map[string] | Optional | - | - | 
engineOpt | map[string] | Optional | - | - | 
engineRegistryMirror | array[string] | Optional | - | - | 
engineStorageDriver | string | Optional | - | - | 
exoscaleConfig | [exoscaleConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/exoscaleConfig/) | Optional | - | - | Configuration for launching a host in exoscale
externalId | string | - | - | - | 
genericConfig | [genericConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/genericConfig/) | Optional | - | - | 
googleConfig | [googleConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/googleConfig/) | Optional | - | - | 
hypervConfig | [hypervConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/hypervConfig/) | Optional | - | - | 
id | int | - | - | - | The unique identifier for the machine
labels | map[string] | Optional | - | - | 
name | string | Yes | - | - | 
openstackConfig | [openstackConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/openstackConfig/) | Optional | - | - | Configuration for launching a host in OpenStack
packetConfig | [packetConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/packetConfig/) | Optional | - | - | Configuration for launching a host in Packet
rackspaceConfig | [rackspaceConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/rackspaceConfig/) | Optional | - | - | Configuration for launching a host in Rackspace
softlayerConfig | [softlayerConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/softlayerConfig/) | Optional | - | - | Configuration for launching a host in IBM Softlayer
ubiquityConfig | [ubiquityConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/ubiquityConfig/) | Optional | - | - | 
virtualboxConfig | [virtualboxConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/virtualboxConfig/) | Optional | - | - | Configuration for launching a host in Oracle VirtualBox
vmwarefusionConfig | [vmwarefusionConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/vmwarefusionConfig/) | Optional | - | - | 
vmwarevcloudairConfig | [vmwarevcloudairConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/vmwarevcloudairConfig/) | Optional | - | - | Configuration for launching a host in VMware vCloud Air
vmwarevsphereConfig | [vmwarevsphereConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/vmwarevsphereConfig/) | Optional | - | - | Configuration for launching a host in VMware vSphere


Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.


### Operations
{::options parse_block_html="true" /}



<div class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/machine</code></span></span>
<div class="action-contents">
{% highlight json %} 
{

	"amazonec2Config": {

		"accessKey": "string",

		"ami": "string",

		"deviceName": "string",

		"iamInstanceProfile": "string",

		"instanceType": "string",

		"monitoring": true,

		"privateAddressOnly": true,

		"region": "string",

		"requestSpotInstance": true,

		"rootSize": "string",

		"secretKey": "string",

		"securityGroup": "string",

		"sessionToken": "string",

		"spotPrice": "string",

		"sshKeypath": "string",

		"sshUser": "string",

		"subnetId": "string",

		"tags": "string",

		"useEbsOptimizedInstance": true,

		"usePrivateAddress": true,

		"volumeType": "string",

		"vpcId": "string",

		"zone": "string"

	},

	"authCertificateAuthority": "string",

	"authKey": "string",

	"azureConfig": {

		"dockerPort": "string",

		"dockerSwarmMasterPort": "string",

		"image": "string",

		"location": "string",

		"password": "string",

		"publishSettingsFile": "string",

		"size": "string",

		"sshPort": "string",

		"subscriptionCert": "string",

		"subscriptionId": "string",

		"username": "string"

	},

	"description": "string",

	"digitaloceanConfig": {

		"accessToken": "string",

		"backups": true,

		"image": "string",

		"ipv6": true,

		"privateNetworking": true,

		"region": "string",

		"size": "string",

		"sshPort": "string",

		"sshUser": "string",

		"userdata": "string"

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

	"exoscaleConfig": {

		"apiKey": "string",

		"apiSecretKey": "string",

		"availabilityZone": "string",

		"diskSize": "string",

		"image": "string",

		"instanceProfile": "string",

		"securityGroup": [

			"string1",

			"string2",

			"...stringN"

		],

		"url": "string"

	},

	"genericConfig": {

		"ipAddress": "string",

		"sshKey": "string",

		"sshPort": "string",

		"sshUser": "string"

	},

	"googleConfig": {

		"address": "string",

		"diskSize": "string",

		"diskType": "string",

		"machineImage": "string",

		"machineType": "string",

		"preemptible": true,

		"project": "string",

		"scopes": "string",

		"tags": "string",

		"useExisting": true,

		"useInternalIp": true,

		"username": "string",

		"zone": "string"

	},

	"hypervConfig": {

		"boot2dockerUrl": "string",

		"cpuCount": "string",

		"diskSize": "string",

		"memory": "string",

		"virtualSwitch": "string"

	},

	"labels": {

		"key1": "value1",

		"key2": "value2",

		"keyN": "valueN"

	},

	"name": "string",

	"openstackConfig": {

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

		"insecure": true,

		"ipVersion": "string",

		"keypairName": "string",

		"netId": "string",

		"netName": "string",

		"novaNetwork": true,

		"password": "string",

		"privateKeyFile": "string",

		"region": "string",

		"secGroups": "string",

		"sshPort": "string",

		"sshUser": "string",

		"tenantId": "string",

		"tenantName": "string",

		"username": "string"

	},

	"packetConfig": {

		"apiKey": "string",

		"billingCycle": "string",

		"facilityCode": "string",

		"os": "string",

		"plan": "string",

		"projectId": "string"

	},

	"rackspaceConfig": {

		"apiKey": "string",

		"dockerInstall": "string",

		"endpointType": "string",

		"flavorId": "string",

		"imageId": "string",

		"region": "string",

		"sshPort": "string",

		"sshUser": "string",

		"username": "string"

	},

	"softlayerConfig": {

		"apiEndpoint": "string",

		"apiKey": "string",

		"cpu": "string",

		"diskSize": "string",

		"domain": "string",

		"hostname": "string",

		"hourlyBilling": true,

		"image": "string",

		"localDisk": true,

		"memory": "string",

		"privateNetOnly": true,

		"privateVlanId": "string",

		"publicVlanId": "string",

		"region": "string",

		"user": "string"

	},

	"ubiquityConfig": {

		"apiToken": "string",

		"apiUsername": "string",

		"clientId": "string",

		"flavorId": "string",

		"imageId": "string",

		"zoneId": "string"

	},

	"virtualboxConfig": {

		"boot2dockerUrl": "string",

		"cpuCount": "string",

		"diskSize": "string",

		"dnsProxy": true,

		"hostDnsResolver": true,

		"hostonlyCidr": "string",

		"hostonlyNicpromisc": "string",

		"hostonlyNictype": "string",

		"importBoot2dockerVm": "string",

		"memory": "string",

		"noShare": true,

		"noVtxCheck": true

	},

	"vmwarefusionConfig": {},

	"vmwarevcloudairConfig": {

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

	},

	"vmwarevsphereConfig": {

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

	}

} 
{% endhighlight %}
</div>
</div>















<div class="action">
<span class="header">
Delete
<span class="headerright">DELETE:  <code>${links.self}</code></span></span>
<div class="action-contents">
{% highlight json %} 
 
{% endhighlight %}
</div>
</div>



### Actions

<div class="action">
<span class="header">
bootstrap
<span class="headerright">POST:  <code>${actions.bootstrap}</code></span></span>
<div class="action-contents">
To bootstrap the machine
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>

<br>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/physicalHost/">physicalHost</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
error
<span class="headerright">POST:  <code>${actions.error}</code></span></span>
<div class="action-contents">
To error the machine
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>

<br>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/physicalHost/">physicalHost</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${actions.remove}</code></span></span>
<div class="action-contents">
To remove the machine
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>

<br>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/physicalHost/">physicalHost</a> resource</span>
</div>
</div>

