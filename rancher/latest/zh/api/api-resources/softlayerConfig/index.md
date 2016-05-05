---
title: API
layout: rancher-default
version: latest
lang: zh
---

## softlayerConfig

The configuration to launch a server in SoftLayer. For all cloud providers, Rancher is calling `docker-machine`, so any available options in `docker-machine` are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation.

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
apiEndpoint | string | Optional | Yes | - | The SoftLayer API endpoint to use
apiKey | string | Optional | Yes | - | <strong>required</strong> Your API key for your user account.
cpu | string | Optional | Yes | - | The number of CPUs for the machine
diskSize | string | Optional | Yes | - | A value of 0 will set the SoftLayer default.
domain | string | Optional | Yes | - | <strong>required</strong> The domain name for the machine
hostname | string | Optional | Yes | - | The hostname for the machine
hourlyBilling | boolean | Optional | Yes | - | Whether or not use hourly billing, if `false`, monthly billing is used
image | string | Optional | Yes | - | The OS image to use
localDisk | boolean | Optional | Yes | - | Whether or not to use local machine disk instead of SoftLayer SAN
memory | string | Optional | Yes | - | The memory for host in MB
privateNetOnly | boolean | Optional | Yes | - | Whether or not to disable public networking
privateVlanId | string | Optional | Yes | - | The private VLAN ID
publicVlanId | string | Optional | Yes | - | The public VLAN ID
region | string | Optional | Yes | - | The SoftLayer region
user | string | Optional | Yes | - | <strong>required</strong> Your username for your SoftLayer account


Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.


### Operations
{::options parse_block_html="true" /}



<div class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/softlayerConfig</code></span></span>
<div class="action-contents">
{% highlight json %} 
{

	"apiEndpoint": "string",

	"apiKey": "string",

	"cpu": "string",

	"diskSize": "string",

	"domain": "string",

	"hostname": "string",

	"hourlyBilling": true,

	"image": "string",

	"localDisk": true,

	"memory": "string",

	"privateNetOnly": true,

	"privateVlanId": "string",

	"publicVlanId": "string",

	"region": "string",

	"user": "string"

} 
{% endhighlight %}
</div>
</div>










