---
title: API
layout: rancher-api-default
version: v1.2
lang: en
---

## externalHostEvent





### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
deleteHost | boolean | false | false | 
eventType | string | false |  | 
externalId | string | false |  | 
hostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/host/) | false |  | The unique identifier for the associated host
hostLabel | string | false |  | 
id | int | false |  | The unique identifier for the externalHostEvent
reportedAccountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/account/) | false |  | 

