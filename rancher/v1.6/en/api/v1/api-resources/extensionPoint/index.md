---
title: Rancher API - extensionPoint
layout: rancher-api-v1-default-v1.6
version: v1.6
lang: en
apiVersion: v1
#redirect_from:
#  - /rancher/v1.6/zh/api/v1/api-resources/extensionPoint/
---

## ExtensionPoint



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
name | string | Optional | Yes | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
excludeSetting | string  | 
implementations | array[[extensionImplementation]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/extensionImplementation/)]  | 
includeSetting | string  | 
listSetting | string  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.




