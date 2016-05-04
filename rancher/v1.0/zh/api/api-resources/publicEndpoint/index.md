---
title: API
layout: rancher-default-v1.0
version: v1.0
lang: zh
---

## publicEndpoint





### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
hostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/host/) | false |  | The unique identifier for the associated host
instanceId | [instance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/instance/) | false |  | The unique identifier for the associated instance
ipAddress | string | false |  | 
port | int | false |  | 
serviceId | [service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/service/) | false |  | The unique identifier of the associated service

