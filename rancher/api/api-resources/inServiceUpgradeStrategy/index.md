---
title: API
layout: rancher-default
---

## inServiceUpgradeStrategy




​​
### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
batchSize | int | false | 1 | The batch size to upgrade a service (i.e. how many containers to launch at a time)
intervalMillis | int | false | 2000 | The number of milliseconds between upgrading
launchConfig | [launchConfig]({{site.baseurl}}/rancher/api/api-resources/launchConfig/) | false | <no value> | The Docker run configuration of a container
previousLaunchConfig | [launchConfig]({{site.baseurl}}/rancher/api/api-resources/launchConfig/) | false | <no value> | 
previousSecondaryLaunchConfigs | array[secondaryLaunchConfig] | false | <no value> | 
secondaryLaunchConfigs | array[secondaryLaunchConfig] | false | <no value> | The list of services that are sidekicks to the service.
startFirst | boolean | false | false | 

