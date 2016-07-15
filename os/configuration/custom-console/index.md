---
title: Custom Console on RancherOS
layout: os-default

---

## Custom Console
---

When [booting from the ISO]({{site.baseurl}}/os/running-rancheros/workstation/boot-from-iso/), RancherOS starts with the default console, which is based on busybox.

You can select which console you want RancherOS to start with using the [cloud-config]({{site.baseurl}}/os/cloud-config/).

### Enabling Consoles using Cloud-Config 

When launching RancherOS with a [cloud-config]({[site.baseurl}}/os/cloud-config/) file, you can select which console you want Rancher to use. 

Currently, the list of available consoles are:

* default 
* centos
* debian
* fedora
* ubuntu

Here is an example cloud-config file that can be used to enable the debian console.

```yaml
#cloud-config
rancher:
  console: debian
```

### Changing Consoles after RancherOS has started

You can view which console is being used by RancherOS by checking which console container is running in System Docker. 

You can easily switch between the different consoles.

```bash
$ sudo ros console switch <console>
```

<br>

> **Note:** When switching between consoles, the currently running console container is destroyed, Docker is restarted and you will be logged out.

### Console persistence

All consoles except the default (busybox) console are persistent. Persistent console means that the console container will remain the same and preserves changes made to its filesystem across reboots. If a container is deleted/rebuilt, state in the console will be lost except what is in the persisted directories.

```bash
/home
/opt
/var/lib/docker
/var/lib/rancher
```
