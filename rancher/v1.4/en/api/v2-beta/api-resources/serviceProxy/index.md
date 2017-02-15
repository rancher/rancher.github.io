---
title: API
layout: rancher-api-v2-beta-default-v1.4
version: v1.4
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.4/zh/api/v2-beta/api-resources/serviceProxy/
---

## serviceProxy



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
port | int | Optional | - | 80 | 
scheme | enum | Optional | - | http | The options are `http`, `https`.
service | string | Yes | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
token | string  | 
url | string  | 


<br>
