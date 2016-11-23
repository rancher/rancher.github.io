---
title: Labels in Rancher
layout: rancher-default-v1.0
version: v1.0
lang: en
---

## Service Accounts in Rancher
---

If you create a service that needs to interact with the Rancher API, service account API keys will need to be created for the containers so that the service will be able to access the API for authenticated set ups. In order to create these keys in the service, the following labels will need to be added to the service.

Key | Value |Description
----|-----|---
`io.rancher.container.create_agent` | `true` | Used to indicate that the service account API keys will be passed as environment variables on each container.
`io.rancher.container.agent.role` | `environment` | Used to indicate what kind of role the account will be. The value to use for creating service accounts will be `environment`.


When the containers of the service are started, the following environment variables will be set on your container.


Key| Value
---|---
`CATTLE_URL` | The URL that is in the [host registration]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/settings/#host-registration).
`CATTLE_ACCESS_KEY` | An access key for the [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/environments/) that the service is being launched in
`CATTLE_SECRET_KEY` | A secret key for the access key.
