---
title: Rancher API - task
layout: rancher-api-v1-default-v1.6
version: v1.6
lang: en
apiVersion: v1
#redirect_from:
#  - /rancher/v1.6/zh/api/v1/api-resources/task/
---

## Task



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
name | string | Optional | Yes | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
id | int  | The unique identifier for the task


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.




### Actions

<div class="action" id="execute">
<span class="header">
execute
<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/tasks/${ID}?action=execute</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/tasks/${ID}?action=execute'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/task/">task</a> resource</span>
</div></div>


