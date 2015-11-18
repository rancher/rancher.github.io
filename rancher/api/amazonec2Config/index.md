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
accessKey | string | true | <no value> | The accessKey for the amazonec2Config
ami | string | false | <no value> | The AMI ID of the instance to use
iamInstanceProfile | string | false | <no value> | The AWS IAM instance role name to be used as the instance profile
instanceType | string | false | <no value> | The AWS instance type to run
monitoring | boolean | false | <no value> | Whether or not to enable CloudWatch Monitoring
privateAddressOnly | boolean | false | <no value> | Whether or not to use the AWS EC2 private IP address
region | string | false | <no value> | The region to use when launching the host
requestSpotInstance | boolean | false | <no value> | Whether or not to use AWS EC2 spot instances
rootSize | string | false | <no value> | The root disk size of the AWS EC2 instance (in GB)
secretKey | string | true | <no value> | The secretKey for the amazonec2Config
securityGroup | string | false | <no value> | The securityGroup for the amazonec2Config
sessionToken | string | false | <no value> | The session token for the AWS API
spotPrice | string | false | <no value> | The spot instance bid price (in dollars) if the `requestSpotInstance` is `true`.
sshUser | string | false | <no value> | The ssh username to use to ssh into the host
subnetId | string | false | <no value> | The AWS VPC subnet ID
usePrivateAddress | boolean | false | <no value> | Whether or not to use the AWS EC2 private IP address
vpcId | string | false | <no value> | The VPC ID to launch the instance in
zone | string | false | <no value> | The AWS zone to launch the instance in (i.e. one of a, b, c, d, e)

