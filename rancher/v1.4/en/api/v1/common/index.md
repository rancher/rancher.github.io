---
title: API Common Resource Fields
layout: rancher-api-v1-default-v1.4
version: v1.4
lang: en
apiVersion: v1
redirect_from:
  - /rancher/v1.4/zh/api/v1/common/
---

## Common Resource Fields
---

In the API, the resource fields that are the most common and read only on a resource have been hidden from the resource view. We've removed it from the list of resource fields to make it easier for a user to view the list of resource fields.


Field | Type |  Notes
---|---|---|---|---|---
accountId | [account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/account/) | The unique identifier for the associated account
created[TS] | date | The date/time when the resource was initially created.
id | string | The unique identifier for the resource.
kind | string | A more specific sub-type for the resoruce.
removeTime | date |  The date/time when the resource was removed, or null if not removed.
removed | bool |  True if a resource has been removed.  Removed resources won't be returned in collection lists but can be individually retrieved by ID.
transitioning | enum |  The transitioning state of the resource:  `yes`, `no`, or `error`
transitioningMessage | string |  A message relating to the transition that is happening, or the error that occurred
transitioningProgress | int |  An estimate of far along the transition is, from 0-100.
uuid | string |  A universally unique identifier for the resource.  This will always be unique across Rancher installations.
