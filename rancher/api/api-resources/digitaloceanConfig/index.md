---
title: API
layout: rancher-default
---

## digitaloceanConfig


The configuration to launch a droplet in DigitalOcean using [machine]({{site.baseurl}}/rancher/api/api-resources/machine). Rancher is calling `docker-machine`, so any available options in `docker-machine` for specific drivers are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation.

​​
### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
accessToken | string | true | <no value> | <strong>required</strong>Your personal access token for the Digital Ocean API
backups | boolean | false | <no value> | Whether or not to enable Digital Oceans backups for the droplet
image | string | false | <no value> | The name of the Digital Ocean image to use
ipv6 | boolean | false | <no value> | Whether or not to enable IPv6 support for the droplet
privateNetworking | boolean | false | <no value> | Whether or not to enable private networking support for the droplet
region | string | false | <no value> | The region to use when launching the host
size | string | false | <no value> | The size of the Digital Ocean droplet (larger than the default option (`512mb`) are of the form `2gb`)
sshUser | string | false | <no value> | The ssh username to use to ssh into the host

