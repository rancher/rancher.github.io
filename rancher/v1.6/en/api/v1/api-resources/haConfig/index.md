---
title: Rancher API - haConfig
layout: rancher-api-v1-default-v1.6
version: v1.6
lang: en
apiVersion: v1
#redirect_from:
#  - /rancher/v1.6/zh/api/v1/api-resources/haConfig/
---

## HaConfig



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
enabled | boolean | - | Yes | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
clusterSize | int  | 
dbHost | string  | 
dbSize | int  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v1/projects/${PROJECT_ID}/haConfigs/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Content-Type: application/json' \
-d '{
	"enabled": false
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/haConfigs/${ID}'
{% endhighlight %}
</div></div>



### Actions

<div class="action" id="createscript">
<span class="header">
createscript
<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/haConfigs/${ID}?action=createscript</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/haConfigInput/">HaConfigInput</a></span>

Field | Type | Required | Default | Notes
---|---|---|---|---
cert |  | No |  | 
certChain |  | No |  | 
clusterSize |  | No | 3 | 
hostRegistrationUrl |  | Yes |  | 
httpEnabled |  | No | true | 
httpPort |  | No | 80 | 
httpsPort |  | No | 443 | 
key |  | No |  | 
ppHttpPort |  | No | 81 | 
ppHttpsPort |  | No | 444 | 
redisPort |  | No | 6379 | 
swarmEnabled |  | No | true | 
swarmPort |  | No | 2376 | 
zookeeperClientPort |  | No | 2181 | 
zookeeperLeaderPort |  | No | 3888 | 
zookeeperQuorumPort |  | No | 2888 | 


<br>
{% highlight json %}
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
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/haConfigs/${ID}?action=createscript'
{% endhighlight %}
<br>

</div></div>


