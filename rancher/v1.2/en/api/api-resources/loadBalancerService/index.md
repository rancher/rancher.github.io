---
title: Rancher API - loadBalancerService
layout: rancher-api-default
version: v1.2
lang: en
---

## LoadBalancerService

Rancher implements a managed load balancer using HAProxy that can be manually scaled to multiple hosts.  A load balancer can be used to distribute network and application traffic to individual containers by directly adding them or "linked" to a basic service.  A basic service that is "linked" will have all its underlying containers automatically registered as load balancer targets by Rancher.

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
assignServiceIpAddress | boolean | Optional | - | - | 
certificateIds | array[[certificate]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/certificate/)] | Optional | Yes | - | 
currentScale | int | - | - | - | 
defaultCertificateId | [certificate]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/certificate/) | Optional | Yes | - | 
description | string | Optional | Yes | - | 
environmentId | [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/environment/) | Yes | - | - | 
externalId | string | Optional | - | - | 
fqdn | string | - | - | - | 
healthState | string | - | - | - | 
id | int | - | - | - | The unique identifier for the loadBalancerService
launchConfig | [launchConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/launchConfig/) | Optional | - | - | 
loadBalancerConfig | [loadBalancerConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/loadBalancerConfig/) | Optional | Yes | - | 
metadata | map[json] | Optional | Yes | - | 
name | string | Yes | Yes | - | 
publicEndpoints | array[[publicEndpoint]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/publicEndpoint/)] | - | - | - | 
retainIp | boolean | Optional | Yes | - | 
scale | int | Optional | Yes | 1 | 
scalePolicy | [scalePolicy]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/scalePolicy/) | Optional | Yes | - | 
selectorLink | string | Optional | Yes | - | 
startOnCreate | boolean | Optional | - | - | 
upgrade | [serviceUpgrade]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/serviceUpgrade/) | - | - | - | 
vip | string | Optional | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/loadBalancerServices</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"assignServiceIpAddress": false,
	"certificateIds": "array[reference[certificate]]",
	"defaultCertificateId": "reference[certificate]",
	"description": "string",
	"environmentId": "reference[environment]",
	"externalId": "string",
	"launchConfig": {
		"accountId": "reference[account]",
		"blkioDeviceOptions": "map[blkioDeviceOption]",
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
		"command": [
			"string1",
			"...stringN"
		],
		"count": 0,
		"cpuSet": "string",
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
		"disks": "array[virtualMachineDisk]",
		"dns": [
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
		"healthState": "enum",
		"hostId": "reference[host]",
		"hostname": "string",
		"id": 0,
		"imageUuid": "string",
		"instanceLinks": "map[reference[instance]]",
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
		"memorySwap": 0,
		"nativeContainer": false,
		"networkContainerId": "reference[container]",
		"networkIds": "array[reference[network]]",
		"networkLaunchConfig": "string",
		"networkMode": "managed",
		"pidMode": "enum",
		"ports": [
			"string1",
			"...stringN"
		],
		"primaryIpAddress": "string",
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
		"startCount": 0,
		"startOnCreate": true,
		"state": "enum",
		"stdinOpen": false,
		"systemContainer": "enum",
		"transitioning": "enum",
		"transitioningMessage": "string",
		"transitioningProgress": 0,
		"tty": false,
		"user": "string",
		"userdata": "string",
		"uuid": "string",
		"vcpu": 1,
		"version": "0",
		"volumeDriver": "string",
		"workingDir": "string"
	},
	"loadBalancerConfig": {
		"haproxyConfig": {
			"defaults": "string",
			"global": "string"
		},
		"lbCookieStickinessPolicy": {
			"cookie": "string",
			"domain": "string",
			"indirect": false,
			"mode": "enum",
			"name": "string",
			"nocache": false,
			"postonly": false
		}
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
	"selectorLink": "string",
	"startOnCreate": false,
	"vip": "string"
}' 'http://${RANCHER_URL}:8080/v1/loadBalancerServices'
{% endhighlight %}
</div></div>

<a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/loadBalancerServices/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X DELETE \
'http://${RANCHER_URL}:8080/v1/loadBalancerServices/${ID}'
{% endhighlight %}
</div></div>

<a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v1/loadBalancerServices/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Content-Type: application/json' \
-d '{
	"certificateIds": "array[reference[certificate]]",
	"defaultCertificateId": "reference[certificate]",
	"description": "string",
	"loadBalancerConfig": {
		"haproxyConfig": {
			"defaults": "string",
			"global": "string"
		},
		"lbCookieStickinessPolicy": {
			"cookie": "string",
			"domain": "string",
			"indirect": false,
			"mode": "enum",
			"name": "string",
			"nocache": false,
			"postonly": false
		}
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
	"selectorLink": "string"
}' 'http://${RANCHER_URL}:8080/v1/loadBalancerServices/${ID}'
{% endhighlight %}
</div></div>



### Actions
<div class="action">
<span class="header">
activate
<span class="headerright">POST:  <code>/v1/loadBalancerServices/${ID}?action=activate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/loadBalancerServices/${ID}?action=activate'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action">
<span class="header">
addservicelink
<span class="headerright">POST:  <code>/v1/loadBalancerServices/${ID}?action=addservicelink</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/addRemoveLoadBalancerServiceLinkInput/">AddRemoveLoadBalancerServiceLinkInput</a></span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"serviceLink": {
		"ports": [
			"string1",
			"...stringN"
		],
		"serviceId": "reference[service]",
		"uuid": "string"
	}
}' 'http://${RANCHER_URL}:8080/v1/loadBalancerServices/${ID}?action=addservicelink'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action">
<span class="header">
cancelrollback
<span class="headerright">POST:  <code>/v1/loadBalancerServices/${ID}?action=cancelrollback</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/loadBalancerServices/${ID}?action=cancelrollback'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action">
<span class="header">
cancelupgrade
<span class="headerright">POST:  <code>/v1/loadBalancerServices/${ID}?action=cancelupgrade</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/loadBalancerServices/${ID}?action=cancelupgrade'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action">
<span class="header">
deactivate
<span class="headerright">POST:  <code>/v1/loadBalancerServices/${ID}?action=deactivate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/loadBalancerServices/${ID}?action=deactivate'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action">
<span class="header">
finishupgrade
<span class="headerright">POST:  <code>/v1/loadBalancerServices/${ID}?action=finishupgrade</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/loadBalancerServices/${ID}?action=finishupgrade'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action">
<span class="header">
removeservicelink
<span class="headerright">POST:  <code>/v1/loadBalancerServices/${ID}?action=removeservicelink</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/addRemoveLoadBalancerServiceLinkInput/">AddRemoveLoadBalancerServiceLinkInput</a></span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"serviceLink": {
		"ports": [
			"string1",
			"...stringN"
		],
		"serviceId": "reference[service]",
		"uuid": "string"
	}
}' 'http://${RANCHER_URL}:8080/v1/loadBalancerServices/${ID}?action=removeservicelink'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action">
<span class="header">
rollback
<span class="headerright">POST:  <code>/v1/loadBalancerServices/${ID}?action=rollback</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/loadBalancerServices/${ID}?action=rollback'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action">
<span class="header">
setservicelinks
<span class="headerright">POST:  <code>/v1/loadBalancerServices/${ID}?action=setservicelinks</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/setLoadBalancerServiceLinksInput/">SetLoadBalancerServiceLinksInput</a></span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"serviceLinks": "array[loadBalancerServiceLink]"
}' 'http://${RANCHER_URL}:8080/v1/loadBalancerServices/${ID}?action=setservicelinks'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action">
<span class="header">
upgrade
<span class="headerright">POST:  <code>/v1/loadBalancerServices/${ID}?action=upgrade</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/serviceUpgrade/">ServiceUpgrade</a></span>

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
			"command": [
				"string1",
				"...stringN"
			],
			"count": 0,
			"cpuSet": "string",
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
			"disks": "array[virtualMachineDisk]",
			"dns": [
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
			"healthState": "enum",
			"hostId": "reference[host]",
			"hostname": "string",
			"id": 0,
			"imageUuid": "string",
			"instanceLinks": "map[reference[instance]]",
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
			"memorySwap": 0,
			"nativeContainer": false,
			"networkContainerId": "reference[container]",
			"networkIds": "array[reference[network]]",
			"networkLaunchConfig": "string",
			"networkMode": "managed",
			"pidMode": "enum",
			"ports": [
				"string1",
				"...stringN"
			],
			"primaryIpAddress": "string",
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
			"startCount": 0,
			"startOnCreate": true,
			"state": "enum",
			"stdinOpen": false,
			"systemContainer": "enum",
			"transitioning": "enum",
			"transitioningMessage": "string",
			"transitioningProgress": 0,
			"tty": false,
			"user": "string",
			"userdata": "string",
			"uuid": "string",
			"vcpu": 1,
			"version": "0",
			"volumeDriver": "string",
			"workingDir": "string"
		},
		"previousLaunchConfig": {
			"accountId": "reference[account]",
			"blkioDeviceOptions": "map[blkioDeviceOption]",
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
			"command": [
				"string1",
				"...stringN"
			],
			"count": 0,
			"cpuSet": "string",
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
			"disks": "array[virtualMachineDisk]",
			"dns": [
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
			"healthState": "enum",
			"hostId": "reference[host]",
			"hostname": "string",
			"id": 0,
			"imageUuid": "string",
			"instanceLinks": "map[reference[instance]]",
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
			"memorySwap": 0,
			"nativeContainer": false,
			"networkContainerId": "reference[container]",
			"networkIds": "array[reference[network]]",
			"networkLaunchConfig": "string",
			"networkMode": "managed",
			"pidMode": "enum",
			"ports": [
				"string1",
				"...stringN"
			],
			"primaryIpAddress": "string",
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
			"startCount": 0,
			"startOnCreate": true,
			"state": "enum",
			"stdinOpen": false,
			"systemContainer": "enum",
			"transitioning": "enum",
			"transitioningMessage": "string",
			"transitioningProgress": 0,
			"tty": false,
			"user": "string",
			"userdata": "string",
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
}' 'http://${RANCHER_URL}:8080/v1/loadBalancerServices/${ID}?action=upgrade'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/service/">service</a> resource</span>
</div></div>




### Actions
<div class="action">
<span class="header">
activate
<span class="headerright">POST:  <code>/v1/loadBalancerServices/${ID}?action=activate</code></span></span>
<div class="action-contents">

<br>
To create a new loadBalancerService, send a POST request to <code>/v1/loadBalancerServices/${ID}?action=activate</code>.

</div></div>

<div class="action">
<span class="header">
addservicelink
<span class="headerright">POST:  <code>/v1/loadBalancerServices/${ID}?action=addservicelink</code></span></span>
<div class="action-contents">

<br>
To create a new loadBalancerService, send a POST request to <code>/v1/loadBalancerServices/${ID}?action=addservicelink</code>.

</div></div>

<div class="action">
<span class="header">
cancelrollback
<span class="headerright">POST:  <code>/v1/loadBalancerServices/${ID}?action=cancelrollback</code></span></span>
<div class="action-contents">

<br>
To create a new loadBalancerService, send a POST request to <code>/v1/loadBalancerServices/${ID}?action=cancelrollback</code>.

</div></div>

<div class="action">
<span class="header">
cancelupgrade
<span class="headerright">POST:  <code>/v1/loadBalancerServices/${ID}?action=cancelupgrade</code></span></span>
<div class="action-contents">

<br>
To create a new loadBalancerService, send a POST request to <code>/v1/loadBalancerServices/${ID}?action=cancelupgrade</code>.

</div></div>

<div class="action">
<span class="header">
deactivate
<span class="headerright">POST:  <code>/v1/loadBalancerServices/${ID}?action=deactivate</code></span></span>
<div class="action-contents">

<br>
To create a new loadBalancerService, send a POST request to <code>/v1/loadBalancerServices/${ID}?action=deactivate</code>.

</div></div>

<div class="action">
<span class="header">
finishupgrade
<span class="headerright">POST:  <code>/v1/loadBalancerServices/${ID}?action=finishupgrade</code></span></span>
<div class="action-contents">

<br>
To create a new loadBalancerService, send a POST request to <code>/v1/loadBalancerServices/${ID}?action=finishupgrade</code>.

</div></div>

<div class="action">
<span class="header">
removeservicelink
<span class="headerright">POST:  <code>/v1/loadBalancerServices/${ID}?action=removeservicelink</code></span></span>
<div class="action-contents">

<br>
To create a new loadBalancerService, send a POST request to <code>/v1/loadBalancerServices/${ID}?action=removeservicelink</code>.

</div></div>

<div class="action">
<span class="header">
rollback
<span class="headerright">POST:  <code>/v1/loadBalancerServices/${ID}?action=rollback</code></span></span>
<div class="action-contents">

<br>
To create a new loadBalancerService, send a POST request to <code>/v1/loadBalancerServices/${ID}?action=rollback</code>.

</div></div>

<div class="action">
<span class="header">
setservicelinks
<span class="headerright">POST:  <code>/v1/loadBalancerServices/${ID}?action=setservicelinks</code></span></span>
<div class="action-contents">

<br>
To create a new loadBalancerService, send a POST request to <code>/v1/loadBalancerServices/${ID}?action=setservicelinks</code>.

</div></div>

<div class="action">
<span class="header">
upgrade
<span class="headerright">POST:  <code>/v1/loadBalancerServices/${ID}?action=upgrade</code></span></span>
<div class="action-contents">

<br>
To create a new loadBalancerService, send a POST request to <code>/v1/loadBalancerServices/${ID}?action=upgrade</code>.

</div></div>


