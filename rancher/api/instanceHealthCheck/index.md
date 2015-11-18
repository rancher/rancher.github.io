---
title: API
layout: rancher-default
---

## <no value>

Description of API Input from yaml file. 
​​
### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
healthyThreshold | int | false | <no value> | The healthyThreshold for the instanceHealthCheck
interval | int | false | <no value> | The interval for the instanceHealthCheck
port | int | true | <no value> | The port for the instanceHealthCheck
requestLine | string | false | <no value> | The requestLine for the instanceHealthCheck
responseTimeout | int | false | <no value> | The responseTimeout for the instanceHealthCheck
unhealthyThreshold | int | false | <no value> | The unhealthyThreshold for the instanceHealthCheck

