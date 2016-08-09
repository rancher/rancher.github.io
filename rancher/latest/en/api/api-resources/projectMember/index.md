---
title: Rancher API - projectMember
layout: rancher-api-default
version: latest
lang: en
---

## ProjectMember

A "project member" in the API is referred to as an environment members in the UI and Rancher documentation. An environment member is a list of all of the members of the  environment. An environment member is an [identity]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/identity).

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
externalId | string | Optional | - | - | 
externalIdType | enum | Optional | - | rancher_id | 
id | int | - | - | - | The unique identifier for the projectMember
name | string | - | - | - | 
projectId | [project]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/project/) | - | - | - | 
role | enum | Optional | - | member | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.




### Actions
<div class="action">
<span class="header">
activate
<span class="headerright">POST:  <code>/v1/projectMembers/${ID}/?action=activate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/projectMember/">projectMember</a> resource</span>
</div></div>

<div class="action">
<span class="header">
deactivate
<span class="headerright">POST:  <code>/v1/projectMembers/${ID}/?action=deactivate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/projectMember/">projectMember</a> resource</span>
</div></div>


