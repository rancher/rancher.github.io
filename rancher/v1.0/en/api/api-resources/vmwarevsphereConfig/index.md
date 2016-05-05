---
title: API
layout: rancher-default-v1.0
version: v1.0
lang: en
---

## vmwarevsphereConfig

The configuration to launch a machine in vSphere. Rancher is just calling `docker-machine`, so any available options in `docker-machine` are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation.

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
boot2dockerUrl | string | Optional | Yes | - | The URL of the boot2docker image. Defaults to the latest available version
cpuCount | string | Optional | Yes | - | The number of CPUs to use to create the VM. Defaults to single CPU
datacenter | string | Optional | Yes | - | The datacenter for Docker VM
datastore | string | Optional | Yes | - | The datastore for Docker VM
diskSize | string | Optional | Yes | - | The size of disk for Docker VM (in MB)
hostsystem | string | Optional | Yes | - | 
memorySize | string | Optional | Yes | - | The size of memory for Docker VM (in MB) and added as `2048`
network | string | Optional | Yes | - | The network where the Docker VM will be attached
password | string | Optional | Yes | - | <strong>required</strong> Your vSphere password
pool | string | Optional | Yes | - | The resource pool for Docker VM
username | string | Optional | Yes | - | <strong>required</strong> Your vSphere username
vcenter | string | Optional | Yes | - | The IP/hostname for vCenter (or ESXi if connecting directly to a single host)
vcenterPort | string | Optional | Yes | - | 


Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.


### Operations
{::options parse_block_html="true" /}



<div class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/vmwarevsphereConfig</code></span></span>
<div class="action-contents">
{% highlight json %} 
{

	"boot2dockerUrl": "string",

	"cpuCount": "string",

	"datacenter": "string",

	"datastore": "string",

	"diskSize": "string",

	"hostsystem": "string",

	"memorySize": "string",

	"network": "string",

	"password": "string",

	"pool": "string",

	"username": "string",

	"vcenter": "string",

	"vcenterPort": "string"

} 
{% endhighlight %}
</div>
</div>










