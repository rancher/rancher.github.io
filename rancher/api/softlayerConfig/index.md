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
apiKey | string | false | <no value> | The apiKey for the softlayerConfig
cpu | string | false | <no value> | The number of CPUs for the machine
diskSize | string | false | <no value> | The diskSize for the softlayerConfig
domain | string | false | <no value> | The domain for the softlayerConfig
hostname | string | false | <no value> | The hostname for the softlayerConfig
hourlyBilling | boolean | false | <no value> | Whether or not use hourly blling, if `false`, monthly billing is used
image | string | false | <no value> | The image for the softlayerConfig
localDisk | boolean | false | <no value> | Whether or not to use local machine disk instead of SoftLayer SAN
memory | string | false | <no value> | The memory for the softlayerConfig
privateNetOnly | boolean | false | <no value> | Whether or not to disable public networking
privateVlanId | string | false | <no value> | The private VLAN ID
publicVlanId | string | false | <no value> | The public VLAN ID
region | string | false | <no value> | The region to use when launching the host
user | string | false | <no value> | The user for the softlayerConfig

