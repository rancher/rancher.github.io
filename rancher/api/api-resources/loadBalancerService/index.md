---
title: API
layout: rancher-default
---

## loadBalancerService

Rancher implements a managed load balancer using HAProxy that can be manually scaled to multiple hosts.  A load balancer can be used to distribute network and application traffic to individual containers by directly adding them or "linked" to a basic service.  A basic service that is "linked" will have all its underlying containers automatically registered as load balancer targets by Rancher.

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
assignServiceIpAddress | boolean | Optional | - | - | 
certificateIds | array[[certificate]({{site.baseurl}}/rancher/api/api-resources/certificate/)] | Optional | Yes | - | The ID of a certificate
defaultCertificateId | [certificate]({{site.baseurl}}/rancher/api/api-resources/certificate/) | Optional | Yes | - | The ID of a default certificate
description | string | Optional | Yes | - | 
environmentId | [environment]({{site.baseurl}}/rancher/api/api-resources/environment/) | Yes | - | - | The identifier of which stack the service belongs to
externalId | string | - | - | - | 
fqdn | string | - | - | - | The fqdn of a service when the [Route 53 DNS service]({{site.baseurl}}/rancher/rancher-services/dns-service/) has started. The format will be `<serviceName>.<stackName>.<environmentName>.<yourHostedZoneName>`.
healthState | string | - | - | - | 
id | int | - | - | - | The unique identifier for the loadBalancerService
launchConfig | [launchConfig]({{site.baseurl}}/rancher/api/api-resources/launchConfig/) | Optional | - | - | The Docker run configuration of a container
loadBalancerConfig | [loadBalancerConfig]({{site.baseurl}}/rancher/api/api-resources/loadBalancerConfig/) | Optional | - | - | Configuration of a load balancer
metadata | map[json] | Optional | Yes | - | The user added [metadata]({{site.baseurl}}/rancher/rancher-services/metadata-service/#adding-user-metadata-to-a-service) to a service.
name | string | Yes | Yes | - | 
publicEndpoints | array[publicEndpoint] | - | - | - | 
retainIp | boolean | Optional | - | - | 
scale | int | Optional | Yes | 1 | The number of containers to deploy as part of a service
selectorLink | string | Optional | Yes | - | The [selector value]({{site.baseurl}}/rancher/labels/#selector-labels) used to select a [service]({{site.baseurl}}/rancher/api/api-resources/service/) to link to the service based on a service's labels.
startOnCreate | boolean | Optional | - | - | 
upgrade | [serviceUpgrade]({{site.baseurl}}/rancher/api/api-resources/serviceUpgrade/) | - | - | - | 
vip | string | Optional | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.
​

### Operations



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/loadBalancerService</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"assignServiceIpAddress": false,

	"certificateIds": "array[reference[certificate]]",

	"defaultCertificateId": "reference[certificate]",

	"description": "string",

	"environmentId": "reference[environment]",

	"launchConfig": {

		"accountId": "reference[account]",

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

	"loadBalancerConfig": {

		"haproxyConfig": {

			"defaults": "string",

			"global": "string"

		},

		"lbCookieStickinessPolicy": {

			"cookie": "string",

			"domain": "string",

			"indirect": true,

			"mode": "enum",

			"name": "string",

			"nocache": true,

			"postonly": true

		}

	},

	"metadata": "map[json]",

	"name": "string",

	"retainIp": true,

	"scale": 1,

	"selectorLink": "string",

	"startOnCreate": false,

	"vip": "string"

} 
{% endhighlight %}
</div>
</span>













<span class="action">
<span class="header">
Update
<span class="headerright">PUT:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

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

			"indirect": true,

			"mode": "enum",

			"name": "string",

			"nocache": true,

			"postonly": true

		}

	},

	"metadata": "map[json]",

	"name": "string",

	"scale": 1,

	"selectorLink": "string"

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
activate
<span class="headerright">POST:  <code>${actions.activate}</code></span>
</span>
<div class="action-contents">
To activate the loadBalancerService
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/service/">service</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
addservicelink
<span class="headerright">POST:  <code>${actions.addservicelink}</code></span>
</span>
<div class="action-contents">
To addservicelink the loadBalancerService
<br>

