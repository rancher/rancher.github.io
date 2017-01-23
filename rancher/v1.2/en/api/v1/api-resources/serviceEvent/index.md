---
title: API
layout: rancher-api-v1-default-v1.2
version: v1.2
lang: en
apiVersion: v1
redirect_from:
  - /rancher/v1.2/zh/api/v1/api-resources/serviceEvent/
---

## serviceEvent



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
created | date  | The date of when the serviceEvent was created.
externalTimestamp | int  | 
healthcheckUuid | string  | 
hostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host/)  | The unique identifier for the associated host
id | int  | The unique identifier for the serviceEvent
instanceId | [instance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instance/)  | The unique identifier for the associated instance
kind | string  | 
removed | date  | The date of when the serviceEvent was removed
reportedHealth | string  | 
state | enum  | The current state of the serviceEvent. The options are `created`, `creating`, `removed`, `removing`, `requested`.
transitioning | enum  | Whether or not the serviceEvent is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the serviceEvent
uuid | string  | The universally unique identifier for the serviceEvent. This will always be unique across Rancher installations.


<br>
