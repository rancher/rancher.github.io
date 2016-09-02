---
title: Running Commands in RancherOS
layout: os-default

---

## Running Commands
---

You can automate running commands on boot using the `runcmd` cloud-config directive. Commands must be specified in a list syntax as in the following example.

```yaml
#cloud-config
runcmd:
- [ touch, /home/rancher/test ]
```

Commands specified using `runcmd` will be executed within the context of the `console` container. More details on the ordering of commands run in the `console` container can be found [here]({{site.baseurl}}/os/system-services/built-in-system-services/#console).
