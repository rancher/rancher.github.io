---
title: Rancher API - serviceLog
layout: rancher-api-v2-beta-default-v1.3
version: v1.3
lang: en
apiVersion: v2-beta
redirect_from:
  - /rancher/v1.3/zh/api/v2-beta/api-resources/serviceLog/
---

## ServiceLog



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
endTime | date  | 
eventType | string  | 
id | int  | The unique identifier for the serviceLog
instanceId | [instance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instance/)  | The unique identifier for the associated instance
level | string  | 
serviceId | [service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/)  | The unique identifier of the associated service
subLog | boolean  | 
transactionId | string  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.




