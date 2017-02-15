---
title: API
layout: rancher-api-v2-beta-default-v1.4
version: v1.4
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.4/zh/api/v2-beta/api-resources/instance/
---

## instance



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
name | string | Optional | Yes | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
accountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | The unique identifier for the associated account
created | date  | The date of when the instance was created.
externalId | string  | 
hostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host/)  | The unique identifier for the associated host
id | int  | The unique identifier for the instance
kind | string  | 
removed | date  | The date of when the instance was removed
state | enum  | The current state of the instance. The options are `creating`, `error`, `erroring`, `migrating`, `purged`, `purging`, `removed`, `removing`, `requested`, `restarting`, `restoring`, `running`, `starting`, `stopped`, `stopping`, `updating-running`, `updating-stopped`.
transitioning | enum  | Whether or not the instance is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the instance
uuid | string  | The universally unique identifier for the instance. This will always be unique across Rancher installations.


<br>
