---
title: Rancher API - databasechangelog
layout: rancher-api-v1-default-v1.6
version: v1.6
lang: en
apiVersion: v1
#redirect_from:
#  - /rancher/v1.6/zh/api/v1/api-resources/databasechangelog/
---

## Databasechangelog



### Resource Fields


#### Read Only Fields

Field | Type   | Notes
---|---|---
author | string  | 
comments | string  | 
dateexecuted | date  | 
description | string  | 
exectype | string  | 
filename | string  | 
id | string  | The unique identifier for the databasechangelog
liquibase | string  | 
md5sum | string  | 
orderexecuted | int  | 
tag | string  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v1/projects/${PROJECT_ID}/databasechangelogs/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X DELETE \
'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/databasechangelogs/${ID}'
{% endhighlight %}
</div></div>



