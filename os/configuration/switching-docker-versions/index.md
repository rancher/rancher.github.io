---
title: Changing Docker Versions in RancherOS
layout: os-default
redirect_from:
  - os/configuration/custom-docker/

---

## Changing Docker Versions

The version of User Docker used in RancherOS can be configured using a [cloud-config]({{site.baseurl}}/os/configuration/#cloud-config) file or by using the `ros engine` command.

### Setting the Docker engine using cloud-config

To define which Docker engine should be used when RancherOS boots, a cloud-config file can be used. For example, RancherOS will use Docker 1.10.3 when booted with the following cloud-config.

```yaml
#cloud-config
rancher:
  docker:
    engine: docker-1.10.3
```

### Listing available Docker engines

The `ros engine list` command can be used to show which Docker engines are currently available for use.

```
$ sudo ros engine list
disabled docker-1.10.3
disabled docker-1.11.2
current  docker-1.12.1
```

### Changing Docker engines after RancherOS has started

To change the Docker engine once RancherOS has started the `ros engine switch` command can be used. For example, you can switch to Docker 1.11.2 with the following command.

```
$ sudo ros engine switch docker-1.11.2
INFO[0000] Project [os]: Starting project               
INFO[0000] [0/19] [docker]: Starting                    
Pulling docker (rancher/os-docker:1.11.2)...
1.11.2: Pulling from rancher/os-docker
2a6bbb293656: Pull complete 
Digest: sha256:ec57fb24f6d4856d737e14c81a20f303afbeef11fc896d31b4e498829f5d18b2
Status: Downloaded newer image for rancher/os-docker:1.11.2
INFO[0007] Recreating docker                            
INFO[0007] [1/19] [docker]: Started                     
INFO[0007] Project [os]: Project started 
$ docker version
Client:
 Version:      1.11.2
 API version:  1.23
 Go version:   go1.5.4
 Git commit:   b9f10c9
 Built:        Wed Jun  1 21:20:08 2016
 OS/Arch:      linux/amd64

Server:
 Version:      1.11.2
 API version:  1.23
 Go version:   go1.5.4
 Git commit:   b9f10c9
 Built:        Wed Jun  1 21:20:08 2016
 OS/Arch:      linux/amd64

```

> **Note:** There are known issues in Docker when switching between versions. For production systems, we recommend setting the Docker engine only once using a cloud-config.

### Enabling Docker engines

To set which version of Docker should be used after the next reboot, the `ros engine enable` command can be used.
