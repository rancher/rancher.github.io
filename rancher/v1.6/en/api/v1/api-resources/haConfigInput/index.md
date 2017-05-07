---
title: Rancher API - haConfigInput
layout: rancher-api-v1-default-v1.6
version: v1.6
lang: en
apiVersion: v1
#redirect_from:
#  - /rancher/v1.6/zh/api/v1/api-resources/haConfigInput/
---

## HaConfigInput



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
cert | string | Optional | - | - | 
certChain | string | Optional | - | - | 
clusterSize | int | Optional | - | 3 | 
hostRegistrationUrl | string | Yes | - | - | 
httpEnabled | boolean | Optional | - | true | 
httpPort | int | Optional | - | 80 | 
httpsPort | int | Optional | - | 443 | 
key | string | Optional | - | - | 
ppHttpPort | int | Optional | - | 81 | 
ppHttpsPort | int | Optional | - | 444 | 
redisPort | int | Optional | - | 6379 | 
swarmEnabled | boolean | Optional | - | true | 
swarmPort | int | Optional | - | 2376 | 
zookeeperClientPort | int | Optional | - | 2181 | 
zookeeperLeaderPort | int | Optional | - | 3888 | 
zookeeperQuorumPort | int | Optional | - | 2888 | 



<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/haConfigInputs</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"cert": "string",
	"certChain": "string",
	"clusterSize": 3,
	"hostRegistrationUrl": "string",
	"httpEnabled": true,
	"httpPort": 80,
	"httpsPort": 443,
	"key": "string",
	"ppHttpPort": 81,
	"ppHttpsPort": 444,
	"redisPort": 6379,
	"swarmEnabled": true,
	"swarmPort": 2376,
	"zookeeperClientPort": 2181,
	"zookeeperLeaderPort": 3888,
	"zookeeperQuorumPort": 2888
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/haConfigInputs'
{% endhighlight %}
</div></div>



