---
title: API
layout: rancher-api-v2-beta-default-v1.5
version: v1.5
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.5/zh/api/v2-beta/api-resources/loadBalancerCookieStickinessPolicy/
---

## loadBalancerCookieStickinessPolicy



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
cookie | string | Optional | Yes | - | 
domain | string | Optional | Yes | - | 
indirect | boolean | Optional | Yes | - | 
mode | enum | Optional | Yes | insert | The options are `rewrite`, `insert`, `prefix`.
name | string | Optional | Yes | - | 
nocache | boolean | Optional | Yes | - | 
postonly | boolean | Optional | Yes | - | 



<br>
