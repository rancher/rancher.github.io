---
title: API
layout: rancher-api-v2-beta-default-v1.2
version: v1.2
lang: en
apiVersion: v2-beta
redirect_from:
  - /rancher/v1.2/zh/api/v2-beta/api-resources/kubernetesService/
---

## kubernetesService



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
externalId | string | Optional | - | - | 
name | string | Yes | Yes | - | 
stackId | [stack]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/stack/) | Optional | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
accountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | The unique identifier for the associated account
created | date  | The date of when the kubernetesService was created.
healthState | string  | 
id | int  | The unique identifier for the kubernetesService
instanceIds | array[[instance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instance/)]  | 
kind | string  | 
linkedServices | map[[service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/)]  | 
removed | date  | The date of when the kubernetesService was removed
selectorContainer | string  | 
state | enum  | The current state of the kubernetesService. The options are `activating`, `active`, `canceled-upgrade`, `canceling-upgrade`, `deactivating`, `finishing-upgrade`, `inactive`, `registering`, `removed`, `removing`, `requested`, `restarting`, `rolling-back`, `updating-active`, `updating-inactive`, `upgraded`, `upgrading`.
system | boolean  | 
template | json  | 
transitioning | enum  | Whether or not the kubernetesService is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the kubernetesService
uuid | string  | The universally unique identifier for the kubernetesService. This will always be unique across Rancher installations.
vip | string  | 


<br>
