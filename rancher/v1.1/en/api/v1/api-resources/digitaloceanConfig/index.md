---
title: Rancher API - digitaloceanConfig
layout: rancher-api-v1-default-v1.1
version: v1.1
lang: en
apiVersion: v1
redirect_from:
  - /rancher/v1.1/zh/api/v1/api-resources/digitaloceanConfig/
---

## DigitaloceanConfig

The configuration to launch a droplet in DigitalOcean using [machine]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/machine). Rancher is calling `docker-machine`, so any available options in `docker-machine` for specific drivers are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation.

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
accessToken | string | Optional | - | - | 
backups | boolean | Optional | - | - | 
image | string | Optional | - | ubuntu-15-10-x64 | 
ipv6 | boolean | Optional | - | - | 
privateNetworking | boolean | Optional | - | - | 
region | string | Optional | - | nyc3 | The region to use when launching the host
size | string | Optional | - | 512mb | 
sshPort | string | Optional | - | 22 | The port to ssh into the host
sshUser | string | Optional | - | root | The ssh username to use to ssh into the host
userdata | string | Optional | - | - | 



<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/digitaloceanConfigs</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"accessToken": "",
	"backups": false,
	"image": "ubuntu-15-10-x64",
	"ipv6": false,
	"privateNetworking": false,
	"region": "nyc3",
	"size": "512mb",
	"sshPort": "22",
	"sshUser": "root",
	"userdata": ""
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/digitaloceanConfigs'
{% endhighlight %}
</div></div>



