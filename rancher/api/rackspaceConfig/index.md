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
apiKey | string | true | <no value> | 
dockerInstall | string | false | <no value> | Whether or not if Docker should be installed on the machine
endpointType | string | false | <no value> | Endpoint type can be `internalURL`, `adminURL`, or` publicURL`. If is a helper for the driver to choose the right URL in the OpenStack service catalog. If not provided the default id `publicURL`
flavorId | string | false | <no value> | The ID of the flavor that will be used for the machine
imageId | string | false | <no value> | The ID of the image that will be used for the machine
region | string | false | <no value> | The region to use when launching the host
sshPort | string | false | <no value> | The port to ssh into the host
sshUser | string | false | <no value> | The ssh username to use to ssh into the host
username | string | true | <no value> | 

