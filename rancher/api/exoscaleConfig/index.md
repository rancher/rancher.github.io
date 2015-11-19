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
apiKey | string | false | <no value> | <strong>required</strong> Your API key
apiSecretKey | string | false | <no value> | <strong>required</strong> Your API secret key
availabilityZone | string | false | <no value> | The exoscale availability zone
diskSize | string | false | <no value> | The disk size for the host in GB
image | string | false | <no value> | The image name for exoscale
instanceProfile | string | false | <no value> | The instance profile
securityGroup | array[string] | false | <no value> | The security group to use in exoscale, which will be created if it doesn’t exist
url | string | false | <no value> | Your API endpoint

