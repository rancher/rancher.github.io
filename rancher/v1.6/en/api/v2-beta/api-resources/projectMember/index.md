---
title: Rancher API - projectMember
layout: rancher-api-v2-beta-default-v1.6
version: v1.6
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.6/zh/api/v2-beta/api-resources/projectMember/
---

## ProjectMember

A "project member" in the API is referred to as an environment members in the UI and Rancher documentation. An environment member is a list of all of the members of the environment. An environment member is an [identity]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/identity).

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
externalId | string | Optional | - | - | 
externalIdType | enum | Optional | - | rancher_id | The options are `rancher_id`, `ldap_user`, `ldap_group`, `openldap_user`, `openldap_group`, `azuread_user`, `azuread_group`, `github_user`, `github_org`, `github_team`, `shibboleth_user`, `shibboleth_group`.
role | enum | Optional | - | member | The options are `member`, `owner`, `readonly`, `restricted`.


#### Read Only Fields

Field | Type   | Notes
---|---|---
data | map[json]  | 
id | int  | The unique identifier for the projectMember
name | string  | 
projectId | [project]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/project/)  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/projectMembers</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"description": "string",
	"externalId": "string",
	"externalIdType": "rancher_id",
	"role": "member"
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/projectMembers'
{% endhighlight %}
</div></div>



### Actions

<div class="action" id="activate">
<span class="header">
activate
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/projectMembers/${ID}?action=activate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/projectMembers/${ID}?action=activate'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/projectMember/">projectMember</a> resource</span>
</div></div>

<div class="action" id="deactivate">
<span class="header">
deactivate
<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/projectMembers/${ID}?action=deactivate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/projectMembers/${ID}?action=deactivate'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/projectMember/">projectMember</a> resource</span>
</div></div>


