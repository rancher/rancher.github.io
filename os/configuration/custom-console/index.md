---
title: Custom Console OS
layout: os-default

---

## Custom Console OS
---

When [booting from the ISO]({{site.baseurl}}/os/running-rancheros/workstation/boot-from-iso/), RancherOS starts with the default console, which is based on busybox. If you are running RancherOS through a cloud provider, RancherOS is enabled to start with the ubuntu console. The console is considered a [system service]({{site.baseurl}}/os/configuration/system-services).

Currently, RancherOS supports three different consoles, busybox, ubuntu and debian console. You can select which console you want RancherOS to start with using [cloud-config]({{site.baseurl}}/os/cloud-config/). If multiple consoles are enabled, the first console that starts will be the console that is used in RancherOS, so it's important to disable any consoles that you don't want to use. 

> **Note:** With v0.4.0, ubuntu and debian are [persistent consoles]({{site.baseurl}}/os/custom-console/#console-persistence). If you have already started RancherOS in a persistent console, you will not be able to switch directly to the other persistent console.  You must first switch back to the default busybox console, and then switch to the new persistent console.


### Enabling Consoles using Cloud Config 

When launching RancherOS with [cloud-config]({[site.baseurl}}/os/cloud-config/), you can select which console you want Rancher to start using the `services_include` key. 

The supported consoles are listed in the [os-services repository](https://github.com/rancher/os-services/blob/master/index.yml) and can be set to `true` or `false` in the file.

Debian Console Example

```yaml
rancher:
  services_include:
    # Disable the Ubuntu Console
    ubuntu-console: false
    # Enable the Debian Console
    debian-console: true
```

In order to enable the busybox console, you would need to set both ubuntu-console and debian-console to false (or just delete these lines from cloud-config). 

### Changing Consoles after RancherOS has launched

You can view which console is being used by RancherOS by checking which console container is running in system-docker. 

To enable the busybox console, all consoles in the system-services list will need to be disabled. You can check which consoles are enabled from the `ros service list` command and disable any consoles that are enabled. **If you enable or disable services, you need to reboot in order for the changes to get applied.**

```bash
$ sudo ros service list
disabled debian-console 
disabled ubuntu-console
$ sudo ros service enable debian-console
$ sudo reboot
```

### Console persistence

As of v0.4.0, debian and ubuntu consoles are persistent, while the default (busybox) console is ephemeral. Persistent console means that the console container will remain the same and preserves changes made to its filesystem across reboots. 

### Switching between custom consoles

Currently, if you want to switch between debian/ubuntu consoles, you will need to change RancherOS to be running the default console before making switches to the other persistent console.

```bash
# Currently running ubuntu console
$ sudo ros service list
disabled debian-console 
enabled ubuntu-console
# Disable ubuntu console
$ sudo ros service disable ubuntu-console
# Both consoles are disabled and RancherOS will start the default busybox console
$ sudo ros service list
disabled debian-console 
disabled ubuntu-console
# Reboot
$ sudo reboot
# Log back in the default busybox console, enable the debian console
$ sudo ros service enable debian-console
# Reboot and log back in to be running the debian console
$ sudo reboot
```
