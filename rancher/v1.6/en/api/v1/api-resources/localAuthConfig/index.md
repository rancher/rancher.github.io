---
title: Rancher API - localAuthConfig
layout: rancher-api-v1-default-v1.6
version: v1.6
lang: en
apiVersion: v1
#redirect_from:
#  - /rancher/v1.6/zh/api/v1/api-resources/localAuthConfig/
---

## LocalAuthConfig



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
accessMode | string | Optional | - | unrestricted | 
enabled | boolean | Optional | - | - | 
name | string | Optional | - | admin | 
password | [password]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/password/) | Yes | - | - | 
username | string | Yes | - | - | 



<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/localAuthConfigs</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"accessMode": "unrestricted",
	"enabled": false,
	"name": "admin",
	"password": "password",
	"username": "string"
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/localAuthConfigs'
{% endhighlight %}
</div></div>



