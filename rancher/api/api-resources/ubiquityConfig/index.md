---
title: API
layout: rancher-default
---

## ubiquityConfig


The configuration to launch a server in Ubiquity Hosting.

​​
### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
apiToken | string | false | <no value> | <strong>required</strong> Your Ubiquity Hosting Access Key
apiUsername | string | false | <no value> | <strong>required</strong> Your Ubiquity Hosting Remote ID
clientId | string | false | <no value> | <strong>required</strong> Your Ubiquity Hosting API Client ID
flavorId | string | false | <no value> | The ID of the flavor that will be used for the machine
imageId | string | false | <no value> | The ID of the image that will be used for the machine
zoneId | string | false | <no value> | The ID of the zone that will be used for the machine

