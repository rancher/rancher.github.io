---
title: API
layout: rancher-api-v2-beta-default-v1.4
version: v1.4
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.4/zh/api/v2-beta/api-resources/label/
---

## label



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
created | date  | The date of when the label was created.
id | int  | The unique identifier for the label
key | string  | 
kind | string  | 
removed | date  | The date of when the label was removed
state | enum  | The current state of the label. The options are `created`, `creating`, `removed`, `removing`, `requested`.
transitioning | enum  | Whether or not the label is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the label
uuid | string  | The universally unique identifier for the label. This will always be unique across Rancher installations.
value | string  | 


<br>
