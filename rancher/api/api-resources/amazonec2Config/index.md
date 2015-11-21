---
title: API
layout: rancher-default
---

## amazonec2Config


The configuration to launch an EC2 instance in Amazon Web Services using [machine]({{site.baseurl}}/rancher/api/api-resources/machine). Rancher is calling `docker-machine`, so any available options in `docker-machine` for specific drivers are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation. The notes on which fields are **required** are from the `docker-machine` documentation.

​​
### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
accessKey | string | true | <no value> | <strong>required</strong> Your access key id for the Amazon Web Services API
ami | string | false | <no value> | The AMI ID of the instance to use
iamInstanceProfile | string | false | <no value> | The AWS IAM instance role name to be used as the instance profile
instanceType | string | false | <no value> | The AWS instance type to run
monitoring | boolean | false | <no value> | Whether or not to enable CloudWatch Monitoring
privateAddressOnly | boolean | false | <no value> | Whether or not to use the AWS EC2 private IP address
region | string | false | <no value> | The region to use when launching the host
requestSpotInstance | boolean | false | <no value> | Whether or not to use AWS EC2 spot instances
rootSize | string | false | <no value> | The root disk size of the AWS EC2 instance (in GB)
secretKey | string | true | <no value> | <strong>required</strong> Your secret access key for the Amazon Web Services API
securityGroup | string | false | <no value> | The AWS VPC security group name to use when launching your instance
sessionToken | string | false | <no value> | The session token for the AWS API
spotPrice | string | false | <no value> | The spot instance bid price (in dollars) if the `requestSpotInstance` is `true`.
sshUser | string | false | <no value> | The ssh username to use to ssh into the host
subnetId | string | false | <no value> | The AWS VPC subnet ID
usePrivateAddress | boolean | false | <no value> | Whether or not to use the AWS EC2 private IP address
vpcId | string | false | <no value> | <strong>required</strong> The VPC ID to launch the instance in
zone | string | false | <no value> | The AWS zone to launch the instance in (i.e. one of a, b, c, d, e)

