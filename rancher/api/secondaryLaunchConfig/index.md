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
build | dockerBuild | false | <no value> | The build for the secondaryLaunchConfig
capAdd | array[enum] | false | <no value> | The capAdd for the secondaryLaunchConfig
capDrop | array[enum] | false | <no value> | The capDrop for the secondaryLaunchConfig
command | array[string] | false | <no value> | The command for the secondaryLaunchConfig
count | int | false | <no value> | The count for the secondaryLaunchConfig
cpuSet | string | false | <no value> | The cpuSet for the secondaryLaunchConfig
cpuShares | int | false | <no value> | The cpuShares for the secondaryLaunchConfig
createIndex | int | false | <no value> | The createIndex for the secondaryLaunchConfig
dataVolumeMounts | map[reference[volume]] | false | <no value> | The dataVolumeMounts for the secondaryLaunchConfig
dataVolumes | array[string] | false | <no value> | The dataVolumes for the secondaryLaunchConfig
dataVolumesFrom | array[reference[container]] | false | <no value> | The dataVolumesFrom for the secondaryLaunchConfig
dataVolumesFromLaunchConfigs | array[string] | false | <no value> | The dataVolumesFromLaunchConfigs for the secondaryLaunchConfig
deploymentUnitUuid | string | false | <no value> | The deploymentUnitUuid for the secondaryLaunchConfig
devices | array[string] | false | <no value> | The devices for the secondaryLaunchConfig
dns | array[string] | false | <no value> | The dns for the secondaryLaunchConfig
dnsSearch | array[string] | false | <no value> | The dnsSearch for the secondaryLaunchConfig
domainName | string | false | <no value> | The domainName for the secondaryLaunchConfig
entryPoint | array[string] | false | <no value> | The entryPoint for the secondaryLaunchConfig
environment | map[string] | false | <no value> | The environment for the secondaryLaunchConfig
expose | array[string] | false | <no value> | The expose for the secondaryLaunchConfig
externalId | string | false | <no value> | The externalId for the secondaryLaunchConfig
extraHosts | array[string] | false | <no value> | The extraHosts for the secondaryLaunchConfig
firstRunning | date | false | <no value> | The firstRunning for the secondaryLaunchConfig
healthCheck | instanceHealthCheck | false | <no value> | The healthCheck for the secondaryLaunchConfig
healthState | enum | false | <no value> | The healthState for the secondaryLaunchConfig
hostname | string | false | <no value> | The hostname for the secondaryLaunchConfig
imageUuid | string | false | <no value> | The imageUuid for the secondaryLaunchConfig
instanceLinks | map[reference[instance]] | false | <no value> | The instanceLinks for the secondaryLaunchConfig
labels | map[string] | false | <no value> | The labels for the secondaryLaunchConfig
logConfig | logConfig | false | <no value> | The logConfig for the secondaryLaunchConfig
lxcConf | map[string] | false | <no value> | The lxcConf for the secondaryLaunchConfig
memory | int | false | <no value> | The memory for the secondaryLaunchConfig
memorySwap | int | false | <no value> | The memorySwap for the secondaryLaunchConfig
nativeContainer | boolean | false | <no value> | The nativeContainer for the secondaryLaunchConfig
networkContainerId | reference[container] | false | <no value> | The networkContainerId for the secondaryLaunchConfig
networkIds | array[reference[network]] | false | <no value> | The networkIds for the secondaryLaunchConfig
networkLaunchConfig | string | false | <no value> | The networkLaunchConfig for the secondaryLaunchConfig
networkMode | enum | false | managed | The networkMode for the secondaryLaunchConfig
pidMode | enum | false | <no value> | The pidMode for the secondaryLaunchConfig
ports | array[string] | false | <no value> | The ports for the secondaryLaunchConfig
primaryIpAddress | string | false | <no value> | The primaryIpAddress for the secondaryLaunchConfig
privileged | boolean | false | false | The privileged for the secondaryLaunchConfig
publishAllPorts | boolean | false | false | The publishAllPorts for the secondaryLaunchConfig
readOnly | boolean | false | false | The readOnly for the secondaryLaunchConfig
registryCredentialId | reference[registryCredential] | false | <no value> | The registryCredentialId for the secondaryLaunchConfig
requestedHostId | reference[host] | false | <no value> | The requestedHostId for the secondaryLaunchConfig
securityOpt | array[string] | false | <no value> | The securityOpt for the secondaryLaunchConfig
startCount | int | false | <no value> | The startCount for the secondaryLaunchConfig
startOnCreate | boolean | false | true | The startOnCreate for the secondaryLaunchConfig
stdinOpen | boolean | false | false | The stdinOpen for the secondaryLaunchConfig
systemContainer | enum | false | <no value> | The systemContainer for the secondaryLaunchConfig
tty | boolean | false | false | The tty for the secondaryLaunchConfig
user | string | false | <no value> | The user for the secondaryLaunchConfig
version | string | false | 0 | The version for the secondaryLaunchConfig
volumeDriver | string | false | <no value> | The volumeDriver for the secondaryLaunchConfig
workingDir | string | false | <no value> | The workingDir for the secondaryLaunchConfig

