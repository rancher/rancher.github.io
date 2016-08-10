---
title: API
layout: rancher-api-default
version: latest
lang: en
---

## externalStoragePoolEvent





### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
eventType | string | false |  | 
externalId | string | false |  | 
hostUuids | array[string] | false |  | 
id | int | false |  | The unique identifier for the externalStoragePoolEvent
reportedAccountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/account/) | false |  | 
storagePool | [storagePool]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/storagePool/) | true |  | 

