---
title: API
layout: rancher-api-v2-beta-default-v1.6
version: v1.6
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.6/zh/api/v2-beta/api-resources/composeProject/
---

## composeProject



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
answers | map[json] | Optional | - | - | 
binding | [binding]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/binding/) | Optional | Yes | - | 
description | string | Optional | Yes | - | 
environment | map[string] | Optional | - | - | 
externalId | string | Optional | Yes | - | 
group | string | Optional | Yes | - | 
name | string | Yes | - | - | 
previousEnvironment | map[string] | Optional | Yes | - | 
previousExternalId | string | Optional | Yes | - | 
templates | map[string] | Yes | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
accountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | The unique identifier for the associated account
created | date  | The date of when the composeProject was created.
data | map[json]  | 
healthState | string  | 
id | int  | The unique identifier for the composeProject
kind | string  | 
removeTime | date  | The date and time of when the composeProject was removed
removed | date  | The date of when the composeProject was removed
serviceIds | array[[service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/)]  | 
state | enum  | The current state of the composeProject. The options are `activating`, `active`, `canceled-upgrade`, `canceling-upgrade`, `error`, `erroring`, `finishing-upgrade`, `removed`, `removing`, `requested`, `rolling-back`, `updating-active`, `upgraded`, `upgrading`.
system | boolean  | 
transitioning | enum  | Whether or not the composeProject is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the composeProject
uuid | string  | The universally unique identifier for the composeProject. This will always be unique across Rancher installations.


<br>
