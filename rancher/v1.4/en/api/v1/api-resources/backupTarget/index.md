---
title: API
layout: rancher-api-v1-default-v1.4
version: v1.4
lang: en
apiVersion: v1
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
id | int  | The unique identifier for the backupTarget
kind | string  | 
removed | date  | The date of when the backupTarget was removed
state | enum  | The current state of the backupTarget. The options are `created`, `creating`, `removed`, `removing`, `requested`.
transitioning | enum  | Whether or not the backupTarget is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the backupTarget
uuid | string  | The universally unique identifier for the backupTarget. This will always be unique across Rancher installations.


<br>
