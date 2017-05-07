---
title: Rancher API - hostTemplate
layout: rancher-api-v2-beta-default-v1.6
version: v1.6
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.6/zh/api/v2-beta/api-resources/hostTemplate/
---

## HostTemplate



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
driver | string | Optional | - | - | 
flavorPrefix | string | Optional | - | - | 
name | string | Optional | Yes | - | 
publicValues | map[json] | Optional | - | - | 
secretValues | map[json] | Optional | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
data | map[json]  | 
id | int  | The unique identifier for the hostTemplate


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.




