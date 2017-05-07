---
title: API
layout: rancher-api-v2-beta-default-v1.6
version: v1.6
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.6/zh/api/v2-beta/api-resources/virtualMachine/
---

## virtualMachine



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
blkioDeviceOptions | map[[blkioDeviceOption]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/blkioDeviceOption/)] | Optional | - | - | 
blkioWeight | int | Optional | - | - | 
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
description | string | Optional | Yes | - | 
diskQuota | int | Optional | - | - | 
disks | array[[virtualMachineDisk]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/virtualMachineDisk/)] | Optional | - | - | 
dns | array[string] | Optional | - | - | 
dnsOpt | array[string] | Optional | - | - | 
dnsSearch | array[string] | Optional | - | - | 
domainName | string | Optional | - | - | 
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
labels | map[string] | Optional | - | - | A map of key value pairs to be used as labels for the virtualMachine
logConfig | [logConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/logConfig/) | Optional | - | - | 
memory | int | Optional | - | - | 
memoryMb | int | Optional | - | 512 | 
memoryReservation | int | Optional | - | - | 
memorySwap | int | Optional | - | - | 
memorySwappiness | int | Optional | - | - | 
milliCpuReservation | int | Optional | - | - | 
name | string | Optional | Yes | - | 
netAlias | array[string] | Optional | - | - | 
networkIds | array[[network]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/network/)] | Optional | - | - | 
networkMode | string | Optional | - | managed | 
oomKillDisable | boolean | Optional | - | - | 
oomScoreAdj | int | Optional | - | - | 
pidsLimit | int | Optional | - | - | 
ports | array[string] | Optional | - | - | 
registryCredentialId | [registryCredential]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/registryCredential/) | Optional | - | - | 
requestedHostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host/) | Optional | - | - | 
restartPolicy | [restartPolicy]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/restartPolicy/) | Optional | - | - | 
securityOpt | array[string] | Optional | - | - | 
shmSize | int | Optional | - | - | 
stackId | [stack]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/stack/) | Optional | - | - | 
startOnCreate | boolean | Optional | - | true | 
stopSignal | string | Optional | - | - | 
storageOpt | map[string] | Optional | - | - | 
sysctls | map[string] | Optional | - | - | 
tmpfs | map[string] | Optional | - | - | 
ulimits | array[[ulimit]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/ulimit/)] | Optional | - | - | 
userdata | string | Optional | - | - | 
usernsMode | string | Optional | - | - | 
uts | string | Optional | - | - | 
vcpu | int | Optional | - | 1 | 
volumeDriver | string | Optional | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
accountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)  | The unique identifier for the associated account
agentId | [agent]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/agent/)  | The unique identifier of the associated agent
allocationState | string  | 
createIndex | int  | 
created | date  | The date of when the virtualMachine was created.
data | map[json]  | 
deploymentUnitUuid | string  | 
externalId | string  | 
firstRunning | date  | 
healthState | enum  | The options are `healthy`, `unhealthy`, `updating-healthy`, `updating-unhealthy`, `initializing`.
hostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host/)  | The unique identifier for the associated host
id | int  | The unique identifier for the virtualMachine
kind | string  | 
mounts | array[[mountEntry]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/mountEntry/)]  | 
nativeContainer | boolean  | 
primaryIpAddress | string  | 
primaryNetworkId | [network]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/network/)  | 
removeTime | date  | The date and time of when the virtualMachine was removed
removed | date  | The date of when the virtualMachine was removed
serviceId | [service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/)  | The unique identifier of the associated service
serviceIds | array[[service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/)]  | 
startCount | int  | 
state | enum  | The current state of the virtualMachine. The options are `creating`, `error`, `erroring`, `migrating`, `purged`, `purging`, `removed`, `removing`, `requested`, `restarting`, `running`, `starting`, `stopped`, `stopping`, `updating-running`, `updating-stopped`.
system | boolean  | 
token | string  | 
transitioning | enum  | Whether or not the virtualMachine is in a transitioning state
transitioningMessage | string  | The message to show while in a transitioning state
transitioningProgress | int  | The percentage remaining in the transitioning process of the virtualMachine
userPorts | array[string]  | 
uuid | string  | The universally unique identifier for the virtualMachine. This will always be unique across Rancher installations.
version | string  | 


<br>
