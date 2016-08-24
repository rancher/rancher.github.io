---
title: Rancher API - serviceConsumeMap
layout: rancher-api-default
version: v1.2
lang: en
---

## ServiceConsumeMap



### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
consumedServiceId | [service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/service/) | - | - | - | 
description | string | Optional | Yes | - | 
id | int | - | - | - | The unique identifier for the serviceConsumeMap
name | string | - | - | - | 
ports | array[string] | - | - | - | 
serviceId | [service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/service/) | - | - | - | The unique identifier of the associated service

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.





