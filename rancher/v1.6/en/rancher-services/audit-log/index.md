---
title: Audit Logging in Rancher
layout: rancher-default-v1.5
version: v1.5
lang: en
---

## Audit Logging
---

Only [admins]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/#admin) will have access to the audit logs. The audit log can be found under **Admin** -> **Audit Log**.

Rancher's audit logs are a compilation of different event types.

* Anything prefixed with `api` is a call to our API. The event type will log the API action, who performed the action and how the API was called (i.e. through the UI, through an API key).
* Any other events that are **not** prefixed with `api` are events that Rancher server is doing. For example, during reconciling of containers of a service, an instance may be created which would log an `instance.create` event.
