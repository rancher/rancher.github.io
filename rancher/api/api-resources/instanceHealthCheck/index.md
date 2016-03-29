---
title: API
layout: rancher-default
---

## instanceHealthCheck




​​
### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
healthyThreshold | int | false | <no value> | 
initializingTimeout | int | false | <no value> | 
interval | int | false | <no value> | 
name | string | false | <no value> | 
port | int | true | <no value> | 
recreateOnQuorumStrategyConfig | [recreateOnQuorumStrategyConfig]({{site.baseurl}}/rancher/api/api-resources/recreateOnQuorumStrategyConfig/) | false | <no value> | 
reinitializingTimeout | int | false | <no value> | 
requestLine | string | false | <no value> | 
responseTimeout | int | false | <no value> | 
strategy | enum | false | recreate | 
unhealthyThreshold | int | false | <no value> | 

