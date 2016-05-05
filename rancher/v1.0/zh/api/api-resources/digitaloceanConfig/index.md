---
title: API
layout: rancher-default-v1.0
version: v1.0
lang: zh
---

## digitaloceanConfig

The configuration to launch a droplet in DigitalOcean using [machine]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/machine). Rancher is calling `docker-machine`, so any available options in `docker-machine` for specific drivers are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation.

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
accessToken | string | Optional | Yes | - | <strong>required</strong>Your personal access token for the Digital Ocean API
backups | boolean | Optional | Yes | - | Whether or not to enable Digital Oceans backups for the droplet
image | string | Optional | Yes | - | The name of the Digital Ocean image to use
ipv6 | boolean | Optional | Yes | - | Whether or not to enable IPv6 support for the droplet
privateNetworking | boolean | Optional | Yes | - | Whether or not to enable private networking support for the droplet
region | string | Optional | Yes | - | The region to create the droplet in
size | string | Optional | Yes | - | The size of the Digital Ocean droplet (larger than the default option (`512mb`) are of the form `2gb`)
sshPort | string | Optional | Yes | - | The port to ssh into the host
sshUser | string | Optional | Yes | - | The ssh username to use to ssh into the host
userdata | string | Optional | Yes | - | 


Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.


### Operations
{::options parse_block_html="true" /}



<div class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/digitaloceanConfig</code></span></span>
<div class="action-contents">
{% highlight json %} 
{

	"accessToken": "string",

	"backups": true,

	"image": "string",

	"ipv6": true,

	"privateNetworking": true,

	"region": "string",

	"size": "string",

	"sshPort": "string",

	"sshUser": "string",

	"userdata": "string"

} 
{% endhighlight %}
</div>
</div>










