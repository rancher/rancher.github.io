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
apiKey | string | false | <no value> | <strong>required</strong> Your API key for your user account.
cpu | string | false | <no value> | The number of CPUs for the machine
diskSize | string | false | <no value> | A value of 0 will set the SoftLayer default.
domain | string | false | <no value> | <strong>required</strong> The domain name for the machine
hostname | string | false | <no value> | The hostname for the machine
hourlyBilling | boolean | false | <no value> | Whether or not use hourly billing, if `false`, monthly billing is used
image | string | false | <no value> | The OS image to use
localDisk | boolean | false | <no value> | Whether or not to use local machine disk instead of SoftLayer SAN
memory | string | false | <no value> | The memory for host in MB
privateNetOnly | boolean | false | <no value> | Whether or not to disable public networking
privateVlanId | string | false | <no value> | The private VLAN ID
publicVlanId | string | false | <no value> | The public VLAN ID
region | string | false | <no value> | The region to use when launching the host
user | string | false | <no value> | <strong>required</strong> Your username for your SoftLayer account

