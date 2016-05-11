---
title: ROS OS
layout: os-default

---

## ROS OS
---

`ros os` gives more information on the OS versions available for RancherOS. 

Remember all `ros` commands needs to be used with `sudo`. 

### Sub Commands

|Command | Description |
|--------|-------------|
|`upgrade` |	Upgrade to the latest version |
|`list`	|	List all the current available versions |
| `version` | Show the currently installed version|


### Version 

Besides using `ros -v`, you can also find the current version with the `version` command. 

```bash
$ sudo ros os version
v0.4.0
v0.4.1
```

### List

It's easy to see all the current available versions using the `list` command. 

```bash
$ sudo ros os list
rancher/os:v0.4.0 remote
rancher/os:v0.4.1 local
```

### Upgrade

Our [upgrading]({{site.baseurl}}/os/upgrading/) page provides more details on steps for upgrading.

#### Upgrade Options

|Options | Description |
|--------|-------------|
|`--stage`, `-s`	|Only stage the new upgrade, don't apply it|
|`--image`, `-i` 	|Upgrade to a certain image|
|  `--force`, `-f` |	do not prompt for input|
|  `--no-reboot` |	do not reboot after upgrade |

#### Image

The `-i` or `--image` option uses an image name to upgrade to the specific version. If no image is specified, the command will automatically use the current version.

```bash
$ sudo ros os upgrade -i rancher/os:v0.4.0    
INFO[0000] [0/1] [os-upgrade]: Starting
INFO[0034] [1/1] [os-upgrade]: Started
Upgrading to rancher/os:v0.4.1
Continue [y/N]: y
...
...
...
Continue with reboot [y/N] y
INFO[0082] Rebooting 
```

#### Stage

The `-s` or `--stage` option is used to stage the specific template instead of immediately installing it. 

```bash
$ sudo ros os upgrade -s -i rancher/os:v0.4.1
INFO[0000] [0/1] [os-upgrade]: Starting
INFO[0040] [1/1] [os-upgrade]: Started
```

#### Force 

The `-f` or `--force` option allows the user to bypass the prompts for continuing with the upgrade and rebooting. It will automatically do the upgrade and reboot.

<br>



