---
title: API
layout: rancher-api-v1-default-v1.4
version: v1.4
lang: en
apiVersion: v1
---

## virtualMachine



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
blkioDeviceOptions | map[[blkioDeviceOption]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/blkioDeviceOption/)] | Optional | - | - | 
command | array[string] | Optional | - | - | 
count | int | Optional | - | - | 
cpuSet | string | Optional | - | - | 
cpuShares | int | Optional | - | - | 
description | string | Optional | Yes | - | 
disks | array[[virtualMachineDisk]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/virtualMachineDisk/)] | Optional | - | - | 
dns | array[string] | Optional | - | - | 
dnsSearch | array[string] | Optional | - | - | 
domainName | string | Optional | - | - | 
expose | array[string] | Optional | - | - | 
extraHosts | array[string] | Optional | - | - | 
healthCheck | [instanceHealthCheck]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instanceHealthCheck/) | Optional | - | - | 
hostname | string | Optional | - | - | 
imageUuid | string | Optional | - | - | 
instanceLinks | map[[instance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instance/)] | Optional | - | - | 
labels | map[string] | Optional | - | - | A map of key value pairs to be used as labels for the virtualMachine
logConfig | [logConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/logConfig/) | Optional | - | - | 
memory | int | Optional | - | - | 
memoryMb | int | Optional | - | 512 | 
memorySwap | int | Optional | - | - | 
name | string | Optional | Yes | - | 
networkIds | array[[network]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/network/)] | Optional | - | - | 
networkMode | enum | Optional | - | managed | The options are `none`, `bridge`, `host`, `managed`, `container`.
ports | array[string] | Optional | - | - | 
registryCredentialId | [registryCredential]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/registryCredential/) | Optional | - | - | 
requestedHostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host/) | Optional | - | - | 
restartPolicy | [restartPolicy]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/restartPolicy/) | Optional | - | - | 
securityOpt | array[string] | Optional | - | - | 
startOnCreate | boolean | Optional | - | true | 
userdata | string | Optional | - | - | 
vcpu | int | Optional | - | 1 | 
volumeDriver | string | Optional | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
accountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | The unique identifier for the associated account
createIndex | int  | 
created | date  | The date of when the virtualMachine was created.
deploymentUnitUuid | string  | 
externalId | string  | 
firstRunning | date  | 
healthState | enum  | The options are `healthy`, `unhealthy`, `updating-healthy`, `updating-unhealthy`, `initializing`.
hostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host/)  | The unique identifier for the associated host
id | int  | The unique identifier for the virtualMachine
kind | string  | 
nativeContainer | boolean  | 
primaryIpAddress | string  | 
removed | date  | The date of when the virtualMachine was removed
startCount | int  | 
state | enum  | The current state of the virtualMachine. The options are `creating`, `error`, `erroring`, `migrating`, `purged`, `purging`, `removed`, `removing`, `requested`, `restarting`, `restoring`, `running`, `starting`, `stopped`, `stopping`, `updating-running`, `updating-stopped`.
systemContainer | enum  | The options are `NetworkAgent`, `LoadBalancerAgent`.
transitioning | enum  | Whether or not the virtualMachine is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the virtualMachine
uuid | string  | The universally unique identifier for the virtualMachine. This will always be unique across Rancher installations.
version | string  | 


<br>
