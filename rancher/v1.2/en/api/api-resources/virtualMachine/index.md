---
title: API
layout: rancher-api-default
version: latest
lang: en
---

## virtualMachine





### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
blkioDeviceOptions | map[[blkioDeviceOption]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/blkioDeviceOption/)] | false |  | 
command | array[string] | false |  | 
count | int | false |  | 
cpuSet | string | false |  | 
cpuShares | int | false |  | 
createIndex | int | false |  | 
deploymentUnitUuid | string | false |  | 
description | string | false |  | 
disks | array[[virtualMachineDisk]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/virtualMachineDisk/)] | false |  | 
dns | array[string] | false |  | 
dnsSearch | array[string] | false |  | 
domainName | string | false |  | 
expose | array[string] | false |  | 
externalId | string | false |  | 
extraHosts | array[string] | false |  | 
firstRunning | date | false |  | 
healthCheck | [instanceHealthCheck]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/instanceHealthCheck/) | false |  | 
healthState | enum | false |  | 
hostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/host/) | false |  | The unique identifier for the associated host
hostname | string | false |  | 
id | int | false |  | The unique identifier for the virtualMachine
imageUuid | string | false |  | 
instanceLinks | map[[instance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/instance/)] | false |  | 
labels | map[string] | false |  | A map of key value pairs to be used as labels for the virtualMachine
logConfig | [logConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/logConfig/) | false |  | 
memory | int | false |  | 
memoryMb | int | false | 512 | 
memorySwap | int | false |  | 
name | string | false |  | 
nativeContainer | boolean | false |  | 
networkIds | array[[network]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/network/)] | false |  | 
networkMode | enum | false | managed | 
ports | array[string] | false |  | 
primaryIpAddress | string | false |  | 
registryCredentialId | [registryCredential]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/registryCredential/) | false |  | 
requestedHostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/host/) | false |  | 
restartPolicy | [restartPolicy]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/restartPolicy/) | false |  | 
securityOpt | array[string] | false |  | 
startCount | int | false |  | 
startOnCreate | boolean | false | true | 
systemContainer | enum | false |  | 
userdata | string | false |  | 
vcpu | int | false | 1 | 
version | string | false | 0 | 
volumeDriver | string | false |  | 

