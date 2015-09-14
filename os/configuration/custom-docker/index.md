---
title: Custom Docker
layout: os-default

---

## Custom Docker

RancherOS lets you use a custom docker binary. There are two ways this is currently possible:

- OS images can be compiled with a custom docker binary built-in. That docker binary will be used by both docker and system-docker daemons.

- Use a custom docker binary from inside the console. This way the custom docker will only be used by (user-) docker daemon. 


### Building custom OS images

The steps are basically the same as for building OS with a [custom kernel](/os/configuration/custom-kernels): you need to replace DOCKER_BINARY_URL with your docker binary download URL (e.g. "https://github.com/rancher/docker/releases/download/v1.8.2-rc1-ros/docker-1.8.2-rc1") and run `./build.sh`. 


### Custom docker binary in persistent console

You need a persistent console, such as debian-console or ubuntu-console, to be able to use custom docker. E.g. to enable debian-console, run the following:

```
$ sudo ros service enable debian-console
$ sudo reboot
```

Having rebooted and logged back into RancherOS, you are now using a persistent console. Now, download the desired docker binary and symlink to it as `/usr/local/bin/docker`: 

```
$ curl -OL https://github.com/rancher/docker/releases/download/v1.8.2-rc1-ros/docker-1.8.2-rc1
$ chmod +x ./docker-1.8.2-rc1
$ sudo cp ./docker-1.8.2-rc1 /usr/local/bin/ 
$ sudo ln -s /usr/local/bin/docker-1.8.2-rc1 /usr/local/bin/docker 
```

Then, reboot again (sorry!). Now you're using a custom docker:

```
$ docker version

Client:
 Version:      1.8.2-rc1
 API version:  1.20
 Go version:   go1.4.2
 Git commit:   66b73cc
 Built:        Tue Sep  8 04:20:42 UTC 2015
 OS/Arch:      linux/amd64

Server:
 Version:      1.8.2-rc1
 API version:  1.20
 Go version:   go1.4.2
 Git commit:   66b73cc
 Built:        Tue Sep  8 04:20:42 UTC 2015
 OS/Arch:      linux/amd64
```

If you haven't touched `/usr/bin/docker` symlink, system-docker will still use the bundled docker from the OS image.
