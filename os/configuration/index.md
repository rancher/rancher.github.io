---
title: Configuring RancherOS
layout: os-default

---

## Configuring RancherOS
---
The configuration of RancherOS is derived from 2 sources.

1. RancherOS ships with a default configuration. Default configuration is hard coded into RancherOS binary. The default configuration cannot be changed, but it can be extended or overwritten by [cloud-config file]({{site.baseurl}}/os/cloud-config).

2. A [cloud config file]({{site.baseurl}}/os/cloud-config) extends and overwrites RancherOS default config. Cloud config itself is derived from several sources by the `cloud-init` program running as a system container inside RancherOS. 

You can view the entire RancherOS configuration in its entirety by typing `sudo ros config export --full`.

The following is a list of topics on RancherOS configuration:

[Networking]({{site.baseurl}}/os/configuration/networking/)<br>
[Users]({{site.baseurl}}/os/configuration/users/)<br>
[SSH Keys]({{site.baseurl}}/os/configuration/ssh-keys/)<br>
[Custom Console OS]({{site.baseurl}}/os/configuration/custom-console/)<br>
[Adding System Services]({{site.baseurl}}/os/configuration/system-services/)<br>
[Setting up Docker TLS]({{site.baseurl}}/os/configuration/setting-up-docker-tls/)<br>
[Loading Kernel Modules]({{site.baseurl}}/os/configuration/loading-kernel-modules/)<br>
[Installing Kernel Modules that require Kernel Headers]({{site.baseurl}}/os/configuration/kernel-modules-kernel-headers/)<br>
[DKMS]({{site.baseurl}}/os/configuration/dkms/)<br>
[Custom Kernels]({{site.baseurl}}/os/configuration/custom-kernels/)<br>
[Building custom RancherOS ISO]({{site.baseurl}}/os/configuration/custom-rancheros-iso/)<br>
[Pre-packing Docker Images]({{site.baseurl}}/os/configuration/prepacking-docker-images/)<br>
