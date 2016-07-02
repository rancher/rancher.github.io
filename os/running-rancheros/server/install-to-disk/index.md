---
title: Installing to Disk
layout: os-default
---

## Installing RancherOS to Disk
---
RancherOS comes with a simple installer that will install RancherOS on a given target disk. To install RancherOS on a new disk, you can use the `ros install` [command]({{site.baseurl}}/os/rancheros-tools/ros/install). Before installing, you'll need to have already [booted RancherOS from ISO]({{site.baseurl}}/os/running-rancheros/workstation/boot-from-iso). Please be sure to pick the `rancheros.iso` from our release [page](https://github.com/rancher/os/releases).

### Using `ros install` to Install RancherOS 

The `ros install` command orchestrates the installation from the `rancher/os` container. You will need to have already created a cloud config file and found the target disk.

#### Cloud Config

The easiest way to log in is to pass a `cloud-config.yml` file containing your public SSH keys. To learn more about what's supported in our cloud-config, please read our [documentation]({{site.baseurl}}/os/cloud-config/). 

The `ros install` command will process your `cloud-config.yml` file specified with the `-c` flag. This file will also be placed onto the disk and installed to `/var/lib/rancher/conf/`. It will be evaluated on every boot.

Create a cloud config file with a SSH key, this allows you to SSH into the box as the rancher user. The yml file would look like this:

```yaml
#cloud-config
ssh_authorized_keys:
  - ssh-rsa AAA...
```

> **Note:** Currently, RancherOS doesn't support adding other users to RancherOS. If this is in your cloud config file, RancherOS will not boot up. 

You can generate a new SSH key for `cloud-config.yml` file by following this [article](https://help.github.com/articles/generating-ssh-keys/). 

Copy the public SSH key into RancherOS before installing to disk. 

Now that our `cloud-config.yml` contains our public SSH key, we can move on to installing RancherOS to disk!

```bash
$ sudo ros install -c cloud-config.yml -d /dev/sda
INFO[0000] No install type specified...defaulting to generic 
Installing from rancher/os:v0.5.0
Continue [y/N]:
```

You will be prompted to see if you want to continue. Type **y**.

```bash
Unable to find image 'rancher/os:v0.5.0' locally
v0.5.0: Pulling from rancher/os
...
...
...
Status: Downloaded newer image for rancher/os:v0.5.0
+ DEVICE=/dev/sda
...
...
...
+ umount /mnt/new_img
Continue with reboot [y/N]:
```

After installing RancherOS to disk, the rancher/rancher user/password will no longer be valid, unless you've booted off the ISO again. You'll need to have added in SSH keys within your [cloud config file]({{site.baseurl}}/os/cloud-config/).

### SSH into RancherOS

After installing RancherOS, you can ssh into RancherOS using your private key and the **rancher** user.

```bash
$ ssh -i /path/to/private/key rancher@<ip-address>
```

