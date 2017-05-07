---
title: API
layout: rancher-api-v1-default-v1.6
version: v1.6
lang: en
apiVersion: v1
#redirect_from:
#  - /rancher/v1.6/zh/api/v1/api-resources/snapshotBackupInput/
---

## snapshotBackupInput



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
backupTargetId | [backupTarget]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/backupTarget/) | Yes | - | - | 
name | string | Optional | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
data | map[json]  | 
removeTime | date  | The date and time of when the snapshotBackupInput was removed


<br>
