---
title: Running RancherOS on Raspberry Pi
layout: os-default
---

## Raspberry Pi
---

As of v0.5.0, RancherOS releases include a Raspberry Pi image that can be found on our [releases page](https://github.com/rancher/os/releases). The official Raspberry Pi documentation contains instructions on how to [install operating system images](https://www.raspberrypi.org/documentation/installation/installing-images/).

When installing, there is no ability to pass in a [cloud-config]({{site.baseurl}}/os/cloud-config). You will need to boot up, change the configuration and then reboot to apply those changes. 

Currently, only Raspberry Pi 2 and 3 are tested and known to work.


### Customization

#### Using the entire SD Card

Unfortunately, there is currently (RancherOS v0.5.0) no way of expanding the partition to use the full SD card capacity, but good news ranchers, there IS a work-around to store your userland docker containers on a larger partition.

1. `sudo fdisk /dev/mmcblk0`
1. Create a `n`ew partition
1. Press `[Enter]` four (4x) times to accept the defaults
1. Then `w`rite the table and exit
1. `sudo shutdown -r now` to reboot and reload the new partition table
1. `sudo mkdir /mnt/docker` to create the new directory
1. `sudo vi /var/lib/rancher/conf/cloud-config.d/user.yml` to edit your user configuration, use the file below.
1. `sudo mkfs.ext4 /dev/mmcblk0p3` to format the disk.
1. `sudo shutdown -r now` to reboot one final time.

##### Caveats

If this is not a new installation, you'll have to copy over your existing docker configuration (`/var/lib/docker`) to
the new mount (`/mnt/docker`).

1. `sudo cp -R /var/lib/docker/* /mnt/docker` to recursively copy all files.
1. `sudo shutdown -r now` to perform a fresh restart.
1. `sudo rm /var/lib/docker/*` to OPTIONALLY delete the userland docker images and free some space.

Additionally, within `user.yml`, you cannot have two `rancher:` directives, so just put the new `docker:` directive under
the existing `rancher:` directive if there is one.

##### user.yml Additions
```yml
#cloud-config
mounts:
  - ["/dev/mmcblk0p3", "/mnt/docker", "ext4", ""]

rancher:
  docker:
    args: [daemon, --log-opt, max-size=25m, --log-opt, max-file=2, -s, overlay, -G, docker, -H, 'unix:///var/run/docker.sock', --userland-proxy=false, -g, /mnt/docker]
```
