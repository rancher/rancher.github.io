---
title: API
layout: rancher-default
version: latest
lang: zh
---

## azureConfig

The configuration to launch an instance in Microsoft Azure. For all cloud providers, Rancher is calling `docker-machine`, so any available options in `docker-machine` are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation.

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
dockerPort | string | Optional | Yes | - | The port to use for the Docker daemon
dockerSwarmMasterPort | string | Optional | Yes | - | 
image | string | Optional | Yes | - | The Azure image name
location | string | Optional | Yes | - | The Azure machine instance location
password | string | Optional | Yes | - | Your Azure password
publishSettingsFile | string | Optional | Yes | - | The Azure setting file
size | string | Optional | Yes | - | The Azure disk size
sshPort | string | Optional | Yes | - | The Azure SSH port
subscriptionCert | string | Optional | Yes | - | <strong>required</strong> The Azure subscription certificate
subscriptionId | string | Optional | Yes | - | <strong>required</strong>The Azure subscription ID (ie. A GUID like`d255d8d7-5af0-4f5c-8a3e-1545044b861e`)
username | string | Optional | Yes | - | Your Azure login user name


Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.


### Operations
{::options parse_block_html="true" /}



<div class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/azureConfig</code></span></span>
<div class="action-contents">
{% highlight json %} 
{

	"dockerPort": "string",

	"dockerSwarmMasterPort": "string",

	"image": "string",

	"location": "string",

	"password": "string",

	"publishSettingsFile": "string",

	"size": "string",

	"sshPort": "string",

	"subscriptionCert": "string",

	"subscriptionId": "string",

	"username": "string"

} 
{% endhighlight %}
</div>
</div>










