---
title: API
layout: rancher-default
---

## processDefinition

Collection Test Description
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
extensionBased | boolean | - | - | - | The extensionBased for the processDefinition
postProcessListeners | [extensionPoint]({{site.baseurl}}/rancher/api/extensionPoint/) | - | - | - | The postProcessListeners for the processDefinition
preProcessListeners | [extensionPoint]({{site.baseurl}}/rancher/api/extensionPoint/) | - | - | - | The preProcessListeners for the processDefinition
processHandlers | [extensionPoint]({{site.baseurl}}/rancher/api/extensionPoint/) | - | - | - | The processHandlers for the processDefinition
resourceType | string | - | - | - | The resourceType for the processDefinition
stateTransitions | array[stateTransition] | - | - | - | The stateTransitions for the processDefinition




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
id | string | - | - | - | The unique identifier for the processDefinition
name | string | Optional | Yes | - | The name for the processDefinition












​