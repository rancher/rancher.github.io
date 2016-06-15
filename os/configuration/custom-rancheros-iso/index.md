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

2. In the root of the repository, the "General Configuration" section of `Dockerfile.dapper` can be updated to use [custom kernels]({{site.baseurl}}/os/configuration/custom-kernels), or [custom Docker]({{site.baseurl}}/os/configuration/custom-docker).

3. After you've saved your edits, run `make` in the root directory. After the build has completed, a `./dist/artifacts` directory will be created with the custom built RancherOS release files.

     Build Requirements: `bash`, `make`, `docker` (Docker version >= 1.10.3)

   ```bash
   $ make
   $ cd dist/artifacts
   $ ls
   initrd             rancheros.iso
   iso-checksums.txt	vmlinuz
   ```

The `rancheros.iso` is ready to be used to [boot RancherOS from ISO]({{site.baseurl}}/os/running-rancheros/workstation/boot-from-iso/) or [launch RancherOS using docker-machine]({{site.baseurl}}/os/running-rancheros/workstation/docker-machine).
