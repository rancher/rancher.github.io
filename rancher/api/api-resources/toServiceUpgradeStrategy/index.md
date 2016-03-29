---
title: API
layout: rancher-default
---

## toServiceUpgradeStrategy




​​
### Resource Fields

Field | Type | Required | Default | Description
---|---|---|---|---
batchSize | int | false | 1 | The batch size to upgrade a service (i.e. how many containers to launch at a time)
finalScale | int | false | 1 | The final scale of the upgraded service
intervalMillis | int | false | 2000 | The number of milliseconds between upgrading
toServiceId | [service]({{site.baseurl}}/rancher/api/api-resources/service/) | false | <no value> | The service ID to upgrade
updateLinks | boolean | false | <no value> | The list of linked services to update to

