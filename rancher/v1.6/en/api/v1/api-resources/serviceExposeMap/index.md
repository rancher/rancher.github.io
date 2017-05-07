---
title: API
layout: rancher-api-v1-default-v1.6
version: v1.6
lang: en
apiVersion: v1
#redirect_from:
#  - /rancher/v1.6/zh/api/v1/api-resources/serviceExposeMap/
---

## serviceExposeMap



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
created | date  | The date of when the serviceExposeMap was created.
data | map[json]  | 
id | int  | The unique identifier for the serviceExposeMap
instanceId | [instance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instance/)  | The unique identifier for the associated instance
ipAddress | string  | 
kind | string  | 
managed | boolean  | 
removeTime | date  | The date and time of when the serviceExposeMap was removed
removed | date  | The date of when the serviceExposeMap was removed
serviceId | [service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/)  | The unique identifier of the associated service
state | enum  | The current state of the serviceExposeMap. The options are `activating`, `active`, `removed`, `removing`, `requested`.
transitioning | enum  | Whether or not the serviceExposeMap is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the serviceExposeMap
uuid | string  | The universally unique identifier for the serviceExposeMap. This will always be unique across Rancher installations.


<br>
