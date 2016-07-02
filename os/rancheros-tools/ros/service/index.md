---
title: ROS Service
layout: os-default

---

## ROS Service
---

`ros service` allows you to enable/disable different system services. Please go to our [Adding System Services page]({{site.baseurl}}/os/system-services/) for more details on how to add system services to RancherOS. The `ros service` command shows you how to turn on and off the services that have been added.

### Sub Commands

|Command | Description |
|--------|-------------|
|`enable`	| Turn on an service|
|`disable`	|Turn off an service|
|`list`	|	List services and state|
| `delete` | Delete services |
|`build` |	Build or rebuild services.
|`create`	| Create all services but do not start
|`up` |		Bring all services up
|`start` |	Start services
|`logs` |		Get service logs
|`restart` |	Restart services
|`stop`, `down` |	Stop services
|`scale` |	Scale services
|`rm`	|	Delete services
|`pull`	|	Pulls images for services
|`kill`	|	Force stop service containers
|`port` |		Print the public port for a port binding
|`ps`	|	List containers
|`help`, `h` |	Shows a list of commands or help for one command

### List

The `list` command will provide you a list of all services available in the [os-services repository](https://github.com/rancher/os-services) as well as any service that was added by the user to `/var/lib/rancher/conf/cloud-config.yml`. The command will also show the state that each service is in.

```bash
$ sudo ros service list
disabled amazon-ecs-agent
disabled kernel-headers
disabled kernel-headers-system-docker
disabled open-vm-tools
```

### Enable

The `enable` command turns on a service. This service can either be a http(s) url, location to a yaml file (file must be located in `/var/lib/rancher/conf/`), or  a service that is already in the [os-services repository](https://github.com/rancher/os-services). For anything outside of the os-services repo, an additional item will be added to the `/var/lib/rancher/conf/cloud-config.yml` file. In order for the change to take effect, you must reboot. In the future, the reboot will be dynamic.

Note: If you are using the location of a yaml file to enable, the system-service-name should be the entire location of the file. Therefore, if you were enabling an `example.yml` file, you will be enabling `/var/lib/rancher/conf/example.yml`.

For our example, we're enabling the `kernel-headers` service, which is in the os-services repository. After a reboot, kernel headers will be installed on the system.

```bash
$ sudo ros service list
disabled amazon-ecs-agent
disabled kernel-headers
disabled kernel-headers-system-docker
disabled open-vm-tools
$ sudo ros service enable kernel-headers
$ sudo ros service list
disabled amazon-ecs-agent
enabled  kernel-headers
disabled kernel-headers-system-docker
disabled open-vm-tools
$ sudo reboot
```

### Disable

The `disable` command turns off any service, but the service will **not** be removed. You will need to reboot in order for the change to take effect. In the future, the reboot will be dynamic. 

For our example, we're disabling the `kernel-headers` service. This service will no longer be run on future boots.

```bash
$ sudo ros service list
disabled amazon-ecs-agent
enabled  kernel-headers
disabled kernel-headers-system-docker
disabled open-vm-tools
$ sudo ros service disable kernel-headers
$ sudo ros service list
disabled amazon-ecs-agent
disabled kernel-headers
disabled kernel-headers-system-docker
disabled open-vm-tools
```

### Delete

The `delete` command can be used to delete services that were added dynamically. i.e. All the services that were not compiled in can be deleted. 

```bash
$ sudo ros service enable /var/lib/rancher/conf/etcd.yml
$ sudo ros service list
disabled amazon-ecs-agent
disabled kernel-headers
disabled kernel-headers-system-docker
disabled open-vm-tools
enabled  /var/lib/rancher/conf/etcd.yml
$ sudo ros delete /var/lib/rancher/conf/etcd.yml
$ sudo ros service list
disabled amazon-ecs-agent
disabled kernel-headers
disabled kernel-headers-system-docker
disabled open-vm-tools
```

