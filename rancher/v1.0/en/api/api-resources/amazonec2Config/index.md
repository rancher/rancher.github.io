---
title: API
layout: rancher-default-v1.0
version: v1.0
lang: en
---

## amazonec2Config

The configuration to launch an EC2 instance in Amazon Web Services using [machine]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/machine). Rancher is calling `docker-machine`, so any available options in `docker-machine` for specific drivers are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation. The notes on which fields are **required** are from the `docker-machine` documentation.

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
accessKey | string | Optional | Yes | - | <strong>required</strong> Your access key id for the Amazon Web Services API
ami | string | Optional | Yes | - | The AMI ID of the instance to use
deviceName | string | Optional | Yes | - | 
iamInstanceProfile | string | Optional | Yes | - | The AWS IAM instance role name to be used as the instance profile
instanceType | string | Optional | Yes | - | The AWS instance type to run
monitoring | boolean | Optional | Yes | - | Whether or not to enable CloudWatch Monitoring
privateAddressOnly | boolean | Optional | Yes | - | Whether or not to use the AWS EC2 private IP address
region | string | Optional | Yes | - | The region to use when launching the instance.
requestSpotInstance | boolean | Optional | Yes | - | Whether or not to use AWS EC2 spot instances
rootSize | string | Optional | Yes | - | The root disk size of the AWS EC2 instance (in GB)
secretKey | string | Optional | Yes | - | <strong>required</strong> Your secret access key for the Amazon Web Services API
securityGroup | string | Optional | Yes | - | The AWS VPC security group name to use when launching your instance
sessionToken | string | Optional | Yes | - | The session token for the AWS API
spotPrice | string | Optional | Yes | - | The spot instance bid price (in dollars) if the `requestSpotInstance` is `true`.
sshKeypath | string | Optional | Yes | - | 
sshUser | string | Optional | Yes | - | The SSH login user name
subnetId | string | Optional | Yes | - | The AWS VPC subnet ID
tags | string | Optional | Yes | - | 
useEbsOptimizedInstance | boolean | Optional | Yes | - | 
usePrivateAddress | boolean | Optional | Yes | - | Whether or not to use the AWS EC2 private IP address
volumeType | string | Optional | Yes | - | 
vpcId | string | Optional | Yes | - | <strong>required</strong> The VPC ID to launch the instance in
zone | string | Optional | Yes | - | The AWS zone to launch the instance in (i.e. one of a, b, c, d, e)


Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.


### Operations
{::options parse_block_html="true" /}



<div class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/amazonec2Config</code></span></span>
<div class="action-contents">
{% highlight json %} 
{

	"accessKey": "string",

	"ami": "string",

	"deviceName": "string",

	"iamInstanceProfile": "string",

	"instanceType": "string",

	"monitoring": true,

	"privateAddressOnly": true,

	"region": "string",

	"requestSpotInstance": true,

	"rootSize": "string",

	"secretKey": "string",

	"securityGroup": "string",

	"sessionToken": "string",

	"spotPrice": "string",

	"sshKeypath": "string",

	"sshUser": "string",

	"subnetId": "string",

	"tags": "string",

	"useEbsOptimizedInstance": true,

	"usePrivateAddress": true,

	"volumeType": "string",

	"vpcId": "string",

	"zone": "string"

} 
{% endhighlight %}
</div>
</div>










