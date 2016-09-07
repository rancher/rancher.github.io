---
title: API
layout: rancher-api-default-v1.2
version: v1.2
lang: zh
---

## azureConfig

The configuration to launch an instance in Microsoft Azure. For all cloud providers, Rancher is calling `docker-machine`, so any available options in `docker-machine` are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation.

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
dockerPort | string | Optional | - | 2376 | 
dockerSwarmMasterPort | string | Optional | - | 3376 | 
image | string | Optional | - | - | 
location | string | Optional | - | West US | 
password | string | Optional | - | - | 
publishSettingsFile | string | Optional | - | - | 
size | string | Optional | - | Small | 
sshPort | string | Optional | - | 22 | The port to ssh into the host
subscriptionCert | string | Optional | - | - | 
subscriptionId | string | Optional | - | - | 
username | string | Optional | - | ubuntu | 



<br>
