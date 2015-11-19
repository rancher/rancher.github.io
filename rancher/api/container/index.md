---
title: API
layout: rancher-default
---

## container

A container is a representation of a Docker container on a host.

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
id | int | - | - | - | The unique identifier for the container
kind | string | - | - | - | 
name | string | Optional | Yes | - | 
state | enum | - | - | - | The current state of the container. The options are [creating, migrating, purged, purging, removed, removing, requested, restarting, restoring, running, starting, stopped, stopping, updating-running, updating-stopped].
build | [dockerBuild]({{site.baseurl}}/rancher/api/dockerBuild/) | Optional | - | - | 
capAdd | array[enum] | Optional | - | - | 
capDrop | array[enum] | Optional | - | - | 
command | array[string] | Optional | - | - | 
count | int | Optional | - | - | 
cpuSet | string | Optional | - | - | 
cpuShares | int | Optional | - | - | 
createIndex | int | - | - | - | 
dataVolumeMounts | map[[volume]({{site.baseurl}}/rancher/api/volume/)] | Optional | - | - | 
dataVolumes | array[string] | Optional | - | - | 
dataVolumesFrom | array[[container]({{site.baseurl}}/rancher/api/container/)] | Optional | - | - | 
deploymentUnitUuid | string | - | - | - | 
devices | array[string] | Optional | - | - | 
dns | array[string] | Optional | - | - | 
dnsSearch | array[string] | Optional | - | - | 
domainName | string | Optional | - | - | 
entryPoint | array[string] | Optional | - | - | 
environment | map[string] | Optional | - | - | 
expose | array[string] | Optional | - | - | 
externalId | string | - | - | - | 
extraHosts | array[string] | Optional | - | - | 
firstRunning | date | - | - | - | 
healthCheck | [instanceHealthCheck]({{site.baseurl}}/rancher/api/instanceHealthCheck/) | Optional | - | - | 
healthState | enum | - | - | - | 
hostname | string | Optional | - | - | 
imageUuid | string | Optional | - | - | 
instanceLinks | map[[instance]({{site.baseurl}}/rancher/api/instance/)] | Optional | - | - | 
labels | map[string] | Optional | - | - | 
logConfig | [logConfig]({{site.baseurl}}/rancher/api/logConfig/) | Optional | - | - | 
lxcConf | map[string] | Optional | - | - | 
memory | int | Optional | - | - | 
memorySwap | int | Optional | - | - | 
nativeContainer | boolean | - | - | - | 
networkContainerId | [container]({{site.baseurl}}/rancher/api/container/) | Optional | - | - | 
networkIds | array[[network]({{site.baseurl}}/rancher/api/network/)] | Optional | - | - | 
networkMode | enum | Optional | - | managed | 
pidMode | enum | Optional | - | - | 
ports | array[string] | Optional | - | - | 
primaryIpAddress | string | - | - | - | 
privileged | boolean | Optional | - | - | 
publishAllPorts | boolean | Optional | - | - | 
readOnly | boolean | Optional | - | - | 
registryCredentialId | [registryCredential]({{site.baseurl}}/rancher/api/registryCredential/) | Optional | - | - | 
requestedHostId | [host]({{site.baseurl}}/rancher/api/host/) | Optional | - | - | 
restartPolicy | [restartPolicy]({{site.baseurl}}/rancher/api/restartPolicy/) | Optional | - | - | 
securityOpt | array[string] | Optional | - | - | 
startCount | int | - | - | - | 
startOnCreate | boolean | Optional | - | true | 
stdinOpen | boolean | Optional | - | - | 
systemContainer | enum | - | - | - | 
tty | boolean | Optional | - | - | 
user | string | Optional | - | - | 
version | string | - | - | 0 | 
volumeDriver | string | Optional | - | - | 
workingDir | string | Optional | - | - | 
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the container was created.
description | string | Optional | Yes | - | 
removed | date | - | - | - | The date of when the container was removed
transitioning | enum | - | - | - | Whether or not the container is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the container
uuid | string | - | - | - | The universally unique identifier for the container. This will always be unique across Rancher installations.





