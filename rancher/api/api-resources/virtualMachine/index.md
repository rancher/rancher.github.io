---
title: API
layout: rancher-default
---

## virtualMachine



​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
command | array[string] | Optional | - | - | 
count | int | Optional | - | - | 
cpuSet | string | Optional | - | - | 
cpuShares | int | Optional | - | - | 
createIndex | int | - | - | - | 
deploymentUnitUuid | string | - | - | - | 
description | string | Optional | Yes | - | 
disks | array[virtualMachineDisk] | Optional | - | - | 
dns | array[string] | Optional | - | - | 
dnsSearch | array[string] | Optional | - | - | 
domainName | string | Optional | - | - | 
expose | array[string] | Optional | - | - | 
externalId | string | - | - | - | 
extraHosts | array[string] | Optional | - | - | 
firstRunning | date | - | - | - | 
healthCheck | [instanceHealthCheck]({{site.baseurl}}/rancher/api/api-resources/instanceHealthCheck/) | Optional | - | - | 
healthState | enum | - | - | - | 
hostId | [host]({{site.baseurl}}/rancher/api/api-resources/host/) | - | - | - | The unique identifier for the associated host
hostname | string | Optional | - | - | 
id | int | - | - | - | The unique identifier for the virtualMachine
imageUuid | string | Optional | - | - | 
instanceLinks | map[[instance]({{site.baseurl}}/rancher/api/api-resources/instance/)] | Optional | - | - | 
labels | map[string] | Optional | - | - | 
logConfig | [logConfig]({{site.baseurl}}/rancher/api/api-resources/logConfig/) | Optional | - | - | 
memory | int | Optional | - | - | 
memoryMb | int | Optional | - | 512 | 
memorySwap | int | Optional | - | - | 
name | string | Optional | Yes | - | 
nativeContainer | boolean | - | - | - | 
networkIds | array[[network]({{site.baseurl}}/rancher/api/api-resources/network/)] | Optional | - | - | 
networkMode | enum | Optional | - | managed | 
ports | array[string] | Optional | - | - | 
primaryIpAddress | string | - | - | - | 
registryCredentialId | [registryCredential]({{site.baseurl}}/rancher/api/api-resources/registryCredential/) | Optional | - | - | 
requestedHostId | [host]({{site.baseurl}}/rancher/api/api-resources/host/) | Optional | - | - | 
restartPolicy | [restartPolicy]({{site.baseurl}}/rancher/api/api-resources/restartPolicy/) | Optional | - | - | 
securityOpt | array[string] | Optional | - | - | 
startCount | int | - | - | - | 
startOnCreate | boolean | Optional | - | true | 
systemContainer | enum | - | - | - | 
userdata | string | Optional | - | - | 
vcpu | int | Optional | - | 1 | 
version | string | - | - | 0 | 
volumeDriver | string | Optional | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.
​

### Operations



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/virtualMachine</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"command": [

		"string1",

		"string2",

		"...stringN"

	],

	"count": 0,

	"cpuSet": "string",

	"cpuShares": 0,

	"description": "string",

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

	"memory": 0,

	"memoryMb": 512,

	"memorySwap": 0,

	"name": "string",

	"networkIds": "array[reference[network]]",

	"networkMode": "managed",

	"ports": [

		"string1",

		"string2",

		"...stringN"

	],

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

	"userdata": "string",

	"vcpu": 1,

	"volumeDriver": "string"

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
<span class="headerright">POST:  <code>${actions.allocate}</code></span>
</span>
<div class="action-contents">
To allocate the virtualMachine
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
console
<span class="headerright">POST:  <code>${actions.console}</code></span>
</span>
<div class="action-contents">
To console the virtualMachine
<br>

<span class="input">
<strong>Input:</strong>​​​ instanceConsoleInput


<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instanceConsole/">instanceConsole</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
deallocate
<span class="headerright">POST:  <code>${actions.deallocate}</code></span>
</span>
<div class="action-contents">
To deallocate the virtualMachine
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
error
<span class="headerright">POST:  <code>${actions.error}</code></span>
</span>
<div class="action-contents">
To error the virtualMachine
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
execute
<span class="headerright">POST:  <code>${actions.execute}</code></span>
</span>
<div class="action-contents">
To execute the virtualMachine
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

	"command": [

		"string1",

		"string2",

		"...stringN"

	],

	"tty": true

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/hostAccess/">hostAccess</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
logs
<span class="headerright">POST:  <code>${actions.logs}</code></span>
</span>
<div class="action-contents">
To logs the virtualMachine
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

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/hostAccess/">hostAccess</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
migrate
<span class="headerright">POST:  <code>${actions.migrate}</code></span>
</span>
<div class="action-contents">
To migrate the virtualMachine
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
proxy
<span class="headerright">POST:  <code>${actions.proxy}</code></span>
</span>
<div class="action-contents">
To proxy the virtualMachine
<br>

<span class="input">
<strong>Input:</strong>​​​ containerProxy


Field | Type | Required | Default | Notes
---|---|---|---|---
port | int | No | 80 | 
scheme | enum | No | http | 


<br>
{% highlight json %}{

	"port": 80,

	"scheme": "http"

}{% endhighlight %}

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/hostAccess/">hostAccess</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
purge
<span class="headerright">POST:  <code>${actions.purge}</code></span>
</span>
<div class="action-contents">
To purge the virtualMachine
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource
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
To remove the virtualMachine
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource
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
To restart the virtualMachine
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
restore
<span class="headerright">POST:  <code>${actions.restore}</code></span>
</span>
<div class="action-contents">
To restore the virtualMachine
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
setlabels
<span class="headerright">POST:  <code>${actions.setlabels}</code></span>
</span>
<div class="action-contents">
To setlabels the virtualMachine
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

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/container/">container</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
start
<span class="headerright">POST:  <code>${actions.start}</code></span>
</span>
<div class="action-contents">
To start the virtualMachine
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
stop
<span class="headerright">POST:  <code>${actions.stop}</code></span>
</span>
<div class="action-contents">
To stop the virtualMachine
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

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
updatehealthy
<span class="headerright">POST:  <code>${actions.updatehealthy}</code></span>
</span>
<div class="action-contents">
To updatehealthy the virtualMachine
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
updatereinitializing
<span class="headerright">POST:  <code>${actions.updatereinitializing}</code></span>
</span>
<div class="action-contents">
To updatereinitializing the virtualMachine
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
updateunhealthy
<span class="headerright">POST:  <code>${actions.updateunhealthy}</code></span>
</span>
<div class="action-contents">
To updateunhealthy the virtualMachine
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/instance/">instance</a> resource
</span>
</div>
</span>
</span>
</span>

