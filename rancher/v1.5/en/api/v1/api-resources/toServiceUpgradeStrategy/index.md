---
title: API
layout: rancher-api-v1-default-v1.4
version: v1.4
lang: en
apiVersion: v1
---

## toServiceUpgradeStrategy



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
batchSize | int | Optional | - | 1 | 
finalScale | int | Optional | - | 1 | 
intervalMillis | int | Optional | - | 2000 | 
toServiceId | [service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/) | Optional | - | - | 
updateLinks | boolean | Optional | - | - | 



<br>
