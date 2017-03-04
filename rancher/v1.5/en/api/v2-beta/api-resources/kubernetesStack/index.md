---
title: API
layout: rancher-api-v2-beta-default-v1.5
version: v1.5
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.5/zh/api/v2-beta/api-resources/kubernetesStack/
---

## kubernetesStack



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
binding | [binding]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/binding/) | Optional | Yes | - | 
description | string | Optional | Yes | - | 
environment | map[string] | Optional | - | - | 
externalId | string | Optional | Yes | - | 
group | string | Optional | Yes | - | 
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
serviceIds | array[[service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/)]  | 
state | enum  | The current state of the kubernetesStack. The options are `activating`, `active`, `canceled-upgrade`, `canceling-upgrade`, `error`, `erroring`, `finishing-upgrade`, `removed`, `removing`, `requested`, `rolling-back`, `updating-active`, `upgraded`, `upgrading`.
system | boolean  | 
transitioning | enum  | Whether or not the kubernetesStack is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the kubernetesStack
uuid | string  | The universally unique identifier for the kubernetesStack. This will always be unique across Rancher installations.


<br>
