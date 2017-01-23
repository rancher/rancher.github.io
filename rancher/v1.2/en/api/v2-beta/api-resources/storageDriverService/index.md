---
title: Rancher API - storageDriverService
layout: rancher-api-v2-beta-default-v1.2
version: v1.2
lang: en
apiVersion: v2-beta
redirect_from:
  - /rancher/v1.2/zh/api/v2-beta/api-resources/storageDriverService/
---

## StorageDriverService



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
assignServiceIpAddress | boolean | Optional | - | - | 
description | string | Optional | Yes | - | 
externalId | string | Optional | - | - | 
launchConfig | [launchConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/launchConfig/) | Optional | - | - | 
lbConfig | [lbTargetConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/lbTargetConfig/) | Optional | Yes | - | 
metadata | map[json] | Optional | Yes | - | 
name | string | Yes | Yes | - | 
retainIp | boolean | Optional | Yes | - | 
scale | int | Optional | Yes | 1 | 
scalePolicy | [scalePolicy]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/scalePolicy/) | Optional | Yes | - | 
secondaryLaunchConfigs | array[[secondaryLaunchConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/secondaryLaunchConfig/)] | Optional | - | - | 
selectorContainer | string | Optional | Yes | - | 
selectorLink | string | Optional | Yes | - | 
stackId | [stack]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/stack/) | Optional | - | - | 
startOnCreate | boolean | Optional | - | - | 
storageDriver | [storageDriver]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/storageDriver/) | Yes | Yes | - | 
vip | string | Optional | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
createIndex | int  | 
currentScale | int  | 
fqdn | string  | 
healthState | string  | 
id | int  | The unique identifier for the storageDriverService
instanceIds | array[[instance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instance/)]  | 
linkedServices | map[[service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/)]  | 
publicEndpoints | array[[publicEndpoint]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/publicEndpoint/)]  | 
system | boolean  | 
upgrade | [serviceUpgrade]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/serviceUpgrade/)  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/storageDriverServices</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"assignServiceIpAddress": false,
	"description": "string",
	"externalId": "string",
	"launchConfig": {
		"accountId": "reference[account]",
		"blkioDeviceOptions": "map[blkioDeviceOption]",
		"blkioWeight": 0,
		"build": {
			"context": "string",
			"dockerfile": "string",
			"forcerm": false,
			"nocache": false,
			"remote": "string",
			"rm": false
		},
		"capAdd": "array[enum]",
		"capDrop": "array[enum]",
		"cgroupParent": "string",
		"command": [
			"string1",
			"...stringN"
		],
		"count": 0,
		"cpuCount": 0,
		"cpuPercent": 0,
		"cpuPeriod": 0,
		"cpuQuota": 0,
		"cpuSet": "string",
		"cpuSetMems": "string",
		"cpuShares": 0,
		"createIndex": 0,
		"created": "date",
		"dataVolumeMounts": "map[reference[volume]]",
		"dataVolumes": [
			"string1",
			"...stringN"
		],
		"dataVolumesFrom": "array[reference[container]]",
		"dataVolumesFromLaunchConfigs": [
			"string1",
			"...stringN"
		],
		"deploymentUnitUuid": "string",
		"description": "string",
		"devices": [
			"string1",
			"...stringN"
		],
		"diskQuota": 0,
		"disks": "array[virtualMachineDisk]",
		"dns": [
			"string1",
			"...stringN"
		],
		"dnsOpt": [
			"string1",
			"...stringN"
		],
		"dnsSearch": [
			"string1",
			"...stringN"
		],
		"domainName": "string",
		"entryPoint": [
			"string1",
			"...stringN"
		],
		"environment": {
			"key": "value-pairs"
		},
		"expose": [
			"string1",
			"...stringN"
		],
		"externalId": "string",
		"extraHosts": [
			"string1",
			"...stringN"
		],
		"firstRunning": "date",
		"groupAdd": [
			"string1",
			"...stringN"
		],
		"healthCheck": {
			"healthyThreshold": 0,
			"initializingTimeout": 0,
			"interval": 0,
			"name": "string",
			"port": 0,
			"recreateOnQuorumStrategyConfig": {
				"quorum": 0
			},
			"reinitializingTimeout": 0,
			"requestLine": "string",
			"responseTimeout": 0,
			"strategy": "recreate",
			"unhealthyThreshold": 0
		},
		"healthCmd": [
			"string1",
			"...stringN"
		],
		"healthInterval": 0,
		"healthRetries": 0,
		"healthState": "enum",
		"healthTimeout": 0,
		"hostId": "reference[host]",
		"hostname": "string",
		"id": 0,
		"imageUuid": "string",
		"instanceLinks": "map[reference[instance]]",
		"instanceTriggeredStop": "stop",
		"ioMaximumBandwidth": 0,
		"ioMaximumIOps": 0,
		"ip": "string",
		"ip6": "string",
		"ipcMode": "string",
		"isolation": "string",
		"kernelMemory": 0,
		"kind": "container",
		"labels": {
			"key": "value-pairs"
		},
		"logConfig": {
			"config": {
				"key": "value-pairs"
			},
			"driver": "string"
		},
		"lxcConf": {
			"key": "value-pairs"
		},
		"memory": 0,
		"memoryMb": 0,
		"memoryReservation": 0,
		"memorySwap": 0,
		"memorySwappiness": 0,
		"milliCpuReservation": 0,
		"mounts": "array[mountEntry]",
		"nativeContainer": false,
		"netAlias": [
			"string1",
			"...stringN"
		],
		"networkContainerId": "reference[container]",
		"networkIds": "array[reference[network]]",
		"networkLaunchConfig": "string",
		"networkMode": "managed",
		"oomKillDisable": false,
		"oomScoreAdj": 0,
		"pidMode": "enum",
		"pidsLimit": 0,
		"ports": [
			"string1",
			"...stringN"
		],
		"primaryIpAddress": "string",
		"primaryNetworkId": "reference[network]",
		"privileged": false,
		"publishAllPorts": false,
		"readOnly": false,
		"registryCredentialId": "reference[registryCredential]",
		"removed": "date",
		"requestedHostId": "reference[host]",
		"requestedIpAddress": "string",
		"securityOpt": [
			"string1",
			"...stringN"
		],
		"serviceIds": "array[reference[service]]",
		"shmSize": 0,
		"startCount": 0,
		"startOnCreate": true,
		"state": "enum",
		"stdinOpen": false,
		"stopSignal": "string",
		"storageOpt": {
			"key": "value-pairs"
		},
		"sysctls": {
			"key": "value-pairs"
		},
		"system": false,
		"tmpfs": {
			"key": "value-pairs"
		},
		"transitioning": "enum",
		"transitioningMessage": "string",
		"transitioningProgress": 0,
		"tty": false,
		"ulimits": "array[ulimit]",
		"user": "string",
		"userdata": "string",
		"usernsMode": "string",
		"uts": "string",
		"uuid": "string",
		"vcpu": 1,
		"version": "0",
		"volumeDriver": "string",
		"workingDir": "string"
	},
	"lbConfig": {
		"portRules": "array[targetPortRule]"
	},
	"metadata": {
		"key": "value-pairs"
	},
	"name": "string",
	"retainIp": false,
	"scale": 1,
	"scalePolicy": {
		"increment": 1,
		"max": 1,
		"min": 1
	},
	"secondaryLaunchConfigs": "array[secondaryLaunchConfig]",
	"selectorContainer": "string",
	"selectorLink": "string",
	"stackId": "reference[stack]",
	"startOnCreate": false,
	"storageDriver": {
		"accountId": "reference[account]",
		"blockDevicePath": "string",
		"created": "date",
		"description": "string",
		"id": 0,
		"kind": "string",
		"name": "string",
		"removed": "date",
		"scope": "enum",
		"serviceId": "reference[service]",
		"state": "enum",
		"transitioning": "enum",
		"transitioningMessage": "string",
		"transitioningProgress": 0,
		"uuid": "string",
		"volumeAccessMode": "multiHostRW",
		"volumeCapabilities": [
			"string1",
			"...stringN"
		]
	},
	"vip": "string"
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/storageDriverServices'
{% endhighlight %}
</div></div>
<a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X DELETE \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}'
{% endhighlight %}
</div></div>
<a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Content-Type: application/json' \
-d '{
	"description": "string",
	"lbConfig": {
		"portRules": "array[targetPortRule]"
	},
	"metadata": {
		"key": "value-pairs"
	},
	"name": "string",
	"retainIp": false,
	"scale": 1,
	"scalePolicy": {
		"increment": 1,
		"max": 1,
		"min": 1
	},
	"selectorContainer": "string",
	"selectorLink": "string",
	"storageDriver": {
		"accountId": "reference[account]",
		"blockDevicePath": "string",
		"created": "date",
		"description": "string",
		"id": 0,
		"kind": "string",
		"name": "string",
		"removed": "date",
		"scope": "enum",
		"serviceId": "reference[service]",
		"state": "enum",
		"transitioning": "enum",
		"transitioningMessage": "string",
		"transitioningProgress": 0,
		"uuid": "string",
		"volumeAccessMode": "multiHostRW",
		"volumeCapabilities": [
			"string1",
			"...stringN"
		]
	}
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}'
{% endhighlight %}
</div></div>



