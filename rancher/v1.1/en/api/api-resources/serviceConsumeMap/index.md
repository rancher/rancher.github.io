---
title: Rancher API - serviceConsumeMap
layout: rancher-api-default-v1.1
version: v1.1
lang: en
---

## ServiceConsumeMap



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
consumedServiceId | [service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/service/)  | 
id | int  | The unique identifier for the serviceConsumeMap
name | string  | 
ports | array[string]  | 
serviceId | [service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/service/)  | The unique identifier of the associated service


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.




