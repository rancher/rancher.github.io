---
title: API
layout: rancher-api-v1-default-v1.0
version: v1.0
lang: en
apiVersion: v1
---

## port



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
name | string | Optional | Yes | - | 
publicPort | int | - | Yes | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
accountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | The unique identifier for the associated account
bindAddress | string  | 
created | date  | The date of when the port was created.
id | int  | The unique identifier for the port
instanceId | [instance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instance/)  | The unique identifier for the associated instance
kind | string  | 
privateIpAddressId | [ipAddress]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/ipAddress/)  | 
privatePort | int  | 
protocol | string  | 
publicIpAddressId | [ipAddress]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/ipAddress/)  | 
removed | date  | The date of when the port was removed
state | enum  | The current state of the port. The options are `activating`, `active`, `deactivating`, `inactive`, `purged`, `purging`, `registering`, `removed`, `removing`, `requested`, `restoring`, `updating-active`, `updating-inactive`.
transitioning | enum  | Whether or not the port is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the port
uuid | string  | The universally unique identifier for the port. This will always be unique across Rancher installations.


<br>
