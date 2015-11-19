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
boot2dockerUrl | string | false | <no value> | The URL of the boot2docker image. Defaults to the latest available version
cpuCount | string | false | <no value> | The number of CPUs to use to create the VM. Defaults to single CPU
diskSize | string | false | <no value> | The size of disk for the host in MB
hostonlyCidr | string | false | <no value> | The CIDR of the host only adapter
importBoot2dockerVm | string | false | <no value> | The name of a Boot2Docker VM to import
memory | string | false | <no value> | The size of memory for the host in MB
noShare | boolean | false | <no value> | Whether or not to disable the mount of your home directory

