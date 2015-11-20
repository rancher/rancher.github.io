---
title: API
layout: rancher-default
---

## identity

An identity is Rancher's representation of an object(i.e. `ldap_group`, `github_user`) when Rancher has turned on [access control]({{site.baseurl}}/rancher/configuration/access-control/). The `externalId` in an identity is the unique identifier in the authentication system that represents the object. The role of an identity is always null unless it is being returned as the identity of a [projectMember]({{site.baseurl}}/rancher/api/projectMember/).

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
id | string | - | - | - | The unique identifier for the identity
name | string | Optional | - | - | 
all | string | Optional | - | - | 
externalId | string | Yes | - | - | 
externalIdType | string | Yes | - | - | 
login | string | Optional | - | - | 
profilePicture | string | Optional | - | - | 
profileUrl | string | Optional | - | - | 
projectId | [project]({{site.baseurl}}/rancher/api/project/) | Optional | - | - | 
role | string | Optional | - | - | 












​