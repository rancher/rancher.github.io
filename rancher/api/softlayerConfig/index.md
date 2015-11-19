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
apiEndpoint | string | false | <no value> | The SoftLayer API endpoint to use
apiKey | string | false | <no value> | 
cpu | string | false | <no value> | The number of CPUs for the machine
diskSize | string | false | <no value> | 
domain | string | false | <no value> | 
hostname | string | false | <no value> | 
hourlyBilling | boolean | false | <no value> | Whether or not use hourly blling, if `false`, monthly billing is used
image | string | false | <no value> | 
localDisk | boolean | false | <no value> | Whether or not to use local machine disk instead of SoftLayer SAN
memory | string | false | <no value> | 
privateNetOnly | boolean | false | <no value> | Whether or not to disable public networking
privateVlanId | string | false | <no value> | The private VLAN ID
publicVlanId | string | false | <no value> | The public VLAN ID
region | string | false | <no value> | The region to use when launching the host
user | string | false | <no value> | 

