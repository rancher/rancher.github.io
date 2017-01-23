---
title: API
layout: rancher-api-v1-default-v1.1
version: v1.1
lang: en
apiVersion: v1
redirect_from:
  - /rancher/v1.1/zh/api/v1/api-resources/register/
---

## register



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
key | string | Yes | - | - | 
name | string | Optional | Yes | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
accessKey | string  | 
accountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | The unique identifier for the associated account
created | date  | The date of when the register was created.
id | int  | The unique identifier for the register
kind | string  | 
removed | date  | The date of when the register was removed
secretKey | string  | 
state | enum  | The current state of the register. The options are `activating`, `active`, `deactivating`, `inactive`, `purged`, `purging`, `registering`, `removed`, `removing`, `requested`, `restoring`, `updating-active`, `updating-inactive`.
transitioning | enum  | Whether or not the register is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the register
uuid | string  | The universally unique identifier for the register. This will always be unique across Rancher installations.


<br>
