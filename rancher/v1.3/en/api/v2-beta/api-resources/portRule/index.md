---
title: API
layout: rancher-api-v2-beta-default-v1.4
version: v1.4
lang: en
apiVersion: v2-beta
---

## portRule



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
backendName | string | Optional | - | - | 
hostname | string | Optional | - | - | 
path | string | Optional | - | - | 
priority | int | Optional | - | - | 
protocol | enum | Optional | - | http | The options are `http`, `tcp`, `https`, `tls`, `sni`, `udp`.
selector | string | Optional | - | - | 
serviceId | [service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/) | Optional | - | - | The unique identifier of the associated service
sourcePort | int | Yes | - | - | 
targetPort | int | Optional | - | - | 



<br>
