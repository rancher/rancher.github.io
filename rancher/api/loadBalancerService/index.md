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
id | int | - | - | - | The unique identifier for the loadBalancerService
kind | string | - | - | - | 
name | string | Yes | Yes | - | 
state | enum | - | - | - | The current state of the loadBalancerService. The options are [activating, active, canceled-rollback, canceled-upgrade, canceling-rollback, canceling-upgrade, deactivating, finishing-upgrade, inactive, registering, removed, removing, requested, rolling-back, updating-active, updating-inactive, upgraded, upgrading].
certificateIds | array[[certificate]({{site.baseurl}}/rancher/api/certificate/)] | Optional | Yes | - | The ID of a certificate
defaultCertificateId | [certificate]({{site.baseurl}}/rancher/api/certificate/) | Optional | Yes | - | The ID of a default certificate
environmentId | [environment]({{site.baseurl}}/rancher/api/environment/) | Yes | - | - | The identifier of which stack the service belongs to
externalId | string | - | - | - | 
fqdn | string | - | - | - | The fqdn of a service when the [Route 53 DNS service]({{site.baseurl}}/rancher/rancher-services/dns-service/) has started. The format will be `<serviceName>.<stackName>.<environmentName>.<yourHostedZoneName>`.
launchConfig | [launchConfig]({{site.baseurl}}/rancher/api/launchConfig/) | Optional | - | - | The Docker run configuration of a container
loadBalancerConfig | [loadBalancerConfig]({{site.baseurl}}/rancher/api/loadBalancerConfig/) | Optional | - | - | Configuration of a load balancer
metadata | map[json] | Optional | Yes | - | The user added [metadata]({{site.baseurl}}/rancher/metadata-service/#adding-user-metadata-to-a-service) to a service.
scale | int | Optional | Yes | 1 | The number of containers to deploy as part of a service
selectorLink | string | Optional | - | - | The [selector value]({{site.baseurl}}/rancher/labels/#selector-labels) used to select a [service]({{site.baseurl}}/rancher/api/service/) to link to the service based on a service's labels.
upgrade | [serviceUpgrade]({{site.baseurl}}/rancher/api/serviceUpgrade/) | - | - | - | 
vip | string | Optional | - | - | 
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the loadBalancerService was created.
description | string | Optional | Yes | - | 
removed | date | - | - | - | The date of when the loadBalancerService was removed
transitioning | enum | - | - | - | Whether or not the loadBalancerService is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the loadBalancerService
uuid | string | - | - | - | The universally unique identifier for the loadBalancerService. This will always be unique across Rancher installations.





### Operations



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

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

		"command": "[string, string, string...]",

		"count": 0,

		"cpuSet": "string",

		"cpuShares": 0,

		"createIndex": 0,

		"created": "date",

		"dataVolumeMounts": "map[reference[volume]]",

		"dataVolumes": "[string, string, string...]",

		"dataVolumesFrom": "array[reference[container]]",

		"dataVolumesFromLaunchConfigs": "[string, string, string...]",

		"deploymentUnitUuid": "string",

		"description": "string",

		"devices": "[string, string, string...]",

		"dns": "[string, string, string...]",

		"dnsSearch": "[string, string, string...]",

		"domainName": "string",

		"entryPoint": "[string, string, string...]",

		"environment": "map[string]",

		"expose": "[string, string, string...]",

		"externalId": "string",

		"extraHosts": "[string, string, string...]",

		"firstRunning": "date",

		"healthCheck": {

			"healthyThreshold": 0,

			"interval": 0,

			"name": "string",

			"port": 0,

			"requestLine": "string",

			"responseTimeout": 0,

			"unhealthyThreshold": 0

		},

		"healthState": "enum",

		"hostname": "string",

		"id": 0,

		"imageUuid": "string",

		"instanceLinks": "map[reference[instance]]",

		"kind": "string",

		"labels": "map[string]",

		"logConfig": {

			"config": "map[string]",

			"driver": "string"

		},

		"lxcConf": "map[string]",

		"memory": 0,

		"memorySwap": 0,

		"nativeContainer": true,

		"networkContainerId": "reference[container]",

		"networkIds": "array[reference[network]]",

		"networkLaunchConfig": "string",

		"networkMode": "managed",

		"pidMode": "enum",

		"ports": "[string, string, string...]",

		"primaryIpAddress": "string",

		"privileged": false,

		"publishAllPorts": false,

		"readOnly": false,

		"registryCredentialId": "reference[registryCredential]",

		"removed": "date",

		"requestedHostId": "reference[host]",

		"securityOpt": "[string, string, string...]",

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

		"uuid": "string",

		"version": "0",

		"volumeDriver": "string",

		"workingDir": "string"

	},

	"loadBalancerConfig": {

		"accountId": "reference[account]",

		"appCookieStickinessPolicy": {

			"cookie": "string",

			"maxLength": 0,

			"mode": "enum",

			"name": "string",

			"prefix": true,

			"requestLearn": true,

			"timeout": 0

		},

		"created": "date",

		"description": "string",

		"healthCheck": {

			"healthyThreshold": 0,

			"interval": 0,

			"name": "string",

			"port": 0,

			"requestLine": "string",

			"responseTimeout": 0,

			"unhealthyThreshold": 0

		},

		"id": 0,

		"kind": "string",

		"lbCookieStickinessPolicy": {

			"cookie": "string",

			"domain": "string",

			"indirect": true,

			"mode": "enum",

			"name": "string",

			"nocache": true,

			"postonly": true

		},

		"name": "string",

		"removed": "date",

		"serviceId": "reference[service]",

		"state": "enum",

		"transitioning": "enum",

		"transitioningMessage": "string",

		"transitioningProgress": 0,

		"uuid": "string"

	},

	"metadata": "map[json]",

	"name": "string",

	"scale": 1,

	"selectorLink": "string",

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

	"metadata": "map[json]",

	"name": "string",

	"scale": 1

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
<span class="headerright">POST:  <code>${action.activate}</code></span>
</span>
<div class="action-contents">
To activate the loadBalancerService
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/service/">service</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
addservicelink
<span class="headerright">POST:  <code>${action.addservicelink}</code></span>
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

		"ports": "[string, string, string...]",

		"serviceId": "reference[service]"

	}

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/service/">service</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
cancelrollback
<span class="headerright">POST:  <code>${action.cancelrollback}</code></span>
</span>
<div class="action-contents">
To cancelrollback the loadBalancerService
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/service/">service</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
cancelupgrade
<span class="headerright">POST:  <code>${action.cancelupgrade}</code></span>
</span>
<div class="action-contents">
To cancelupgrade the loadBalancerService
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/service/">service</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
deactivate
<span class="headerright">POST:  <code>${action.deactivate}</code></span>
</span>
<div class="action-contents">
To deactivate the loadBalancerService
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/service/">service</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
finishupgrade
<span class="headerright">POST:  <code>${action.finishupgrade}</code></span>
</span>
<div class="action-contents">
To finishupgrade the loadBalancerService
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/service/">service</a> resource
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
To remove the loadBalancerService
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/service/">service</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
removeservicelink
<span class="headerright">POST:  <code>${action.removeservicelink}</code></span>
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

		"ports": "[string, string, string...]",

		"serviceId": "reference[service]"

	}

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/service/">service</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
rollback
<span class="headerright">POST:  <code>${action.rollback}</code></span>
</span>
<div class="action-contents">
To rollback the loadBalancerService
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/service/">service</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
setservicelinks
<span class="headerright">POST:  <code>${action.setservicelinks}</code></span>
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

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/service/">service</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
upgrade
<span class="headerright">POST:  <code>${action.upgrade}</code></span>
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

			"command": "[string, string, string...]",

			"count": 0,

			"cpuSet": "string",

			"cpuShares": 0,

			"createIndex": 0,

			"created": "date",

			"dataVolumeMounts": "map[reference[volume]]",

			"dataVolumes": "[string, string, string...]",

			"dataVolumesFrom": "array[reference[container]]",

			"dataVolumesFromLaunchConfigs": "[string, string, string...]",

			"deploymentUnitUuid": "string",

			"description": "string",

			"devices": "[string, string, string...]",

			"dns": "[string, string, string...]",

			"dnsSearch": "[string, string, string...]",

			"domainName": "string",

			"entryPoint": "[string, string, string...]",

			"environment": "map[string]",

			"expose": "[string, string, string...]",

			"externalId": "string",

			"extraHosts": "[string, string, string...]",

			"firstRunning": "date",

			"healthCheck": {

				"healthyThreshold": 0,

				"interval": 0,

				"name": "string",

				"port": 0,

				"requestLine": "string",

				"responseTimeout": 0,

				"unhealthyThreshold": 0

			},

			"healthState": "enum",

			"hostname": "string",

			"id": 0,

			"imageUuid": "string",

			"instanceLinks": "map[reference[instance]]",

			"kind": "string",

			"labels": "map[string]",

			"logConfig": {

				"config": "map[string]",

				"driver": "string"

			},

			"lxcConf": "map[string]",

			"memory": 0,

			"memorySwap": 0,

			"nativeContainer": true,

			"networkContainerId": "reference[container]",

			"networkIds": "array[reference[network]]",

			"networkLaunchConfig": "string",

			"networkMode": "managed",

			"pidMode": "enum",

			"ports": "[string, string, string...]",

			"primaryIpAddress": "string",

			"privileged": false,

			"publishAllPorts": false,

			"readOnly": false,

			"registryCredentialId": "reference[registryCredential]",

			"removed": "date",

			"requestedHostId": "reference[host]",

			"securityOpt": "[string, string, string...]",

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

			"uuid": "string",

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

			"command": "[string, string, string...]",

			"count": 0,

			"cpuSet": "string",

			"cpuShares": 0,

			"createIndex": 0,

			"created": "date",

			"dataVolumeMounts": "map[reference[volume]]",

			"dataVolumes": "[string, string, string...]",

			"dataVolumesFrom": "array[reference[container]]",

			"dataVolumesFromLaunchConfigs": "[string, string, string...]",

			"deploymentUnitUuid": "string",

			"description": "string",

			"devices": "[string, string, string...]",

			"dns": "[string, string, string...]",

			"dnsSearch": "[string, string, string...]",

			"domainName": "string",

			"entryPoint": "[string, string, string...]",

			"environment": "map[string]",

			"expose": "[string, string, string...]",

			"externalId": "string",

			"extraHosts": "[string, string, string...]",

			"firstRunning": "date",

			"healthCheck": {

				"healthyThreshold": 0,

				"interval": 0,

				"name": "string",

				"port": 0,

				"requestLine": "string",

				"responseTimeout": 0,

				"unhealthyThreshold": 0

			},

			"healthState": "enum",

			"hostname": "string",

			"id": 0,

			"imageUuid": "string",

			"instanceLinks": "map[reference[instance]]",

			"kind": "string",

			"labels": "map[string]",

			"logConfig": {

				"config": "map[string]",

				"driver": "string"

			},

			"lxcConf": "map[string]",

			"memory": 0,

			"memorySwap": 0,

			"nativeContainer": true,

			"networkContainerId": "reference[container]",

			"networkIds": "array[reference[network]]",

			"networkLaunchConfig": "string",

			"networkMode": "managed",

			"pidMode": "enum",

			"ports": "[string, string, string...]",

			"primaryIpAddress": "string",

			"privileged": false,

			"publishAllPorts": false,

			"readOnly": false,

			"registryCredentialId": "reference[registryCredential]",

			"removed": "date",

			"requestedHostId": "reference[host]",

			"securityOpt": "[string, string, string...]",

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

			"uuid": "string",

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

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/service/">service</a> resource
</span>
</div>
</span>
</span>
</span>

