---
title: API
layout: rancher-api-default
version: v1.2
lang: en
---

## externalVolumeEvent





### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
eventType | string | false |  | 
externalId | string | false |  | 
id | int | false |  | The unique identifier for the externalVolumeEvent
reportedAccountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/account/) | false |  | 
volume | [volume]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/volume/) | true |  | 

