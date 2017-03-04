---
title: Rancher API - container
layout: rancher-api-v2-beta-default-v1.5
version: v1.5
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.5/zh/api/v2-beta/api-resources/container/
---

## Container

A container is a representation of a Docker container on a host.

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
blkioDeviceOptions | map[[blkioDeviceOption]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/blkioDeviceOption/)] | Optional | - | - | 
blkioWeight | int | Optional | - | - | 
build | [dockerBuild]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/dockerBuild/) | Optional | - | - | 
capAdd | array[enum] | Optional | - | - | 
capDrop | array[enum] | Optional | - | - | 
cgroupParent | string | Optional | - | - | 
command | array[string] | Optional | - | - | 
count | int | Optional | - | - | 
cpuCount | int | Optional | - | - | 
cpuPercent | int | Optional | - | - | 
cpuPeriod | int | Optional | - | - | 
cpuQuota | int | Optional | - | - | 
cpuSet | string | Optional | - | - | 
cpuSetMems | string | Optional | - | - | 
cpuShares | int | Optional | - | - | 
dataVolumeMounts | map[[volume]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/volume/)] | Optional | - | - | 
dataVolumes | array[string] | Optional | - | - | 
dataVolumesFrom | array[[container]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/container/)] | Optional | - | - | 
description | string | Optional | Yes | - | 
devices | array[string] | Optional | - | - | 
diskQuota | int | Optional | - | - | 
dns | array[string] | Optional | - | - | 
dnsOpt | array[string] | Optional | - | - | 
dnsSearch | array[string] | Optional | - | - | 
domainName | string | Optional | - | - | 
entryPoint | array[string] | Optional | - | - | 
environment | map[string] | Optional | - | - | 
expose | array[string] | Optional | - | - | 
extraHosts | array[string] | Optional | - | - | 
groupAdd | array[string] | Optional | - | - | 
healthCheck | [instanceHealthCheck]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instanceHealthCheck/) | Optional | - | - | 
healthCmd | array[string] | Optional | - | - | 
healthInterval | int | Optional | - | - | 
healthRetries | int | Optional | - | - | 
healthTimeout | int | Optional | - | - | 
hostname | string | Optional | - | - | 
imageUuid | string | Optional | - | - | 
instanceLinks | map[[instance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instance/)] | Optional | - | - | 
instanceTriggeredStop | enum | Optional | - | stop | The options are `stop`, `remove`.
ioMaximumBandwidth | int | Optional | - | - | 
ioMaximumIOps | int | Optional | - | - | 
ip | string | Optional | - | - | 
ip6 | string | Optional | - | - | 
ipcMode | string | Optional | - | - | 
isolation | string | Optional | - | - | 
kernelMemory | int | Optional | - | - | 
labels | map[string] | Optional | - | - | A map of key value pairs to be used as labels for the container
logConfig | [logConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/logConfig/) | Optional | - | - | 
lxcConf | map[string] | Optional | - | - | 
memory | int | Optional | - | - | 
memoryReservation | int | Optional | - | - | 
memorySwap | int | Optional | - | - | 
memorySwappiness | int | Optional | - | - | 
milliCpuReservation | int | Optional | - | - | 
name | string | Optional | Yes | - | 
netAlias | array[string] | Optional | - | - | 
networkContainerId | [container]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/container/) | Optional | - | - | 
networkIds | array[[network]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/network/)] | Optional | - | - | 
networkMode | string | Optional | - | managed | 
oomKillDisable | boolean | Optional | - | - | 
oomScoreAdj | int | Optional | - | - | 
pidMode | enum | Optional | - | - | The options are `host`.
pidsLimit | int | Optional | - | - | 
ports | array[string] | Optional | - | - | 
privileged | boolean | Optional | - | - | 
publishAllPorts | boolean | Optional | - | - | 
readOnly | boolean | Optional | - | - | 
registryCredentialId | [registryCredential]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/registryCredential/) | Optional | - | - | 
requestedHostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host/) | Optional | - | - | 
restartPolicy | [restartPolicy]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/restartPolicy/) | Optional | - | - | 
secrets | array[[secretReference]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/secretReference/)] | Optional | - | - | 
securityOpt | array[string] | Optional | - | - | 
shmSize | int | Optional | - | - | 
stackId | [stack]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/stack/) | Optional | - | - | 
startOnCreate | boolean | Optional | - | true | 
stdinOpen | boolean | Optional | - | - | 
stopSignal | string | Optional | - | - | 
storageOpt | map[string] | Optional | - | - | 
sysctls | map[string] | Optional | - | - | 
tmpfs | map[string] | Optional | - | - | 
tty | boolean | Optional | - | - | 
ulimits | array[[ulimit]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/ulimit/)] | Optional | - | - | 
user | string | Optional | - | - | 
usernsMode | string | Optional | - | - | 
uts | string | Optional | - | - | 
volumeDriver | string | Optional | - | - | 
workingDir | string | Optional | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
createIndex | int  | 
deploymentUnitUuid | string  | 
externalId | string  | 
firstRunning | date  | 
healthState | enum  | The options are `healthy`, `unhealthy`, `updating-healthy`, `updating-unhealthy`, `initializing`.
hostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host/)  | The unique identifier for the associated host
id | int  | The unique identifier for the container
mounts | array[[mountEntry]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/mountEntry/)]  | 
nativeContainer | boolean  | 
primaryIpAddress | string  | 
primaryNetworkId | [network]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/network/)  | 
serviceId | [service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/)  | The unique identifier of the associated service
serviceIds | array[[service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/)]  | 
startCount | int  | 
system | boolean  | 
userPorts | array[string]  | 
version | string  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/containers</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
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
	"dataVolumeMounts": "map[reference[volume]]",
	"dataVolumes": [
		"string1",
		"...stringN"
	],
	"dataVolumesFrom": "array[reference[container]]",
	"description": "string",
	"devices": [
		"string1",
		"...stringN"
	],
	"diskQuota": 0,
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
	"extraHosts": [
		"string1",
		"...stringN"
	],
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
	"healthTimeout": 0,
	"hostname": "string",
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
	"memoryReservation": 0,
	"memorySwap": 0,
	"memorySwappiness": 0,
	"milliCpuReservation": 0,
	"name": "string",
	"netAlias": [
		"string1",
		"...stringN"
	],
	"networkContainerId": "reference[container]",
	"networkIds": "array[reference[network]]",
	"networkMode": "managed",
	"oomKillDisable": false,
	"oomScoreAdj": 0,
	"pidMode": "enum",
	"pidsLimit": 0,
	"ports": [
		"string1",
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
	"secrets": "array[secretReference]",
	"securityOpt": [
		"string1",
		"...stringN"
	],
	"shmSize": 0,
	"stackId": "reference[stack]",
	"startOnCreate": true,
	"stdinOpen": false,
	"stopSignal": "string",
	"storageOpt": {
		"key": "value-pairs"
	},
	"sysctls": {
		"key": "value-pairs"
	},
	"tmpfs": {
		"key": "value-pairs"
	},
	"tty": false,
	"ulimits": "array[ulimit]",
	"user": "string",
	"usernsMode": "string",
	"uts": "string",
	"volumeDriver": "string",
	"workingDir": "string"
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/containers'
{% endhighlight %}
</div></div>
<a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v2-beta/projects/${PROJECT_ID}/containers/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X DELETE \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/containers/${ID}'
{% endhighlight %}
</div></div>
<a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v2-beta/projects/${PROJECT_ID}/containers/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Content-Type: application/json' \
-d '{
	"description": "string",
	"name": "string"
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/containers/${ID}'
{% endhighlight %}
</div></div>



### Actions

<div class="action" id="console">
<span class="header">
console
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/containers/${ID}?action=console</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instanceConsoleInput/">InstanceConsoleInput</a></span>


<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/containers/${ID}?action=console'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instanceConsole/">instanceConsole</a> resource</span>
</div></div>

<div class="action" id="execute">
<span class="header">
execute
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/containers/${ID}?action=execute</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/containerExec/">ContainerExec</a></span>

Field | Type | Required | Default | Notes
---|---|---|---|---
attachStdin |  | No | true | 
attachStdout |  | No | true | 
command | array[string] | Yes |  | 
tty |  | No | true | 


<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"attachStdin": true,
	"attachStdout": true,
	"command": [
		"string1",
		"...stringN"
	],
	"tty": true
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/containers/${ID}?action=execute'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/hostAccess/">hostAccess</a> resource</span>
</div></div>

<div class="action" id="logs">
<span class="header">
logs
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/containers/${ID}?action=logs</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/containerLogs/">ContainerLogs</a></span>

Field | Type | Required | Default | Notes
---|---|---|---|---
follow |  | No | true | 
lines |  | No | 100 | 


<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"follow": true,
	"lines": 100
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/containers/${ID}?action=logs'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/hostAccess/">hostAccess</a> resource</span>
</div></div>

<div class="action" id="proxy">
<span class="header">
proxy
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/containers/${ID}?action=proxy</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/containerProxy/">ContainerProxy</a></span>

Field | Type | Required | Default | Notes
---|---|---|---|---
port |  | No | 80 | 
scheme |  | No | http | The options are `http`, `https`.


<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"port": 80,
	"scheme": "http"
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/containers/${ID}?action=proxy'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/hostAccess/">hostAccess</a> resource</span>
</div></div>

<div class="action" id="restart">
<span class="header">
restart
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/containers/${ID}?action=restart</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/containers/${ID}?action=restart'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instance/">instance</a> resource</span>
</div></div>

<div class="action" id="start">
<span class="header">
start
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/containers/${ID}?action=start</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/containers/${ID}?action=start'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instance/">instance</a> resource</span>
</div></div>

<div class="action" id="stop">
<span class="header">
stop
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/containers/${ID}?action=stop</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instanceStop/">InstanceStop</a></span>

Field | Type | Required | Default | Notes
---|---|---|---|---
remove |  | No |  | 
timeout |  | No |  | 


<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"remove": false,
	"timeout": 0
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/containers/${ID}?action=stop'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instance/">instance</a> resource</span>
</div></div>


