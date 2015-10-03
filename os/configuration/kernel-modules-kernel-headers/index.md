---
title: Installing Kernel Modules with Kernel Headers
layout: os-default

---

## Installing Kernel Modules that require Kernel Headers


To compile any kernel modules you first need to download the kernel headers.  The kernel headers are available in the form of a system service.  Run the below to install the kernel headers:

```sh
sudo ros service enable kernel-headers
sudo ros service up -d kernel-headers
```

The above command will end up installing the kernel headers in `/lib/modules/$(uname -r)/build`.  This will make the kernel headers available to any container running in User Docker.  Once the headers are installed any container can be deployed that compiles a kernel module just ensure you bind mount in `/usr/src` and `/lib/modules`.
