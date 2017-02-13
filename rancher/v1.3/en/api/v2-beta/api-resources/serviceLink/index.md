---
title: API
layout: rancher-api-v2-beta-default-v1.4
version: v1.4
lang: en
apiVersion: v2-beta
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
