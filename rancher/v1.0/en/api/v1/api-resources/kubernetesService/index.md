---
title: API
layout: rancher-api-v1-default-v1.0
version: v1.0
lang: en
apiVersion: v1
---

## kubernetesService



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
environmentId | [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/environment/) | Yes | - | - | 
name | string | Yes | Yes | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
accountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | The unique identifier for the associated account
created | date  | The date of when the kubernetesService was created.
externalId | string  | 
healthState | string  | 
id | int  | The unique identifier for the kubernetesService
kind | string  | 
removed | date  | The date of when the kubernetesService was removed
selectorContainer | string  | 
state | enum  | The current state of the kubernetesService. The options are `activating`, `active`, `canceled-rollback`, `canceled-upgrade`, `canceling-rollback`, `canceling-upgrade`, `deactivating`, `finishing-upgrade`, `inactive`, `registering`, `removed`, `removing`, `requested`, `restarting`, `rolling-back`, `updating-active`, `updating-inactive`, `upgraded`, `upgrading`.
template | json  | 
transitioning | enum  | Whether or not the kubernetesService is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the kubernetesService
uuid | string  | The universally unique identifier for the kubernetesService. This will always be unique across Rancher installations.
vip | string  | 


<br>
