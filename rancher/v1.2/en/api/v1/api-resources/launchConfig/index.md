---
title: API
layout: rancher-api-v1-default-v1.2
version: v1.2
lang: en
apiVersion: v1
redirect_from:
  - /rancher/v1.2/zh/api/v1/api-resources/launchConfig/
---

## launchConfig



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
blkioDeviceOptions | map[[blkioDeviceOption]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/blkioDeviceOption/)] | Optional | - | - | 
build | [dockerBuild]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/dockerBuild/) | Optional | - | - | 
capAdd | array[enum] | Optional | - | - | 
capDrop | array[enum] | Optional | - | - | 
command | array[string] | Optional | - | - | 
count | int | Optional | - | - | 
cpuSet | string | Optional | - | - | 
cpuShares | int | Optional | - | - | 
dataVolumeMounts | map[[volume]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/volume/)] | Optional | - | - | 
dataVolumes | array[string] | Optional | - | - | 
dataVolumesFrom | array[[container]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/container/)] | Optional | - | - | 
dataVolumesFromLaunchConfigs | array[string] | Optional | - | - | 
description | string | Optional | Yes | - | 
devices | array[string] | Optional | - | - | 
disks | array[[virtualMachineDisk]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/virtualMachineDisk/)] | Optional | - | - | 
dns | array[string] | Optional | - | - | 
dnsSearch | array[string] | Optional | - | - | 
domainName | string | Optional | - | - | 
entryPoint | array[string] | Optional | - | - | 
environment | map[string] | Optional | - | - | 
expose | array[string] | Optional | - | - | 
extraHosts | array[string] | Optional | - | - | 
healthCheck | [instanceHealthCheck]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instanceHealthCheck/) | Optional | - | - | 
hostname | string | Optional | - | - | 
imageUuid | string | Optional | - | - | 
instanceLinks | map[[instance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instance/)] | Optional | - | - | 
kind | enum | Optional | - | container | The options are `container`, `virtualMachine`.
labels | map[string] | Optional | - | - | A map of key value pairs to be used as labels for the launchConfig
logConfig | [logConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/logConfig/) | Optional | - | - | 
lxcConf | map[string] | Optional | - | - | 
memory | int | Optional | - | - | 
memoryMb | int | Optional | - | - | 
memorySwap | int | Optional | - | - | 
networkContainerId | [container]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/container/) | Optional | - | - | 
networkIds | array[[network]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/network/)] | Optional | - | - | 
networkLaunchConfig | string | Optional | - | - | 
networkMode | enum | Optional | - | managed | The options are `none`, `bridge`, `host`, `managed`, `container`.
pidMode | enum | Optional | - | - | The options are `host`.
ports | array[string] | Optional | - | - | 
privileged | boolean | Optional | - | - | 
publishAllPorts | boolean | Optional | - | - | 
readOnly | boolean | Optional | - | - | 
registryCredentialId | [registryCredential]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/registryCredential/) | Optional | - | - | 
requestedHostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host/) | Optional | - | - | 
requestedIpAddress | string | Optional | - | - | 
securityOpt | array[string] | Optional | - | - | 
startOnCreate | boolean | Optional | - | true | 
stdinOpen | boolean | Optional | - | - | 
tty | boolean | Optional | - | - | 
user | string | Optional | - | - | 
userdata | string | Optional | - | - | 
vcpu | int | Optional | - | 1 | 
volumeDriver | string | Optional | - | - | 
workingDir | string | Optional | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
accountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | The unique identifier for the associated account
createIndex | int  | 
created | date  | The date of when the launchConfig was created.
deploymentUnitUuid | string  | 
externalId | string  | 
firstRunning | date  | 
healthState | enum  | The options are `healthy`, `unhealthy`, `updating-healthy`, `updating-unhealthy`, `initializing`.
hostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host/)  | The unique identifier for the associated host
id | int  | The unique identifier for the launchConfig
nativeContainer | boolean  | 
primaryIpAddress | string  | 
removed | date  | The date of when the launchConfig was removed
startCount | int  | 
state | enum  | The current state of the launchConfig. The options are `creating`, `error`, `erroring`, `migrating`, `purged`, `purging`, `removed`, `removing`, `requested`, `restarting`, `restoring`, `running`, `starting`, `stopped`, `stopping`, `updating-running`, `updating-stopped`.
systemContainer | enum  | The options are `NetworkAgent`, `LoadBalancerAgent`.
transitioning | enum  | Whether or not the launchConfig is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the launchConfig
uuid | string  | The universally unique identifier for the launchConfig. This will always be unique across Rancher installations.
version | string  | 


<br>
