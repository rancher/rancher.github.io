---
title: Using Rancher with SELinux Enabled
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## 在SELinux模式下使用Rancher - RHEL/CentOS
---

_从1.6+版本后支持_

为了使Rancher在RHEL/CentOS的SELinux模式下正常工作，你需要在安装有RPM包`container-selinux-2.14`（或更高的版本）的主机上运行Rancher Server容器。同时，全部的agent[主机]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/)也要安装这个包。如果你安装了较低版本的`container-selinux`包，你需要构建额外的SELinux模块，从而使Rancher正常工作。

你可以通过这个命令来查看这个包的版本：`rpm -q container-selinux`。

```
# Check container-selinux version
$ rpm -q container-selinux
container-selinux-2.19-2.1.el7.noarch
```

## 构建额外的SELinux模块

### 安装包并构建SELinux模块

为了安装另外的SELinux模块，你需要安装 `selinux-policy-devel` 这个包。

```bash
$ yum install selinux-policy-devel
```

### 构建模块

创建一个名叫 `virtpatch.te` 的文件并写入以下内容

```
policy_module(virtpatch, 1.0)

gen_require(`
  type svirt_lxc_net_t;
')

allow svirt_lxc_net_t self:netlink_xfrm_socket create_netlink_socket_perms;
```

构建模块

```
$ make -f /usr/share/selinux/devel/Makefile
```

运行 `make` 命令后，当构建成功后，一个名叫 `virtpatch.pp` 的文件将会被创建。`virtpatch.pp` 是编译后的SELinux模块

### 加载模块

在SELinux模块被构建后，使用以下命令加载。

```
# Load the module
$ semodule -i virtpatch.pp
# Verify the module is loaded
$ semodule -l
```
