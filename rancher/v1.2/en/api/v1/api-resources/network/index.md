---
title: Rancher API - network
layout: rancher-api-v1-default-v1.2
version: v1.2
lang: en
apiVersion: v1
redirect_from:
  - /rancher/v1.2/zh/api/v1/api-resources/network/
---

## Network

The networks available within Rancher that containers could be launched on.

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
name | string | Optional | Yes | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
id | int  | The unique identifier for the network


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.




