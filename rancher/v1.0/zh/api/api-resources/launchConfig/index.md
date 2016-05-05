---
title: API
layout: rancher-default-v1.0
version: v1.0
lang: zh
---

## launchConfig





### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
build | [dockerBuild]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/dockerBuild/) | false |  | 
capAdd | array[enum] | false |  | Add Linux capabilities. <code>--cap-add</code> in a <code>docker run</code> command
capDrop | array[enum] | false |  | Drop Linux capabilities. <code>--cap-drop</code> in a <code>docker run</code> command
command | array[string] | false |  | Overwrite the default commands set by the image
count | int | false |  | 
cpuSet | string | false |  | CPUs in which to allow execution (0-3, 0,1). <code>--cpuset</code> in a <code>docker run</code> command
cpuShares | int | false |  | CPU shares (relative weight). <code>--cpu-shares</code> in a <code>docker run</code> command
createIndex | int | false |  | The order that the container was created in a service.
dataVolumeMounts | map[[volume]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/volume/)] | false |  | 
dataVolumes | array[string] | false |  | 
dataVolumesFrom | array[[container]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/container/)] | false |  | 
dataVolumesFromLaunchConfigs | array[string] | false |  | 
deploymentUnitUuid | string | false |  | 
description | string | false |  | 
devices | array[string] | false |  | Allows you to run devices inside the container without the <code>--privileged</code> flag
disks | array[virtualMachineDisk] | false |  | 
dns | array[string] | false |  | Set custom dns servers for the container. <code>--dns</code> in a <code>docker run</code> command
dnsSearch | array[string] | false |  | 
domainName | string | false |  | 
entryPoint | array[string] | false |  | Overwrite the default entrypoint set by the image. <code>--entrypoint</code> in a <code>docker run</code> command
environment | map[string] | false |  | 
expose | array[string] | false |  | 
externalId | string | false |  | 
extraHosts | array[string] | false |  | 
firstRunning | date | false |  | 
healthCheck | [instanceHealthCheck]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/instanceHealthCheck/) | false |  | The configuration of the health monitoring for managed network services
healthState | enum | false |  | 
hostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/host/) | false |  | The unique identifier for the associated host
hostname | string | false |  | 
id | int | false |  | The unique identifier for the launchConfig
imageUuid | string | false |  | 
instanceLinks | map[[instance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/instance/)] | false |  | 
labels | map[string] | false |  | 
logConfig | [logConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/logConfig/) | false |  | The logging configuration. <code>--log-driver</code> in a <code>docker run</code> command
lxcConf | map[string] | false |  | Add custom lxc options. <code>--lxc-conf</code> in a <code>docker run</code> command
memory | int | false |  | 
memoryMb | int | false |  | 
memorySwap | int | false |  | Total memory limit (memory + swap, `<number>[<unit>]`, where unit = b, k, m or g). <code>--memory-swap</code> in a <code>docker run</code> command
nativeContainer | boolean | false |  | 
networkContainerId | [container]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/container/) | false |  | 
networkIds | array[[network]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/network/)] | false |  | 
networkLaunchConfig | string | false |  | 
networkMode | enum | false | managed | Set the Network mode for the container. <code>--net</code> in a <code>docker run</code> command <br> `bridge` - creates a new network stack for the container on the docker bridge<br> `none` -no networking for this container<br> `container<colon><name|id>` - reuses another container network stack<br> `host` - use the host network stack inside the container
pidMode | enum | false |  | Set the PID (Process) Namespace mode for the container. `host` - use the host's PID namespace inside the container.  <code>--pid</code> in a <code>docker run</code> command
ports | array[string] | false |  | 
primaryIpAddress | string | false |  | 
privileged | boolean | false | false | Give extended privileges to this container. <code>--privileged</code> in a <code>docker run</code> command
publishAllPorts | boolean | false | false | Publish all exposed ports to the host interfaces
readOnly | boolean | false | false | 
registryCredentialId | [registryCredential]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/registryCredential/) | false |  | 
requestedHostId | [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/host/) | false |  | 
requestedIpAddress | string | false |  | 
securityOpt | array[string] | false |  | Override the default labeling scheme for each container. <code>--security-opt</code> in a <code>docker run</code> command
startCount | int | false |  | The number of times the container was started
startOnCreate | boolean | false | true | Whether or not the services in the stack should be started after creation
stdinOpen | boolean | false | false | Keep STDIN open even if not attached. <code>-i</code> in a <code>docker run</code> command
systemContainer | enum | false |  | 
tty | boolean | false | false | Allocate a pseudo-tty. <code>-t</code> in a <code>docker run</code> command
user | string | false |  | 
userdata | string | false |  | 
vcpu | int | false | 1 | 
version | string | false | 0 | 
volumeDriver | string | false |  | 
workingDir | string | false |  | The working directory inside the container

