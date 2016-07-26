---
title: API
layout: rancher-default
version: latest
lang: en
---

## vmwarevcloudairConfig

The configuration to launch a machine in vCloudAir. Rancher is just calling `docker-machine`, so any available options in `docker-machine` are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation.

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
catalog | string | Optional | Yes | - | The catalog
catalogitem | string | Optional | Yes | - | The catalog item
computeid | string | Optional | Yes | - | The compute ID (if using dedicated cloud)
cpuCount | string | Optional | Yes | - | The number of CPUs to use to create the VM. Defaults to single CPU
dockerPort | string | Optional | Yes | - | The port to use for the Docker daemon
edgegateway | string | Optional | Yes | - | The organization edge gateway
memorySize | string | Optional | Yes | - | The size of memory for Docker VM (in MB) and added as `2048`
orgvdcnetwork | string | Optional | Yes | - | The organization VDC network to attach
password | string | Optional | Yes | - | <strong>required</strong>Your vCloud Air Password
publicip | string | Optional | Yes | - | The  organization public IP to use
sshPort | string | Optional | Yes | - | The SSH port
username | string | Optional | Yes | - | <strong>required</strong> Your vCloud Air username
vdcid | string | Optional | Yes | - | The Virtual Data Center ID


Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.


### Operations
{::options parse_block_html="true" /}



<div class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/vmwarevcloudairConfig</code></span></span>
<div class="action-contents">
{% highlight json %} 
{

	"catalog": "string",

	"catalogitem": "string",

	"computeid": "string",

	"cpuCount": "string",

	"dockerPort": "string",

	"edgegateway": "string",

	"memorySize": "string",

	"orgvdcnetwork": "string",

	"password": "string",

	"publicip": "string",

	"sshPort": "string",

	"username": "string",

	"vdcid": "string"

} 
{% endhighlight %}
</div>
</div>










