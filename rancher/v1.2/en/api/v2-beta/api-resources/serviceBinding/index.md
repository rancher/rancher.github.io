---
title: Rancher API - serviceBinding
layout: rancher-api-v2-beta-default-v1.2
version: v1.2
lang: en
apiVersion: v2-beta
---

## ServiceBinding



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
labels | map[string] | Optional | - | - | A map of key value pairs to be used as labels for the serviceBinding
ports | array[string] | Optional | - | - | 
scale | string | Optional | - | - | 



<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v2-beta/serviceBindings</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"labels": {
		"key": "value-pairs"
	},
	"ports": [
		"string1",
		"...stringN"
	],
	"scale": "string"
}' 'http://${RANCHER_URL}:8080/v2-beta/serviceBindings'
{% endhighlight %}
</div></div>
<a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v2-beta/serviceBindings/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Content-Type: application/json' \
-d '{}' 'http://${RANCHER_URL}:8080/v2-beta/serviceBindings/${ID}'
{% endhighlight %}
</div></div>



