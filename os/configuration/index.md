---
title: Configuring RancherOS
layout: os-default

---

## Configuring RancherOS
---
The configuration of RancherOS is derived from three sources.

1. RancherOS ships with a default configuration. The default configuration cannot (and should not) be changed, but it can be extended or overridden by [cloud-config file]({{site.baseurl}}/os/cloud-config).

2. [Cloud-config]({{site.baseurl}}/os/cloud-config) extends and overrides RancherOS default config. Cloud-config is obtained on boot from several sources by the cloud-init program running as a system container inside RancherOS. 

3. Finally, you can add or override a config value using `ros config` command. 

You can view the entire RancherOS configuration in its entirety by typing `sudo ros config export --full`.
