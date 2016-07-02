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
v0.5.0-rc3: Pulling from rancher/os-ubuntuconsole
6d3a6d998241: Pull complete 
606b08bdd0f3: Pull complete 
1d99b95ffc1c: Pull complete 
a3ed95caeb02: Pull complete 
21e9a7e529d0: Pull complete 
c70bea4dcb69: Pull complete 
ac1733490c6b: Pull complete 
f8e0071f38f1: Pull complete 
9808e71293a6: Pull complete 
113254b8db30: Pull complete 
Digest: sha256:4fcff04e5ae009b5891092e64e600563af70a090c01098a03739538d04291afa
Status: Downloaded newer image for rancher/os-ubuntuconsole:v0.5.0-rc3
switch-console_1 | time="2016-06-14T06:45:14Z" level=info msg="Project [os]: Starting project " 
switch-console_1 | time="2016-06-14T06:45:14Z" level=info msg="[0/18] [console]: Starting " 
switch-console_1 | time="2016-06-14T06:45:14Z" level=info msg="Recreating console" 
Connection to 127.0.0.1 closed by remote host.
Connection to 127.0.0.1 closed.
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
Pulling console (rancher/os-debianconsole:v0.5.0-rc3)...
v0.5.0-rc3: Pulling from rancher/os-debianconsole
7268d8f794c4: Pull complete 
a3ed95caeb02: Pull complete 
f774062bef60: Pull complete 
dfa80dc6f374: Pull complete 
017e85cae03c: Pull complete 
a8136a6de4d9: Pull complete 
08e2eb4e8c91: Pull complete 
Digest: sha256:d6d8999ff5fa6e2f6fc2e7e1858613d5651f33de573ad5a51205328e50887734
Status: Downloaded newer image for rancher/os-debianconsole:v0.5.0-rc3
```

At the next reboot, RancherOS will use the Debian console. 
