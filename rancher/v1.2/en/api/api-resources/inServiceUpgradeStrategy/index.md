---
title: API
layout: rancher-api-default
version: latest
lang: en
---

## inServiceUpgradeStrategy





### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
batchSize | int | false | 1 | 
intervalMillis | int | false | 2000 | 
launchConfig | [launchConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/launchConfig/) | false |  | 
previousLaunchConfig | [launchConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/launchConfig/) | false |  | 
previousSecondaryLaunchConfigs | array[[secondaryLaunchConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/secondaryLaunchConfig/)] | false |  | 
secondaryLaunchConfigs | array[[secondaryLaunchConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/secondaryLaunchConfig/)] | false |  | 
startFirst | boolean | false | false | 

