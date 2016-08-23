---
title: API
layout: rancher-api-default
version: v1.2
lang: en
---

## amazonec2Config


The configuration to launch an EC2 instance in Amazon Web Services using [machine]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/machine). Rancher is calling `docker-machine`, so any available options in `docker-machine` for specific drivers are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation. The notes on which fields are **required** are from the `docker-machine` documentation.


### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
accessKey | string | false |  | 
ami | string | false |  | 
deviceName | string | false | /dev/sda1 | 
iamInstanceProfile | string | false |  | 
instanceType | string | false | t2.micro | 
monitoring | boolean | false |  | 
privateAddressOnly | boolean | false |  | 
region | string | false | us-east-1 | The region to use when launching the host
requestSpotInstance | boolean | false |  | 
rootSize | string | false | 16 | 
secretKey | string | false |  | 
securityGroup | string | false | docker-machine | 
sessionToken | string | false |  | 
spotPrice | string | false | 0.50 | 
sshKeypath | string | false |  | 
sshUser | string | false | ubuntu | The ssh username to use to ssh into the host
subnetId | string | false |  | 
tags | string | false |  | 
useEbsOptimizedInstance | boolean | false |  | 
usePrivateAddress | boolean | false |  | 
volumeType | string | false | gp2 | 
vpcId | string | false |  | 
zone | string | false | a | 

