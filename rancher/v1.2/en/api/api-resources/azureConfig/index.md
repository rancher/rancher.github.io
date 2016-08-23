---
title: API
layout: rancher-api-default
version: v1.2
lang: en
---

## azureConfig


The configuration to launch an instance in Microsoft Azure. For all cloud providers, Rancher is calling `docker-machine`, so any available options in `docker-machine` are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation.


### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
dockerPort | string | false | 2376 | 
dockerSwarmMasterPort | string | false | 3376 | 
image | string | false |  | 
location | string | false | West US | 
password | string | false |  | 
publishSettingsFile | string | false |  | 
size | string | false | Small | 
sshPort | string | false | 22 | The port to ssh into the host
subscriptionCert | string | false |  | 
subscriptionId | string | false |  | 
username | string | false | ubuntu | 

