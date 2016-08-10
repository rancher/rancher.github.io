---
title: API
layout: rancher-api-default
version: latest
lang: en
---

## serviceEvent





### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
description | string | false |  | 
externalTimestamp | int | false |  | 
healthcheckUuid | string | false |  | 
hostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/host/) | false |  | The unique identifier for the associated host
id | int | false |  | The unique identifier for the serviceEvent
instanceId | [instance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/instance/) | false |  | The unique identifier for the associated instance
name | string | false |  | 
reportedHealth | string | false |  | 

