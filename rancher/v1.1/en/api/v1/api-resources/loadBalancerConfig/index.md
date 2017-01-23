---
title: Rancher API - loadBalancerConfig
layout: rancher-api-v1-default-v1.1
version: v1.1
lang: en
apiVersion: v1
redirect_from:
  - /rancher/v1.1/zh/api/v1/api-resources/loadBalancerConfig/
---

## LoadBalancerConfig



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
haproxyConfig | [haproxyConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/haproxyConfig/) | Optional | Yes | - | 
lbCookieStickinessPolicy | [loadBalancerCookieStickinessPolicy]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/loadBalancerCookieStickinessPolicy/) | Optional | Yes | - | 



<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/loadBalancerConfigs</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"haproxyConfig": {
		"defaults": "string",
		"global": "string"
	},
	"lbCookieStickinessPolicy": {
		"cookie": "string",
		"domain": "string",
		"indirect": false,
		"mode": "enum",
		"name": "string",
		"nocache": false,
		"postonly": false
	}
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/loadBalancerConfigs'
{% endhighlight %}
</div></div>
<a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/projects/${PROJECT_ID}/loadBalancerConfigs/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X DELETE \
'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/loadBalancerConfigs/${ID}'
{% endhighlight %}
</div></div>
<a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v1/projects/${PROJECT_ID}/loadBalancerConfigs/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Content-Type: application/json' \
-d '{
	"haproxyConfig": {
		"defaults": "string",
		"global": "string"
	},
	"lbCookieStickinessPolicy": {
		"cookie": "string",
		"domain": "string",
		"indirect": false,
		"mode": "enum",
		"name": "string",
		"nocache": false,
		"postonly": false
	}
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/loadBalancerConfigs/${ID}'
{% endhighlight %}
</div></div>



