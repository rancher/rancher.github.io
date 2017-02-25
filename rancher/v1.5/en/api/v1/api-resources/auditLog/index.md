---
title: Rancher API - auditLog
layout: rancher-api-v1-default-v1.4
version: v1.4
lang: en
apiVersion: v1
---

## AuditLog

The audit log provides a list of API requests. It logs the environment as well as the API call. After access control is enabled, it also logs the user.

### Resource Fields


#### Read Only Fields

Field | Type   | Notes
---|---|---
authType | enum  | The options are `AdminAuth`, `BasicAuth`, `RegistrationToken`, `TokenAccount`, `TokenAuth`.
authenticatedAsAccountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | 
authenticatedAsIdentityId | [identity]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/identity/)  | 
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

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.




