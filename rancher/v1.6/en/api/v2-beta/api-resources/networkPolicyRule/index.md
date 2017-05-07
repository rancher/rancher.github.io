---
title: API
layout: rancher-api-v2-beta-default-v1.6
version: v1.6
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.6/zh/api/v2-beta/api-resources/networkPolicyRule/
---

## networkPolicyRule



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
action | enum | Optional | - | - | The options are `allow`, `deny`.
between | [networkPolicyRuleBetween]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/networkPolicyRuleBetween/) | Optional | - | - | 
from | [networkPolicyRuleMember]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/networkPolicyRuleMember/) | Optional | - | - | 
ports | array[string] | Optional | - | - | 
to | [networkPolicyRuleMember]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/networkPolicyRuleMember/) | Optional | - | - | 
within | enum | Optional | - | - | The options are `stack`, `service`, `linked`.



<br>
