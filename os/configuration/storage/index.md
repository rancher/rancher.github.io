---
title: Docker
layout: os-default

---

## Configuring Storage

By default, User Docker runs in the console container, which means that it will for the most part act and behave like Docker on any other standard Linux distribution. Customizing the storage that is available to Docker is largely a matter of installing components into the console. There is a second option in which you can create a dedicated container to provide storage.

### Modifying Console

#### Example: Mounting NFS

Example of mounting `192.168.1.180:/home` to `/mnt`

```yaml
#cloud-config
rancher:
  services_include:
    ubuntu-console: true

write_files:
  # /opt/rancher/bin/start.sh is executed on start before User Docker starts
  # /etc/rc.local is also executed on start but not guarenteed to be ran before User Docker
  - path: /opt/rancher/bin/start.sh
    permissions: "0755"
    owner: root
    content: |
      #!/bin/bash
      if ! dpkg -l | grep -q nfs-common; then
        apt-get update -qq && apt-get install -y nfs-common
      fi
      rpcbind
      mount -t nfs 192.168.1.180:/home /mnt
```

### Custom Storage Container

A custom storage container can be created and Docker will run inside of that container and not the console.  This allows one to provide custom storage but maintain a lightweight and ephemeral console.

#### Example:

```yaml
#cloud-config

rancher:
  docker:
    # This must be the name of the service that provides the storage.  Docker will run this container.
    storage_context: nfs
    
  services:
    nfs:
      # Your custom image
      image: example/custom-nfs-image

      # Everything below is required to be set so that Docker can run properly
      labels:
        io.rancher.os.after: console
        io.rancher.os.scope: system
      net: host
      pid: host
      uts: host
      ipc: host
      privileged: true
      restart: always
      volumes_from:
      - all-volumes
      volumes:
      - /usr/bin/iptables:/sbin/iptables:ro
```

## Using ZFS

In order to start using ZFS, you'll need to first enable one of the [persistent consoles]({{site.baseurl}}/os/configuration/custom-console/#console-persistence) and enable [kernel headers]({{site.baseurl}}/os/configuration/kernel-modules-kernel-headers/).

```bash
# You can enable either ubuntu-console or debian-console
$ sudo ros service enable ubuntu-console
$ sudo ros service enable kernel-headers

$ sudo ros service pull
# Reboot in order for the changes to take effect
$ sudo reboot
```

When RancherOS has booted up again, you will have logged into the persistent console and the current kernel headers will have been downloaded and unpacked.

### Installing ZFS on Ubuntu Console

Based on the [ZFS docs regarding Ubuntu](https://launchpad.net/~zfs-native/+archive/stable), you'll need to add the `ppa:zfs-native/stable` PPA to the Ubuntu console. 

There will be a couple of packages that need to be installed in order to add the PPA. 

```bash
# Installing DKMS-based kernel modules
$ apt-get install software-properties-common build-essential dkms
# Adding ZFS PPA and updating the package cache
$ add-apt-repository ppa:zfs-native/stable
$ apt-get update
```

At this point, if we tried to install `ubuntu-zfs`, the `apt-get` will show that `mountall` isn't updated. We'll need to install `mountall` and then install ZFS.

```bash
$ apt-get install mountall
$ apt-get install --no-install-recommends ubuntu-zfs
```

### Installing ZFS on Debian Console

Instead of enabling the Ubuntu console, you'll need to have enabled the Debian console and install prerequisites for building DKMS modules. 

```bash
$ apt-get update
$ apt-get install --no-install-recommends build-essential dkms
```

Based on the [ZFS docs regarding Debian](http://zfsonlinux.org/debian.html), the following commands need to occur to install `debian-zfs`. 

```bash
# Pre-requisites to install debian-zfs
$ apt-get install lsb-release
# curl -OL http://archive.zfsonlinux.org/debian/pool/main/z/zfsonlinux/zfsonlinux_6_all.deb
# dpkg -i zfsonlinux_6_all.deb
# Updating the package cache 
$ apt-get update
$ apt-get install debian-zfs
```

### Adding ZFS to load on every boot

In order for ZFS to load on boot, it needs to be added to `modules` list in the config. Prior to adding it to the list of modules, you'll need to check to see if there are other modules that are currently enabled. 

```bash
$ ros config get rancher.modules
# Make sure to include any modules that were already enabled
$ ros config set rancher.modules [zfs]
```

### Using ZFS

After it's installed, it should be ready to use!

```bash
$ modprobe zfs
$ zpool list
$ zpool create zpool1 /dev/<some-disk-dev>
```

To experiment with ZFS, you can create zpool backed by just ordinary files, not necessarily real block devices. In fact, you can mix storage devices in your ZFS pools; it's perfectly fine to create a zpool backed by real devices **and** ordinary files.

## ZFS storage for Docker on RancherOS

Before editing the Docker daemon, you'll need to create a ZFS filesystem for Docker. 

```bash
$ zfs create zpool1/zdocker
$ zfs list
```

We'll need to edit the user Docker daemon by adding `zfs` to the list of args. 

```bash
$ sudo ros config set rancher.docker.args "[daemon, --log-opt, max-size=25m, --log-opt, max-file=2, -s, zfs, --storage-opt, zfs.fsname=zpool1/zdocker, -G, docker, -H, unix:///var/run/docker.sock, --userland-proxy=false]"
# After editing the user Docker daemon, you'll need to restart user Docker
$ sudo system-docker stop docker
$ sudo system-docker start docker
```

After customizing the Docker daemon paramaeters and restarting the user Docker service, ZFS should work for Docker. 

```bash
$ docker info
Containers: 0
Images: 0
Storage Driver: zfs
  Zpool: zpool1
  Zpool Health: ONLINE
  Parent Dataset: zpool1/zdocker
  Space Used By Parent: 19456
  Space Available: 1023326720
  Parent Quota: no
  Compression: off
Execution Driver: native-0.2
Logging Driver: json-file
Kernel Version: 4.2.2-rancher
Operating System: RancherOS (containerized)
CPUs: 2
Total Memory: 996.4 MiB
Name: rancher-dev
ID: PVRY:SQJ5:GQPH:BMHA:74RQ:WOIW:NMGM:EFGE:JZVS:MUH7:TFT2:RZ4W
```