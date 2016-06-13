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
| `list`	| list available consoles |

### List

The `list` command will provide you a list of all consoles available.

```bash
$ sudo ros console list
centos
debian
default
fedora
ubuntu
```

### Switch

The `switch` command will switch from your currently running console to the console of your choice. 

> **Note:** When switching between consoles, your current console will be destroyed, Docker will restart and you will be logged out of RancherOS. 

For our example, we'll switch to the ubuntu console. 

```bash
$ sudo ros console switch
Switching consoles will destroy the current console container and restart Docker.
Note: You will also be logged out.
Continue [y/N]:y
Pulling console (rancher/os-ubuntu-console:v0.5.0)
Pulling console (rancher/os-ubuntuconsole:v0.5.0-rc3)...
v0.5.0: Pulling from rancher/os-ubuntuconsole
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
```

After you log back in, you'll be in the ubuntu console. 

```bash
$ sudo system-docker ps
```


