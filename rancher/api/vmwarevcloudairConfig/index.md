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
catalog | string | false | <no value> | The catalog
catalogitem | string | false | <no value> | The catalog item
computeid | string | false | <no value> | The compute ID (if using dedicated cloud)
cpuCount | string | false | <no value> | The number of CPUs to use to create the VM. Defaults to single CPU
dockerPort | string | false | <no value> | The port to use for the Docker daemon
edgegateway | string | false | <no value> | The organization edge gateway
memorySize | string | false | <no value> | The size of memory for Docker VM (in MB) and added as `2048`
orgvdcnetwork | string | false | <no value> | The organization VDC network to attach
password | string | false | <no value> | 
provision | boolean | false | <no value> | Whether or not to install Docker binaries
publicip | string | false | <no value> | The  organization public IP to use
sshPort | string | false | <no value> | The port to ssh into the host
username | string | false | <no value> | 
vdcid | string | false | <no value> | The Virtiual Data Center ID

