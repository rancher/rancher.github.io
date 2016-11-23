---
title: Rancher API - containerExec
layout: rancher-api-v1-default-v1.0
version: v1.0
lang: en
apiVersion: v1
---

## ContainerExec



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
attachStdin | boolean | Optional | - | true | 
attachStdout | boolean | Optional | - | true | 
command | array[string] | Yes | - | - | 
tty | boolean | Optional | - | true | 



<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/containerExecs</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"attachStdin": true,
	"attachStdout": true,
	"command": [
		"string1",
		"...stringN"
	],
	"tty": true
}' 'http://${RANCHER_URL}:8080/v1/containerExecs'
{% endhighlight %}
</div></div>



