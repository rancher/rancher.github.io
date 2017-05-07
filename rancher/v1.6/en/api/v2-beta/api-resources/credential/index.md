---
title: API
layout: rancher-api-v2-beta-default-v1.6
version: v1.6
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.6/zh/api/v2-beta/api-resources/credential/
---

## credential



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
name | string | Optional | Yes | - | 
publicValue | string | Optional | - | - | The public value of the credential
secretValue | [password]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/password/) | Optional | - | - | The secret value of the credential


#### Read Only Fields

Field | Type   | Notes
---|---|---
accountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | The unique identifier for the associated account
created | date  | The date of when the credential was created.
data | map[json]  | 
id | int  | The unique identifier for the credential
kind | string  | 
removeTime | date  | The date and time of when the credential was removed
removed | date  | The date of when the credential was removed
state | enum  | The current state of the credential. The options are `activating`, `active`, `deactivating`, `inactive`, `purged`, `purging`, `registering`, `removed`, `removing`, `requested`, `updating-active`, `updating-inactive`.
transitioning | enum  | Whether or not the credential is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the credential
uuid | string  | The universally unique identifier for the credential. This will always be unique across Rancher installations.


<br>
