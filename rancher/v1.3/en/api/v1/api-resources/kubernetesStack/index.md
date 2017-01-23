---
title: API
layout: rancher-api-v1-default-v1.3
version: v1.3
lang: en
apiVersion: v1
redirect_from:
  - /rancher/v1.3/zh/api/v1/api-resources/kubernetesStack/
---

## kubernetesStack



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
environment | map[string] | Optional | - | - | 
externalId | string | Optional | Yes | - | 
name | string | Yes | - | - | 
namespace | string | Yes | - | - | 
previousEnvironment | map[string] | Optional | Yes | - | 
previousExternalId | string | Optional | Yes | - | 
templates | map[string] | Yes | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
accountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | The unique identifier for the associated account
created | date  | The date of when the kubernetesStack was created.
healthState | string  | 
id | int  | The unique identifier for the kubernetesStack
kind | string  | 
removed | date  | The date of when the kubernetesStack was removed
state | enum  | The current state of the kubernetesStack. The options are `activating`, `active`, `canceled-upgrade`, `canceling-rollback`, `canceling-upgrade`, `error`, `erroring`, `finishing-upgrade`, `removed`, `removing`, `requested`, `rolling-back`, `updating-active`, `upgraded`, `upgrading`.
transitioning | enum  | Whether or not the kubernetesStack is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the kubernetesStack
uuid | string  | The universally unique identifier for the kubernetesStack. This will always be unique across Rancher installations.


<br>
