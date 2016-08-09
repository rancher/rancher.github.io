---
title: Rancher API - container
layout: rancher-api-default
version: latest
lang: en
---

## Container

A container is a representation of a Docker container on a host.

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
blkioDeviceOptions | map[[blkioDeviceOption]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/blkioDeviceOption/)] | Optional | - | - | 
build | [dockerBuild]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/dockerBuild/) | Optional | - | - | 
capAdd | array[enum] | Optional | - | - | 
capDrop | array[enum] | Optional | - | - | 
command | array[string] | Optional | - | - | 
count | int | Optional | - | - | 
cpuSet | string | Optional | - | - | 
cpuShares | int | Optional | - | - | 
createIndex | int | - | - | - | 
dataVolumeMounts | map[[volume]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/volume/)] | Optional | - | - | 
dataVolumes | array[string] | Optional | - | - | 
dataVolumesFrom | array[[container]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/container/)] | Optional | - | - | 
deploymentUnitUuid | string | - | - | - | 
description | string | Optional | Yes | - | 
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
healthCheck | [instanceHealthCheck]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/instanceHealthCheck/) | Optional | - | - | 
healthState | enum | - | - | - | 
hostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/host/) | - | - | - | The unique identifier for the associated host
hostname | string | Optional | - | - | 
id | int | - | - | - | The unique identifier for the container
imageUuid | string | Optional | - | - | 
instanceLinks | map[[instance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/instance/)] | Optional | - | - | 
labels | map[string] | Optional | - | - | A map of key value pairs to be used as labels for the container
logConfig | [logConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/logConfig/) | Optional | - | - | 
lxcConf | map[string] | Optional | - | - | 
memory | int | Optional | - | - | 
memorySwap | int | Optional | - | - | 
name | string | Optional | Yes | - | 
nativeContainer | boolean | - | - | - | 
networkContainerId | [container]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/container/) | Optional | - | - | 
networkIds | array[[network]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/network/)] | Optional | - | - | 
networkMode | enum | Optional | - | managed | 
pidMode | enum | Optional | - | - | 
ports | array[string] | Optional | - | - | 
primaryIpAddress | string | - | - | - | 
privileged | boolean | Optional | - | - | 
publishAllPorts | boolean | Optional | - | - | 
readOnly | boolean | Optional | - | - | 
registryCredentialId | [registryCredential]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/registryCredential/) | Optional | - | - | 
requestedHostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/host/) | Optional | - | - | 
restartPolicy | [restartPolicy]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/restartPolicy/) | Optional | - | - | 
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

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/container</code></span></span>
<div class="action-contents">
{% highlight json %}
{
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
	"dataVolumeMounts": "map[reference[volume]]",
	"dataVolumes": [
		"string1",
		"string2",
		"...stringN"
	],
	"dataVolumesFrom": "array[reference[container]]",
	"description": "string",
	"devices": [
		"string1",
		"string2",
		"...stringN"
	],
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
	"extraHosts": [
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
	"imageUuid": "string",
	"instanceLinks": "map[reference[instance]]",
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
	"memorySwap": 0,
	"name": "string",
	"networkContainerId": "reference[container]",
	"networkIds": "array[reference[network]]",
	"networkMode": "managed",
	"pidMode": "enum",
	"ports": [
		"string1",
		"string2",
		"...stringN"
	],
	"privileged": false,
	"publishAllPorts": false,
	"readOnly": false,
	"registryCredentialId": "reference[registryCredential]",
	"requestedHostId": "reference[host]",
	"restartPolicy": {
		"maximumRetryCount": 0,
		"name": "string"
	},
	"securityOpt": [
		"string1",
		"string2",
		"...stringN"
	],
	"startOnCreate": true,
	"stdinOpen": false,
	"tty": false,
	"user": "string",
	"volumeDriver": "string",
	"workingDir": "string"
}
{% endhighlight %}
</div>
</div>



<a id="update"></a>
<div class="action">
<span class="header">Update
<span class="headerright">PUT:  <code>${links.self}</code></span></span>
<div class="action-contents">
{% highlight json %}
{
	"description": "string",
	"name": "string"
}
{% endhighlight %}
</div>
</div>


<a id="delete"></a>
<div class="action">
<span class="header">Delete
<span class="headerright">DELETE:  <code>${links.self}</code></span></span>
<div class="action-contents">
{% highlight json %}

{% endhighlight %}
</div>
</div>

### Actions
<div class="action">
<span class="header">
console
<span class="headerright">POST:  <code>/v1/containers/${ID}/?action=console</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> instanceConsoleInput</span>


<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instanceConsole/">instanceConsole</a> resource</span>
</div></div>

<div class="action">
<span class="header">
execute
<span class="headerright">POST:  <code>/v1/containers/${ID}/?action=execute</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> containerExec</span>

<br>{% highlight json %}{
	"attachStdin": true,
	"attachStdout": true,
	"command": [
		"string1",
		"string2",
		"...stringN"
	],
	"tty": true
}{% endhighlight %}<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/hostAccess/">hostAccess</a> resource</span>
</div></div>

<div class="action">
<span class="header">
logs
<span class="headerright">POST:  <code>/v1/containers/${ID}/?action=logs</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> containerLogs</span>

<br>{% highlight json %}{
	"follow": true,
	"lines": 100
}{% endhighlight %}<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/hostAccess/">hostAccess</a> resource</span>
</div></div>

<div class="action">
<span class="header">
proxy
<span class="headerright">POST:  <code>/v1/containers/${ID}/?action=proxy</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> containerProxy</span>

<br>{% highlight json %}{
	"port": 80,
	"scheme": "http"
}{% endhighlight %}<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/hostAccess/">hostAccess</a> resource</span>
</div></div>

<div class="action">
<span class="header">
restart
<span class="headerright">POST:  <code>/v1/containers/${ID}/?action=restart</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource</span>
</div></div>

<div class="action">
<span class="header">
start
<span class="headerright">POST:  <code>/v1/containers/${ID}/?action=start</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource</span>
</div></div>

<div class="action">
<span class="header">
stop
<span class="headerright">POST:  <code>/v1/containers/${ID}/?action=stop</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> instanceStop</span>

<br>{% highlight json %}{
	"remove": true,
	"timeout": 0
}{% endhighlight %}<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource</span>
</div></div>


