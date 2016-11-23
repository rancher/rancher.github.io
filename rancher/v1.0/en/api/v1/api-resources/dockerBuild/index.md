---
title: Rancher API - dockerBuild
layout: rancher-api-v1-default-v1.0
version: v1.0
lang: en
apiVersion: v1
---

## DockerBuild



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
context | string | Optional | - | - | 
dockerfile | string | Optional | - | - | 
forcerm | boolean | Optional | - | - | 
nocache | boolean | Optional | - | - | 
remote | string | Optional | - | - | 
rm | boolean | Optional | - | - | 



<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/dockerBuilds</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"context": "string",
	"dockerfile": "string",
	"forcerm": false,
	"nocache": false,
	"remote": "string",
	"rm": false
}' 'http://${RANCHER_URL}:8080/v1/dockerBuilds'
{% endhighlight %}
</div></div>



