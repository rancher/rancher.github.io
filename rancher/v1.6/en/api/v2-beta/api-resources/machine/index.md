---
title: Rancher API - machine
layout: rancher-api-v2-beta-default-v1.6
version: v1.6
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.6/zh/api/v2-beta/api-resources/machine/
---

## Machine

Machines are created whenever Rancher uses `docker-machine` to create hosts in Rancher. Adding any type of host through the UI that is not the custom command option is calling `docker-machine` and a machine entry will be created as well as a [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host).

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
name | string | Optional | Yes | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
amazonec2Config | [amazonec2Config]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/amazonec2Config/)  | 
authCertificateAuthority | string  | 
authKey | string  | 
azureConfig | [azureConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/azureConfig/)  | 
data | map[json]  | 
digitaloceanConfig | [digitaloceanConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/digitaloceanConfig/)  | 
dockerVersion | string  | 
driver | string  | 
engineEnv | map[string]  | 
engineInsecureRegistry | array[string]  | 
engineInstallUrl | string  | 
engineLabel | map[string]  | 
engineOpt | map[string]  | 
engineRegistryMirror | array[string]  | 
engineStorageDriver | string  | 
externalId | string  | 
hostTemplateId | [hostTemplate]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/hostTemplate/)  | 
id | int  | The unique identifier for the machine
labels | map[string]  | A map of key value pairs to be used as labels for the machine
packetConfig | [packetConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/packetConfig/)  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.




