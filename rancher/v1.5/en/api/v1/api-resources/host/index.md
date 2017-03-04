---
title: Rancher API - host
layout: rancher-api-v1-default-v1.5
version: v1.5
lang: en
apiVersion: v1
#redirect_from:
#  - /rancher/v1.5/zh/api/v1/api-resources/host/
---

## Host

Hosts are the most basic unit of resource within Rancher and is represented as any Linux server, virtual or physical, with the following minimum requirements. <br> <br> * Any modern Linux distribution with a [supported version of Docker]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#supported-docker-versions). <br> * Must be able to communicate with the Rancher server via http or https through the pre-configured port (Default is 8080). <br> * Must be routable to any other hosts belonging to the same environment to leverage Rancher's cross-host networking for Docker containers.<br> <br> Rancher also supports Docker Machine and allows you to add your host via any of its supported drivers.

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
labels | map[string] | Optional | Yes | - | A map of key value pairs to be used as labels for the host
name | string | Optional | Yes | - | 
packetConfig | [packetConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/packetConfig/) | Optional | Yes | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
agentState | string  | 
computeTotal | int  | 
driver | string  | 
hostname | string  | 
id | int  | The unique identifier for the host
info | json  | 
physicalHostId | [physicalHost]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/physicalHost/)  | 
publicEndpoints | array[[publicEndpoint]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/publicEndpoint/)]  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/hosts</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"amazonec2Config": {
		"accessKey": "",
		"ami": "",
		"blockDurationMinutes": "0",
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
		"userdata": "",
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
		"sshKeyPath": "",
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
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/hosts'
{% endhighlight %}
</div></div>
<a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/projects/${PROJECT_ID}/hosts/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X DELETE \
'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/hosts/${ID}'
{% endhighlight %}
</div></div>
<a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v1/projects/${PROJECT_ID}/hosts/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Content-Type: application/json' \
-d '{
	"amazonec2Config": {
		"accessKey": "",
		"ami": "",
		"blockDurationMinutes": "0",
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
		"userdata": "",
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
		"sshKeyPath": "",
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
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/hosts/${ID}'
{% endhighlight %}
</div></div>



### Actions

<div class="action" id="activate">
<span class="header">
activate
<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/hosts/${ID}?action=activate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/hosts/${ID}?action=activate'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host/">host</a> resource</span>
</div></div>

<div class="action" id="deactivate">
<span class="header">
deactivate
<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/hosts/${ID}?action=deactivate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/hosts/${ID}?action=deactivate'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host/">host</a> resource</span>
</div></div>

<div class="action" id="dockersocket">
<span class="header">
dockersocket
<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/hosts/${ID}?action=dockersocket</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/hosts/${ID}?action=dockersocket'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/hostAccess/">hostAccess</a> resource</span>
</div></div>


