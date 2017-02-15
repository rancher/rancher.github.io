---
title: API
layout: rancher-api-v2-beta-default-v1.4
version: v1.4
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.4/zh/api/v2-beta/api-resources/healthcheckInstanceHostMap/
---

## healthcheckInstanceHostMap



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
created | date  | The date of when the healthcheckInstanceHostMap was created.
healthState | string  | 
hostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host/)  | The unique identifier for the associated host
id | int  | The unique identifier for the healthcheckInstanceHostMap
instanceId | [instance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instance/)  | The unique identifier for the associated instance
kind | string  | 
removed | date  | The date of when the healthcheckInstanceHostMap was removed
state | enum  | The current state of the healthcheckInstanceHostMap. The options are `activating`, `active`, `removed`, `removing`, `requested`.
transitioning | enum  | Whether or not the healthcheckInstanceHostMap is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the healthcheckInstanceHostMap
uuid | string  | The universally unique identifier for the healthcheckInstanceHostMap. This will always be unique across Rancher installations.


<br>
