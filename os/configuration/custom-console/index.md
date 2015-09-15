---
title: Custom Console OS
layout: os-default

---

## Custom Console OS
---

By default, RancherOS starts with the default (busybox based) console. This is a [system service]({{site.baseurl}}/os/configuration/system-services) that has been enabled in RancherOS default configuration.

RancherOS also comes with a ubuntu and debian console. You can select which console you want enabled using [cloud-config]({{site.baseurl}}/os/cloud-config/) or you can change it after RancherOS has started using `ros config` CLI. 

When multiple consoles are enabled, the first console that starts will be the console that is used in RancherOS, so it's important to disable any consoles that you don't want to use. 

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

To enable debian or ubuntu console, you'll need to enable it in the services list. You'll want to make sure all other consoles are either disabled or not listed. 

Debian and ubuntu consoles are persistent, while the default (busybox) console is ephemeral. Persistent console means that the console container stays the same and preserves changes made to its filesystem across reboots. 

**Note:** Currently, if you want to change from debian to ubuntu console (or vice versa), you need to change to the default console first (and reboot), and make the change to ubuntu console from there.

```bash
$ sudo ros service list
disabled debian-console 
enabled ubuntu-console
$ sudo ros service disable debian-console
$ sudo reboot
$ sudo ros service enable ubuntu-console
$ sudo reboot
```
