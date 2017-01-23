---
title: API
layout: rancher-api-v1-default-v1.2
version: v1.2
lang: en
apiVersion: v1
redirect_from:
  - /rancher/v1.2/zh/api/v1/api-resources/serviceLink/
---

## serviceLink



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
name | string | Optional | - | - | 
serviceId | [service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/) | Yes | - | - | The unique identifier of the associated service


#### Read Only Fields

Field | Type   | Notes
---|---|---
uuid | string  | The universally unique identifier for the serviceLink. This will always be unique across Rancher installations.


<br>
