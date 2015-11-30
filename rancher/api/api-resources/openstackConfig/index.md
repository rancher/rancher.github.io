---
title: API
layout: rancher-default
---

## openstackConfig


The configuration to launch an instance in OpenStack. For all cloud providers, Rancher is calling `docker-machine`, so any available options in `docker-machine` are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation.

​​
### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
authUrl | string | false | <no value> | The keystone service base URL
availabilityZone | string | false | <no value> | The availability zone in which to launch the server
domainId | string | false | <no value> | The ID of the domain to use for authentication (Keystone v3 only)
domainName | string | false | <no value> | Domain to use for authentication (Keystone v3 only)
endpointType | string | false | <no value> | Endpoint type can be `internalURL`, `adminURL`, or` publicURL`. If is a helper for the driver to choose the right URL in the OpenStack service catalog. If not provided the default id `publicURL`
flavorId | string | false | <no value> | The ID of the flavor that will be used for the machine
flavorName | string | false | <no value> | The name of the flavor that will be used for the machine
floatingipPool | string | false | <no value> | The IP pool that will be used to get a public IP can assign it to the machine. If there is an IP address already allocated but not assigned to any machine, this IP will be chosen and assigned to the machine. If there is no IP address already allocated a new IP will be allocated and assigned to the machine.
imageId | string | false | <no value> | The ID of the image that will be used for the machine
imageName | string | false | <no value> | The name of the image that will be used for the machine
insecure | boolean | false | <no value> | Explicitly allow OpenStack driver to perform “insecure” SSL (https) requests. The server’s certificate will not be verified against any certificate authorities. This option should be used with caution.
netId | string | false | <no value> | The ID of the private network the machine will be connected on. If your OpenStack project project contains only one private network it will be use automatically.
netName | string | false | <no value> | The name of the private network the machine will be connected on. If your OpenStack project  contains only one private network it will be use automatically.
password | string | false | <no value> | Your user password
region | string | false | <no value> | The region to use when launching the host
secGroups | string | false | <no value> | If security groups are available on your OpenStack you can specify a comma separated list to use for the machine (e.g. `secgrp001`,`secgrp002`)
sshPort | string | false | <no value> | The port to ssh into the host
sshUser | string | false | <no value> | The ssh username to use to ssh into the host
tenantId | string | false | <no value> | The ID of the tenant in which the machine will be created
tenantName | string | false | <no value> | The name of the tenant in which the machine will be created
username | string | false | <no value> | The user identifier to authenticate with

