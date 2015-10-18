---
title: Custom Kernels
layout: os-default

---

## Custom Kernels

### Changing the Kernel in RancherOS 

Currently, RancherOS ships with Linux 3.19.2 kernel. Starting with v0.4.0+, the kernel in RancherOS can be swapped out to your own version by [building your own custom RancherOS ISO]({{site.baseurl}}/os/configuration/custom-rancheros-iso/).

 1. Create a clone of the the main [RancherOS repository](https://github.com/rancher/os) to your local machine with a `git clone`. 

    ```bash
    $ git clone https://github.com/rancher/os.git
    ```

 2. In the root of the repository, the `build.conf` file will need to be updated. Using your favorite editor, replace the `COMPILED_KERNEL_URL` value with a URL of your compiled custom kernel tarball. Ideally, the URL will be pre-fixed with `https`.

     `build.conf` file

     ```
     IMAGE_NAME=rancher/os
     VERSION=v0.4.0
 
     DOCKER_BINARY_URL=https://github.com/rancher/docker/releases/download/v1.8.2-ros1/docker-1.8.2
     # Update the URL to your own custom kernel tarball
     COMPILED_KERNEL_URL=https://github.com/rancher/os-kernel/releases/download/Ubuntu-3.19.0-27.29-ros1/linux-3.19.8-ckt5-rancher-x86.tar.gz
     DFS_IMAGE=rancher/docker:1.8.2
     ```

     > **Note:** `COMPILED_KERNEL_URL` should point to a Linux kernel, compiled and packaged in a specific way. You can use the [os-kernel repository](https://github.com/rancher/os-kernel) to package your own kernel.
  
 3. After you've replaced the URL with your custom kernel, run `./build.sh` in the root directory. After the build has completed, a `./dist/artifacts` directory will be created with the custom built RancherOS release files. 

     Build Requirements: `bash`, `make`, `docker` (docker version >= 1.8.0)
     
     ```bash
     $ ./build.sh
     $ cd dist/artifacts
     $ ls
     initrd             rancheros.iso
     iso-checksums.txt	vmlinuz
     ```

The `rancheros.iso` is ready to be used to [boot RancherOS from ISO]({{site.baseurl}}/os/running-rancheros/workstation/boot-from-iso/) or [launch RancherOS using docker-machine]({{site.baseurl}}/os/running-rancheros/workstation/docker-machine). The new ISO and will be running with your custom kernel. 

### Packaging a Kernel to be used in RancherOS

We build the kernel for RancherOS at the [os-kernel repository](https://github.com/rancher/os-kernel). You can use this repository to help package your own custom kernel to be used in RancherOS.


1. Create a clone of the the [os-kernel](https://github.com/rancher/os-kernel) repository to your local machine using `git clone`.

     ```bash
     $ git clone https://github.com/rancher/os-kernel.git
     ```

2. In the `./scripts/build-common` file, update the `KERNEL_URL` and `KERNEL_SHA1`. `KERNEL_URL` points to Linux kernel sources archive, packaged as `.tar.gz` or `.tar.xz`. `KERNEL_SHA1` is the `SHA1` sum of the kernel sources archive.

     `./scripts/build-common` file

     ```
    #!/bin/bash
     set -e

     : ${KERNEL_URL:="https://github.com/rancher/linux/archive/Ubuntu-3.19.0-27.29.tar.gz"}
     : ${KERNEL_SHA1:="84b9bc53bbb4dd465b97ea54a71a9805e27ae4f2"}
     : ${ARTIFACTS:=$(pwd)/assets}
     : ${BUILD:=$(pwd)/build}
     : ${CONFIG:=$(pwd)/config}
     : ${DIST:=$(pwd)/dist}

     ```

3. After you've replaced the `KERNEL_URL` and `KERNEL_SHA1`, run `./build.sh` in the root `os-kernel` directory. After the build is completed, a `./dist/kernel` directory will be created with the freshly built kernel tarball and headers. 

     ```bash
     $ ./build.sh
     $ cd dist/kernel
     $ ls
     headers    <name_of_kernel>.tar.gz
     ```