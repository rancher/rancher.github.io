---
title: API
layout: rancher-api-v1-default-v1.3
version: v1.3
lang: en
apiVersion: v1
redirect_from:
  - /rancher/v1.3/zh/api/v1/api-resources/serviceConsumeMap/
---

## serviceConsumeMap



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
accountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | The unique identifier for the associated account
consumedServiceId | [service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/)  | 
created | date  | The date of when the serviceConsumeMap was created.
id | int  | The unique identifier for the serviceConsumeMap
kind | string  | 
name | string  | 
ports | array[string]  | 
removed | date  | The date of when the serviceConsumeMap was removed
serviceId | [service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/)  | The unique identifier of the associated service
state | enum  | The current state of the serviceConsumeMap. The options are `activating`, `active`, `removed`, `removing`, `requested`, `updating-active`.
transitioning | enum  | Whether or not the serviceConsumeMap is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the serviceConsumeMap
uuid | string  | The universally unique identifier for the serviceConsumeMap. This will always be unique across Rancher installations.


<br>
