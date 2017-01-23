---
title: API
layout: rancher-api-v2-beta-default-v1.3
version: v1.3
lang: en
apiVersion: v2-beta
redirect_from:
  - /rancher/v1.3/zh/api/v2-beta/api-resources/amazonec2Config/
---

## amazonec2Config

The configuration to launch an EC2 instance in Amazon Web Services using [machine]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/machine). Rancher is calling `docker-machine`, so any available options in `docker-machine` for specific drivers are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation. The notes on which fields are **required** are from the `docker-machine` documentation.

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
accessKey | string | Optional | - | - | 
ami | string | Optional | - | - | 
blockDurationMinutes | string | Optional | - | 0 | 
deviceName | string | Optional | - | /dev/sda1 | 
endpoint | string | Optional | - | - | 
iamInstanceProfile | string | Optional | - | - | 
insecureTransport | boolean | Optional | - | - | 
instanceType | string | Optional | - | t2.micro | 
keypairName | string | Optional | - | - | 
monitoring | boolean | Optional | - | - | 
openPort | array[string] | Optional | - | - | 
privateAddressOnly | boolean | Optional | - | - | 
region | string | Optional | - | us-east-1 | The region to use when launching the host
requestSpotInstance | boolean | Optional | - | - | 
retries | string | Optional | - | 5 | 
rootSize | string | Optional | - | 16 | 
secretKey | string | Optional | - | - | 
securityGroup | array[string] | Optional | - | [docker-machine] | 
sessionToken | string | Optional | - | - | 
spotPrice | string | Optional | - | 0.50 | 
sshKeypath | string | Optional | - | - | 
sshUser | string | Optional | - | ubuntu | The ssh username to use to ssh into the host
subnetId | string | Optional | - | - | 
tags | string | Optional | - | - | 
useEbsOptimizedInstance | boolean | Optional | - | - | 
usePrivateAddress | boolean | Optional | - | - | 
userdata | string | Optional | - | - | 
volumeType | string | Optional | - | gp2 | 
vpcId | string | Optional | - | - | 
zone | string | Optional | - | a | 



<br>
