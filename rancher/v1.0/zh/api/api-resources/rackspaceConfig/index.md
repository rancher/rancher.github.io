---
title: API
layout: rancher-default-v1.0
version: v1.0
lang: zh
---

## rackspaceConfig

The configuration to launch a server in Rackspace. For all cloud providers, Rancher is calling `docker-machine`, so any available options in `docker-machine` are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation.

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
apiKey | string | Optional | Yes | - | <strong>required</strong> Your Rackspace API key
dockerInstall | string | Optional | Yes | - | Whether or not if Docker should be installed on the machine
endpointType | string | Optional | Yes | - | Endpoint type can be `internalURL`, `adminURL`, or` publicURL`. If is a helper for the driver to choose the right URL in the OpenStack service catalog. If not provided the default id `publicURL`
flavorId | string | Optional | Yes | - | The ID of the flavor that will be used for the machine
imageId | string | Optional | Yes | - | The ID of the image that will be used for the machine
region | string | Optional | Yes | - | <strong>required</strong>Rackspace region name
sshPort | string | Optional | Yes | - | The SSH port for the newly booted machine
sshUser | string | Optional | Yes | - | The SSH user for the newly booted machine
username | string | Optional | Yes | - | <strong>required</strong> Your Rackspace account username.


Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.


### Operations
{::options parse_block_html="true" /}



<div class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/rackspaceConfig</code></span></span>
<div class="action-contents">
{% highlight json %} 
{

	"apiKey": "string",

	"dockerInstall": "string",

	"endpointType": "string",

	"flavorId": "string",

	"imageId": "string",

	"region": "string",

	"sshPort": "string",

	"sshUser": "string",

	"username": "string"

} 
{% endhighlight %}
</div>
</div>










