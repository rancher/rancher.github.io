---
title: API
layout: rancher-api-v1-default-v1.6
version: v1.6
lang: en
apiVersion: v1
#redirect_from:
#  - /rancher/v1.6/zh/api/v1/api-resources/image/
---

## image



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
created | date  | The date of when the image was created.
data | map[json]  | 
id | int  | The unique identifier for the image
kind | string  | 
removeTime | date  | The date and time of when the image was removed
removed | date  | The date of when the image was removed
state | enum  | The current state of the image. The options are `activating`, `active`, `deactivating`, `inactive`, `purged`, `purging`, `registering`, `removed`, `removing`, `requested`, `restoring`, `updating-active`, `updating-inactive`.
transitioning | enum  | Whether or not the image is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the image
uuid | string  | The universally unique identifier for the image. This will always be unique across Rancher installations.


<br>