### Actions

<div class="action" id="activate">
<span class="header">
activate
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}?action=activate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}?action=activate'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action" id="addservicelink">
<span class="header">
addservicelink
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}?action=addservicelink</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/addRemoveServiceLinkInput/">AddRemoveServiceLinkInput</a></span>

Field | Type | Required | Default | Notes
---|---|---|---|---
serviceLink | [serviceLink]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/serviceLink/) | Yes |  | 


<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"serviceLink": {
		"name": "string",
		"serviceId": "reference[service]",
		"uuid": "string"
	}
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}?action=addservicelink'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action" id="cancelupgrade">
<span class="header">
cancelupgrade
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}?action=cancelupgrade</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}?action=cancelupgrade'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action" id="continueupgrade">
<span class="header">
continueupgrade
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}?action=continueupgrade</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}?action=continueupgrade'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action" id="deactivate">
<span class="header">
deactivate
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}?action=deactivate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}?action=deactivate'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action" id="finishupgrade">
<span class="header">
finishupgrade
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}?action=finishupgrade</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}?action=finishupgrade'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action" id="removeservicelink">
<span class="header">
removeservicelink
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}?action=removeservicelink</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/addRemoveServiceLinkInput/">AddRemoveServiceLinkInput</a></span>

Field | Type | Required | Default | Notes
---|---|---|---|---
serviceLink | [serviceLink]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/serviceLink/) | Yes |  | 


