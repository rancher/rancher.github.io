---
title: Custom Console OS
layout: os-default

---

## Custom Console OS
---

By default, RancherOS starts with the ubuntu console enabled. This is a [system service]({{site.baseurl}}/os/configuration/system-services) that has been enabled by Rancher.

RancherOS also comes with a busybox and debian console. You can select which console you want enabled with the [cloud config file]({{site.baseurl}}/os/cloud-config/) or you can change it after RancherOS has started. 

When multiple consoles are enabled, the first console that starts will be the console that is used in RancherOS, so it's important to disable any consoles that you don't want to use. 

### Enabling Consoles using Cloud Config 

When launching RancherOS with a [cloud config file]({[site.baseurl}}/os/cloud-config/), you can select which console you want Rancher to start using the `services_include` key. 

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

In order to enable the busybox console, you would need to set both ubuntu-console and debian-console to false. 

### Changing Consoles after RancherOS has launched

You can view which console is being used by RancherOS by checking which console container is running in system-docker. 

To enable the busybox console, all consoles in the system-services list will need to be disabled. You can check which consoles are enabled from the `ros service list` command and disable any consoles that are enabled. **If you make any changes to the console, you will need to reboot in order to start using the new console.**

```bash
$ sudo ros service list
disabled debian-console 
disabled ubuntu-console
```

To enable the debian console, you'll need to enable the debian console in the services list. You'll want to make sure that the ubuntu-console is also disabled. 

```bash
$ sudo ros service list
disabled debian-console 
enabled ubuntu-console
$ sudo ros service disable ubuntu-console
$ sudo ros service enable debian-console
$ sudo reboot
```

To enable the ubuntu console, you'll need to enable the ubuntu console in the services list. You'll want to make sure that the debian-console is also disabled. 

```bash
$ sudo ros service list
disabled debian-console 
enabled ubuntu-console
$ sudo ros service disable ubuntu-console
$ sudo ros service enable debian-console
$ sudo reboot
```

