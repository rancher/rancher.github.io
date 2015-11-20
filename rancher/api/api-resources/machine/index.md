---
title: API
layout: rancher-default
---

## machine

Machines are created whenever Rancher uses `docker-machine` to create hosts in Rancher. Adding any type of host through the UI that is not the custom command option is calling `docker-machine` and a machine entry will be created as well as a [host]({{site.baseurl}}/rancher/api/host).

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
id | int | - | - | - | The unique identifier for the machine
kind | string | - | - | - | 
name | string | Yes | Yes | - | 
state | enum | - | - | - | The current state of the machine. The options are [active, bootstrapping, created, creating, error, erroring, removed, removing, requested, updating].
amazonec2Config | [amazonec2Config]({{site.baseurl}}/rancher/api/amazonec2Config/) | Optional | - | - | Configuration for launching a host in Amazon EC2
authCertificateAuthority | string | Optional | - | - | 
authKey | string | Optional | - | - | 
azureConfig | [azureConfig]({{site.baseurl}}/rancher/api/azureConfig/) | Optional | - | - | Configuration for launching a host in Microsoft Azure
digitaloceanConfig | [digitaloceanConfig]({{site.baseurl}}/rancher/api/digitaloceanConfig/) | Optional | - | - | Configuration for launching a host in DigitalOcean
dockerVersion | string | Optional | - | - | 
driver | string | - | - | - | 
engineOpts | array[string] | Optional | - | - | 
exoscaleConfig | [exoscaleConfig]({{site.baseurl}}/rancher/api/exoscaleConfig/) | Optional | - | - | Configuration for launching a host in exoscale
externalId | string | - | - | - | 
labels | map[string] | Optional | - | - | 
openstackConfig | [openstackConfig]({{site.baseurl}}/rancher/api/openstackConfig/) | Optional | - | - | Configuration for launching a host in OpenStack
packetConfig | [packetConfig]({{site.baseurl}}/rancher/api/packetConfig/) | Optional | - | - | Configuration for launching a host in Packet
rackspaceConfig | [rackspaceConfig]({{site.baseurl}}/rancher/api/rackspaceConfig/) | Optional | - | - | Configuration for launching a host in Rackspace
softlayerConfig | [softlayerConfig]({{site.baseurl}}/rancher/api/softlayerConfig/) | Optional | - | - | Configuration for launching a host in IBM Softlayer
ubiquityConfig | [ubiquityConfig]({{site.baseurl}}/rancher/api/ubiquityConfig/) | Optional | - | - | 
virtualboxConfig | [virtualboxConfig]({{site.baseurl}}/rancher/api/virtualboxConfig/) | Optional | - | - | Configuration for launching a host in Oracle VirtualBox
vmwarevcloudairConfig | [vmwarevcloudairConfig]({{site.baseurl}}/rancher/api/vmwarevcloudairConfig/) | Optional | - | - | Configuration for launching a host in VMware vCloud Air
vmwarevsphereConfig | [vmwarevsphereConfig]({{site.baseurl}}/rancher/api/vmwarevsphereConfig/) | Optional | - | - | Configuration for launching a host in VMware vSphere
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the machine was created.
description | string | Optional | Yes | - | 
removed | date | - | - | - | The date of when the machine was removed
transitioning | enum | - | - | - | Whether or not the machine is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the machine
uuid | string | - | - | - | The universally unique identifier for the machine. This will always be unique across Rancher installations.





### Operations



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"amazonec2Config": {

		"accessKey": "string",

		"ami": "string",

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

		"sshUser": "string",

		"subnetId": "string",

		"usePrivateAddress": true,

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

		"sshUser": "string"

	},

	"dockerVersion": "string",

	"engineOpts": "[string, string, string...]",

	"exoscaleConfig": {

		"apiKey": "string",

		"apiSecretKey": "string",

		"availabilityZone": "string",

		"diskSize": "string",

		"image": "string",

		"instanceProfile": "string",

		"securityGroup": "[string, string, string...]",

		"url": "string"

	},

	"labels": "map[string]",

	"name": "string",

	"openstackConfig": {

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

		"netId": "string",

		"netName": "string",

		"password": "string",

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

		"hostonlyCidr": "string",

		"importBoot2dockerVm": "string",

		"memory": "string",

		"noShare": true

	},

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

		"provision": true,

		"publicip": "string",

		"sshPort": "string",

		"username": "string",

		"vdcid": "string"

	},

	"vmwarevsphereConfig": {

		"boot2dockerUrl": "string",

		"computeIp": "string",

		"cpuCount": "string",

		"datacenter": "string",

		"datastore": "string",

		"diskSize": "string",

		"memorySize": "string",

		"network": "string",

		"password": "string",

		"pool": "string",

		"username": "string",

		"vcenter": "string"

	}

} 
{% endhighlight %}
</div>
</span>















<span class="action">
<span class="header">
Delete
<span class="headerright">DELETE:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
 
{% endhighlight %}
</div>
</span>




​
### Actions

<span class="action">
<span class="header">
bootstrap
<span class="headerright">POST:  <code>${action.bootstrap}</code></span>
</span>
<div class="action-contents">
To bootstrap the machine
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/physicalHost/">physicalHost</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
error
<span class="headerright">POST:  <code>${action.error}</code></span>
</span>
<div class="action-contents">
To error the machine
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/physicalHost/">physicalHost</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${action.remove}</code></span>
</span>
<div class="action-contents">
To remove the machine
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/physicalHost/">physicalHost</a> resource
</span>
</div>
</span>
</span>
</span>

