---
title: API
layout: rancher-default
---

## <no value>

Description of API Input from yaml file. 
​​
### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
build | dockerBuild | false | <no value> | The build for the launchConfig
capAdd | array[enum] | false | <no value> | The capAdd for the launchConfig
capDrop | array[enum] | false | <no value> | The capDrop for the launchConfig
command | array[string] | false | <no value> | The command for the launchConfig
count | int | false | <no value> | The count for the launchConfig
cpuSet | string | false | <no value> | The cpuSet for the launchConfig
cpuShares | int | false | <no value> | The cpuShares for the launchConfig
createIndex | int | false | <no value> | The createIndex for the launchConfig
dataVolumeMounts | map[reference[volume]] | false | <no value> | The dataVolumeMounts for the launchConfig
dataVolumes | array[string] | false | <no value> | The dataVolumes for the launchConfig
dataVolumesFrom | array[reference[container]] | false | <no value> | The dataVolumesFrom for the launchConfig
dataVolumesFromLaunchConfigs | array[string] | false | <no value> | The dataVolumesFromLaunchConfigs for the launchConfig
deploymentUnitUuid | string | false | <no value> | The deploymentUnitUuid for the launchConfig
devices | array[string] | false | <no value> | The devices for the launchConfig
dns | array[string] | false | <no value> | The dns for the launchConfig
dnsSearch | array[string] | false | <no value> | The dnsSearch for the launchConfig
domainName | string | false | <no value> | The domainName for the launchConfig
entryPoint | array[string] | false | <no value> | The entryPoint for the launchConfig
environment | map[string] | false | <no value> | The environment for the launchConfig
expose | array[string] | false | <no value> | The expose for the launchConfig
externalId | string | false | <no value> | The externalId for the launchConfig
extraHosts | array[string] | false | <no value> | The extraHosts for the launchConfig
firstRunning | date | false | <no value> | The firstRunning for the launchConfig
healthCheck | instanceHealthCheck | false | <no value> | The healthCheck for the launchConfig
healthState | enum | false | <no value> | The healthState for the launchConfig
hostname | string | false | <no value> | The hostname for the launchConfig
imageUuid | string | false | <no value> | The imageUuid for the launchConfig
instanceLinks | map[reference[instance]] | false | <no value> | The instanceLinks for the launchConfig
labels | map[string] | false | <no value> | The labels for the launchConfig
logConfig | logConfig | false | <no value> | The logConfig for the launchConfig
lxcConf | map[string] | false | <no value> | The lxcConf for the launchConfig
memory | int | false | <no value> | The memory for the launchConfig
memorySwap | int | false | <no value> | The memorySwap for the launchConfig
nativeContainer | boolean | false | <no value> | The nativeContainer for the launchConfig
networkContainerId | reference[container] | false | <no value> | The networkContainerId for the launchConfig
networkIds | array[reference[network]] | false | <no value> | The networkIds for the launchConfig
networkLaunchConfig | string | false | <no value> | The networkLaunchConfig for the launchConfig
networkMode | enum | false | managed | The networkMode for the launchConfig
pidMode | enum | false | <no value> | The pidMode for the launchConfig
ports | array[string] | false | <no value> | The ports for the launchConfig
primaryIpAddress | string | false | <no value> | The primaryIpAddress for the launchConfig
privileged | boolean | false | false | The privileged for the launchConfig
publishAllPorts | boolean | false | false | The publishAllPorts for the launchConfig
readOnly | boolean | false | false | The readOnly for the launchConfig
registryCredentialId | reference[registryCredential] | false | <no value> | The registryCredentialId for the launchConfig
requestedHostId | reference[host] | false | <no value> | The requestedHostId for the launchConfig
securityOpt | array[string] | false | <no value> | The securityOpt for the launchConfig
startCount | int | false | <no value> | The startCount for the launchConfig
startOnCreate | boolean | false | true | The startOnCreate for the launchConfig
stdinOpen | boolean | false | false | The stdinOpen for the launchConfig
systemContainer | enum | false | <no value> | The systemContainer for the launchConfig
tty | boolean | false | false | The tty for the launchConfig
user | string | false | <no value> | The user for the launchConfig
version | string | false | 0 | The version for the launchConfig
volumeDriver | string | false | <no value> | The volumeDriver for the launchConfig
workingDir | string | false | <no value> | The workingDir for the launchConfig

