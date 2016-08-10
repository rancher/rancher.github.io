---
title: API
layout: rancher-api-default
version: latest
lang: en
---

## secondaryLaunchConfig





### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
blkioDeviceOptions | map[[blkioDeviceOption]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/blkioDeviceOption/)] | false |  | 
build | [dockerBuild]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/dockerBuild/) | false |  | 
capAdd | array[enum] | false |  | 
capDrop | array[enum] | false |  | 
command | array[string] | false |  | 
count | int | false |  | 
cpuSet | string | false |  | 
cpuShares | int | false |  | 
createIndex | int | false |  | 
dataVolumeMounts | map[[volume]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/volume/)] | false |  | 
dataVolumes | array[string] | false |  | 
dataVolumesFrom | array[[container]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/container/)] | false |  | 
dataVolumesFromLaunchConfigs | array[string] | false |  | 
deploymentUnitUuid | string | false |  | 
description | string | false |  | 
devices | array[string] | false |  | 
disks | array[[virtualMachineDisk]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/virtualMachineDisk/)] | false |  | 
dns | array[string] | false |  | 
dnsSearch | array[string] | false |  | 
domainName | string | false |  | 
entryPoint | array[string] | false |  | 
environment | map[string] | false |  | 
expose | array[string] | false |  | 
externalId | string | false |  | 
extraHosts | array[string] | false |  | 
firstRunning | date | false |  | 
healthCheck | [instanceHealthCheck]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/instanceHealthCheck/) | false |  | 
healthState | enum | false |  | 
hostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/host/) | false |  | The unique identifier for the associated host
hostname | string | false |  | 
id | int | false |  | The unique identifier for the secondaryLaunchConfig
imageUuid | string | false |  | 
instanceLinks | map[[instance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/instance/)] | false |  | 
labels | map[string] | false |  | A map of key value pairs to be used as labels for the secondaryLaunchConfig
logConfig | [logConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/logConfig/) | false |  | 
lxcConf | map[string] | false |  | 
memory | int | false |  | 
memoryMb | int | false |  | 
memorySwap | int | false |  | 
name | string | true |  | 
nativeContainer | boolean | false |  | 
networkContainerId | [container]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/container/) | false |  | 
networkIds | array[[network]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/network/)] | false |  | 
networkLaunchConfig | string | false |  | 
networkMode | enum | false | managed | 
pidMode | enum | false |  | 
ports | array[string] | false |  | 
primaryIpAddress | string | false |  | 
privileged | boolean | false | false | 
publishAllPorts | boolean | false | false | 
readOnly | boolean | false | false | 
registryCredentialId | [registryCredential]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/registryCredential/) | false |  | 
requestedHostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/host/) | false |  | 
requestedIpAddress | string | false |  | 
securityOpt | array[string] | false |  | 
startCount | int | false |  | 
startOnCreate | boolean | false | true | 
stdinOpen | boolean | false | false | 
systemContainer | enum | false |  | 
tty | boolean | false | false | 
user | string | false |  | 
userdata | string | false |  | 
vcpu | int | false | 1 | 
version | string | false | 0 | 
volumeDriver | string | false |  | 
workingDir | string | false |  | 

