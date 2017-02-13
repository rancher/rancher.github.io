---
title: API
layout: rancher-api-v2-beta-default-v1.4
version: v1.4
lang: en
apiVersion: v2-beta
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
