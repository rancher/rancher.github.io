---
title: ROS Console
layout: os-default

---

## ROS Console
---

`ros console` allows you to switch between the different console containers.

### Sub Commands

|Command | Description |
|--------|-------------|
| `switch`	| switch currently running console |
|  `enable` |	set console to be switched on next reboot |
| `list`	| list available consoles |

### List

The `list` command will provide you a list of all consoles available.

```bash
$ sudo ros console list
disabled centos
disabled debian
current  default
disabled fedora
disabled ubuntu
```

### Switch

The `switch` command will switch from your currently running console to the console of your choice. 

> **Note:** When switching between consoles, your current console will be destroyed, Docker will restart and you will be logged out of RancherOS. 

For our example, we'll switch to the Ubuntu console. 

```bash
$ sudo ros console switch ubuntu
Switching consoles will
1. destroy the current console container
2. log you out
3. restart Docker
Continue [y/N]:y
Pulling console (rancher/os-ubuntuconsole:v0.5.0-3)...
v0.5.0-3: Pulling from rancher/os-ubuntuconsole
6d3a6d998241: Pull complete 
606b08bdd0f3: Pull complete 
1d99b95ffc1c: Pull complete 
a3ed95caeb02: Pull complete 
3fc2f42db623: Pull complete 
2fb84911e8d2: Pull complete 
fff5d987b31c: Pull complete 
e7849ae8f782: Pull complete 
de375d40ae05: Pull complete 
8939c16614d1: Pull complete 
Digest: sha256:37224c3964801d633ea8b9629137bc9d4a8db9d37f47901111b119d3e597d15b
Status: Downloaded newer image for rancher/os-ubuntuconsole:v0.5.0-3
switch-console_1 | time="2016-07-02T01:47:14Z" level=info msg="Project [os]: Starting project " 
switch-console_1 | time="2016-07-02T01:47:14Z" level=info msg="[0/18] [console]: Starting " 
switch-console_1 | time="2016-07-02T01:47:14Z" level=info msg="Recreating console" 
Connection to 127.0.0.1 closed by remote host.
```

After logging back, you'll be in the Ubuntu console. 

```bash
$ sudo system-docker ps
CONTAINER ID        IMAGE                                 COMMAND                  CREATED              STATUS              PORTS               NAMES
6bf33541b2dc        rancher/os-ubuntuconsole:v0.5.0-rc3   "/usr/sbin/entry.sh /"   About a minute ago   Up About a minute  
```

### Enable

The `enable` comand allows you to set the console to be switched at the next reboot. 

For our example, we'll switch to the Debian console.

```bash
# Check the console running in System Docker
$ sudo system-docker ps
CONTAINER ID        IMAGE                              COMMAND                  CREATED             STATUS              PORTS               NAMES
95d548689e82        rancher/os-docker:v0.5.0    "/usr/sbin/entry.sh /"   About an hour ago   Up About an hour                        docker
# Enable the Debian console
$ sudo ros console enable debian
Pulling console (rancher/os-debianconsole:v0.5.0-3)...
v0.5.0-3: Pulling from rancher/os-debianconsole
7268d8f794c4: Pull complete 
a3ed95caeb02: Pull complete 
21cb8a645d75: Pull complete 
5ee1d288a088: Pull complete 
c09f41c2bd29: Pull complete 
02b48ce40553: Pull complete 
38a4150e7e9c: Pull complete 
Digest: sha256:5dbca5ba6c3b7ba6cd6ac75a1d054145db4b4ea140db732bfcbd06f17059c5d0
Status: Downloaded newer image for rancher/os-debianconsole:v0.5.0-3
```

At the next reboot, RancherOS will use the Debian console. 
