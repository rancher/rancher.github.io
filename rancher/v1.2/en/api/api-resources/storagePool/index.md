---
title: API
layout: rancher-api-default
version: v1.2
lang: en
---

## storagePool


A storage pool is a list of hosts that can participate in shared storage.


### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
blockDevicePath | string | false |  | 
description | string | false |  | 
driverName | string | false |  | 
externalId | string | false |  | 
id | int | false |  | The unique identifier for the storagePool
name | string | false |  | 
volumeAccessMode | string | false |  | 
volumeCapabilities | array[string] | false |  | 

