---
title: Rancher API - dnsService
layout: rancher-api-default
version: v1.2
lang: en
---

## DnsService

A "dnsService" in the API is referred to as a Service Alias in the UI and the Rancher documentation. In the API documentation, we'll use the UI terminology. A service alias allows the ability to add a DNS record for your services to be discovered.

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
assignServiceIpAddress | boolean | Optional | - | - | 
description | string | Optional | Yes | - | 
environmentId | [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/environment/) | Yes | - | - | 
externalId | string | Optional | - | - | 
fqdn | string | - | - | - | 
healthState | string | - | - | - | 
id | int | - | - | - | The unique identifier for the dnsService
launchConfig | [launchConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/launchConfig/) | Optional | - | - | 
metadata | map[json] | Optional | Yes | - | 
name | string | Yes | Yes | - | 
retainIp | boolean | Optional | Yes | - | 
selectorLink | string | Optional | Yes | - | 
startOnCreate | boolean | Optional | - | - | 
upgrade | [serviceUpgrade]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/serviceUpgrade/) | - | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/dnsServices</code></span></span>
<div class="action-contents">
{% highlight json %}
{
	"assignServiceIpAddress": false,
	"description": "string",
	"environmentId": "reference[environment]",
	"externalId": "string",
	"launchConfig": {
		"accountId": "reference[account]",
		"blkioDeviceOptions": "map[blkioDeviceOption]",
		"build": {
			"context": "string",
			"dockerfile": "string",
			"forcerm": true,
			"nocache": true,
			"remote": "string",
			"rm": true
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
		"nativeContainer": true,
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
	"retainIp": true,
	"selectorLink": "string",
	"startOnCreate": false
}
{% endhighlight %}
</div>
</div>

<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/dnsServices</code></span></span>
<div class="action-contents">
<figure class="highlight">
<pre>
<code>
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{% highlight json %}
{
	"assignServiceIpAddress": false,
	"description": "string",
	"environmentId": "reference[environment]",
	"externalId": "string",
	"launchConfig": {
		"accountId": "reference[account]",
		"blkioDeviceOptions": "map[blkioDeviceOption]",
		"build": {
			"context": "string",
			"dockerfile": "string",
			"forcerm": true,
			"nocache": true,
			"remote": "string",
			"rm": true
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
		"nativeContainer": true,
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
	"retainIp": true,
	"selectorLink": "string",
	"startOnCreate": false
}
{% endhighlight %}' \
'http://RANCHER_URL:8080/v1/dnsServices'
</code></pre></figure>

</div>
</div>

<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/dnsServices</code></span></span>
<div class="action-contents">
<figure class="highlight">
<pre>
<code>
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{
	"assignServiceIpAddress": false,
	"description": "string",
	"environmentId": "reference[environment]",
	"externalId": "string",
	"launchConfig": {
		"accountId": "reference[account]",
		"blkioDeviceOptions": "map[blkioDeviceOption]",
		"build": {
			"context": "string",
			"dockerfile": "string",
			"forcerm": true,
			"nocache": true,
			"remote": "string",
			"rm": true
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
		"nativeContainer": true,
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
	"retainIp": true,
	"selectorLink": "string",
	"startOnCreate": false
}' \
'http://RANCHER_URL:8080/v1/dnsServices'
</code></pre></figure>

</div>
</div>


<a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/dnsServices/${ID}</code></span></span>
<div class="action-contents">
{% highlight json %}

{% endhighlight %}
</div>
</div>

<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/dnsServices/${ID}</code></span></span>
<div class="action-contents">
<figure class="highlight">
<pre>
<code>
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X DELETE \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{% highlight json %}

{% endhighlight %}' \
'http://RANCHER_URL:8080/v1/dnsServices/${ID}'
</code></pre></figure>

</div>
</div>

<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/dnsServices/${ID}</code></span></span>
<div class="action-contents">
<figure class="highlight">
<pre>
<code>
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X DELETE \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '' \
'http://RANCHER_URL:8080/v1/dnsServices/${ID}'
</code></pre></figure>

</div>
</div>


<a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v1/dnsServices/${ID}</code></span></span>
<div class="action-contents">
{% highlight json %}
{
	"description": "string",
	"metadata": "map[json]",
	"name": "string",
	"retainIp": true,
	"selectorLink": "string"
}
{% endhighlight %}
</div>
</div>

<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v1/dnsServices/${ID}</code></span></span>
<div class="action-contents">
<figure class="highlight">
<pre>
<code>
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{% highlight json %}
{
	"description": "string",
	"metadata": "map[json]",
	"name": "string",
	"retainIp": true,
	"selectorLink": "string"
}
{% endhighlight %}' \
'http://RANCHER_URL:8080/v1/dnsServices/${ID}'
</code></pre></figure>

</div>
</div>

<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v1/dnsServices/${ID}</code></span></span>
<div class="action-contents">
<figure class="highlight">
<pre>
<code>
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{
	"description": "string",
	"metadata": "map[json]",
	"name": "string",
	"retainIp": true,
	"selectorLink": "string"
}' \
'http://RANCHER_URL:8080/v1/dnsServices/${ID}'
</code></pre></figure>

</div>
</div>




### Actions
<div class="action">
<span class="header">
activate
<span class="headerright">POST:  <code>/v1/dnsServices/${ID}?action=activate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action">
<span class="header">
deactivate
<span class="headerright">POST:  <code>/v1/dnsServices/${ID}?action=deactivate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action">
<span class="header">
removeservicelink
<span class="headerright">POST:  <code>/v1/dnsServices/${ID}?action=removeservicelink</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> addRemoveServiceLinkInput</span>

<br>{% highlight json %}{
	"serviceLink": {
		"name": "string",
		"serviceId": "reference[service]",
		"uuid": "string"
	}
}{% endhighlight %}<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action">
<span class="header">
rollback
<span class="headerright">POST:  <code>/v1/dnsServices/${ID}?action=rollback</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action">
<span class="header">
setservicelinks
<span class="headerright">POST:  <code>/v1/dnsServices/${ID}?action=setservicelinks</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> setServiceLinksInput</span>

<br>{% highlight json %}{
	"serviceLinks": "array[serviceLink]"
}{% endhighlight %}<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/service/">service</a> resource</span>
</div></div>

<div class="action">
<span class="header">
upgrade
<span class="headerright">POST:  <code>/v1/dnsServices/${ID}?action=upgrade</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> serviceUpgrade</span>

<br>{% highlight json %}{
	"inServiceStrategy": {
		"batchSize": 1,
		"intervalMillis": 2000,
		"launchConfig": {
			"accountId": "reference[account]",
			"blkioDeviceOptions": "map[blkioDeviceOption]",
			"build": {
				"context": "string",
				"dockerfile": "string",
				"forcerm": true,
				"nocache": true,
				"remote": "string",
				"rm": true
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
			"nativeContainer": true,
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
				"forcerm": true,
				"nocache": true,
				"remote": "string",
				"rm": true
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
			"nativeContainer": true,
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
		"updateLinks": true
	}
}{% endhighlight %}<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/service/">service</a> resource</span>
</div></div>


