---
title: API
layout: rancher-api-v1-default-v1.3
version: v1.3
lang: en
apiVersion: v1
redirect_from:
  - /rancher/v1.3/zh/api/v1/api-resources/serviceProxy/
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
