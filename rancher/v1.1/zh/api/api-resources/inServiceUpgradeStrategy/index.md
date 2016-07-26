---
title: API
layout: rancher-default
version: latest
lang: zh
---

## inServiceUpgradeStrategy





### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
batchSize | int | false | 1 | The batch size to upgrade a service (i.e. how many containers to launch at a time)
intervalMillis | int | false | 2000 | The number of milliseconds between upgrading
launchConfig | [launchConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/launchConfig/) | false |  | The Docker run configuration of a container
previousLaunchConfig | [launchConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/launchConfig/) | false |  | 
previousSecondaryLaunchConfigs | array[secondaryLaunchConfig] | false |  | 
secondaryLaunchConfigs | array[secondaryLaunchConfig] | false |  | The list of services that are sidekicks to the service.
startFirst | boolean | false | false | 

