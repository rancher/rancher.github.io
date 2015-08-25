---
title: Configuring RancherOS
layout: os-default

---

## Configuring RancherOS
---
The configuration of RancherOS is derived from three sources.

1. RancherOS ships with a default configuration. Default configuration is hard coded into RancherOS binary. The default configuration cannot be changed, but it can be extended or overwritten by [cloud-config file]({{site.baseurl}}/os/cloud-config).

2. A [cloud config file]({{site.baseurl}}/os/cloud-config) extends and overwrites RancherOS default config. Cloud config itself is derived from several sources by the `cloud-init` program running as a system container inside RancherOS. 

3. Finally, `cloud-config-local.yml` file extends and overwrites the result of cloud config. Anything configured using `ros config` is saved in the `cloud-config-local.yml` file. 

You can view the entire RancherOS configuration in its entirety by typing `sudo ros config export --full`.
