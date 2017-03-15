---
title: API
layout: rancher-api-v1-default-v1.5
version: v1.5
lang: en
apiVersion: v1
#redirect_from:
#  - /rancher/v1.5/zh/api/v1/api-resources/loadBalancerCookieStickinessPolicy/
---

## loadBalancerCookieStickinessPolicy



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
cookie | string | Optional | Yes | - | 
domain | string | Optional | Yes | - | 
indirect | boolean | Optional | Yes | - | 
mode | enum | Optional | Yes | - | The options are `rewrite`, `insert`, `prefix`.
name | string | Optional | Yes | - | 
nocache | boolean | Optional | Yes | - | 
postonly | boolean | Optional | Yes | - | 



<br>
