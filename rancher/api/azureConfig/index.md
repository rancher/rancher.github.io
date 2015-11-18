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
dockerSwarmMasterPort | string | false | <no value> | The dockerSwarmMasterPort for the azureConfig
image | string | false | <no value> | The image for the azureConfig
location | string | false | <no value> | The Azure machine instance location
password | string | false | <no value> | The password for the azureConfig
publishSettingsFile | string | false | <no value> | The Azure setting file
size | string | false | <no value> | The size for the azureConfig
sshPort | string | false | <no value> | The port to ssh into the host
subscriptionCert | string | false | <no value> | The Azure subscription certificate
subscriptionId | string | false | <no value> | The Azure subscription ID (ie. A GUID like`d255d8d7-5af0-4f5c-8a3e-1545044b861e`)
username | string | false | <no value> | The username for the azureConfig

