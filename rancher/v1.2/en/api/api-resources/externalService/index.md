---
title: Rancher API - externalService
layout: rancher-api-default
version: v1.2
lang: en
---

## ExternalService

An external service allows the ability to add any IP or hostname as a service to be discovered as a service.

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
environmentId | [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/environment/) | Yes | - | - | 
externalId | string | Optional | - | - | 
externalIpAddresses | array[string] | Optional | Yes | - | 
fqdn | string | - | - | - | 
healthCheck | [instanceHealthCheck]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/instanceHealthCheck/) | Optional | - | - | 
healthState | string | - | - | - | 
hostname | string | Optional | Yes | - | 
id | int | - | - | - | The unique identifier for the externalService
launchConfig | [launchConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/launchConfig/) | Optional | - | - | 
metadata | map[json] | Optional | Yes | - | 
name | string | Yes | Yes | - | 
startOnCreate | boolean | Optional | - | - | 
upgrade | [serviceUpgrade]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/serviceUpgrade/) | - | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/externalServices</code></span></span>
<div class="action-contents"><figure class="highlight"><pre><code>
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{% highlight json %}
{
	"description": "string",
	"environmentId": "reference[environment]",
	"externalId": "string",
	"externalIpAddresses": [
		"string1",
		"string2",
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
	"hostname": "string",
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
			"string2",
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
			"string2",
			"...stringN"
		],
		"dataVolumesFrom": "array[reference[container]]",
		"dataVolumesFromLaunchConfigs": [
			"string1",
			"string2",
			"...stringN"
		],
		"deploymentUnitUuid": "string",
		"description": "string",
		"devices": [
			"string1",
			"string2",
			"...stringN"
		],
		"disks": "array[virtualMachineDisk]",
		"dns": [
			"string1",
			"string2",
			"...stringN"
		],
		"dnsSearch": [
			"string1",
			"string2",
			"...stringN"
		],
		"domainName": "string",
		"entryPoint": [
			"string1",
			"string2",
			"...stringN"
		],
		"environment": {
			"key1": "value1",
			"key2": "value2",
			"keyN": "valueN"
		},
		"expose": [
			"string1",
			"string2",
			"...stringN"
		],
		"externalId": "string",
		"extraHosts": [
			"string1",
			"string2",
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
			"key1": "value1",
			"key2": "value2",
			"keyN": "valueN"
		},
		"logConfig": {
			"config": {
				"key1": "value1",
				"key2": "value2",
				"keyN": "valueN"
			},
			"driver": "string"
		},
		"lxcConf": {
			"key1": "value1",
			"key2": "value2",
			"keyN": "valueN"
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
			"string2",
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
			"string2",
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
	"metadata": "map[json]",
	"name": "string",
	"startOnCreate": false
}
{% endhighlight %}' \
'http://RANCHER_URL:8080/v1/externalServices'
</code></pre></figure>
</div></div>

<a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/externalServices/${ID}</code></span></span>
<div class="action-contents"><figure class="highlight"><pre><code>
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X DELETE \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{% highlight json %}

{% endhighlight %}' \
'http://RANCHER_URL:8080/v1/externalServices/${ID}'
</code></pre></figure>
</div></div>

<a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v1/externalServices/${ID}</code></span></span>
<div class="action-contents"><figure class="highlight"><pre><code>
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{% highlight json %}
{
	"description": "string",
	"externalIpAddresses": [
		"string1",
		"string2",
		"...stringN"
	],
	"hostname": "string",
	"metadata": "map[json]",
	"name": "string"
}
{% endhighlight %}' \
'http://RANCHER_URL:8080/v1/externalServices/${ID}'
</code></pre></figure>
</div></div>



### Actions
<div class="action">
<span class="header">
activate
<span class="headerright">POST:  <code>/v1/externalServices/${ID}?action=activate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action">
<span class="header">
cancelrollback
<span class="headerright">POST:  <code>/v1/externalServices/${ID}?action=cancelrollback</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action">
<span class="header">
cancelupgrade
<span class="headerright">POST:  <code>/v1/externalServices/${ID}?action=cancelupgrade</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action">
<span class="header">
deactivate
<span class="headerright">POST:  <code>/v1/externalServices/${ID}?action=deactivate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action">
<span class="header">
finishupgrade
<span class="headerright">POST:  <code>/v1/externalServices/${ID}?action=finishupgrade</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action">
<span class="header">
rollback
<span class="headerright">POST:  <code>/v1/externalServices/${ID}?action=rollback</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action">
<span class="header">
upgrade
<span class="headerright">POST:  <code>/v1/externalServices/${ID}?action=upgrade</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> serviceUpgrade</span>

<br>

<figure class="highlight"><pre><code>
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{% highlight json %}{
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
				"string2",
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
				"string2",
				"...stringN"
			],
			"dataVolumesFrom": "array[reference[container]]",
			"dataVolumesFromLaunchConfigs": [
				"string1",
				"string2",
				"...stringN"
			],
			"deploymentUnitUuid": "string",
			"description": "string",
			"devices": [
				"string1",
				"string2",
				"...stringN"
			],
			"disks": "array[virtualMachineDisk]",
			"dns": [
				"string1",
				"string2",
				"...stringN"
			],
			"dnsSearch": [
				"string1",
				"string2",
				"...stringN"
			],
			"domainName": "string",
			"entryPoint": [
				"string1",
				"string2",
				"...stringN"
			],
			"environment": {
				"key1": "value1",
				"key2": "value2",
				"keyN": "valueN"
			},
			"expose": [
				"string1",
				"string2",
				"...stringN"
			],
			"externalId": "string",
			"extraHosts": [
				"string1",
				"string2",
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
				"key1": "value1",
				"key2": "value2",
				"keyN": "valueN"
			},
			"logConfig": {
				"config": {
					"key1": "value1",
					"key2": "value2",
					"keyN": "valueN"
				},
				"driver": "string"
			},
			"lxcConf": {
				"key1": "value1",
				"key2": "value2",
				"keyN": "valueN"
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
				"string2",
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
				"string2",
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
				"string2",
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
				"string2",
				"...stringN"
			],
			"dataVolumesFrom": "array[reference[container]]",
			"dataVolumesFromLaunchConfigs": [
				"string1",
				"string2",
				"...stringN"
			],
			"deploymentUnitUuid": "string",
			"description": "string",
			"devices": [
				"string1",
				"string2",
				"...stringN"
			],
			"disks": "array[virtualMachineDisk]",
			"dns": [
				"string1",
				"string2",
				"...stringN"
			],
			"dnsSearch": [
				"string1",
				"string2",
				"...stringN"
			],
			"domainName": "string",
			"entryPoint": [
				"string1",
				"string2",
				"...stringN"
			],
			"environment": {
				"key1": "value1",
				"key2": "value2",
				"keyN": "valueN"
			},
			"expose": [
				"string1",
				"string2",
				"...stringN"
			],
			"externalId": "string",
			"extraHosts": [
				"string1",
				"string2",
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
				"key1": "value1",
				"key2": "value2",
				"keyN": "valueN"
			},
			"logConfig": {
				"config": {
					"key1": "value1",
					"key2": "value2",
					"keyN": "valueN"
				},
				"driver": "string"
			},
			"lxcConf": {
				"key1": "value1",
				"key2": "value2",
				"keyN": "valueN"
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
				"string2",
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
				"string2",
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
}{% endhighlight %}' \
'http://RANCHER_URL:8080/v1/externalServices/${ID}?action=upgrade'
</code></pre></figure>
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/service/">service</a> resource</span>
</div></div>


