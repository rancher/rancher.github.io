---
title: API
layout: rancher-default
---

## secondaryLaunchConfig




​​
### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
build | dockerBuild | false | <no value> | 
capAdd | array[enum] | false | <no value> | 
capDrop | array[enum] | false | <no value> | 
command | array[string] | false | <no value> | 
count | int | false | <no value> | 
cpuSet | string | false | <no value> | 
cpuShares | int | false | <no value> | 
createIndex | int | false | <no value> | 
dataVolumeMounts | map[reference[volume]] | false | <no value> | 
dataVolumes | array[string] | false | <no value> | 
dataVolumesFrom | array[reference[container]] | false | <no value> | 
dataVolumesFromLaunchConfigs | array[string] | false | <no value> | 
deploymentUnitUuid | string | false | <no value> | 
devices | array[string] | false | <no value> | 
dns | array[string] | false | <no value> | 
dnsSearch | array[string] | false | <no value> | 
domainName | string | false | <no value> | 
entryPoint | array[string] | false | <no value> | 
environment | map[string] | false | <no value> | 
expose | array[string] | false | <no value> | 
externalId | string | false | <no value> | 
extraHosts | array[string] | false | <no value> | 
firstRunning | date | false | <no value> | 
healthCheck | instanceHealthCheck | false | <no value> | 
healthState | enum | false | <no value> | 
hostname | string | false | <no value> | 
imageUuid | string | false | <no value> | 
instanceLinks | map[reference[instance]] | false | <no value> | 
labels | map[string] | false | <no value> | 
logConfig | logConfig | false | <no value> | 
lxcConf | map[string] | false | <no value> | 
memory | int | false | <no value> | 
memorySwap | int | false | <no value> | 
nativeContainer | boolean | false | <no value> | 
networkContainerId | reference[container] | false | <no value> | 
networkIds | array[reference[network]] | false | <no value> | 
networkLaunchConfig | string | false | <no value> | 
networkMode | enum | false | managed | 
pidMode | enum | false | <no value> | 
ports | array[string] | false | <no value> | 
primaryIpAddress | string | false | <no value> | 
privileged | boolean | false | false | 
publishAllPorts | boolean | false | false | 
readOnly | boolean | false | false | 
registryCredentialId | reference[registryCredential] | false | <no value> | 
requestedHostId | reference[host] | false | <no value> | 
securityOpt | array[string] | false | <no value> | 
startCount | int | false | <no value> | 
startOnCreate | boolean | false | true | 
stdinOpen | boolean | false | false | 
systemContainer | enum | false | <no value> | 
tty | boolean | false | false | 
user | string | false | <no value> | 
version | string | false | 0 | 
volumeDriver | string | false | <no value> | 
workingDir | string | false | <no value> | 

