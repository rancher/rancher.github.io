---
title: API
layout: rancher-api-default
version: v1.2
lang: en
---

## kubernetesService





### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
description | string | false |  | 
environmentId | [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/environment/) | true |  | 
externalId | string | false |  | 
healthState | string | false |  | 
id | int | false |  | The unique identifier for the kubernetesService
name | string | true |  | 
selectorContainer | string | false |  | 
template | json | false |  | 
vip | string | false |  | 

