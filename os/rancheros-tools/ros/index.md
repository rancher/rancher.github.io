---
title: ROS 
layout: os-default
---

## What is ROS?
---

A useful command that can be used with RancherOS is `ros` which can be used to control and configure the system. `ros` requires you to be the root user, so with the rancher user, you will need to use `sudo`.

### Sub Commands

| Command       | Description                                                                                   |
|---------------|-----------------------------------------------------------------------------------------------|
|`config`, `c`  | [Configure Settings]({{site.baseurl}}/os/rancheros-tools/ros/config/)                         |
| `console` |	[console container commands]({{site.baseurl}}/os/rancheros-tools/ros/console/)
|`service`, `s` | [Command Line interface for services and compose.]({{site.baseurl}}/os/rancheros-tools/ros/service/)                          |
|`os`           | [Operating System Upgrade/Downgrade]({{site.baseurl}}/os/rancheros-tools/ros/os/)             |
|`tls`          | [Setup TLS configuration]({{site.baseurl}}/os/rancheros-tools/ros/tls/)                       |
|`install`      | [Install RancherOS to Disk]({{site.baseurl}}/os/rancheros-tools/ros/install/)                 |
| `selinux` |	Launch SELinux tools container. |
|`help`, `h`    | Shows a list of commands or help for one command                                              |


### RancherOS Version

If you want to check what version you are on, just use the `-v` option.

```sh
$ sudo ros -v
ros version v0.5.0
```

### Help

To list available commands, run any `ros` command with `-h` or `--help`. This would work with any subcommand within `ros`.

```sh
$ sudo ros -h
NAME:
    ros - Control and configure RancherOS

USAGE:
    ros [global options] command [command options] [arguments...]

VERSION:
    v0.5.0

AUTHOR(S): 
    Rancher Labs, Inc.  

Options:
--help, -h			show help
--generate-bash-completion	
--version, -v			print the version

Commands:
    config, c	configure settings
    console     console container commands
    dev, d      dev spec
    env, e      env command
    service, s	Command line interface for services and compose.
    os          operating system upgrade/downgrade
    tls         setup tls configuration
    install     install RancherOS to disk
    selinux     Launch SELinux tools container.
    help		Shows a list of commands or help for one command

Run 'ros COMMAND --help' for more information on a command.
```
