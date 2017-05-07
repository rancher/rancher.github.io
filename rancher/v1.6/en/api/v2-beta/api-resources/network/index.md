---
title: Rancher API - network
layout: rancher-api-v2-beta-default-v1.6
version: v1.6
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.6/zh/api/v2-beta/api-resources/network/
---

## Network

The networks available within Rancher that containers could be launched on.

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
defaultPolicyAction | enum | Optional | Yes | allow | The options are `allow`, `deny`.
description | string | Optional | Yes | - | 
dns | array[string] | Optional | - | - | 
dnsSearch | array[string] | Optional | - | - | 
hostPorts | boolean | Optional | - | - | 
metadata | map[json] | Optional | Yes | - | 
name | string | Optional | Yes | - | 
networkDriverId | [networkDriver]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/networkDriver/) | Yes | - | - | 
policy | array[[networkPolicyRule]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/networkPolicyRule/)] | Optional | Yes | - | 
subnets | array[[subnet]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/subnet/)] | Optional | - | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
data | map[json]  | 
id | int  | The unique identifier for the network


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.




