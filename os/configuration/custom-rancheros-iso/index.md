---
title: Custom RancherOS ISO
layout: os-default

---

## Custom RancherOS ISO

You can build your own RancherOS ISO image. Here's a quick how-to:

 1. Git clone https://github.com/rancher/os repo to a directory on your disk.

 2. Edit the [build.conf](https://github.com/rancher/os/blob/master/build.conf) file (in the root of the repo) to your needs (see details for custom [kernel](/os/configuration/custom-kernels) and [docker](/os/configuration/custom-docker)).
    
 3. Run `./build.sh` in the repo root directory. You need to have `bash`, `make` and `docker` (docker version >= 1.8.0).
    In a couple minutes you'll have ./dist/artifacts dir with the custom built RancherOS release files (ISO included).
