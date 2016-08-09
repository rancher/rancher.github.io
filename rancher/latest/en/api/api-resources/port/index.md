---
title: API
layout: rancher-api-default
version: latest
lang: en
---

## port





### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
bindAddress | string | false |  | 
description | string | false |  | 
id | int | false |  | The unique identifier for the port
instanceId | [instance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/instance/) | false |  | The unique identifier for the associated instance
name | string | false |  | 
privateIpAddressId | [ipAddress]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/ipAddress/) | false |  | 
privatePort | int | false |  | 
protocol | string | false |  | 
publicIpAddressId | [ipAddress]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/ipAddress/) | false |  | 
publicPort | int | false |  | 

