---
title: Rancher API - container
layout: rancher-api-v1-default-v1.3
version: v1.3
lang: en
apiVersion: v1
redirect_from:
  - /rancher/v1.3/zh/api/v1/api-resources/container/
---

## Container

A container is a representation of a Docker container on a host.

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
blkioDeviceOptions | map[[blkioDeviceOption]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/blkioDeviceOption/)] | Optional | - | - | 
build | [dockerBuild]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/dockerBuild/) | Optional | - | - | 
capAdd | array[enum] | Optional | - | - | 
capDrop | array[enum] | Optional | - | - | 
command | array[string] | Optional | - | - | 
count | int | Optional | - | - | 
cpuSet | string | Optional | - | - | 
cpuShares | int | Optional | - | - | 
dataVolumeMounts | map[[volume]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/volume/)] | Optional | - | - | 
dataVolumes | array[string] | Optional | - | - | 
dataVolumesFrom | array[[container]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/container/)] | Optional | - | - | 
description | string | Optional | Yes | - | 
devices | array[string] | Optional | - | - | 
dns | array[string] | Optional | - | - | 
dnsSearch | array[string] | Optional | - | - | 
domainName | string | Optional | - | - | 
entryPoint | array[string] | Optional | - | - | 
environment | map[string] | Optional | - | - | 
expose | array[string] | Optional | - | - | 
extraHosts | array[string] | Optional | - | - | 
healthCheck | [instanceHealthCheck]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instanceHealthCheck/) | Optional | - | - | 
hostname | string | Optional | - | - | 
imageUuid | string | Optional | - | - | 
instanceLinks | map[[instance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instance/)] | Optional | - | - | 
labels | map[string] | Optional | - | - | A map of key value pairs to be used as labels for the container
logConfig | [logConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/logConfig/) | Optional | - | - | 
lxcConf | map[string] | Optional | - | - | 
memory | int | Optional | - | - | 
memorySwap | int | Optional | - | - | 
name | string | Optional | Yes | - | 
networkContainerId | [container]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/container/) | Optional | - | - | 
networkIds | array[[network]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/network/)] | Optional | - | - | 
networkMode | enum | Optional | - | managed | The options are `none`, `bridge`, `host`, `managed`, `container`.
pidMode | enum | Optional | - | - | The options are `host`.
ports | array[string] | Optional | - | - | 
privileged | boolean | Optional | - | - | 
publishAllPorts | boolean | Optional | - | - | 
readOnly | boolean | Optional | - | - | 
registryCredentialId | [registryCredential]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/registryCredential/) | Optional | - | - | 
requestedHostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host/) | Optional | - | - | 
restartPolicy | [restartPolicy]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/restartPolicy/) | Optional | - | - | 
securityOpt | array[string] | Optional | - | - | 
startOnCreate | boolean | Optional | - | true | 
stdinOpen | boolean | Optional | - | - | 
tty | boolean | Optional | - | - | 
user | string | Optional | - | - | 
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
nativeContainer | boolean  | 
primaryIpAddress | string  | 
startCount | int  | 
systemContainer | enum  | The options are `NetworkAgent`, `LoadBalancerAgent`.
version | string  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/containers</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
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
	"extraHosts": [
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
	"hostname": "string",
	"imageUuid": "string",
	"instanceLinks": "map[reference[instance]]",
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
	"memorySwap": 0,
	"name": "string",
	"networkContainerId": "reference[container]",
	"networkIds": "array[reference[network]]",
	"networkMode": "managed",
	"pidMode": "enum",
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
	"securityOpt": [
		"string1",
		"...stringN"
	],
	"startOnCreate": true,
	"stdinOpen": false,
	"tty": false,
	"user": "string",
	"volumeDriver": "string",
	"workingDir": "string"
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/containers'
{% endhighlight %}
</div></div>
<a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/projects/${PROJECT_ID}/containers/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X DELETE \
'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/containers/${ID}'
{% endhighlight %}
</div></div>
<a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v1/projects/${PROJECT_ID}/containers/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Content-Type: application/json' \
-d '{
	"description": "string",
	"name": "string"
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/containers/${ID}'
{% endhighlight %}
</div></div>



### Actions

<div class="action" id="console">
<span class="header">
console
<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/containers/${ID}?action=console</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instanceConsoleInput/">InstanceConsoleInput</a></span>


<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/containers/${ID}?action=console'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instanceConsole/">instanceConsole</a> resource</span>
</div></div>

<div class="action" id="execute">
<span class="header">
execute
<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/containers/${ID}?action=execute</code></span></span>
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
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/containers/${ID}?action=execute'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/hostAccess/">hostAccess</a> resource</span>
</div></div>

<div class="action" id="logs">
<span class="header">
logs
<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/containers/${ID}?action=logs</code></span></span>
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
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/containers/${ID}?action=logs'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/hostAccess/">hostAccess</a> resource</span>
</div></div>

<div class="action" id="proxy">
<span class="header">
proxy
<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/containers/${ID}?action=proxy</code></span></span>
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
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/containers/${ID}?action=proxy'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/hostAccess/">hostAccess</a> resource</span>
</div></div>

<div class="action" id="restart">
<span class="header">
restart
<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/containers/${ID}?action=restart</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/containers/${ID}?action=restart'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instance/">instance</a> resource</span>
</div></div>

<div class="action" id="start">
<span class="header">
start
<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/containers/${ID}?action=start</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/containers/${ID}?action=start'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instance/">instance</a> resource</span>
</div></div>

<div class="action" id="stop">
<span class="header">
stop
<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/containers/${ID}?action=stop</code></span></span>
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
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/containers/${ID}?action=stop'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instance/">instance</a> resource</span>
</div></div>


