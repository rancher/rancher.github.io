---
title: API
layout: rancher-api-default
version: v1.2
lang: en
---

## backup





### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
backupTargetId | [backupTarget]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/backupTarget/) | false |  | 
description | string | false |  | 
id | int | false |  | The unique identifier for the backup
name | string | false |  | 
snapshotId | [snapshot]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/snapshot/) | false |  | 
uri | string | false |  | 
volumeId | [volume]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/volume/) | false |  | 

