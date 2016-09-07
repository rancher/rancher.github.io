---
title: API
layout: rancher-api-default-v1.2
version: v1.2
lang: zh
---

## instanceHealthCheck



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
healthyThreshold | int | Optional | - | - | 
initializingTimeout | int | Optional | - | - | 
interval | int | Optional | - | - | 
name | string | Optional | Yes | - | 
port | int | Yes | - | - | 
recreateOnQuorumStrategyConfig | [recreateOnQuorumStrategyConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/recreateOnQuorumStrategyConfig/) | Optional | - | - | 
reinitializingTimeout | int | Optional | - | - | 
requestLine | string | Optional | - | - | 
responseTimeout | int | Optional | - | - | 
strategy | enum | Optional | - | recreate | 
unhealthyThreshold | int | Optional | - | - | 



<br>
