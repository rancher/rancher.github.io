---
title: API
layout: rancher-api-v2-beta-default-v1.6
version: v1.6
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.6/zh/api/v2-beta/api-resources/publish/
---

## publish



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
data | map[json] | Optional | - | - | 
id | string | Optional | - | - | The unique identifier for the publish
name | string | Yes | - | - | 
previousIds | array[string] | Optional | - | - | 
publisher | string | Optional | - | - | 
resourceId | string | Optional | - | - | 
resourceType | string | Optional | - | - | 
time | int | Optional | - | - | 
transitioning | string | Optional | - | - | Whether or not the publish is in a transitioning state
transitioningInternalMessage | string | Optional | - | - | 
transitioningMessage | string | Optional | - | - | The message to show while in a transitioning state
transitioningProgress | int | Optional | - | - | The percentage remaining in the transitioning process of the publish



<br>
