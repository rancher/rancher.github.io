---
title: API
layout: rancher-api-v2-beta-default-v1.3
version: v1.3
lang: zh
apiVersion: v2-beta
---

## inServiceUpgradeStrategy



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
batchSize | int | Optional | - | 1 | 
intervalMillis | int | Optional | - | 2000 | 
launchConfig | [launchConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/launchConfig/) | Optional | - | - | 
secondaryLaunchConfigs | array[[secondaryLaunchConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/secondaryLaunchConfig/)] | Optional | - | - | 
startFirst | boolean | Optional | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
previousLaunchConfig | [launchConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/launchConfig/)  | 
previousSecondaryLaunchConfigs | array[[secondaryLaunchConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/secondaryLaunchConfig/)]  | 


<br>
