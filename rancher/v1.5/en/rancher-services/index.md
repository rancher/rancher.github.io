---
title: Infrastructure Services in Rancher
layout: rancher-default-v1.5
version: v1.5
lang: en
---

## Infrastructure Services
---

When starting Rancher, each [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/) is based on an [environment template]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#what-is-an-environment-template) and in the environment template, you select which infrastructure service you'd like to start when creating an environment. These infrastructure services include type of orchestration, [external DNS]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/external-dns-service/), [networking]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/networking/), [storage]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/storage-service/), and framework services (i.e. [internal dns]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/dns-service/),   [metadata]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/metadata-service), and [health check]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/health-checks)).

These infrastructure services are based on the templates in the `infra-templates` folder of our [Rancher catalog](https://github.com/rancher/rancher-catalog) and [community catalog](https://github.com/rancher/community-catalog). By default, both the Rancher catalog and community catalog are enabled, which provide a basic list of infrastructure services that can be used in an environment template.

When creating new environment templates, the default set of infrastructure services that are required to have a working environment are automatically enabled.
