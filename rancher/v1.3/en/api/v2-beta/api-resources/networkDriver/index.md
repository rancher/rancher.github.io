---
title: Rancher API - networkDriver
layout: rancher-api-v2-beta-default-v1.3
version: v1.3
lang: en
apiVersion: v2-beta
redirect_from:
  - /rancher/v1.3/zh/api/v2-beta/api-resources/networkDriver/
---

## NetworkDriver

A network driver is the

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
cniConfig | map[json] | Optional | - | - | 
defaultNetwork | [defaultNetwork]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/defaultNetwork/) | Optional | - | - | 
description | string | Optional | Yes | - | 
name | string | Optional | Yes | - | 
networkMetadata | map[json] | Optional | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
id | int  | The unique identifier for the networkDriver
serviceId | [service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/)  | The unique identifier of the associated service


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.




