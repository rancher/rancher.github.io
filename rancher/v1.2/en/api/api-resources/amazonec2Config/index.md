---
title: API
layout: rancher-api-default-v1.2
version: v1.2
lang: en
---

## amazonec2Config


The configuration to launch an EC2 instance in Amazon Web Services using [machine]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/machine). Rancher is calling `docker-machine`, so any available options in `docker-machine` for specific drivers are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation. The notes on which fields are **required** are from the `docker-machine` documentation.


