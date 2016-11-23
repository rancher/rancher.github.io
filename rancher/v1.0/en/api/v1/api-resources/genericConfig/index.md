---
title: Rancher API - genericConfig
layout: rancher-api-v1-default-v1.0
version: v1.0
lang: en
apiVersion: v1
---

## GenericConfig



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
ipAddress | string | Optional | Yes | - | 
sshKey | string | Optional | Yes | - | 
sshPort | string | Optional | Yes | - | The port to ssh into the host
sshUser | string | Optional | Yes | - | The ssh username to use to ssh into the host



<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/genericConfigs</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"ipAddress": "string",
	"sshKey": "string",
	"sshPort": "string",
	"sshUser": "string"
}' 'http://${RANCHER_URL}:8080/v1/genericConfigs'
{% endhighlight %}
</div></div>



