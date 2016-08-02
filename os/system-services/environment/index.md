---
title: Adding System Services in RancherOS
layout: os-default

---

## Environment
---

With [environment](https://docs.docker.com/compose/yml/#environment) in the yaml file, if the environment is not set (i.e. it doesn't have an `=`), then RancherOS looks up the value in the [cloud-config file]({{site.baseurl}}/os/cloud-config). 

We support worldwide globbing, so in our example below, the `services.yml` file will find `ETCD_DISCOVERY` in the `cloud-config.yml` file and set the environment to `https://discovery.etcd.io/d1cd18f5ee1c1e2223aed6a1734719f7` for the service. 

`services.yml` File:

```yaml
etcd:
  environment:
    - ETCD_*
```

<br>

`cloud-config.yml` File:

```yaml
rancher:
  environment:
    ETCD_DISCOVERY: https://discovery.etcd.io/d1cd18f5ee1c1e2223aed6a1734719f7
```
