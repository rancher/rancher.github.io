---
title: API
layout: rancher-api-v1-default-v1.0
version: v1.0
lang: en
apiVersion: v1
---

## loadBalancerAppCookieStickinessPolicy



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
cookie | string | Yes | Yes | - | 
maxLength | int | Yes | Yes | - | 
mode | enum | Optional | Yes | - | The options are `path_parameters`, `query_string`.
name | string | Optional | Yes | - | 
prefix | boolean | Optional | Yes | - | 
requestLearn | boolean | Optional | Yes | - | 
timeout | int | Yes | Yes | - | 



<br>
