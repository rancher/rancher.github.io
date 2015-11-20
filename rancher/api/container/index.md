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
capAdd | array[enum] | Optional | - | - | Add Linux capabilities. <code>--cap-add</code> in a <code>docker run</code> command
capDrop | array[enum] | Optional | - | - | Drop Linux capabilities. <code>--cap-drop</code> in a <code>docker run</code> command
command | array[string] | Optional | - | - | Overwrite the default commands set by the image
count | int | Optional | - | - | 
cpuSet | string | Optional | - | - | CPUs in which to allow execution (0-3, 0,1). <code>--cpuset</code> in a <code>docker run</code> command
cpuShares | int | Optional | - | - | CPU shares (relative weight). <code>--cpu-shares</code> in a <code>docker run</code> command
createIndex | int | - | - | - | The order that the container was created in a service.
dataVolumeMounts | map[[volume]({{site.baseurl}}/rancher/api/volume/)] | Optional | - | - | 
dataVolumes | array[string] | Optional | - | - | 
dataVolumesFrom | array[[container]({{site.baseurl}}/rancher/api/container/)] | Optional | - | - | 
deploymentUnitUuid | string | - | - | - | 
devices | array[string] | Optional | - | - | Allows you to run devices inside the container without the <code>--privileged</code> flag
dns | array[string] | Optional | - | - | Set custom dns servers for the container. <code>--dns</code> in a <code>docker run</code> command
dnsSearch | array[string] | Optional | - | - | 
domainName | string | Optional | - | - | 
entryPoint | array[string] | Optional | - | - | Overwrite the default entrypoint set by the image. <code>--entrypoint</code> in a <code>docker run</code> command
environment | map[string] | Optional | - | - | 
expose | array[string] | Optional | - | - | 
externalId | string | - | - | - | 
extraHosts | array[string] | Optional | - | - | 
firstRunning | date | - | - | - | 
healthCheck | [instanceHealthCheck]({{site.baseurl}}/rancher/api/instanceHealthCheck/) | Optional | - | - | The configuration of the health monitoring for managed network services
healthState | enum | - | - | - | 
hostname | string | Optional | - | - | 
imageUuid | string | Optional | - | - | 
instanceLinks | map[[instance]({{site.baseurl}}/rancher/api/instance/)] | Optional | - | - | 
labels | map[string] | Optional | - | - | 
logConfig | [logConfig]({{site.baseurl}}/rancher/api/logConfig/) | Optional | - | - | The logging configuration. <code>--log-driver</code> in a <code>docker run</code> command
lxcConf | map[string] | Optional | - | - | Add custom lxc options. <code>--lxc-conf</code> in a <code>docker run</code> command
memory | int | Optional | - | - | 
memorySwap | int | Optional | - | - | Total memory limit (memory + swap, `<number>[<unit>]`, where unit = b, k, m or g). <code>--memory-swap</code> in a <code>docker run</code> command
nativeContainer | boolean | - | - | - | 
networkContainerId | [container]({{site.baseurl}}/rancher/api/container/) | Optional | - | - | 
networkIds | array[[network]({{site.baseurl}}/rancher/api/network/)] | Optional | - | - | 
networkMode | enum | Optional | - | managed | Set the Network mode for the container. <code>--net</code> in a <code>docker run</code> command <br> `bridge` - creates a new network stack for the container on the docker bridge<br> `none` -no networking for this container<br> `container<colon><name|id>` - reuses another container network stack<br> `host` - use the host network stack inside the container
pidMode | enum | Optional | - | - | Set the PID (Process) Namespace mode for the container. `host` - use the host's PID namespace inside the container.  <code>--pid</code> in a <code>docker run</code> command
ports | array[string] | Optional | - | - | 
primaryIpAddress | string | - | - | - | 
privileged | boolean | Optional | - | - | Give extended privileges to this container. <code>--privileged</code> in a <code>docker run</code> command
publishAllPorts | boolean | Optional | - | - | Publish all exposed ports to the host interfaces
readOnly | boolean | Optional | - | - | 
registryCredentialId | [registryCredential]({{site.baseurl}}/rancher/api/registryCredential/) | Optional | - | - | 
requestedHostId | [host]({{site.baseurl}}/rancher/api/host/) | Optional | - | - | 
restartPolicy | [restartPolicy]({{site.baseurl}}/rancher/api/restartPolicy/) | Optional | - | - | Specify a restart policy for how a container should or should not be restarted on exit.
securityOpt | array[string] | Optional | - | - | Override the default labeling scheme for each container. <code>--security-opt</code> in a <code>docker run</code> command
startCount | int | - | - | - | 
startOnCreate | boolean | Optional | - | true | Whether or not the services in the stack should be started after creation
stdinOpen | boolean | Optional | - | - | Keep STDIN open even if not attached. <code>-i</code> in a <code>docker run</code> command
systemContainer | enum | - | - | - | 
tty | boolean | Optional | - | - | Allocate a pseudo-tty. <code>-t</code> in a <code>docker run</code> command
user | string | Optional | - | - | 
version | string | - | - | 0 | 
volumeDriver | string | Optional | - | - | 
workingDir | string | Optional | - | - | The working directory inside the container
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
attachStdin | boolean | No | true | Attach to standard in stream. <code>-a stdin</code> in a <code>docker run</code> command
attachStdout | boolean | No | true | Attach to standard out stream. <code>-a stdout</code> in a <code>docker run</code> command
command | array[string] | Yes | <no value> | Overwrite the default commands set by the image
tty | boolean | No | true | Allocate a pseudo-tty. <code>-t</code> in a <code>docker run</code> command


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

