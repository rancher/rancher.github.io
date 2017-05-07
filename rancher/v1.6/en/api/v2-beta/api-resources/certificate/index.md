---
title: Rancher API - certificate
layout: rancher-api-v2-beta-default-v1.6
version: v1.6
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.6/zh/api/v2-beta/api-resources/certificate/
---

## Certificate

A certificate is used to add in SSL termination to load balancers.

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
cert | string | Yes | Yes | - | 
certChain | string | Optional | Yes | - | 
description | string | Optional | Yes | - | 
key | string | Yes | Yes | - | 
name | string | Yes | Yes | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
CN | string  | 
algorithm | string  | 
certFingerprint | string  | 
data | map[json]  | 
expiresAt | string  | 
id | int  | The unique identifier for the certificate
issuedAt | string  | 
issuer | string  | 
keySize | int  | 
serialNumber | string  | 
subjectAlternativeNames | array[string]  | 
version | string  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.




