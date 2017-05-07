---
title: API
layout: rancher-api-v2-beta-default-v1.6
version: v1.6
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.6/zh/api/v2-beta/api-resources/register/
---

## register



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
key | string | Yes | - | - | 
kind | string | Optional | - | - | 
name | string | Optional | - | - | 
resourceData | map[json] | Optional | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
accessKey | string  | 
accountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | The unique identifier for the associated account
created | date  | The date of when the register was created.
data | map[json]  | 
id | int  | The unique identifier for the register
removeTime | date  | The date and time of when the register was removed
removed | date  | The date of when the register was removed
secretKey | string  | 
state | enum  | The current state of the register. The options are `activating`, `active`, `removed`, `removing`, `requested`.
transitioning | enum  | Whether or not the register is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the register
uuid | string  | The universally unique identifier for the register. This will always be unique across Rancher installations.


<br>
