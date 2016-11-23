---
title: Rancher API - digitaloceanConfig
layout: rancher-api-v1-default-v1.0
version: v1.0
lang: en
apiVersion: v1
---

## DigitaloceanConfig

The configuration to launch a droplet in DigitalOcean using [machine]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/machine). Rancher is calling `docker-machine`, so any available options in `docker-machine` for specific drivers are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation.

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
accessToken | string | Optional | Yes | - | 
backups | boolean | Optional | Yes | - | 
image | string | Optional | Yes | - | 
ipv6 | boolean | Optional | Yes | - | 
privateNetworking | boolean | Optional | Yes | - | 
region | string | Optional | Yes | - | The region to use when launching the host
size | string | Optional | Yes | - | 
sshPort | string | Optional | Yes | - | The port to ssh into the host
sshUser | string | Optional | Yes | - | The ssh username to use to ssh into the host
userdata | string | Optional | Yes | - | 



<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/digitaloceanConfigs</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"accessToken": "string",
	"backups": false,
	"image": "string",
	"ipv6": false,
	"privateNetworking": false,
	"region": "string",
	"size": "string",
	"sshPort": "string",
	"sshUser": "string",
	"userdata": "string"
}' 'http://${RANCHER_URL}:8080/v1/digitaloceanConfigs'
{% endhighlight %}
</div></div>



