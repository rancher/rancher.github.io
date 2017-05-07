---
title: Rancher API - configItemStatus
layout: rancher-api-v2-beta-default-v1.6
version: v1.6
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.6/zh/api/v2-beta/api-resources/configItemStatus/
---

## ConfigItemStatus



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
appliedVersion | int | - | Yes | - | 
name | string | Optional | Yes | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
agentId | [agent]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/agent/)  | The unique identifier of the associated agent
appliedUpdated | date  | 
id | int  | The unique identifier for the configItemStatus
requestedUpdated | date  | 
requestedVersion | int  | 
sourceVersion | string  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v2-beta/projects/${PROJECT_ID}/configItemStatuses/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Content-Type: application/json' \
-d '{
	"appliedVersion": 0,
	"name": "string"
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/configItemStatuses/${ID}'
{% endhighlight %}
</div></div>



