---
title: Rancher API - storageDriver
layout: rancher-api-v2-beta-default-v1.5
version: v1.5
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.5/zh/api/v2-beta/api-resources/storageDriver/
---

## StorageDriver



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
name | string | Optional | Yes | - | 
scope | enum | Optional | - | - | The options are `local`, `environment`, `custom`.
volumeAccessMode | enum | Optional | - | multiHostRW | The options are `singleHostRW`, `singleInstanceRW`, `multiHostRW`.


#### Read Only Fields

Field | Type   | Notes
---|---|---
id | int  | The unique identifier for the storageDriver
serviceId | [service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/)  | The unique identifier of the associated service


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.




