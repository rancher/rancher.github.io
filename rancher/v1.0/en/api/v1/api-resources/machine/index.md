---
title: Rancher API - machine
layout: rancher-api-v1-default-v1.0
version: v1.0
lang: en
apiVersion: v1
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
exoscaleConfig | [exoscaleConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/exoscaleConfig/) | Optional | - | - | 
genericConfig | [genericConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/genericConfig/) | Optional | - | - | 
googleConfig | [googleConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/googleConfig/) | Optional | - | - | 
hypervConfig | [hypervConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/hypervConfig/) | Optional | - | - | 
labels | map[string] | Optional | - | - | A map of key value pairs to be used as labels for the machine
name | string | Yes | - | - | 
openstackConfig | [openstackConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/openstackConfig/) | Optional | - | - | 
packetConfig | [packetConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/packetConfig/) | Optional | - | - | 
rackspaceConfig | [rackspaceConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/rackspaceConfig/) | Optional | - | - | 
softlayerConfig | [softlayerConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/softlayerConfig/) | Optional | - | - | 
ubiquityConfig | [ubiquityConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/ubiquityConfig/) | Optional | - | - | 
virtualboxConfig | [virtualboxConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/virtualboxConfig/) | Optional | - | - | 
vmwarefusionConfig | [vmwarefusionConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/vmwarefusionConfig/) | Optional | - | - | 
vmwarevcloudairConfig | [vmwarevcloudairConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/vmwarevcloudairConfig/) | Optional | - | - | 
vmwarevsphereConfig | [vmwarevsphereConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/vmwarevsphereConfig/) | Optional | - | - | 


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
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/machines</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"amazonec2Config": {
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
		"backups": false,
		"image": "string",
		"ipv6": false,
		"privateNetworking": false,
		"region": "string",
		"size": "string",
		"sshPort": "string",
		"sshUser": "string",
		"userdata": "string"
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
	"exoscaleConfig": {
		"apiKey": "string",
		"apiSecretKey": "string",
		"availabilityZone": "string",
		"diskSize": "string",
		"image": "string",
		"instanceProfile": "string",
		"securityGroup": [
			"string1",
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
		"preemptible": false,
		"project": "string",
		"scopes": "string",
		"tags": "string",
		"useExisting": false,
		"useInternalIp": false,
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
		"key": "value-pairs"
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
		"hourlyBilling": false,
		"image": "string",
		"localDisk": false,
		"memory": "string",
		"privateNetOnly": false,
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
		"dnsProxy": false,
		"hostDnsResolver": false,
		"hostonlyCidr": "string",
		"hostonlyNicpromisc": "string",
		"hostonlyNictype": "string",
		"importBoot2dockerVm": "string",
		"memory": "string",
		"noShare": false,
		"noVtxCheck": false
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
}' 'http://${RANCHER_URL}:8080/v1/machines'
{% endhighlight %}
</div></div>
<a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/machines/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X DELETE \
'http://${RANCHER_URL}:8080/v1/machines/${ID}'
{% endhighlight %}
</div></div>



