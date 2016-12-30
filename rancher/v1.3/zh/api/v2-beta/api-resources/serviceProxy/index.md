---
title: API
layout: rancher-api-v2-beta-default-v1.3
version: v1.3
lang: zh
apiVersion: v2-beta
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
