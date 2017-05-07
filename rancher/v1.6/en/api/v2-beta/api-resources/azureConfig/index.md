---
title: API
layout: rancher-api-v2-beta-default-v1.6
version: v1.6
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.6/zh/api/v2-beta/api-resources/azureConfig/
---

## azureConfig

The configuration to launch an instance in Microsoft Azure. For all cloud providers, Rancher is calling `docker-machine`, so any available options in `docker-machine` are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation.

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
availabilitySet | string | Optional | - | docker-machine | 
clientId | string | Optional | - | - | 
clientSecret | string | Optional | - | - | 
customData | string | Optional | - | - | 
dns | string | Optional | - | - | 
dockerPort | string | Optional | - | 2376 | 
environment | string | Optional | - | AzurePublicCloud | 
image | string | Optional | - | canonical:UbuntuServer:16.04.0-LTS:latest | 
location | string | Optional | - | westus | 
noPublicIp | boolean | Optional | - | - | 
openPort | array[string] | Optional | - | - | 
privateIpAddress | string | Optional | - | - | 
resourceGroup | string | Optional | - | docker-machine | 
size | string | Optional | - | Standard_A2 | 
sshUser | string | Optional | - | docker-user | The ssh username to use to ssh into the host
staticPublicIp | boolean | Optional | - | - | 
storageType | string | Optional | - | Standard_LRS | 
subnet | string | Optional | - | docker-machine | 
subnetPrefix | string | Optional | - | 192.168.0.0/16 | 
subscriptionId | string | Optional | - | - | 
usePrivateIp | boolean | Optional | - | - | 
vnet | string | Optional | - | docker-machine-vnet | 



<br>
