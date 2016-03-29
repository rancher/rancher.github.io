---
title: API
layout: rancher-default
---

## secondaryLaunchConfig




​​
### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
build | [dockerBuild]({{site.baseurl}}/rancher/api/api-resources/dockerBuild/) | false | <no value> | 
capAdd | array[enum] | false | <no value> | Add Linux capabilities. <code>--cap-add</code> in a <code>docker run</code> command
capDrop | array[enum] | false | <no value> | Drop Linux capabilities. <code>--cap-drop</code> in a <code>docker run</code> command
command | array[string] | false | <no value> | Overwrite the default commands set by the image
count | int | false | <no value> | 
cpuSet | string | false | <no value> | CPUs in which to allow execution (0-3, 0,1). <code>--cpuset</code> in a <code>docker run</code> command
cpuShares | int | false | <no value> | CPU shares (relative weight). <code>--cpu-shares</code> in a <code>docker run</code> command
createIndex | int | false | <no value> | The order that the container was created in a service.
dataVolumeMounts | map[[volume]({{site.baseurl}}/rancher/api/api-resources/volume/)] | false | <no value> | 
dataVolumes | array[string] | false | <no value> | 
dataVolumesFrom | array[[container]({{site.baseurl}}/rancher/api/api-resources/container/)] | false | <no value> | 
dataVolumesFromLaunchConfigs | array[string] | false | <no value> | 
deploymentUnitUuid | string | false | <no value> | 
description | string | false | <no value> | 
devices | array[string] | false | <no value> | Allows you to run devices inside the container without the <code>--privileged</code> flag
disks | array[virtualMachineDisk] | false | <no value> | 
dns | array[string] | false | <no value> | Set custom dns servers for the container. <code>--dns</code> in a <code>docker run</code> command
dnsSearch | array[string] | false | <no value> | 
domainName | string | false | <no value> | 
entryPoint | array[string] | false | <no value> | Overwrite the default entrypoint set by the image. <code>--entrypoint</code> in a <code>docker run</code> command
environment | map[string] | false | <no value> | 
expose | array[string] | false | <no value> | 
externalId | string | false | <no value> | 
extraHosts | array[string] | false | <no value> | 
firstRunning | date | false | <no value> | 
healthCheck | [instanceHealthCheck]({{site.baseurl}}/rancher/api/api-resources/instanceHealthCheck/) | false | <no value> | The configuration of the health monitoring for managed network services
healthState | enum | false | <no value> | 
hostId | [host]({{site.baseurl}}/rancher/api/api-resources/host/) | false | <no value> | The unique identifier for the associated host
hostname | string | false | <no value> | 
id | int | false | <no value> | The unique identifier for the secondaryLaunchConfig
imageUuid | string | false | <no value> | 
instanceLinks | map[[instance]({{site.baseurl}}/rancher/api/api-resources/instance/)] | false | <no value> | 
labels | map[string] | false | <no value> | 
logConfig | [logConfig]({{site.baseurl}}/rancher/api/api-resources/logConfig/) | false | <no value> | The logging configuration. <code>--log-driver</code> in a <code>docker run</code> command
lxcConf | map[string] | false | <no value> | Add custom lxc options. <code>--lxc-conf</code> in a <code>docker run</code> command
memory | int | false | <no value> | 
memoryMb | int | false | <no value> | 
memorySwap | int | false | <no value> | Total memory limit (memory + swap, `<number>[<unit>]`, where unit = b, k, m or g). <code>--memory-swap</code> in a <code>docker run</code> command
name | string | true | <no value> | 
nativeContainer | boolean | false | <no value> | 
networkContainerId | [container]({{site.baseurl}}/rancher/api/api-resources/container/) | false | <no value> | 
networkIds | array[[network]({{site.baseurl}}/rancher/api/api-resources/network/)] | false | <no value> | 
networkLaunchConfig | string | false | <no value> | 
networkMode | enum | false | managed | Set the Network mode for the container. <code>--net</code> in a <code>docker run</code> command <br> `bridge` - creates a new network stack for the container on the docker bridge<br> `none` -no networking for this container<br> `container<colon><name|id>` - reuses another container network stack<br> `host` - use the host network stack inside the container
pidMode | enum | false | <no value> | Set the PID (Process) Namespace mode for the container. `host` - use the host's PID namespace inside the container.  <code>--pid</code> in a <code>docker run</code> command
ports | array[string] | false | <no value> | 
primaryIpAddress | string | false | <no value> | 
privileged | boolean | false | false | Give extended privileges to this container. <code>--privileged</code> in a <code>docker run</code> command
publishAllPorts | boolean | false | false | Publish all exposed ports to the host interfaces
readOnly | boolean | false | false | 
registryCredentialId | [registryCredential]({{site.baseurl}}/rancher/api/api-resources/registryCredential/) | false | <no value> | 
requestedHostId | [host]({{site.baseurl}}/rancher/api/api-resources/host/) | false | <no value> | 
requestedIpAddress | string | false | <no value> | 
securityOpt | array[string] | false | <no value> | Override the default labeling scheme for each container. <code>--security-opt</code> in a <code>docker run</code> command
startCount | int | false | <no value> | 
startOnCreate | boolean | false | true | Whether or not the services in the stack should be started after creation
stdinOpen | boolean | false | false | Keep STDIN open even if not attached. <code>-i</code> in a <code>docker run</code> command
systemContainer | enum | false | <no value> | 
tty | boolean | false | false | Allocate a pseudo-tty. <code>-t</code> in a <code>docker run</code> command
user | string | false | <no value> | 
userdata | string | false | <no value> | 
vcpu | int | false | 1 | 
version | string | false | 0 | 
volumeDriver | string | false | <no value> | 
workingDir | string | false | <no value> | The working directory inside the container

