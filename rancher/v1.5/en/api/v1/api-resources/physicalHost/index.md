---
title: API
layout: rancher-api-v1-default-v1.4
version: v1.4
lang: en
apiVersion: v1
---

## physicalHost



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
created | date  | The date of when the physicalHost was created.
driver | string  | 
externalId | string  | 
id | int  | The unique identifier for the physicalHost
kind | string  | 
removed | date  | The date of when the physicalHost was removed
state | enum  | The current state of the physicalHost. The options are `active`, `bootstrapping`, `created`, `creating`, `error`, `erroring`, `removed`, `removing`, `requested`, `updating`.
transitioning | enum  | Whether or not the physicalHost is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the physicalHost
uuid | string  | The universally unique identifier for the physicalHost. This will always be unique across Rancher installations.


<br>
