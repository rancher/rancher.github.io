---
title: API Common Resource Fields
layout: rancher-default
---

## Common Resource Fields

In the API, the resource fields that are the most common and read only on a resource have been hidden from the resource view. We've removed it from the list of resource fields to make it easier for a user to view the list of resource fields.


Field | Type |  Notes
---|---|---|---|---|---
accountId | [account]({{site.baseurl}}/rancher/api/account/) | The unique identifier for the associated account
created | date | The date of when the container was created.
id | int | The unique identifier for the container
kind | string | The kind for the container
removeTime | date |  The date and time of when the container was removed
removed | date |  The date of when the container was removed
transitioning | enum |  Whether or not the container is in a transitioning state
transitioningMessage | string |  The message to show while in a transitioning state
transitioningProgress | int |  The percentage remaining in the transitioning process of the container
uuid | string |  The universally unique identifier for the container. This will always be unique across Rancher installations.

