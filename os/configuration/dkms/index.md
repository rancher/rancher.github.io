---
title: DKMS
layout: os-default

---

## DKMS

DKMS is supported by running the DKMS scripts inside a container.  To compile any kernel modules you first need to download the kernel headers.  The kernel headers are available in the form of a system service.  Run the below to install the kernel headers:

```sh
sudo ros service enable kernel-headers
sudo ros service up -d kernel-headers
```

The above command will end up installing the kernel headers in `/lib/modules/$(uname -r)/build`.  This will make the kernel headers available to any container running in User Docker.  To install the kernel headers for use by container running in System Docker run the below commands:

```sh
sudo ros service enable kernel-headers-system-docker
sudo ros service up -d kernel-headers-system-docker
```

Once the headers are installed any container can be deployed that runs DKMS just ensure you bind mount in `/usr/src` and `/lib/modules`.  For example

    docker run -it -v /usr/src:/usr/src -v /lib/modules:/lib/modules ubuntu:15.10 sh -c 'apt-get update && apt-get install -y sysdig-dkms'
