---
title: API
layout: rancher-api-default
version: latest
lang: en
---

## containerEvent





### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
dockerInspect | json | false |  | 
externalFrom | string | false |  | 
externalId | string | false |  | 
externalStatus | string | false |  | 
externalTimestamp | int | false |  | 
hostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/host/) | false |  | The unique identifier for the associated host
id | int | false |  | The unique identifier for the containerEvent
reportedHostUuid | string | false |  | 

