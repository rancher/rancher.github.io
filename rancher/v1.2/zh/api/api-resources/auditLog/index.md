---
title: Rancher API - auditLog
layout: rancher-api-default-v1.2
version: v1.2
lang: zh
---

## AuditLog



### Resource Fields


#### Read Only Fields

Field | Type   | Notes
---|---|---
authType | enum  | 
authenticatedAsAccountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/account/)  | 
authenticatedAsIdentityId | [identity]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/identity/)  | 
clientIp | string  | 
description | string  | 
eventType | string  | 
id | int  | The unique identifier for the auditLog
requestObject | string  | 
resourceId | int  | 
resourceType | string  | 
responseCode | string  | 
responseObject | string  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.




