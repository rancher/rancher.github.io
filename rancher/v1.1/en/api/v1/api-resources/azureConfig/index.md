---
title: Rancher API - azureConfig
layout: rancher-api-v1-default-v1.1
version: v1.1
lang: en
apiVersion: v1
redirect_from:
  - /rancher/v1.1/zh/api/v1/api-resources/azureConfig/
---

## AzureConfig

The configuration to launch an instance in Microsoft Azure. For all cloud providers, Rancher is calling `docker-machine`, so any available options in `docker-machine` are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation.

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
dockerPort | string | Optional | - | 2376 | 
dockerSwarmMasterPort | string | Optional | - | 3376 | 
image | string | Optional | - | - | 
location | string | Optional | - | West US | 
password | string | Optional | - | - | 
publishSettingsFile | string | Optional | - | - | 
size | string | Optional | - | Small | 
sshPort | string | Optional | - | 22 | The port to ssh into the host
subscriptionCert | string | Optional | - | - | 
subscriptionId | string | Optional | - | - | 
username | string | Optional | - | ubuntu | 



<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/azureConfigs</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"dockerPort": "2376",
	"dockerSwarmMasterPort": "3376",
	"image": "",
	"location": "West US",
	"password": "",
	"publishSettingsFile": "",
	"size": "Small",
	"sshPort": "22",
	"subscriptionCert": "",
	"subscriptionId": "",
	"username": "ubuntu"
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/azureConfigs'
{% endhighlight %}
</div></div>



