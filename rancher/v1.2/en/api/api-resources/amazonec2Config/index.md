---
title: API
layout: rancher-api-default-v1.2
version: v1.2
lang: en
---

## amazonec2Config

The configuration to launch an EC2 instance in Amazon Web Services using [machine]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/machine). Rancher is calling `docker-machine`, so any available options in `docker-machine` for specific drivers are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation. The notes on which fields are **required** are from the `docker-machine` documentation.

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
accessKey | string | Optional | - | - | 
ami | string | Optional | - | - | 
deviceName | string | Optional | - | /dev/sda1 | 
iamInstanceProfile | string | Optional | - | - | 
instanceType | string | Optional | - | t2.micro | 
monitoring | boolean | Optional | - | - | 
privateAddressOnly | boolean | Optional | - | - | 
region | string | Optional | - | us-east-1 | The region to use when launching the host
requestSpotInstance | boolean | Optional | - | - | 
rootSize | string | Optional | - | 16 | 
secretKey | string | Optional | - | - | 
securityGroup | string | Optional | - | docker-machine | 
sessionToken | string | Optional | - | - | 
spotPrice | string | Optional | - | 0.50 | 
sshKeypath | string | Optional | - | - | 
sshUser | string | Optional | - | ubuntu | The ssh username to use to ssh into the host
subnetId | string | Optional | - | - | 
tags | string | Optional | - | - | 
useEbsOptimizedInstance | boolean | Optional | - | - | 
usePrivateAddress | boolean | Optional | - | - | 
volumeType | string | Optional | - | gp2 | 
vpcId | string | Optional | - | - | 
zone | string | Optional | - | a | 



<br>
