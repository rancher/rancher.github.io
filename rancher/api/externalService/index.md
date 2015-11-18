---
title: API
layout: rancher-default
---

## externalService

An external service allows the ability to add any IP or hostname as a service to be discovered as a service.
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
environmentId | [environment]({{site.baseurl}}/rancher/api/environment/) | Yes | - | - | The environmentId for the externalService
externalId | string | - | - | - | The externalId for the externalService
externalIpAddresses | array[string] | Optional | Yes | - | The external IP address used for an external service
fqdn | string | - | - | - | The fqdn for the externalService
healthCheck | [instanceHealthCheck]({{site.baseurl}}/rancher/api/instanceHealthCheck/) | Optional | - | - | The healthCheck for the externalService
hostname | string | Optional | Yes | - | The hostname for the externalService
launchConfig | [launchConfig]({{site.baseurl}}/rancher/api/launchConfig/) | Optional | - | - | Configuration of a container
metadata | map[json] | Optional | Yes | - | The metadata for the externalService
selectorLink | string | Optional | - | - | The selectorLink for the externalService
upgrade | [serviceUpgrade]({{site.baseurl}}/rancher/api/serviceUpgrade/) | - | - | - | The upgrade for the externalService




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the externalService was created.
description | string | Optional | Yes | - | The description for the externalService
id | int | - | - | - | The unique identifier for the externalService
kind | string | - | - | - | The kind for the externalService
name | string | Yes | Yes | - | The name for the externalService
removed | date | - | - | - | The date of when the externalService was removed
state | enum | - | - | - | The current state of the externalService. The options are [activating, active, canceled-rollback, canceled-upgrade, canceling-rollback, canceling-upgrade, deactivating, finishing-upgrade, inactive, registering, removed, removing, requested, rolling-back, updating-active, updating-inactive, upgraded, upgrading].
transitioning | enum | - | - | - | Whether or not the externalService is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the externalService
uuid | string | - | - | - | The universally unique identifier for the externalService. This will always be unique across Rancher installations.




### Actions



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"description": "string",

	"environmentId": "reference[environment]",

	"externalIpAddresses": "[string, string, string...]",

	"healthCheck": {

		"healthyThreshold": 0,

		"interval": 0,

		"name": "string",

		"port": 0,

		"requestLine": "string",

		"responseTimeout": 0,

		"unhealthyThreshold": 0

	},

	"hostname": "string",

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

	"metadata": "map[json]",

	"name": "string",

	"selectorLink": "string"

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

	"description": "string",

	"externalIpAddresses": "[string, string, string...]",

	"hostname": "string",

	"metadata": "map[json]",

	"name": "string"

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

<span class="action">
<span class="header">
activate
<span class="headerright">POST:  <code>${action.activate}</code></span>
</span>
<div class="action-contents">
To activate the externalService
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

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
To addservicelink the externalService
<br>

<span class="input">
<strong>Input:</strong>​​​ addRemoveServiceLinkInput


Field | Type | Required | Default | Description
---|---|---|---|---
serviceLink | serviceLink | Yes | <no value> | The serviceLink for the addRemoveServiceLinkInput


<br>
{% highlight json %}{

	"serviceLink": {

		"name": "string",

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
To cancelrollback the externalService
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

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
To cancelupgrade the externalService
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

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
To deactivate the externalService
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

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
To finishupgrade the externalService
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

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
To remove the externalService
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

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
To removeservicelink the externalService
<br>

<span class="input">
<strong>Input:</strong>​​​ addRemoveServiceLinkInput


Field | Type | Required | Default | Description
---|---|---|---|---
serviceLink | serviceLink | Yes | <no value> | The serviceLink for the addRemoveServiceLinkInput


<br>
{% highlight json %}{

	"serviceLink": {

		"name": "string",

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
To rollback the externalService
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>
{% highlight json %}{}{% endhighlight %}

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
To setservicelinks the externalService
<br>

<span class="input">
<strong>Input:</strong>​​​ setServiceLinksInput


Field | Type | Required | Default | Description
---|---|---|---|---
serviceLinks | array[serviceLink] | No | <no value> | The list of services linked


<br>
{% highlight json %}{

	"serviceLinks": "array[serviceLink]"

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
To upgrade the externalService
<br>

<span class="input">
<strong>Input:</strong>​​​ serviceUpgrade


Field | Type | Required | Default | Description
---|---|---|---|---
inServiceStrategy | inServiceUpgradeStrategy | No | <no value> | ALENA
toServiceStrategy | toServiceUpgradeStrategy | No | <no value> | ALENA


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

