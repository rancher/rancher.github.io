---
title: API
layout: rancher-api-v2-beta-default-v1.3
version: v1.3
lang: en
apiVersion: v2-beta
redirect_from:
  - /rancher/v1.3/zh/api/v2-beta/api-resources/secondaryLaunchConfig/
---

## secondaryLaunchConfig



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
blkioDeviceOptions | map[[blkioDeviceOption]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/blkioDeviceOption/)] | Optional | - | - | 
blkioWeight | int | Optional | - | - | 
build | [dockerBuild]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/dockerBuild/) | Optional | - | - | 
capAdd | array[enum] | Optional | - | - | 
capDrop | array[enum] | Optional | - | - | 
cgroupParent | string | Optional | - | - | 
command | array[string] | Optional | - | - | 
count | int | Optional | - | - | 
cpuCount | int | Optional | - | - | 
cpuPercent | int | Optional | - | - | 
cpuPeriod | int | Optional | - | - | 
cpuQuota | int | Optional | - | - | 
cpuSet | string | Optional | - | - | 
cpuSetMems | string | Optional | - | - | 
cpuShares | int | Optional | - | - | 
dataVolumeMounts | map[[volume]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/volume/)] | Optional | - | - | 
dataVolumes | array[string] | Optional | - | - | 
dataVolumesFrom | array[[container]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/container/)] | Optional | - | - | 
dataVolumesFromLaunchConfigs | array[string] | Optional | - | - | 
description | string | Optional | Yes | - | 
devices | array[string] | Optional | - | - | 
diskQuota | int | Optional | - | - | 
disks | array[[virtualMachineDisk]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/virtualMachineDisk/)] | Optional | - | - | 
dns | array[string] | Optional | - | - | 
dnsOpt | array[string] | Optional | - | - | 
dnsSearch | array[string] | Optional | - | - | 
domainName | string | Optional | - | - | 
entryPoint | array[string] | Optional | - | - | 
environment | map[string] | Optional | - | - | 
expose | array[string] | Optional | - | - | 
extraHosts | array[string] | Optional | - | - | 
groupAdd | array[string] | Optional | - | - | 
healthCheck | [instanceHealthCheck]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instanceHealthCheck/) | Optional | - | - | 
healthCmd | array[string] | Optional | - | - | 
healthInterval | int | Optional | - | - | 
healthRetries | int | Optional | - | - | 
healthTimeout | int | Optional | - | - | 
hostname | string | Optional | - | - | 
imageUuid | string | Optional | - | - | 
instanceLinks | map[[instance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/instance/)] | Optional | - | - | 
instanceTriggeredStop | enum | Optional | - | stop | The options are `stop`, `remove`.
ioMaximumBandwidth | int | Optional | - | - | 
ioMaximumIOps | int | Optional | - | - | 
ip | string | Optional | - | - | 
ip6 | string | Optional | - | - | 
ipcMode | string | Optional | - | - | 
isolation | string | Optional | - | - | 
kernelMemory | int | Optional | - | - | 
kind | enum | Optional | - | container | The options are `container`, `virtualMachine`.
labels | map[string] | Optional | - | - | A map of key value pairs to be used as labels for the secondaryLaunchConfig
logConfig | [logConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/logConfig/) | Optional | - | - | 
lxcConf | map[string] | Optional | - | - | 
memory | int | Optional | - | - | 
memoryMb | int | Optional | - | - | 
memoryReservation | int | Optional | - | - | 
memorySwap | int | Optional | - | - | 
memorySwappiness | int | Optional | - | - | 
milliCpuReservation | int | Optional | - | - | 
name | string | Yes | - | - | 
netAlias | array[string] | Optional | - | - | 
networkContainerId | [container]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/container/) | Optional | - | - | 
networkIds | array[[network]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/network/)] | Optional | - | - | 
networkLaunchConfig | string | Optional | - | - | 
networkMode | string | Optional | - | managed | 
oomKillDisable | boolean | Optional | - | - | 
oomScoreAdj | int | Optional | - | - | 
pidMode | enum | Optional | - | - | The options are `host`.
pidsLimit | int | Optional | - | - | 
ports | array[string] | Optional | Yes | - | 
privileged | boolean | Optional | - | - | 
publishAllPorts | boolean | Optional | - | - | 
readOnly | boolean | Optional | - | - | 
registryCredentialId | [registryCredential]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/registryCredential/) | Optional | - | - | 
requestedHostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host/) | Optional | - | - | 
requestedIpAddress | string | Optional | - | - | 
securityOpt | array[string] | Optional | - | - | 
shmSize | int | Optional | - | - | 
startOnCreate | boolean | Optional | - | true | 
stdinOpen | boolean | Optional | - | - | 
stopSignal | string | Optional | - | - | 
storageOpt | map[string] | Optional | - | - | 
sysctls | map[string] | Optional | - | - | 
tmpfs | map[string] | Optional | - | - | 
tty | boolean | Optional | - | - | 
ulimits | array[[ulimit]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/ulimit/)] | Optional | - | - | 
user | string | Optional | - | - | 
userdata | string | Optional | - | - | 
usernsMode | string | Optional | - | - | 
uts | string | Optional | - | - | 
vcpu | int | Optional | - | 1 | 
volumeDriver | string | Optional | - | - | 
workingDir | string | Optional | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
accountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | The unique identifier for the associated account
createIndex | int  | 
created | date  | The date of when the secondaryLaunchConfig was created.
deploymentUnitUuid | string  | 
externalId | string  | 
firstRunning | date  | 
healthState | enum  | The options are `healthy`, `unhealthy`, `updating-healthy`, `updating-unhealthy`, `initializing`.
hostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host/)  | The unique identifier for the associated host
id | int  | The unique identifier for the secondaryLaunchConfig
mounts | array[[mountEntry]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/mountEntry/)]  | 
nativeContainer | boolean  | 
primaryIpAddress | string  | 
primaryNetworkId | [network]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/network/)  | 
removed | date  | The date of when the secondaryLaunchConfig was removed
serviceIds | array[[service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/)]  | 
startCount | int  | 
state | enum  | The current state of the secondaryLaunchConfig. The options are `creating`, `error`, `erroring`, `migrating`, `purged`, `purging`, `removed`, `removing`, `requested`, `restarting`, `restoring`, `running`, `starting`, `stopped`, `stopping`, `updating-running`, `updating-stopped`.
system | boolean  | 
transitioning | enum  | Whether or not the secondaryLaunchConfig is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the secondaryLaunchConfig
uuid | string  | The universally unique identifier for the secondaryLaunchConfig. This will always be unique across Rancher installations.
version | string  | 


<br>
