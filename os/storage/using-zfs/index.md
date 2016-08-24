---
title: Using ZFS in RancherOS
layout: os-default
redirect_from:
  - os/configuration/storage/
---

## Using ZFS

In order to start using ZFS, you'll need to first enable one of the [persistent consoles]({{site.baseurl}}/os/configuration/custom-console/#console-persistence) and enable [kernel headers]({{site.baseurl}}/os/configuration/kernel-modules-kernel-headers/).

```
$ sudo ros console switch ubuntu
$ sudo ros service enable kernel-headers
$ sudo ros service up -d kernel-headers
```

When RancherOS console has reloaded, you will have logged into the persistent console. The current kernel headers will need to be downloaded using the `ros service enable` and the service will be started with `ros service up -d kernel-headers`.

#### Installing ZFS on Ubuntu Console

Based on the [Ubuntu ZFS docs](https://wiki.ubuntu.com/Kernel/Reference/ZFS), you only need to install `zfs` package into the Ubuntu console to enable ZFS. Aall the other necessary packages will be installed as its dependencies.

```
# Adding ZFS PPA and updating the package cache
$ sudo apt update
$ sudo apt upgrade
$ sudo apt install zfs
```

#### Mounting ZFS filesystems on boot

In order for ZFS to load on boot, it needs to be added to `modules` list in the config. Prior to adding it to the list of modules, you'll need to check to see if there are other modules that are currently enabled.

```
# Check to see what modules currently exist
$ sudo ros config get rancher.modules
# Make sure to include any modules that were already enabled
$ sudo ros config set rancher.modules [zfs]
```

<br>

You will need to create a file called `/opt/rancher/bin/start.sh`, which will contain:

```bash
[ -f /etc/zfs/zpool.cache ] && zpool import -c /etc/zfs/zpool.cache -a
```

<br>

```bash
# Create the directory
$ sudo mkdir -p /opt/rancher/bin
# Create the file
$ sudo vi /opt/rancher/bin/start.sh
$ sudo chmod +x /opt/rancher/bin/start.sh
```

#### Using ZFS

After it's installed, it should be ready to use!

```bash
$ sudo modprobe zfs
$ sudo zpool list
$ sudo zpool create zpool1 /dev/<some-disk-dev>
```

To experiment with ZFS, you can create zpool backed by just ordinary files, not necessarily real block devices. In fact, you can mix storage devices in your ZFS pools; it's perfectly fine to create a zpool backed by real devices **and** ordinary files.

## ZFS storage for Docker on RancherOS

First, you need to stop  the`docker` system service and wipe out `/var/lib/docker` folder:

```bash
$ sudo system-docker stop docker
$ sudo rm -rf /var/lib/docker/*
```

To enable ZFS as the storage driver for Docker, you'll need to create a ZFS filesystem for Docker and make sure it's mounted.

```bash
$ sudo zfs create zpool1/docker
$ sudo zfs list -o name,mountpoint,mounted
```

At this point you'll have a ZFS filesystem created and mounted at `/zpool1/docker`. According to [Docker ZFS storage docs](https://docs.docker.com/engine/userguide/storagedriver/zfs-driver/), if the Docker root dir is a ZFS filesystem, the Docker daemon will automatically use `zfs` as its storage driver.

Now you'll need to remove `-s overlay` (or any other storage driver) from the Docker daemon args to allow docker to automatically detect `zfs`.

```bash
$ sudo ros config set rancher.docker.args "[daemon, --log-opt, max-size=25m, --log-opt, max-file=2, -G, docker, -H, 'unix:///var/run/docker.sock', -g, '/zpool1/docker']"
# After editing Docker daemon args, you'll need to start Docker
$ sudo system-docker start docker
```

After customizing the Docker daemon arguments and restarting `docker` system service, ZFS will be used as Docker storage driver:

```bash
$ docker info

Containers: 0
 Running: 0
 Paused: 0
 Stopped: 0
Images: 0
Server Version: 1.11.2
Storage Driver: zfs
 Zpool: zpool1
 Zpool Health: ONLINE
 Parent Dataset: zpool1/docker
 Space Used By Parent: 19968
 Space Available: 4128138240
 Parent Quota: no
 Compression: off
Logging Driver: json-file
Cgroup Driver: cgroupfs
Plugins:
 Volume: local
 Network: bridge null host
Kernel Version: 4.4.10-rancher
Operating System: RancherOS (containerized)
OSType: linux
Architecture: x86_64
CPUs: 1
Total Memory: 1.955 GiB
Name: rancher-dev
ID: YNXU:HZ7N:H4RI:TFND:YHJT:JJFZ:33II:7M7V:FBAO:7WWF:GTCH:WZ3K
Docker Root Dir: /var/lib/docker
Debug mode (client): false
Debug mode (server): false
Registry: https://index.docker.io/v1/
```
