---
title: API
layout: rancher-default
---

## container

A container is a representation of a Docker container on a host.
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
build | [dockerBuild]({{site.baseurl}}/rancher/api/dockerBuild/) | Optional | - | - | The build for the container
capAdd | array[enum] | Optional | - | - | The capAdd for the container
capDrop | array[enum] | Optional | - | - | The capDrop for the container
command | array[string] | Optional | - | - | The command for the container
count | int | Optional | - | - | The count for the container
cpuSet | string | Optional | - | - | The cpuSet for the container
cpuShares | int | Optional | - | - | The cpuShares for the container
createIndex | int | - | - | - | The createIndex for the container
dataVolumeMounts | map[[volume]({{site.baseurl}}/rancher/api/volume/)] | Optional | - | - | The dataVolumeMounts for the container
dataVolumes | array[string] | Optional | - | - | The dataVolumes for the container
dataVolumesFrom | array[[container]({{site.baseurl}}/rancher/api/container/)] | Optional | - | - | The dataVolumesFrom for the container
deploymentUnitUuid | string | - | - | - | The deploymentUnitUuid for the container
devices | array[string] | Optional | - | - | The devices for the container
dns | array[string] | Optional | - | - | The dns for the container
dnsSearch | array[string] | Optional | - | - | The dnsSearch for the container
domainName | string | Optional | - | - | The domainName for the container
entryPoint | array[string] | Optional | - | - | The entryPoint for the container
environment | map[string] | Optional | - | - | The environment for the container
expose | array[string] | Optional | - | - | The expose for the container
externalId | string | - | - | - | The externalId for the container
extraHosts | array[string] | Optional | - | - | The extraHosts for the container
firstRunning | date | - | - | - | The firstRunning for the container
healthCheck | [instanceHealthCheck]({{site.baseurl}}/rancher/api/instanceHealthCheck/) | Optional | - | - | The healthCheck for the container
healthState | enum | - | - | - | The healthState for the container
hostname | string | Optional | - | - | The hostname for the container
imageUuid | string | Optional | - | - | The imageUuid for the container
instanceLinks | map[[instance]({{site.baseurl}}/rancher/api/instance/)] | Optional | - | - | The instanceLinks for the container
labels | map[string] | Optional | - | - | The labels for the container
logConfig | [logConfig]({{site.baseurl}}/rancher/api/logConfig/) | Optional | - | - | The logConfig for the container
lxcConf | map[string] | Optional | - | - | The lxcConf for the container
memory | int | Optional | - | - | The memory for the container
memorySwap | int | Optional | - | - | The memorySwap for the container
nativeContainer | boolean | - | - | - | The nativeContainer for the container
networkContainerId | [container]({{site.baseurl}}/rancher/api/container/) | Optional | - | - | The networkContainerId for the container
networkIds | array[[network]({{site.baseurl}}/rancher/api/network/)] | Optional | - | - | The networkIds for the container
networkMode | enum | Optional | - | managed | The networkMode for the container
pidMode | enum | Optional | - | - | The pidMode for the container
ports | array[string] | Optional | - | - | The ports for the container
primaryIpAddress | string | - | - | - | The primaryIpAddress for the container
privileged | boolean | Optional | - | - | The privileged for the container
publishAllPorts | boolean | Optional | - | - | The publishAllPorts for the container
readOnly | boolean | Optional | - | - | The readOnly for the container
registryCredentialId | [registryCredential]({{site.baseurl}}/rancher/api/registryCredential/) | Optional | - | - | The registryCredentialId for the container
requestedHostId | [host]({{site.baseurl}}/rancher/api/host/) | Optional | - | - | The requestedHostId for the container
restartPolicy | [restartPolicy]({{site.baseurl}}/rancher/api/restartPolicy/) | Optional | - | - | The restartPolicy for the container
securityOpt | array[string] | Optional | - | - | The securityOpt for the container
startCount | int | - | - | - | The startCount for the container
startOnCreate | boolean | Optional | - | true | The startOnCreate for the container
stdinOpen | boolean | Optional | - | - | The stdinOpen for the container
systemContainer | enum | - | - | - | The systemContainer for the container
tty | boolean | Optional | - | - | The tty for the container
user | string | Optional | - | - | The user for the container
version | string | - | - | 0 | The version for the container
volumeDriver | string | Optional | - | - | The volumeDriver for the container
workingDir | string | Optional | - | - | The workingDir for the container




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
accountId | [account]({{site.baseurl}}/rancher/api/account/) | - | - | - | The unique identifier for the associated account
created | date | - | - | - | The date of when the container was created.
description | string | Optional | Yes | - | The description for the container
id | int | - | - | - | The unique identifier for the container
kind | string | - | - | - | The kind for the container
name | string | Optional | Yes | - | The name for the container
removed | date | - | - | - | The date of when the container was removed
state | enum | - | - | - | The current state of the container. The options are [creating, migrating, purged, purging, removed, removing, requested, restarting, restoring, running, starting, stopped, stopping, updating-running, updating-stopped].
transitioning | enum | - | - | - | Whether or not the container is in a transitioning state
transitioningMessage | string | - | - | - | The message to show while in a transitioning state
transitioningProgress | int | - | - | - | The percentage remaining in the transitioning process of the container
uuid | string | - | - | - | The universally unique identifier for the container. This will always be unique across Rancher installations.




### Actions



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
{% highlight json %}{}{% endhighlight %}

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
{% highlight json %}{}{% endhighlight %}

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
{% highlight json %}{}{% endhighlight %}

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


Field | Type | Required | Default | Description
---|---|---|---|---
attachStdin | boolean | No | true | The attachStdin for the containerExec
attachStdout | boolean | No | true | The attachStdout for the containerExec
command | array[string] | Yes | <no value> | The command for the containerExec
tty | boolean | No | true | The tty for the containerExec


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


Field | Type | Required | Default | Description
---|---|---|---|---
follow | boolean | No | true | The follow for the containerLogs
lines | int | No | 100 | The lines for the containerLogs


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
{% highlight json %}{}{% endhighlight %}

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
{% highlight json %}{}{% endhighlight %}

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
{% highlight json %}{}{% endhighlight %}

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
{% highlight json %}{}{% endhighlight %}

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
{% highlight json %}{}{% endhighlight %}

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


Field | Type | Required | Default | Description
---|---|---|---|---
labels | json | No | <no value> | The labels for the setLabelsInput


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
{% highlight json %}{}{% endhighlight %}

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


Field | Type | Required | Default | Description
---|---|---|---|---
remove | boolean | No | <no value> | The remove for the instanceStop
timeout | int | No | <no value> | The timeout for the instanceStop


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
{% highlight json %}{}{% endhighlight %}

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
{% highlight json %}{}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/instance/">instance</a> resource
</span>
</div>
</span>
</span>
</span>

