---
title: Rancher API - machineDriver
layout: rancher-api-v2-beta-default-v1.5
version: v1.5
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.5/zh/api/v2-beta/api-resources/machineDriver/
---

## MachineDriver



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
activateOnCreate | boolean | Optional | - | - | 
builtin | boolean | Optional | - | - | 
checksum | string | Optional | Yes | - | 
description | string | Optional | Yes | - | 
externalId | string | Optional | Yes | - | 
uiUrl | string | Optional | Yes | - | 
url | string | Yes | Yes | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
defaultActive | boolean  | 
id | int  | The unique identifier for the machineDriver
name | string  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.




