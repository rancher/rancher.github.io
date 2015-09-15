---
title: ROS Install
layout: os-default
---

## ROS Install
---

The `ros install` command is used to install RancherOS to hard disk. Please follow the [guide]({{site.baseurl}}/os/running-rancheros/server/install-to-disk/) for an example of how to install to disk.

### Options

| Options | Description                                                             |
|---------|-------------------------------------------------------------------------|
| -i      | Install RancherOS from a specific image                                 |
| -c      | The Cloud-Config file needed for SSH keys                               |
| -d      | Which Device to Install to                                              |
| -f      | [ DANGEROUS! Data loss can happen ] Partition/Format without prompting  |
| -t      | Decide the install-type: 
              generic:    (Default) Creates 1 ext4 partition and installs RancherOS
              amazon-ebs: Installs RancherOS and sets up PV-GRUB                    |
| -v      | Provide which os-installer version                                      |
| -h      | Prints the help informations                                            |

#### Image

The `-i` option specifies the particular image to install from. By default, `ros install` uses the same installer image version as the ISO it is run from. E.g. for RancherOS v0.4.0 the default installer image would be `rancher/os:v0.4.0`.

#### Cloud-Config

The `-c` option provides the location of the cloud config file. Read more about [cloud config files]({{site.baseurl}}/os/cloud-config).

#### Device

The `-d` option provide the target disk location. 

You can see the list of disks available to install to by running `sudo fdisk -l`

```bash
$ sudo fdisk -l
Disk /dev/sda: 8589 MB, 8589934592 bytes
255 heads, 63 sectors/track, 1044 cylinders
Units = cylinders of 16065 *512 = 8225280 bytes

Disk /dev/sda doesn't contain a valid partition table
```

#### Install Type
The `-t` option determines what type of installation is used. The _amazon-ebs_ type is for creating your own AMI images. Since we are creating the [RancherOS AMI images]({{site.baseurl}}/os/running-rancheros/cloud/aws/), there is no need to create your own. 

By default, the install type will be generic.

#### Version

The `-v` option will indicate which version of RancherOS to install. To see the most recent versions of RancherOS, please vist the RancherOS GitHub page of [releases](https://github.com/rancher/os/releases).

By default, the version installed will be version that RancherOS is currently running.

You can use the [ros os]({{site.baseurl}}/os/rancheros-tools/ros/os/) commands to find the list of available versions.
 
```bash
$ sudo ros os list
rancher/os:v0.4.0 remote
```

