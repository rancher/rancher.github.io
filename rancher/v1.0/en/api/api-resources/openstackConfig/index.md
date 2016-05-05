---
title: API
layout: rancher-default-v1.0
version: v1.0
lang: en
---

## openstackConfig

The configuration to launch an instance in OpenStack. For all cloud providers, Rancher is calling `docker-machine`, so any available options in `docker-machine` are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation.

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
activeTimeout | string | Optional | Yes | - | 
authUrl | string | Optional | Yes | - | The keystone service base URL
availabilityZone | string | Optional | Yes | - | The availability zone in which to launch the server
domainId | string | Optional | Yes | - | The ID of the domain to use for authentication (Keystone v3 only)
domainName | string | Optional | Yes | - | Domain to use for authentication (Keystone v3 only)
endpointType | string | Optional | Yes | - | Endpoint type can be `internalURL`, `adminURL`, or` publicURL`. If is a helper for the driver to choose the right URL in the OpenStack service catalog. If not provided the default id `publicURL`
flavorId | string | Optional | Yes | - | The ID of the flavor that will be used for the machine
flavorName | string | Optional | Yes | - | The name of the flavor that will be used for the machine
floatingipPool | string | Optional | Yes | - | The IP pool that will be used to get a public IP can assign it to the machine. If there is an IP address already allocated but not assigned to any machine, this IP will be chosen and assigned to the machine. If there is no IP address already allocated a new IP will be allocated and assigned to the machine.
imageId | string | Optional | Yes | - | The ID of the image that will be used for the machine
imageName | string | Optional | Yes | - | The name of the image that will be used for the machine
insecure | boolean | Optional | Yes | - | Explicitly allow OpenStack driver to perform “insecure” SSL (https) requests. The server’s certificate will not be verified against any certificate authorities. This option should be used with caution.
ipVersion | string | Optional | Yes | - | 
keypairName | string | Optional | Yes | - | 
netId | string | Optional | Yes | - | The ID of the private network the machine will be connected on. If your OpenStack project project contains only one private network it will be use automatically.
netName | string | Optional | Yes | - | The name of the private network the machine will be connected on. If your OpenStack project  contains only one private network it will be use automatically.
novaNetwork | boolean | Optional | Yes | - | 
password | string | Optional | Yes | - | Your user password
privateKeyFile | string | Optional | Yes | - | 
region | string | Optional | Yes | - | The region to work on, which can be omitted if there is only one region on the OpenStack
secGroups | string | Optional | Yes | - | If security groups are available on your OpenStack you can specify a comma separated list to use for the machine (e.g. `secgrp001`,`secgrp002`)
sshPort | string | Optional | Yes | - | Customize the SSH port if the SSH server on the machine does not listen on the default port
sshUser | string | Optional | Yes | - | The username to use for SSH into the machine. If not provided,  `root`  will be used.
tenantId | string | Optional | Yes | - | The ID of the tenant in which the machine will be created
tenantName | string | Optional | Yes | - | The name of the tenant in which the machine will be created
username | string | Optional | Yes | - | The user identifier to authenticate with


Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.


### Operations
{::options parse_block_html="true" /}



<div class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/openstackConfig</code></span></span>
<div class="action-contents">
{% highlight json %} 
{

	"activeTimeout": "string",

	"authUrl": "string",

	"availabilityZone": "string",

	"domainId": "string",

	"domainName": "string",

	"endpointType": "string",

	"flavorId": "string",

	"flavorName": "string",

	"floatingipPool": "string",

	"imageId": "string",

	"imageName": "string",

	"insecure": true,

	"ipVersion": "string",

	"keypairName": "string",

	"netId": "string",

	"netName": "string",

	"novaNetwork": true,

	"password": "string",

	"privateKeyFile": "string",

	"region": "string",

	"secGroups": "string",

	"sshPort": "string",

	"sshUser": "string",

	"tenantId": "string",

	"tenantName": "string",

	"username": "string"

} 
{% endhighlight %}
</div>
</div>










