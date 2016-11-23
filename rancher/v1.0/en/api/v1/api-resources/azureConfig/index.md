---
title: Rancher API - azureConfig
layout: rancher-api-v1-default-v1.0
version: v1.0
lang: en
apiVersion: v1
---

## AzureConfig

The configuration to launch an instance in Microsoft Azure. For all cloud providers, Rancher is calling `docker-machine`, so any available options in `docker-machine` are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation.

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
dockerPort | string | Optional | Yes | - | 
dockerSwarmMasterPort | string | Optional | Yes | - | 
image | string | Optional | Yes | - | 
location | string | Optional | Yes | - | 
password | string | Optional | Yes | - | 
publishSettingsFile | string | Optional | Yes | - | 
size | string | Optional | Yes | - | 
sshPort | string | Optional | Yes | - | The port to ssh into the host
subscriptionCert | string | Optional | Yes | - | 
subscriptionId | string | Optional | Yes | - | 
username | string | Optional | Yes | - | 



<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/azureConfigs</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
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
}' 'http://${RANCHER_URL}:8080/v1/azureConfigs'
{% endhighlight %}
</div></div>



