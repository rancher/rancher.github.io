---
title: Rancher API - identity
layout: rancher-api-v2-beta-default-v1.3
version: v1.3
lang: en
apiVersion: v2-beta
redirect_from:
  - /rancher/v1.3/zh/api/v2-beta/api-resources/identity/
---

## Identity

An identity is Rancher's representation of an object(i.e. `ldap_group`, `github_user`) when Rancher has turned on [access control]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/). The `externalId` in an identity is the unique identifier in the authentication system that represents the object. The role of an identity is always null unless it is being returned as the identity of a [projectMember]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/projectMember/).

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
all | string | Optional | - | - | 
externalId | string | Yes | - | - | 
externalIdType | string | Yes | - | - | 
login | string | Optional | - | - | 
name | string | Optional | - | - | 
profilePicture | string | Optional | - | - | 
profileUrl | string | Optional | - | - | 
projectId | [project]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/project/) | Optional | - | - | 
role | string | Optional | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
id | string  | The unique identifier for the identity


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.




