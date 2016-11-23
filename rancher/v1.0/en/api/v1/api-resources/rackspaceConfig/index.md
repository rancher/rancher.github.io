---
title: Rancher API - rackspaceConfig
layout: rancher-api-v1-default-v1.0
version: v1.0
lang: en
apiVersion: v1
---

## RackspaceConfig



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
apiKey | string | Optional | Yes | - | 
dockerInstall | string | Optional | Yes | - | 
endpointType | string | Optional | Yes | - | 
flavorId | string | Optional | Yes | - | 
imageId | string | Optional | Yes | - | 
region | string | Optional | Yes | - | The region to use when launching the host
sshPort | string | Optional | Yes | - | The port to ssh into the host
sshUser | string | Optional | Yes | - | The ssh username to use to ssh into the host
username | string | Optional | Yes | - | 



<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/rackspaceConfigs</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"apiKey": "string",
	"dockerInstall": "string",
	"endpointType": "string",
	"flavorId": "string",
	"imageId": "string",
	"region": "string",
	"sshPort": "string",
	"sshUser": "string",
	"username": "string"
}' 'http://${RANCHER_URL}:8080/v1/rackspaceConfigs'
{% endhighlight %}
</div></div>



