---
title: API
layout: rancher-api-v2-beta-default-v1.6
version: v1.6
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.6/zh/api/v2-beta/api-resources/backupTarget/
---

## backupTarget



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
name | string | Yes | Yes | - | 
nfsConfig | [nfsConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/nfsConfig/) | Optional | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
accountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | The unique identifier for the associated account
created | date  | The date of when the backupTarget was created.
data | map[json]  | 
id | int  | The unique identifier for the backupTarget
kind | string  | 
removeTime | date  | The date and time of when the backupTarget was removed
removed | date  | The date of when the backupTarget was removed
state | enum  | The current state of the backupTarget. The options are `created`, `creating`, `removed`, `removing`, `requested`.
transitioning | enum  | Whether or not the backupTarget is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the backupTarget
uuid | string  | The universally unique identifier for the backupTarget. This will always be unique across Rancher installations.


<br>
