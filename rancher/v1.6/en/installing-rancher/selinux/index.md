---
title: Using Rancher with SELinux Enabled
layout: rancher-default-v1.6
version: v1.6
lang: en
---

## Using Rancher with SELinux enabled - RHEL/CentOS
---

_Available for Rancher 1.6+_

For Rancher on RHEL/CentOS and SELinux to work, you will need to have the RPM package `container-selinux-2.14` or higher installed on instances running the Rancher server container as well as any [hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/). If there is a lower version installed, you will need to build an additional SELinux module to make Rancher work.

You can validate the version by running this command: `rpm -q container-selinux`.

```
# Check container-selinux version
$ rpm -q container-selinux
container-selinux-2.19-2.1.el7.noarch
```

## Building the additional SELinux module

### Installing Package to Build the Module

In order to build the additional SELinux module, you will need to install the `selinux-policy-devel` package.

```bash
$ yum install selinux-policy-devel
```

### Building the Module

Create a file named `virtpatch.te` with the following contents.

```
policy_module(virtpatch, 1.0)

gen_require(`
  type svirt_lxc_net_t;
')

allow svirt_lxc_net_t self:netlink_xfrm_socket create_netlink_socket_perms;
```

Build the module.

```
$ make -f /usr/share/selinux/devel/Makefile
```

After running the `make` command, a file named `virtpatch.pp` should be created if the build was successful. `virtpatch.pp` is the compiled SELinux module.

### Loading the Module

After the SELinux module is built, load the module on instances running the Rancher server container as well as any [hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/).

```
# Load the module
$ semodule -i virtpatch.pp
# Verify the module is loaded
$ semodule -l
```
