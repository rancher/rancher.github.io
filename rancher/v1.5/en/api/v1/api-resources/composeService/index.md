---
title: API
layout: rancher-api-v1-default-v1.4
version: v1.4
lang: en
apiVersion: v1
---

## composeService



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
environmentId | [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/environment/) | Yes | - | - | 
externalId | string | Optional | - | - | 
launchConfig | [launchConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/launchConfig/) | Optional | - | - | 
name | string | Yes | Yes | - | 
scale | int | Optional | Yes | 1 | 
scalePolicy | [scalePolicy]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/scalePolicy/) | Optional | Yes | - | 
selectorContainer | string | Optional | Yes | - | 
selectorLink | string | Optional | Yes | - | 
startOnCreate | boolean | Optional | - | - | 
vip | string | Optional | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
accountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | The unique identifier for the associated account
created | date  | The date of when the composeService was created.
currentScale | int  | 
fqdn | string  | 
healthState | string  | 
id | int  | The unique identifier for the composeService
kind | string  | 
publicEndpoints | array[[publicEndpoint]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/publicEndpoint/)]  | 
removed | date  | The date of when the composeService was removed
state | enum  | The current state of the composeService. The options are `activating`, `active`, `canceled-rollback`, `canceled-upgrade`, `canceling-rollback`, `canceling-upgrade`, `deactivating`, `finishing-upgrade`, `inactive`, `registering`, `removed`, `removing`, `requested`, `restarting`, `rolling-back`, `updating-active`, `updating-inactive`, `upgraded`, `upgrading`.
transitioning | enum  | Whether or not the composeService is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the composeService
uuid | string  | The universally unique identifier for the composeService. This will always be unique across Rancher installations.


<br>
