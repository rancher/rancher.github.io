---
title: API
layout: rancher-api-default
version: v1.2
lang: en
---

## digitaloceanConfig


The configuration to launch a droplet in DigitalOcean using [machine]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/machine). Rancher is calling `docker-machine`, so any available options in `docker-machine` for specific drivers are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation.


### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
accessToken | string | false |  | 
backups | boolean | false |  | 
image | string | false | ubuntu-15-10-x64 | 
ipv6 | boolean | false |  | 
privateNetworking | boolean | false |  | 
region | string | false | nyc3 | The region to use when launching the host
size | string | false | 512mb | 
sshPort | string | false | 22 | The port to ssh into the host
sshUser | string | false | root | The ssh username to use to ssh into the host
userdata | string | false |  | 

