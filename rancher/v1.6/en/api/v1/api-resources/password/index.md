---
title: API
layout: rancher-api-v1-default-v1.6
version: v1.6
lang: en
apiVersion: v1
#redirect_from:
#  - /rancher/v1.6/zh/api/v1/api-resources/password/
---

## password



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
accountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/) | Optional | - | - | The unique identifier for the associated account
description | string | Optional | Yes | - | 
name | string | Optional | Yes | - | 
publicValue | string | Optional | - | - | The public value of the password
secretValue | [password]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/password/) | Optional | - | - | The secret value of the password


#### Read Only Fields

Field | Type   | Notes
---|---|---
created | date  | The date of when the password was created.
data | map[json]  | 
id | int  | The unique identifier for the password
kind | string  | 
removeTime | date  | The date and time of when the password was removed
removed | date  | The date of when the password was removed
state | enum  | The current state of the password. The options are `activating`, `active`, `deactivating`, `inactive`, `purged`, `purging`, `registering`, `removed`, `removing`, `requested`, `updating-active`, `updating-inactive`.
transitioning | enum  | Whether or not the password is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the password
uuid | string  | The universally unique identifier for the password. This will always be unique across Rancher installations.


<br>
