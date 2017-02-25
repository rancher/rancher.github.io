---
title: API
layout: rancher-api-v1-default-v1.4
version: v1.4
lang: en
apiVersion: v1
---

## containerEvent



### Resource Fields


#### Read Only Fields

Field | Type   | Notes
---|---|---
accountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | The unique identifier for the associated account
created | date  | The date of when the containerEvent was created.
dockerInspect | json  | 
externalFrom | string  | 
externalId | string  | 
externalStatus | string  | 
externalTimestamp | int  | 
hostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host/)  | The unique identifier for the associated host
id | int  | The unique identifier for the containerEvent
kind | string  | 
reportedHostUuid | string  | 
state | enum  | The current state of the containerEvent. The options are `created`, `creating`, `removed`, `removing`, `requested`.
transitioning | enum  | Whether or not the containerEvent is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the containerEvent


<br>
