---
title: API
layout: rancher-api-v1-default-v1.0
version: v1.0
lang: en
apiVersion: v1
---

## credential



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
created | date  | The date of when the credential was created.
id | int  | The unique identifier for the credential
kind | string  | 
publicValue | string  | The public value of the credential
removed | date  | The date of when the credential was removed
secretValue | [password]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/password/)  | The secret value of the credential
state | enum  | The current state of the credential. The options are `activating`, `active`, `deactivating`, `inactive`, `purged`, `purging`, `registering`, `removed`, `removing`, `requested`, `updating-active`, `updating-inactive`.
transitioning | enum  | Whether or not the credential is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the credential
uuid | string  | The universally unique identifier for the credential. This will always be unique across Rancher installations.


<br>
