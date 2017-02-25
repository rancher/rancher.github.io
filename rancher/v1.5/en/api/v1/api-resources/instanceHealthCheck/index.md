---
title: API
layout: rancher-api-v1-default-v1.4
version: v1.4
lang: en
apiVersion: v1
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
recreateOnQuorumStrategyConfig | [recreateOnQuorumStrategyConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/recreateOnQuorumStrategyConfig/) | Optional | - | - | 
reinitializingTimeout | int | Optional | - | - | 
requestLine | string | Optional | - | - | 
responseTimeout | int | Optional | - | - | 
strategy | enum | Optional | - | recreate | The options are `none`, `recreate`, `recreateOnQuorum`.
unhealthyThreshold | int | Optional | - | - | 



<br>
