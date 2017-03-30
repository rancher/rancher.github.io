---
title: Using Rancher with SELinux Enabled
layout: rancher-default-v1.6
version: v1.6
lang: en
---

## Using Rancher with SELinux enabled - RHEL/CentOS
---

_Available for Rancher 1.6+_

If you are running Rancher on RHEL/CentOS and want to enable SELinux, you will be required to install an additional SELinux module.

The steps in this document are a necessary workaround until the [changes present in the module](https://github.com/projectatomic/container-selinux/pull/33) are shipped in RHEL and CentOS. Once these changes are made in RHEL and CentOS then these steps will no longer be required.

These steps must occur on the instances that are running the Rancher server container as well as any [hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/).

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

After the SELinux module is built, load the module.

```
# Load the module
$ semodule -i virtpatch.pp
# Verify the module is loaded
$ semodule -l
```
