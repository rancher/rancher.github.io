---
title: API
layout: rancher-api-default
version: v1.2
lang: en
---

## composeService





### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
currentScale | int | false |  | 
description | string | false |  | 
environmentId | [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/environment/) | true |  | 
externalId | string | false |  | 
fqdn | string | false |  | 
healthState | string | false |  | 
id | int | false |  | The unique identifier for the composeService
launchConfig | [launchConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/launchConfig/) | false |  | 
name | string | true |  | 
publicEndpoints | array[[publicEndpoint]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/publicEndpoint/)] | false |  | 
scale | int | false | 1 | 
scalePolicy | [scalePolicy]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/scalePolicy/) | false |  | 
selectorContainer | string | false |  | 
selectorLink | string | false |  | 
startOnCreate | boolean | false | false | 
vip | string | false |  | 

