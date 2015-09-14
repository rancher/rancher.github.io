---
title: Custom Kernels
layout: os-default

---

## Custom Kernels

You can build your own RancherOS images with a custom Linux kernel. Currently, Linux v3.19 - v4.2 are known to work, and other versions might work as well. Here's a quick how-to:

 1. Git clone https://github.com/rancher/os repo to a directory on your disk.

 2. Edit the [build.conf](https://github.com/rancher/os/blob/master/build.conf) file (in the root of the repo):
    Replace the COMPILED_KERNEL_URL value with a (preferably, https) download URL of your compiled custom kernel tarball, 
    e.g. "https://github.com/imikushin/os-kernel/releases/download/4.2/linux-4.2.0-rancher-x86.tar.gz".
    
 3. Run `./build.sh` in the repo root directory. You need to have `bash`, `make` and `docker` (docker version >= 1.8.0).
    In a couple minutes you'll have ./dist/artifacts dir with the custom built RancherOS release files. 

COMPILED_KERNEL_URL should point to a Linux kernel, compiled and packaged in a specific way. 

We build the kernel for RancherOS here: https://github.com/rancher/os-kernel. To build your own, clone the [os-kernel](https://github.com/rancher/os-kernel) repo, replace KERNEL_URL and KERNEL_SHA1 values in [./scripts/build-common](https://github.com/rancher/os-kernel/blob/master/scripts/build-common) file and run `./build.sh`: the freshly built kernel tarball (and headers) will show up in ./dist/kernel in a few minutes. 

KERNEL_URL should point to Linux kernel sources archive, packaged as '.tar.gz' or '.tar.xz'.
KERNEL_SHA1 is the SHA1 sum of the kernel sources archive.
