---
title: API
layout: rancher-api-v2-beta-default-v1.6
version: v1.6
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.6/zh/api/v2-beta/api-resources/externalDnsEvent/
---

## externalDnsEvent



### Resource Fields


#### Read Only Fields

Field | Type   | Notes
---|---|---
accountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | The unique identifier for the associated account
created | date  | The date of when the externalDnsEvent was created.
data | map[json]  | 
eventType | string  | 
externalId | string  | 
fqdn | string  | 
id | int  | The unique identifier for the externalDnsEvent
kind | string  | 
reportedAccountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | 
serviceName | string  | 
stackName | string  | 
state | enum  | The current state of the externalDnsEvent. The options are `created`, `creating`, `removed`, `removing`, `requested`.
transitioning | enum  | Whether or not the externalDnsEvent is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the externalDnsEvent
uuid | string  | The universally unique identifier for the externalDnsEvent. This will always be unique across Rancher installations.


<br>