<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"serviceLink": {
		"name": "string",
		"serviceId": "reference[service]",
		"uuid": "string"
	}
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}?action=removeservicelink'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action" id="restart">
<span class="header">
restart
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}?action=restart</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/serviceRestart/">ServiceRestart</a></span>

Field | Type | Required | Default | Notes
---|---|---|---|---
rollingRestartStrategy | [rollingRestartStrategy]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/rollingRestartStrategy/) | Yes |  | 


<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"rollingRestartStrategy": {
		"batchSize": 1,
		"intervalMillis": 2000
	}
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}?action=restart'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action" id="rollback">
<span class="header">
rollback
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}?action=rollback</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}?action=rollback'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action" id="setservicelinks">
<span class="header">
setservicelinks
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}?action=setservicelinks</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/setServiceLinksInput/">SetServiceLinksInput</a></span>

Field | Type | Required | Default | Notes
---|---|---|---|---
serviceLinks | array[[serviceLink]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/serviceLink/)] | No |  | 


<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"serviceLinks": "array[serviceLink]"
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}?action=setservicelinks'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action" id="upgrade">
<span class="header">
upgrade
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}?action=upgrade</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/serviceUpgrade/">ServiceUpgrade</a></span>

Field | Type | Required | Default | Notes
---|---|---|---|---
inServiceStrategy | [inServiceUpgradeStrategy]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/inServiceUpgradeStrategy/) | No |  | 
toServiceStrategy | [toServiceUpgradeStrategy]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/toServiceUpgradeStrategy/) | No |  | 


