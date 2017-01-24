---
title: API
layout: rancher-api-v1-default-v1.4
version: v1.4
lang: en
apiVersion: v1
---

## externalStoragePoolEvent



### Resource Fields


#### Read Only Fields

Field | Type   | Notes
---|---|---
accountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | The unique identifier for the associated account
created | date  | The date of when the externalStoragePoolEvent was created.
eventType | string  | 
externalId | string  | 
hostUuids | array[string]  | 
id | int  | The unique identifier for the externalStoragePoolEvent
kind | string  | 
reportedAccountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | 
state | enum  | The current state of the externalStoragePoolEvent. The options are `created`, `creating`, `removed`, `removing`, `requested`.
storagePool | [storagePool]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/storagePool/)  | 
transitioning | enum  | Whether or not the externalStoragePoolEvent is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the externalStoragePoolEvent
uuid | string  | The universally unique identifier for the externalStoragePoolEvent. This will always be unique across Rancher installations.


<br>
