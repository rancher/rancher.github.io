---
title: API
layout: rancher-api-v2-beta-default-v1.2
version: v1.2
lang: zh
apiVersion: v2-beta
---

## lbConfig



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
certificateIds | array[[certificate]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/certificate/)] | Optional | - | - | 
config | string | Optional | - | - | 
defaultCertificateId | [certificate]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/certificate/) | Optional | - | - | 
portRules | array[[portRule]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/portRule/)] | Optional | - | - | 
stickinessPolicy | [loadBalancerCookieStickinessPolicy]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/loadBalancerCookieStickinessPolicy/) | Optional | - | - | 



<br>
