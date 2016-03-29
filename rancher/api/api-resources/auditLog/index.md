---
title: API
layout: rancher-default
---

## auditLog



​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
authType | enum | - | - | - | 
authenticatedAsAccountId | [account]({{site.baseurl}}/rancher/api/api-resources/account/) | - | - | - | 
authenticatedAsIdentityId | [identity]({{site.baseurl}}/rancher/api/api-resources/identity/) | - | - | - | 
clientIp | string | - | - | - | 
description | string | - | - | - | 
eventType | string | - | - | - | 
id | int | - | - | - | The unique identifier for the auditLog
requestObject | string | - | - | - | 
resourceId | int | - | - | - | 
resourceType | string | - | - | - | 
responseCode | string | - | - | - | 
responseObject | string | - | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.
​








​