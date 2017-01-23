---
title: API
layout: rancher-api-v2-beta-default-v1.2
version: v1.2
lang: en
apiVersion: v2-beta
redirect_from:
  - /rancher/v1.2/zh/api/v2-beta/api-resources/instanceHealthCheck/
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
