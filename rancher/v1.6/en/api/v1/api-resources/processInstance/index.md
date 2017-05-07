---
title: Rancher API - processInstance
layout: rancher-api-v1-default-v1.6
version: v1.6
lang: en
apiVersion: v1
#redirect_from:
#  - /rancher/v1.6/zh/api/v1/api-resources/processInstance/
---

## ProcessInstance



### Resource Fields


#### Read Only Fields

Field | Type   | Notes
---|---|---
data | map[json]  | 
endTime | date  | 
exitReason | string  | 
id | int  | The unique identifier for the processInstance
phase | string  | 
priority | int  | 
processName | string  | 
resourceId | string  | 
resourceType | string  | 
result | string  | 
runningProcessServerId | string  | 
startProcessServerId | string  | 
startTime | date  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.




