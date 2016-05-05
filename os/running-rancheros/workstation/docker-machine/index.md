---
title: Running RancherOS on VirtualBox using docker machine
layout: os-default

---

## Running RancherOS using Docker Machine 
---

Before we get started, you'll need to make sure that you have docker machine installed. Download it directly from the docker machine [releases](https://github.com/docker/machine/releases). The version must be at least [v0.3.0-rc1](https://github.com/docker/machine/releases/tag/v0.3.0-rc1) or greater. 

> **Note:** If you create a RancherOS instance using `docker-machine`, you will not be able to upgrade your version of RancherOS.

### Downloading RancherOS

Get the latest `rancheros.iso` artifact from the RancherOS [releases](https://github.com/rancher/os/releases).  As of v0.4.0, the `rancheros.iso` can be used for `docker-machine`. Prior to v0.4.0, you must select the `machine-rancheros.iso`. 

### Using Docker Machine  

You can use `docker-machine` to launch VMs for various providers. Currently only VirtualBox and AWS are supported.

#### Using Docker Machine with VirtualBox

Before moving forward, you'll need to have VirtualBox installed. Download it directly from [VirtualBox](https://www.virtualbox.org/wiki/Downloads). Once you have VirtualBox and Docker Machine installed, it's just one command to get RancherOS running. 

```bash
$ docker-machine create -d virtualbox --virtualbox-boot2docker-url <LOCATION-OF-RANCHEROS-ISO> <MACHINE-NAME>
```

<br>

> **Note:** Instead of downloading the ISO, you can directly use the URL for the `rancheros.iso`. 

Example with RancherOS v0.4.0 link:

```bash
$ docker-machine create -d virtualbox --virtualbox-boot2docker-url https://github.com/rancher/os/releases/download/v0.4.0/rancheros.iso MyRancherOSMachine
```

That's it! You should now have a RancherOS host running on VirtualBox. You can verify that you have a VirtualBox VM running on your host.

```bash
$ VBoxManage list runningvms | grep <MACHINE-NAME>
```

This command will print out the newly created machine. If not, something went wrong with the provisioning step.

### Logging into RancherOS

Logging into RancherOS follows the standard `docker-machine` commands. To login into your newly provisioned RancherOS VM.

```bash
$ docker-machine ssh <MACHINE-NAME>
```

You'll be logged into RancherOS and can start exploring the OS, This will log you into the RancherOS VM. You'll then be able to explore the OS using [commands]({{site.baseurl}}/os/rancheros-tools/ros/), [adding system services]({{site.baseurl}}/configuration/system-services/), and launching containers.

If you want to exit out of RancherOS, you can exit by pressing `Ctrl+D`.

### Docker Machine Benefits

With docker-machine, you can point the docker client on your host to the docker daemon running inside of the VM. This allows you to run your docker commands as if you had installed docker on your host. 

To point your docker client to the docker daemon inside the VM, use the following command:

```bash
$ eval $(docker-machine env <MACHINE-NAME>)
```

After setting this up, you can run any docker command in your host, and it will execute the command in your RancherOS VM. 

```bash
$ docker run -p 80:80 -p 443:443 -d nginx
```

In your VM, a nginx container will start on your VM. To access the container, you will need the IP address of the VM. 

```bash
$ docker-machine ip <MACHINE-NAME>
```

Once you obtain the IP address, paste it in a browser and a _Welcome Page_ for nginx will be displayed.
