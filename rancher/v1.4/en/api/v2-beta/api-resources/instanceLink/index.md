---
title: API
layout: rancher-api-v2-beta-default-v1.4
version: v1.4
lang: en
apiVersion: v2-beta
redirect_from:
  - /rancher/v1.4/zh/api/v2-beta/api-resources/instanceLink/
---

## instanceLink



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
name | string | Optional | Yes | - | 
targetInstanceId | [instance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instance/) | - | Yes | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
accountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | The unique identifier for the associated account
created | date  | The date of when the instanceLink was created.
id | int  | The unique identifier for the instanceLink
instanceId | [instance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instance/)  | The unique identifier for the associated instance
kind | string  | 
linkName | string  | 
removed | date  | The date of when the instanceLink was removed
state | enum  | The current state of the instanceLink. The options are `activating`, `active`, `deactivating`, `inactive`, `purged`, `purging`, `registering`, `removed`, `removing`, `requested`, `restoring`, `updating-active`, `updating-inactive`.
transitioning | enum  | Whether or not the instanceLink is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the instanceLink
uuid | string  | The universally unique identifier for the instanceLink. This will always be unique across Rancher installations.


<br>
