---
title: API
layout: rancher-default
---

## exoscaleConfig


The configuration to launch an instance in exoscale using [machine]({{site.baseurl}}/rancher/api/api-resources/machine). Rancher is calling `docker-machine`, so any available options in `docker-machine` for specific drivers are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation. The notes on which fields are **required** are from the `docker-machine` documentation.

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

