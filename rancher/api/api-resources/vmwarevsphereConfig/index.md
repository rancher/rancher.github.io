---
title: API
layout: rancher-default
---

## vmwarevsphereConfig


The configuration to launch a machine in vSphere. Rancher is just calling `docker-machine`, so any available options in `docker-machine` are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation.

​​
### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
boot2dockerUrl | string | false | <no value> | The URL of the boot2docker image. Defaults to the latest available version
computeIp | string | false | <no value> | The compute host IP where the Docker VM will be instantiated
cpuCount | string | false | <no value> | The number of CPUs to use to create the VM. Defaults to single CPU
datacenter | string | false | <no value> | The datacenter for Docker VM
datastore | string | false | <no value> | The datastore for Docker VM
diskSize | string | false | <no value> | The size of disk for Docker VM (in MB)
memorySize | string | false | <no value> | The size of memory for Docker VM (in MB) and added as `2048`
network | string | false | <no value> | The network where the Docker VM will be attached
password | string | false | <no value> | <strong>required</strong> Your vSphere password
pool | string | false | <no value> | The resource pool for Docker VM
username | string | false | <no value> | <strong>required</strong> Your vSphere username
vcenter | string | false | <no value> | The IP/hostname for vCenter (or ESXi if connecting directly to a single host)