<span class="input">
<strong>Input:</strong>​​​ addRemoveLoadBalancerServiceLinkInput


Field | Type | Required | Default | Notes
---|---|---|---|---
serviceLink | loadBalancerServiceLink | Yes | <no value> | 


<br>
{% highlight json %}{

	"serviceLink": {

		"ports": [

			"string1",

			"string2",

			"...stringN"

		],

		"serviceId": "reference[service]",

		"uuid": "string"

	}

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/service/">service</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
cancelrollback
<span class="headerright">POST:  <code>${actions.cancelrollback}</code></span>
</span>
<div class="action-contents">
To cancelrollback the loadBalancerService
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/service/">service</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
cancelupgrade
<span class="headerright">POST:  <code>${actions.cancelupgrade}</code></span>
</span>
<div class="action-contents">
To cancelupgrade the loadBalancerService
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/service/">service</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
deactivate
<span class="headerright">POST:  <code>${actions.deactivate}</code></span>
</span>
<div class="action-contents">
To deactivate the loadBalancerService
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/service/">service</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
finishupgrade
<span class="headerright">POST:  <code>${actions.finishupgrade}</code></span>
</span>
<div class="action-contents">
To finishupgrade the loadBalancerService
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/service/">service</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${actions.remove}</code></span>
</span>
<div class="action-contents">
To remove the loadBalancerService
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/service/">service</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
removeservicelink
<span class="headerright">POST:  <code>${actions.removeservicelink}</code></span>
</span>
<div class="action-contents">
To removeservicelink the loadBalancerService
<br>

<span class="input">
<strong>Input:</strong>​​​ addRemoveLoadBalancerServiceLinkInput


Field | Type | Required | Default | Notes
---|---|---|---|---
serviceLink | loadBalancerServiceLink | Yes | <no value> | 


<br>
{% highlight json %}{

	"serviceLink": {

		"ports": [

			"string1",

			"string2",

			"...stringN"

		],

		"serviceId": "reference[service]",

		"uuid": "string"

	}

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/service/">service</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
restart
<span class="headerright">POST:  <code>${actions.restart}</code></span>
</span>
<div class="action-contents">
To restart the loadBalancerService
<br>

<span class="input">
<strong>Input:</strong>​​​ serviceRestart


Field | Type | Required | Default | Notes
---|---|---|---|---
rollingRestartStrategy | rollingRestartStrategy | Yes | <no value> | 


<br>
{% highlight json %}{

	"rollingRestartStrategy": {

		"batchSize": 1,

		"intervalMillis": 2000

	}

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/service/">service</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
rollback
<span class="headerright">POST:  <code>${actions.rollback}</code></span>
</span>
<div class="action-contents">
To rollback the loadBalancerService
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/service/">service</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
setservicelinks
<span class="headerright">POST:  <code>${actions.setservicelinks}</code></span>
</span>
<div class="action-contents">
To setservicelinks the loadBalancerService
<br>

<span class="input">
<strong>Input:</strong>​​​ setLoadBalancerServiceLinksInput


Field | Type | Required | Default | Notes
---|---|---|---|---
serviceLinks | array[loadBalancerServiceLink] | No | <no value> | The list of services linked


<br>
{% highlight json %}{

	"serviceLinks": "array[loadBalancerServiceLink]"

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/service/">service</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
upgrade
<span class="headerright">POST:  <code>${actions.upgrade}</code></span>
</span>
<div class="action-contents">
To upgrade the loadBalancerService
<br>

<span class="input">
<strong>Input:</strong>​​​ serviceUpgrade


Field | Type | Required | Default | Notes
---|---|---|---|---
inServiceStrategy | inServiceUpgradeStrategy | No | <no value> | 
toServiceStrategy | toServiceUpgradeStrategy | No | <no value> | 


<br>
{% highlight json %}{

	"inServiceStrategy": {

		"batchSize": 1,

		"intervalMillis": 2000,

		"launchConfig": {

			"accountId": "reference[account]",

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

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/service/">service</a> resource
</span>
</div>
</span>
</span>
</span>

