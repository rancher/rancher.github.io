---
title: API
layout: rancher-api-default-v1.2
version: v1.2
lang: en
---

## digitaloceanConfig

The configuration to launch a droplet in DigitalOcean using [machine]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/machine). Rancher is calling `docker-machine`, so any available options in `docker-machine` for specific drivers are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation.

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
accessToken | string | Optional | - | - | 
backups | boolean | Optional | - | - | 
image | string | Optional | - | ubuntu-15-10-x64 | 
ipv6 | boolean | Optional | - | - | 
privateNetworking | boolean | Optional | - | - | 
region | string | Optional | - | nyc3 | The region to use when launching the host
size | string | Optional | - | 512mb | 
sshPort | string | Optional | - | 22 | The port to ssh into the host
sshUser | string | Optional | - | root | The ssh username to use to ssh into the host
userdata | string | Optional | - | - | 



<br>
