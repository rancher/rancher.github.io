---
title: API
layout: rancher-api-v2-beta-default-v1.4
version: v1.4
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.4/zh/api/v2-beta/api-resources/defaultNetwork/
---

## defaultNetwork



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
defaultPolicyAction | enum | Optional | Yes | allow | The options are `allow`, `deny`.
description | string | Optional | Yes | - | 
dns | array[string] | Optional | - | - | 
dnsSearch | array[string] | Optional | - | - | 
hostPorts | boolean | Optional | - | - | 
kind | string | Optional | - | - | 
metadata | map[json] | Optional | Yes | - | 
name | string | Optional | Yes | - | 
policy | array[[networkPolicyRule]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/networkPolicyRule/)] | Optional | Yes | - | 
subnets | array[[subnet]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/subnet/)] | Optional | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
accountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | The unique identifier for the associated account
created | date  | The date of when the defaultNetwork was created.
id | int  | The unique identifier for the defaultNetwork
removed | date  | The date of when the defaultNetwork was removed
state | enum  | The current state of the defaultNetwork. The options are `activating`, `active`, `deactivating`, `inactive`, `purged`, `purging`, `registering`, `removed`, `removing`, `requested`, `restoring`, `updating-active`, `updating-inactive`.
transitioning | enum  | Whether or not the defaultNetwork is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the defaultNetwork
uuid | string  | The universally unique identifier for the defaultNetwork. This will always be unique across Rancher installations.


<br>
