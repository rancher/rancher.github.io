---
title: API
layout: rancher-default
---

## <no value>

Description of API Input from yaml file. 
​​
### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
dockerPort | string | false | <no value> | The port to use for the Docker daemon
dockerSwarmMasterPort | string | false | <no value> | 
image | string | false | <no value> | The Azure image name
location | string | false | <no value> | The Azure machine instance location
password | string | false | <no value> | Your Azure password
publishSettingsFile | string | false | <no value> | The Azure setting file
size | string | false | <no value> | The Azure disk size
sshPort | string | false | <no value> | The port to ssh into the host
subscriptionCert | string | false | <no value> | <strong>required</strong> The Azure subscription certificate
subscriptionId | string | false | <no value> | <strong>required</strong>The Azure subscription ID (ie. A GUID like`d255d8d7-5af0-4f5c-8a3e-1545044b861e`)
username | string | false | <no value> | Your Azure login user name

