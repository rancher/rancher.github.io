---
title: Configuring RancherOS
layout: os-default

---

## Configuring RancherOS
---
The configuration of RancherOS is derived from two sources.

1. RancherOS ships with a default configuration. The default configuration cannot be changed, but it can be extended or overridden by [cloud-config file]({{site.baseurl}}/os/cloud-config).

2. [Cloud-config]({{site.baseurl}}/os/cloud-config) extends and overrides RancherOS default config. Cloud-config is obtained on boot from several sources by the cloud-init program running as a system container inside RancherOS.  Additionally the cloud-config is read from disk if you wish to make local changes.

As a convenience we provide the `ros config` command which makes it easy to modify the Cloud-config on disk.

You can view the entire RancherOS configuration in its entirety by typing `sudo ros config export --full`.
