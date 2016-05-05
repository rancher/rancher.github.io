---
title: Quick Start Guide
layout: os-default

---

## Quick Start Guide
---

If you have a specific RanchersOS machine requirements, please check out our [guides on running RancherOS]({{site.baseurl}}/os/running-rancheros/). With the rest of this guide, we'll start up a RancherOS using [docker machine]({{site.baseurl}}/os/running-rancheros/workstation/docker-machine/) and show you some of what RancherOS can do.

### Launching RancherOS using Docker Machine

Before moving forward, you'll need to have [Docker Machine](https://docs.docker.com/machine/) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads) installed. Once you have VirtualBox and Docker Machine installed, it's just one command to get RancherOS running. 

```bash
$ docker-machine create -d virtualbox --virtualbox-boot2docker-url https://releases.rancher.com/os/latest/rancheros.iso <MACHINE-NAME>
```

That's it! You're up and running a RancherOS instance.

To log into the instance, just use the docker-machine command.

```bash
$ docker-machine ssh <MACHINE-NAME>
```

### A First Look At RancherOS

There are two Docker daemons running in RancherOS. The first is called **system-docker**, which is where RancherOS runs system services like ntpd and rsyslogd. You can use the `system-docker` command to control the **system-docker** daemon. 

The other Docker daemon running on the system is **docker**, which can be accessed by using the normal `docker` command.


When you first launch RancherOS, there are no containers running in the `docker` daemon. However, if you run the same command against the `system-docker` instance, you’ll see a number of system services that are shipped with RancherOS. 

> **Note:** `system-docker` can only be used by root, so it is necessary to use the `sudo` command whenever you want to interact with `system-docker`.

```bash
$ sudo system-docker ps
CONTAINER ID        IMAGE                       COMMAND                  CREATED             STATUS              PORTS               NAMES
4710a91a0729        rancher/os-docker:v0.4.4    "/usr/sbin/entry.sh /"   6 minutes ago       Up 6 minutes                            docker
7ef4fad1612c        rancher/os-console:v0.4.4   "/usr/sbin/entry.sh /"   6 minutes ago       Up 6 minutes                            console
1b436b6b7fdb        rancher/os-network:v0.4.4   "/usr/sbin/entry.sh /"   6 minutes ago       Up 6 minutes                            network
2ce47a55d1bd        rancher/os-ntp:v0.4.4       "/usr/sbin/entry.sh /"   6 minutes ago       Up 6 minutes                            ntp
c2237144ec41        rancher/os-udev:v0.4.4      "/usr/sbin/entry.sh /"   6 minutes ago       Up 6 minutes                            udev
5373e592dc51        rancher/os-acpid:v0.4.4     "/usr/sbin/entry.sh /"   6 minutes ago       Up 6 minutes                            acpid
c5d8cd81a94c        rancher/os-syslog:v0.4.4    "/usr/sbin/entry.sh /"   6 minutes ago       Up 6 minutes                            syslog
```

Some containers are run at boot time, and others, such as the `console`, `docker`, etc. containers are always running.

## Using RancherOS
---

### Deploying a Docker Container

Let's try to deploy a normal Docker container on the `docker` daemon.  The RancherOS `docker` daemon is identical to any other Docker environment, so all normal Docker commands work.

```bash
$ docker run -d nginx 
```

You can see that the nginx container is up and running:

```sh
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
e99c2c4b8b30        nginx               "nginx -g 'daemon off"   12 seconds ago      Up 11 seconds       80/tcp, 443/tcp     drunk_ptolemy
```

### Deploying A System Service Container

The following is a simple Docker container to set up Linux-dash, which is a minimal low-overhead web dashboard for monitoring Linux servers. The Dockerfile will be like this:

```
FROM hwestphal/nodebox
MAINTAINER hussein.galal.ahmed.11@gmail.com

RUN opkg-install unzip
RUN curl -k -L -o master.zip https://github.com/afaqurk/linux-dash/archive/master.zip
RUN unzip master.zip
WORKDIR linux-dash-master
RUN npm install

ENTRYPOINT ["node","server"]
```

Using the `hwestphal/nodebox` image, which uses a busybox image and installs `node.js` and `npm`. We downloaded the source code of Linux-dash, and then ran the server. Linux-dash will run on port 80 by default.

To run this container with system-docker use the following command:

```sh
$ sudo system-docker run -d --net=host --name busydash husseingalal/busydash
```
In the commad, we used `--net=host` to tell `system-docker` not to containerize the container's networking, and use the host’s networking instead. After running the container, you can see the monitoring server by accessing `http://<IP_OF_MACHINE`.

![System Docker Container]({{site.baseurl}}/img/os/Rancher_busydash.png)

To make the container survive during the reboots, you can create the `/opt/rancher/bin/start.sh` script, and add the docker start line to launch the docker at each startup.

```bash
$ sudo mkdir -p /opt/rancher/bin
$ echo “sudo system-docker start busydash” | sudo tee -a /opt/rancher/bin/start.sh
$ sudo chmod 755 /opt/rancher/bin/start.sh
```

### Using [ROS]({{site.baseurl}}/os/rancheros-tools/ros/)

Another useful command that can be used with RancherOS is `ros` which can be used to control and configure the system. 

```bash
$ ros -v
ros version 0.0.1
```

RancherOS state is controlled by a cloud config file. `ros` is used to edit the configuration of the system, to see for example the dns configuration of the system:

```sh
$ sudo ros config get rancher.dns
- 8.8.8.8
- 8.8.4.4
```


When using the native Busybox console, any changes to the console will be lost after reboots, only changes to `/home` or `/opt` will be persistent. The console always executes **/opt/rancher/bin/start.sh** at each startup. You can use `ros` to enable a [persistent console]({{site.baseurl}}/os/configuration/custom-console/#console-persistence) and replace the native Busybox console. In order to enable the Ubuntu console, use the following command:

```sh
$ sudo ros service enable ubuntu-console
$ sudo reboot
```

<br>

> **Note:** You must reboot after enabling a console.

### Conclusion

RancherOS is a simple Linux distribution ideal for running Docker.  By embracing containerization of system services and leveraging Docker for management, RancherOS hopes to provide a very reliable, and easy to manage OS for running containers. 

