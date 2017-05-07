---
title: Rancher API - databasechangeloglock
layout: rancher-api-v2-beta-default-v1.6
version: v1.6
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.6/zh/api/v2-beta/api-resources/databasechangeloglock/
---

## Databasechangeloglock



### Resource Fields


#### Read Only Fields

Field | Type   | Notes
---|---|---
id | int  | The unique identifier for the databasechangeloglock
locked | boolean  | 
lockedby | string  | 
lockgranted | date  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="delete"></a>
<div class="action"><span class="header">Delete<span class="headerright">DELETE:  <code>/v2-beta/projects/${PROJECT_ID}/databasechangeloglocks/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X DELETE \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/databasechangeloglocks/${ID}'
{% endhighlight %}
</div></div>



