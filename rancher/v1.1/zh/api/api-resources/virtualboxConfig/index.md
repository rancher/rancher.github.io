---
title: API
layout: rancher-default
version: latest
lang: zh
---

## virtualboxConfig

The configuration to launch a local VM using VirtualBox. Rancher is calling `docker-machine`, so any available options in `docker-machine` are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation.

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
boot2dockerUrl | string | Optional | Yes | - | The URL of the boot2docker image. Defaults to the latest available version
cpuCount | string | Optional | Yes | - | The number of CPUs to use to create the VM. Defaults to single CPU
diskSize | string | Optional | Yes | - | The size of disk for the host in MB
dnsProxy | boolean | Optional | Yes | - | 
hostDnsResolver | boolean | Optional | Yes | - | 
hostonlyCidr | string | Optional | Yes | - | The CIDR of the host only adapter
hostonlyNicpromisc | string | Optional | Yes | - | 
hostonlyNictype | string | Optional | Yes | - | 
importBoot2dockerVm | string | Optional | Yes | - | The name of a Boot2Docker VM to import
memory | string | Optional | Yes | - | The size of memory for the host in MB
noShare | boolean | Optional | Yes | - | Whether or not to disable the mount of your home directory
noVtxCheck | boolean | Optional | Yes | - | 


Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.


### Operations
{::options parse_block_html="true" /}



<div class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/virtualboxConfig</code></span></span>
<div class="action-contents">
{% highlight json %} 
{

	"boot2dockerUrl": "string",

	"cpuCount": "string",

	"diskSize": "string",

	"dnsProxy": true,

	"hostDnsResolver": true,

	"hostonlyCidr": "string",

	"hostonlyNicpromisc": "string",

	"hostonlyNictype": "string",

	"importBoot2dockerVm": "string",

	"memory": "string",

	"noShare": true,

	"noVtxCheck": true

} 
{% endhighlight %}
</div>
</div>










