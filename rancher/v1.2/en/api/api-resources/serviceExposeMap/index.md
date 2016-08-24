---
title: Rancher API - serviceExposeMap
layout: rancher-api-default
version: v1.2
lang: en
---

## ServiceExposeMap



### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
id | int | - | - | - | The unique identifier for the serviceExposeMap
instanceId | [instance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/instance/) | - | - | - | The unique identifier for the associated instance
ipAddress | string | - | - | - | 
managed | boolean | - | - | - | 
name | string | Optional | Yes | - | 
serviceId | [service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/service/) | - | - | - | The unique identifier of the associated service

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.





