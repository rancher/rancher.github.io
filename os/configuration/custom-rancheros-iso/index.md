---
title: Custom RancherOS ISO
layout: os-default

---

## Custom RancherOS ISO

It's easy to build your own RancherOS ISO.

1. Create a clone of the main [RancherOS repository](https://github.com/rancher/os) to your local machine with a `git clone`. 

     ```bash
     $ git clone https://github.com/rancher/os.git
     ```

2. In the root of the repository, the `build.conf` file can be updated for changes for [custom kernels]({{site.baseurl}}/os/configuration/custom-kernels), or [custom docker]({{site.baseurl}}/os/configuration/custom-docker). 

     `build.conf` file

     ```
     IMAGE_NAME=rancher/os
     VERSION=v0.4.0

     DOCKER_BINARY_URL=https://github.com/rancher/docker/releases/download/v1.8.2-ros1/docker-1.8.2
     COMPILED_KERNEL_URL=https://github.com/rancher/os-kernel/releases/download/Ubuntu-3.19.0-27.29-ros1/linux-3.19.8-ckt5-rancher-x86.tar.gz
     DFS_IMAGE=rancher/docker:1.8.2
     ```

3. After you've saved your edits, run `./build.sh` in the root directory. After the build has completed, a `./dist/artifacts` directory will be created with the custom built RancherOS release files. 

     Build Requirements: `bash`, `make`, `docker` (docker version >= 1.8.0)

     ```bash
     $ ./build.sh
     $ cd dist/artifacts
     $ ls
     initrd             rancheros.iso
     iso-checksums.txt	vmlinuz
     ```

The `rancheros.iso` is ready to be used to [boot RancherOS from ISO]({{site.baseurl}}/os/running-rancheros/workstation/boot-from-iso/) or [launch RancherOS using docker-machine]({{site.baseurl}}/os/running-rancheros/workstation/docker-machine). 