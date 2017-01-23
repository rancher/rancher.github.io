---
title: API
layout: rancher-api-v2-beta-default-v1.2
version: v1.2
lang: en
apiVersion: v2-beta
redirect_from:
  - /rancher/v1.2/zh/api/v2-beta/api-resources/externalVolumeEvent/
---

## externalVolumeEvent



### Resource Fields


#### Read Only Fields

Field | Type   | Notes
---|---|---
accountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | The unique identifier for the associated account
created | date  | The date of when the externalVolumeEvent was created.
eventType | string  | 
externalId | string  | 
id | int  | The unique identifier for the externalVolumeEvent
kind | string  | 
reportedAccountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | 
state | enum  | The current state of the externalVolumeEvent. The options are `created`, `creating`, `removed`, `removing`, `requested`.
transitioning | enum  | Whether or not the externalVolumeEvent is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the externalVolumeEvent
uuid | string  | The universally unique identifier for the externalVolumeEvent. This will always be unique across Rancher installations.
volume | [volume]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/volume/)  | 


<br>
