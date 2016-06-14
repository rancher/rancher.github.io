---
title: Custom Docker
layout: os-default

---

## Custom Docker

In RancherOS, you can change the default Docker version with a custom Docker version. You can change the Docker version for only Docker in RancherOS and keep System Docker with the default version, or you can change the Docker version for Docker and System Docker. 

### Custom Docker with default System Docker

In order to update the Docker binary, you will need to be in a [persistent console]({{site.baseurl}}/os/configuration/custom-console/#console-persistence). To confirm what console is running, run `sudo system-docker ps` to see what console container is running.

```bash
$ sudo system-docker ps
CONTAINER ID        IMAGE                           COMMAND                  CREATED             STATUS              PORTS               NAMES
# os-console is a busybox console and not persistent. 
f5ea8eb23fb6        rancher/os-console:v0.4.0-rc6   "/usr/sbin/entry.sh /"   2 minutes ago       Up 2 minutes                            os_console_1
825b860b3a6c        rancher/os-docker:v0.4.0-rc6    "/usr/sbin/entry.sh /"   23 hours ago        Up 2 minutes                            docker
e8b20d1b34fe        rancher/os-ntp:v0.4.0-rc6       "/usr/sbin/entry.sh /"   23 hours ago        Up 2 minutes                            ntp
420aced55a08        rancher/os-acpid:v0.4.0-rc6     "/usr/sbin/entry.sh /"   23 hours ago        Up 2 minutes                            acpid
1a1bd08c3120        rancher/os-udev:v0.4.0-rc6      "/usr/sbin/entry.sh /"   23 hours ago        Up 2 minutes                            
e52f62fcba82        rancher/os-syslog:v0.4.0-rc6    "/usr/sbin/entry.sh /"   23 hours ago        Up 2 minutes                            syslog
```

If you are in the default console, `os-console`, then you will need to [switch consoles]({{site.baseurl}}/os/configuration/custom-console/#changing-consoles-after-rancheros-has-started) to one of the persistent ones.

After you are logged in a persistent console, you can download the Docker binary and symlink as `/usr/local/bin/docker`.

```bash
$ curl -OL https://github.com/rancher/docker/releases/download/v1.8.2-rc1-ros/docker-1.8.2-rc1
$ chmod +x ./docker-1.8.2-rc1
$ sudo cp ./docker-1.8.2-rc1 /usr/local/bin/ 
$ sudo ln -s /usr/local/bin/docker-1.8.2-rc1 /usr/local/bin/docker 
$ sudo reboot
```

In order to have the Docker version to be updated, you'll need to reboot. When you log back into RancherOS, you'll be running the new Docker version. 

```bash
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

If you haven't touched `/usr/bin/docker` symlink, System Docker will still use the bundled Docker from the OS image.

### Custom Docker and Custom System Docker 

In order to change the Docker version in Docker and System Docker, you'll be [building your own custom RancherOS ISO]({{site.baseurl}}/os/configuration/custom-rancheros-iso/).

1. Create a clone of the main [RancherOS repository](https://github.com/rancher/os) to your local machine with a `git clone`. 

   ```bash
   $ git clone https://github.com/rancher/os.git
   ```

2. In the root of the repository, the `build.conf` file will need to be updated. Using your favorite editor, replace the `DOCKER_BINARY_URL` value with a Docker binary download URL. 

   `build.conf` file

   ```
   IMAGE_NAME=rancher/os
   VERSION=v0.4.0

   # Update the URL to your preferred Docker version
   DOCKER_BINARY_URL=https://github.com/rancher/docker/releases/download/v1.8.2-ros1/docker-1.8.2
   COMPILED_KERNEL_URL=https://github.com/rancher/os-kernel/releases/download/Ubuntu-3.19.0-27.29-ros1/linux-3.19.8-ckt5-rancher-x86.tar.gz
   DFS_IMAGE=rancher/docker:1.8.2
   ```

3. After you've replaced the URL with your custom kernel, run `./build.sh` in the root directory. After the build has completed, a `./dist/artifacts` directory will be created with the custom built RancherOS release files. 

     Build Requirements: `bash`, `make`, `docker` (docker version >= 1.8.0)

   ```bash
   $ ./build.sh
   $ cd dist/artifacts
   $ ls
   initrd             rancheros.iso
   iso-checksums.txt	vmlinuz
   ```

The `rancheros.iso` is ready to be used to [boot RancherOS from ISO]({{site.baseurl}}/os/running-rancheros/workstation/boot-from-iso/) or [launch RancherOS using docker-machine]({{site.baseurl}}/os/running-rancheros/workstation/docker-machine). The new ISO will be running your custom Docker version in Docker and System Docker. 


