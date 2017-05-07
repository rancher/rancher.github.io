---
title: Rancher API - pullTask
layout: rancher-api-v2-beta-default-v1.6
version: v1.6
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.6/zh/api/v2-beta/api-resources/pullTask/
---

## PullTask



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
image | string | Yes | - | - | 
labels | map[string] | Optional | - | - | A map of key value pairs to be used as labels for the pullTask
mode | enum | Yes | - | all | The options are `all`, `cached`.
name | string | Optional | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
data | map[json]  | 
id | int  | The unique identifier for the pullTask
status | map[string]  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.




