---
title: API
layout: rancher-default
---

## identity

An identity is Rancher's representation of an object(i.e. `ldap_group`, `github_user`) when Rancher has turned on [access control]({{site.baseurl}}/rancher/configuration/access-control/). The `externalId` in an identity is the unique identifier in the authentication system that represents the object. The role of an identity is always null unless it is being returned as the identity of a [projectMember]({{site.baseurl}}/rancher/api/api-resources/projectMember/).

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
all | string | Optional | - | - | 
externalId | string | Yes | - | - | 
externalIdType | string | Yes | - | - | 
id | string | - | - | - | The unique identifier for the identity
login | string | Optional | - | - | 
name | string | Optional | - | - | 
profilePicture | string | Optional | - | - | 
profileUrl | string | Optional | - | - | 
projectId | [project]({{site.baseurl}}/rancher/api/api-resources/project/) | Optional | - | - | 
role | string | Optional | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.
​








​