### Operations



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

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

	"dataVolumeMounts": "map[reference[volume]]",

	"dataVolumes": "[string, string, string...]",

	"dataVolumesFrom": "array[reference[container]]",

	"description": "string",

	"devices": "[string, string, string...]",

	"dns": "[string, string, string...]",

	"dnsSearch": "[string, string, string...]",

	"domainName": "string",

	"entryPoint": "[string, string, string...]",

	"environment": "map[string]",

	"expose": "[string, string, string...]",

	"extraHosts": "[string, string, string...]",

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

	"imageUuid": "string",

	"instanceLinks": "map[reference[instance]]",

	"labels": "map[string]",

	"logConfig": {

		"config": "map[string]",

		"driver": "string"

	},

	"lxcConf": "map[string]",

	"memory": 0,

	"memorySwap": 0,

	"name": "string",

	"networkContainerId": "reference[container]",

	"networkIds": "array[reference[network]]",

	"networkMode": "managed",

	"pidMode": "enum",

	"ports": "[string, string, string...]",

	"privileged": false,

	"publishAllPorts": false,

	"readOnly": false,

	"registryCredentialId": "reference[registryCredential]",

	"requestedHostId": "reference[host]",

	"restartPolicy": {

		"maximumRetryCount": 0,

		"name": "string"

	},

	"securityOpt": "[string, string, string...]",

	"startOnCreate": true,

	"stdinOpen": false,

	"tty": false,

	"user": "string",

	"volumeDriver": "string",

	"workingDir": "string"

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
### Actions

<span class="action">
<span class="header">
allocate
<span class="headerright">POST:  <code>${action.allocate}</code></span>
</span>
<div class="action-contents">
To allocate the container
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/instance/">instance</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
console
<span class="headerright">POST:  <code>${action.console}</code></span>
</span>
<div class="action-contents">
To console the container
<br>

<span class="input">
<strong>Input:</strong>​​​ instanceConsoleInput


<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/instanceConsole/">instanceConsole</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
deallocate
<span class="headerright">POST:  <code>${action.deallocate}</code></span>
</span>
<div class="action-contents">
To deallocate the container
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/instance/">instance</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
execute
<span class="headerright">POST:  <code>${action.execute}</code></span>
</span>
<div class="action-contents">
To execute the container
<br>

<span class="input">
<strong>Input:</strong>​​​ containerExec


Field | Type | Required | Default | Notes
---|---|---|---|---
attachStdin | boolean | No | true | 
attachStdout | boolean | No | true | 
command | array[string] | Yes | <no value> | 
tty | boolean | No | true | 


<br>
{% highlight json %}{

	"attachStdin": true,

	"attachStdout": true,

	"command": "[string, string, string...]",

	"tty": true

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/hostAccess/">hostAccess</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
logs
<span class="headerright">POST:  <code>${action.logs}</code></span>
</span>
<div class="action-contents">
To logs the container
<br>

<span class="input">
<strong>Input:</strong>​​​ containerLogs


Field | Type | Required | Default | Notes
---|---|---|---|---
follow | boolean | No | true | 
lines | int | No | 100 | 


<br>
{% highlight json %}{

	"follow": true,

	"lines": 100

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/hostAccess/">hostAccess</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
migrate
<span class="headerright">POST:  <code>${action.migrate}</code></span>
</span>
<div class="action-contents">
To migrate the container
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/instance/">instance</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
purge
<span class="headerright">POST:  <code>${action.purge}</code></span>
</span>
<div class="action-contents">
To purge the container
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/instance/">instance</a> resource
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
To remove the container
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/instance/">instance</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
restart
<span class="headerright">POST:  <code>${action.restart}</code></span>
</span>
<div class="action-contents">
To restart the container
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/instance/">instance</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
restore
<span class="headerright">POST:  <code>${action.restore}</code></span>
</span>
<div class="action-contents">
To restore the container
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/instance/">instance</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
setlabels
<span class="headerright">POST:  <code>${action.setlabels}</code></span>
</span>
<div class="action-contents">
To setlabels the container
<br>

<span class="input">
<strong>Input:</strong>​​​ setLabelsInput


Field | Type | Required | Default | Notes
---|---|---|---|---
labels | json | No | <no value> | 


<br>
{% highlight json %}{

	"labels": "json"

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/container/">container</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
start
<span class="headerright">POST:  <code>${action.start}</code></span>
</span>
<div class="action-contents">
To start the container
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/instance/">instance</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
stop
<span class="headerright">POST:  <code>${action.stop}</code></span>
</span>
<div class="action-contents">
To stop the container
<br>

<span class="input">
<strong>Input:</strong>​​​ instanceStop


Field | Type | Required | Default | Notes
---|---|---|---|---
remove | boolean | No | <no value> | 
timeout | int | No | <no value> | 


<br>
{% highlight json %}{

	"remove": true,

	"timeout": 0

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/instance/">instance</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
updatehealthy
<span class="headerright">POST:  <code>${action.updatehealthy}</code></span>
</span>
<div class="action-contents">
To updatehealthy the container
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/instance/">instance</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
updateunhealthy
<span class="headerright">POST:  <code>${action.updateunhealthy}</code></span>
</span>
<div class="action-contents">
To updateunhealthy the container
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/instance/">instance</a> resource
</span>
</div>
</span>
</span>
</span>

