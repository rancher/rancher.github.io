---
title: Getting Started on Vagrant
layout: os-default

---

## Running RancherOS on Vagrant
---

We have created a [RancherOS Vagrant project](https://github.com/rancher/os-vagrant) that allows you to quickly test out RancherOS.

Vagrant can be downloaded and installed from [here](http://www.vagrantup.com/downloads.html).

After installing Vagrant, you should clone the [RancherOS Vagrant repository](https://github.com/rancher/os-vagrant). From the command line, go to the directory that you want to clone the repo into. Clone the repo and go into the newly cloned directory.

```bash
$ git clone https://github.com/rancher/os-vagrant.git
$ cd os-vagrant
```

Within this directory, the Vagrantfile is the file that will be used to build a virtual machine on top of virtualbox. Vagrantfile will use the second version of the configuration, and it will specify the vagrant box url, and will deploy the ssh keys to rancher user. After that it will specify virtualbox as the provider, note that RancherOS needs at least **1GB** RAM.

Run `vagrant up`. This will import the vagrant box and create the virtual machine with RancherOS installed. 

```bash
$ vagrant up
Bringing machine 'rancher-01' up with 'virtualbox' provider...
…
…
==> rancher-01: Machine booted and ready!
==> rancher-01: Configuring and enabling network interfaces...
```

## Logging into RancherOS
---

Now, let's log in to the system. We use `vagrant ssh` to authenticate with the private Vagrant key and login to the system:

```bash
$ vagrant ssh
```

After you're logged into the system, go back to the [Quick Start Guide]({{site.baseurl}}/os/quick-start-guide/) to see some examples of what we can do.  

## Shutting Down the VM
---
If you are in the RancherOS command line, type `exit`.

```bash
$ exit 
logout
Connection to 127.0.0.1 closed. 
```

If you want to shut down your VM, run `vagrant halt` command from the os-vagrant directory. Or if you want to destroy the VM, run `vagrant destroy`. 

To get the VM back up, run `vagrant up` in the os-vagrant directory and just log back in `vagrant ssh`.

