---
title: Rancher API - processInstance
layout: rancher-api-v2-beta-default-v1.6
version: v1.6
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.6/zh/api/v2-beta/api-resources/processInstance/
---

## ProcessInstance



### Resource Fields


#### Read Only Fields

Field | Type   | Notes
---|---|---
data | map[json]  | 
endTime | date  | 
executionCount | int  | 
exitReason | string  | 
id | int  | The unique identifier for the processInstance
phase | string  | 
priority | int  | 
processName | string  | 
resourceId | string  | 
resourceType | string  | 
result | string  | 
runAfter | date  | 
runningProcessServerId | string  | 
startProcessServerId | string  | 
startTime | date  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.




### Actions

<div class="action" id="replay">
<span class="header">
replay
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/processInstances/${ID}?action=replay</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/processInstances/${ID}?action=replay'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/processInstance/">processInstance</a> resource</span>
</div></div>