<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"inServiceStrategy": {
		"batchSize": 1,
		"intervalMillis": 2000,
		"launchConfig": {
			"accountId": "reference[account]",
			"blkioDeviceOptions": "map[blkioDeviceOption]",
			"blkioWeight": 0,
			"build": {
				"context": "string",
				"dockerfile": "string",
				"forcerm": false,
				"nocache": false,
				"remote": "string",
				"rm": false
			},
			"capAdd": "array[enum]",
			"capDrop": "array[enum]",
			"cgroupParent": "string",
			"command": [
				"string1",
				"...stringN"
			],
			"count": 0,
			"cpuCount": 0,
			"cpuPercent": 0,
			"cpuPeriod": 0,
			"cpuQuota": 0,
			"cpuSet": "string",
			"cpuSetMems": "string",
			"cpuShares": 0,
			"createIndex": 0,
			"created": "date",
			"dataVolumeMounts": "map[reference[volume]]",
			"dataVolumes": [
				"string1",
				"...stringN"
			],
			"dataVolumesFrom": "array[reference[container]]",
			"dataVolumesFromLaunchConfigs": [
				"string1",
				"...stringN"
			],
			"deploymentUnitUuid": "string",
			"description": "string",
			"devices": [
				"string1",
				"...stringN"
			],
			"diskQuota": 0,
			"disks": "array[virtualMachineDisk]",
			"dns": [
				"string1",
				"...stringN"
			],
			"dnsOpt": [
				"string1",
				"...stringN"
			],
			"dnsSearch": [
				"string1",
				"...stringN"
			],
			"domainName": "string",
			"entryPoint": [
				"string1",
				"...stringN"
			],
			"environment": {
				"key": "value-pairs"
			},
			"expose": [
				"string1",
				"...stringN"
			],
			"externalId": "string",
			"extraHosts": [
				"string1",
				"...stringN"
			],
			"firstRunning": "date",
			"groupAdd": [
				"string1",
				"...stringN"
			],
			"healthCheck": {
				"healthyThreshold": 0,
				"initializingTimeout": 0,
				"interval": 0,
				"name": "string",
				"port": 0,
				"recreateOnQuorumStrategyConfig": {
					"quorum": 0
				},
				"reinitializingTimeout": 0,
				"requestLine": "string",
				"responseTimeout": 0,
				"strategy": "recreate",
				"unhealthyThreshold": 0
			},
			"healthCmd": [
				"string1",
				"...stringN"
			],
			"healthInterval": 0,
			"healthRetries": 0,
			"healthState": "enum",
			"healthTimeout": 0,
			"hostId": "reference[host]",
			"hostname": "string",
			"id": 0,
			"imageUuid": "string",
			"instanceLinks": "map[reference[instance]]",
			"instanceTriggeredStop": "stop",
			"ioMaximumBandwidth": 0,
			"ioMaximumIOps": 0,
			"ip": "string",
			"ip6": "string",
			"ipcMode": "string",
			"isolation": "string",
			"kernelMemory": 0,
			"kind": "container",
			"labels": {
				"key": "value-pairs"
			},
			"logConfig": {
				"config": {
					"key": "value-pairs"
				},
				"driver": "string"
			},
			"lxcConf": {
				"key": "value-pairs"
			},
			"memory": 0,
			"memoryMb": 0,
			"memoryReservation": 0,
			"memorySwap": 0,
			"memorySwappiness": 0,
			"milliCpuReservation": 0,
			"mounts": "array[mountEntry]",
			"nativeContainer": false,
			"netAlias": [
				"string1",
				"...stringN"
			],
			"networkContainerId": "reference[container]",
			"networkIds": "array[reference[network]]",
			"networkLaunchConfig": "string",
			"networkMode": "managed",
			"oomKillDisable": false,
			"oomScoreAdj": 0,
			"pidMode": "enum",
			"pidsLimit": 0,
			"ports": [
				"string1",
				"...stringN"
			],
			"primaryIpAddress": "string",
			"primaryNetworkId": "reference[network]",
			"privileged": false,
			"publishAllPorts": false,
			"readOnly": false,
			"registryCredentialId": "reference[registryCredential]",
			"removed": "date",
			"requestedHostId": "reference[host]",
			"requestedIpAddress": "string",
			"securityOpt": [
				"string1",
				"...stringN"
			],
			"serviceIds": "array[reference[service]]",
			"shmSize": 0,
			"startCount": 0,
			"startOnCreate": true,
			"state": "enum",
			"stdinOpen": false,
			"stopSignal": "string",
			"storageOpt": {
				"key": "value-pairs"
			},
			"sysctls": {
				"key": "value-pairs"
			},
			"system": false,
			"tmpfs": {
				"key": "value-pairs"
			},
			"transitioning": "enum",
			"transitioningMessage": "string",
			"transitioningProgress": 0,
			"tty": false,
			"ulimits": "array[ulimit]",
			"user": "string",
			"userdata": "string",
			"usernsMode": "string",
			"uts": "string",
			"uuid": "string",
			"vcpu": 1,
			"version": "0",
			"volumeDriver": "string",
			"workingDir": "string"
		},
		"previousLaunchConfig": {
			"accountId": "reference[account]",
			"blkioDeviceOptions": "map[blkioDeviceOption]",
			"blkioWeight": 0,
			"build": {
				"context": "string",
				"dockerfile": "string",
				"forcerm": false,
				"nocache": false,
				"remote": "string",
				"rm": false
			},
			"capAdd": "array[enum]",
			"capDrop": "array[enum]",
			"cgroupParent": "string",
			"command": [
				"string1",
				"...stringN"
			],
			"count": 0,
			"cpuCount": 0,
			"cpuPercent": 0,
			"cpuPeriod": 0,
			"cpuQuota": 0,
			"cpuSet": "string",
			"cpuSetMems": "string",
			"cpuShares": 0,
			"createIndex": 0,
			"created": "date",
			"dataVolumeMounts": "map[reference[volume]]",
			"dataVolumes": [
				"string1",
				"...stringN"
			],
			"dataVolumesFrom": "array[reference[container]]",
			"dataVolumesFromLaunchConfigs": [
				"string1",
				"...stringN"
			],
			"deploymentUnitUuid": "string",
			"description": "string",
			"devices": [
				"string1",
				"...stringN"
			],
			"diskQuota": 0,
			"disks": "array[virtualMachineDisk]",
			"dns": [
				"string1",
				"...stringN"
			],
			"dnsOpt": [
				"string1",
				"...stringN"
			],
			"dnsSearch": [
				"string1",
				"...stringN"
			],
			"domainName": "string",
			"entryPoint": [
				"string1",
				"...stringN"
			],
			"environment": {
				"key": "value-pairs"
			},
			"expose": [
				"string1",
				"...stringN"
			],
			"externalId": "string",
			"extraHosts": [
				"string1",
				"...stringN"
			],
			"firstRunning": "date",
			"groupAdd": [
				"string1",
				"...stringN"
			],
			"healthCheck": {
				"healthyThreshold": 0,
				"initializingTimeout": 0,
				"interval": 0,
				"name": "string",
				"port": 0,
				"recreateOnQuorumStrategyConfig": {
					"quorum": 0
				},
				"reinitializingTimeout": 0,
				"requestLine": "string",
				"responseTimeout": 0,
				"strategy": "recreate",
				"unhealthyThreshold": 0
			},
			"healthCmd": [
				"string1",
				"...stringN"
			],
			"healthInterval": 0,
			"healthRetries": 0,
			"healthState": "enum",
			"healthTimeout": 0,
			"hostId": "reference[host]",
			"hostname": "string",
			"id": 0,
			"imageUuid": "string",
			"instanceLinks": "map[reference[instance]]",
			"instanceTriggeredStop": "stop",
			"ioMaximumBandwidth": 0,
			"ioMaximumIOps": 0,
			"ip": "string",
			"ip6": "string",
			"ipcMode": "string",
			"isolation": "string",
			"kernelMemory": 0,
			"kind": "container",
			"labels": {
				"key": "value-pairs"
			},
			"logConfig": {
				"config": {
					"key": "value-pairs"
				},
				"driver": "string"
			},
			"lxcConf": {
				"key": "value-pairs"
			},
			"memory": 0,
			"memoryMb": 0,
			"memoryReservation": 0,
			"memorySwap": 0,
			"memorySwappiness": 0,
			"milliCpuReservation": 0,
			"mounts": "array[mountEntry]",
			"nativeContainer": false,
			"netAlias": [
				"string1",
				"...stringN"
			],
			"networkContainerId": "reference[container]",
			"networkIds": "array[reference[network]]",
			"networkLaunchConfig": "string",
			"networkMode": "managed",
			"oomKillDisable": false,
			"oomScoreAdj": 0,
			"pidMode": "enum",
			"pidsLimit": 0,
			"ports": [
				"string1",
				"...stringN"
			],
			"primaryIpAddress": "string",
			"primaryNetworkId": "reference[network]",
			"privileged": false,
			"publishAllPorts": false,
			"readOnly": false,
			"registryCredentialId": "reference[registryCredential]",
			"removed": "date",
			"requestedHostId": "reference[host]",
			"requestedIpAddress": "string",
			"securityOpt": [
				"string1",
				"...stringN"
			],
			"serviceIds": "array[reference[service]]",
			"shmSize": 0,
			"startCount": 0,
			"startOnCreate": true,
			"state": "enum",
			"stdinOpen": false,
			"stopSignal": "string",
			"storageOpt": {
				"key": "value-pairs"
			},
			"sysctls": {
				"key": "value-pairs"
			},
			"system": false,
			"tmpfs": {
				"key": "value-pairs"
			},
			"transitioning": "enum",
			"transitioningMessage": "string",
			"transitioningProgress": 0,
			"tty": false,
			"ulimits": "array[ulimit]",
			"user": "string",
			"userdata": "string",
			"usernsMode": "string",
			"uts": "string",
			"uuid": "string",
			"vcpu": 1,
			"version": "0",
			"volumeDriver": "string",
			"workingDir": "string"
		},
		"previousSecondaryLaunchConfigs": "array[secondaryLaunchConfig]",
		"secondaryLaunchConfigs": "array[secondaryLaunchConfig]",
		"startFirst": false
	},
	"toServiceStrategy": {
		"batchSize": 1,
		"finalScale": 1,
		"intervalMillis": 2000,
		"toServiceId": "reference[service]",
		"updateLinks": false
	}
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/storageDriverServices/${ID}?action=upgrade'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/">service</a> resource</span>
</div></div>


