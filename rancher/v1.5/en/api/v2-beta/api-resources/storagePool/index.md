---
title: API
layout: rancher-api-v2-beta-default-v1.4
version: v1.4
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.4/zh/api/v2-beta/api-resources/storagePool/
---

## storagePool

A storage pool is a list of hosts that can participate in shared storage.

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
blockDevicePath | string  | 
created | date  | The date of when the storagePool was created.
driverName | string  | 
externalId | string  | 
hostIds | array[[host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host/)]  | 
id | int  | The unique identifier for the storagePool
kind | string  | 
removed | date  | The date of when the storagePool was removed
state | enum  | The current state of the storagePool. The options are `activating`, `active`, `deactivating`, `inactive`, `purged`, `purging`, `registering`, `removed`, `removing`, `requested`, `restoring`, `updating-active`, `updating-inactive`.
storageDriverId | [storageDriver]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/storageDriver/)  | 
transitioning | enum  | Whether or not the storagePool is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the storagePool
uuid | string  | The universally unique identifier for the storagePool. This will always be unique across Rancher installations.
volumeAccessMode | string  | 
volumeCapabilities | array[string]  | 
volumeIds | array[[volume]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/volume/)]  | 


<br>
