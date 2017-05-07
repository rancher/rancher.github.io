---
title: API
layout: rancher-api-v2-beta-default-v1.6
version: v1.6
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.6/zh/api/v2-beta/api-resources/subnet/
---

## subnet



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
cidrSize | int | Yes | - | 24 | 
description | string | Optional | Yes | - | 
endAddress | string | Optional | - | - | 
gateway | string | Optional | - | - | 
name | string | Optional | Yes | - | 
networkAddress | string | Yes | - | - | 
startAddress | string | Optional | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
accountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | The unique identifier for the associated account
created | date  | The date of when the subnet was created.
data | map[json]  | 
id | int  | The unique identifier for the subnet
kind | string  | 
networkId | [network]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/network/)  | 
removeTime | date  | The date and time of when the subnet was removed
removed | date  | The date of when the subnet was removed
state | enum  | The current state of the subnet. The options are `activating`, `active`, `deactivating`, `inactive`, `purged`, `purging`, `registering`, `removed`, `removing`, `requested`, `updating-active`, `updating-inactive`.
transitioning | enum  | Whether or not the subnet is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the subnet
uuid | string  | The universally unique identifier for the subnet. This will always be unique across Rancher installations.


<br>
