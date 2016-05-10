---
title: Adding System Services
layout: os-default

---

## System Services

A system service is a container that can be run in either system-docker or docker. Rancher provides services that are already available in RancherOS by adding them to the [os-services repo](https://github.com/rancher/os-services). Anything in the `index.yml` file from the repo will be an option shown when using the `ros service list` command. This command will list all system services and whether they are enabled or disabled.

You can also create your own system service in the [docker compose](https://docs.docker.com/compose/) format. 

### Enabling/Disabling System Services

For any services that are listed from the `ros service list`, they can be enabled by running a single command. In order for the changes take effect, you will also need to reboot. In the future, the reboot will be dynamic.

```bash
$ sudo ros service list
disabled amazon-ecs-agent
disabled debian-console
disabled kernel-headers
disabled kernel-headers-system-docker
disabled resize-fs
disabled ubuntu-console
$ sudo ros service enable ubuntu-console
$ sudo reboot
```

To turn off a system service, run `ros service disable <system-service-name>`. This will only turn off the service, but it will not remove the service from RancherOS. Similar to when we enabled the service, we'll need to reboot in order for the disabling to take effect.

To delete a service that you added, run `ros service delete <system-service-name>`. This will remove the service from the list of services.

### Adding Custom System Services

After creating your own custom service, you can launch the services in RancherOS in two different methods. The service could be directly added to the [cloud-config]({{site.baseurl}}/os/cloud-config/) that you start RancherOS with or a `docker-compose.yml` file could be saved in a http(s) url location or in a directory of RancherOS. 

#### Launching Services through Cloud Config

If you want to boot RancherOS with a system-service running, you can add the service to the cloud-config that is passed to RancherOS.

```yaml
#cloud-config
rancher:
  services: 
    nginxapp:
      image: nginx
      restart: always
```      

#### Launching Services inside RancherOS 

If you want to add a system-service to a running RancherOS, a `docker-compose.yml` file must be saved in `/var/lib/rancher/conf/` in order for it to be enabled. 

```yaml
nginxapp:
  image: nginx
  restart: always
```     

To enable a custom system-service from a file location, the command must indicate the file location if saved in RancherOS.

```bash
$ sudo ros service enable /var/lib/rancher/conf/example.yml
```

If the file is saved at a http(s) url, just use the http(s) url when enabling/disabling.

```bash
$ sudo ros service enable http://mydomain.com/example.yml
```

<br>

> **Note:** You will need to reboot in order for the services to start.

### System-Docker vs. Docker

RancherOS uses labels to determine if the container should be deployed in system-docker. By default without the label, the container will be deployed in Docker.

```yaml
labels:
  - io.rancher.os.scope=system
```

### Labels

We use labels to determine how to handle the service containers.

Key | Value |Description
----|-----|---
`io.rancher.os.detach` | Default: `true` | Equivalent of `docker run -d`. If set to `false`, equivalent of `docker run --detach=false`
`io.rancher.os.scope` | `system` | Use this label to have the container deployed in system-docker instead of docker.
`io.rancher.os.before`/`io.rancher.os.after` | Service Names (Comma separated list is accepted) | Used to determine order of when containers should be started. 
`io.rancher.os.createonly` | Default: `false` | When set to `true`, only a `docker create` will be performed and not a `docker start`.
`io.rancher.os.reloadconfig` | Default: `false`| When set to `true`, it reloads the configuration. 


#### Example of how to order container deployment

```yaml
foo:
  labels:
    # Start foo before bar is launched
    io.rancher.os.before: bar
    # Start foo after baz has been launched
    io.rancher.os.after: baz 
```

### Environment

With [environment](https://docs.docker.com/compose/yml/#environment) in the yaml file, if the environment is not set (i.e. it doesn't have an `=`), then RancherOS looks up the value in the [cloud config file]({{site.baseurl}}/os/cloud-config). 

We support worldwide globbing, so in our example below, the services.yml file will find ETCD_DISCOVERY in the `cloud-config.yml` file and set the environment to `https://discovery.etcd.io/d1cd18f5ee1c1e2223aed6a1734719f7` for the service. 

`services.yml` File:

```yaml
etcd:
  environment:
    - ETCD_*
```

`cloud-config.yml` File:

```yaml
rancher:
  environment:
    ETCD_DISCOVERY: https://discovery.etcd.io/d1cd18f5ee1c1e2223aed6a1734719f7
```

### Unsupported Keys in RancherOS

RancherOS doesn't support some docker-compose keys as it isn't relevant to RancherOS.

* Build 
* Env_File
* External_Links

If you set the net to your host, then the `hostname` key will not be set for the container. Instead, it will be automatically set to `rancher`.

## Contributing to OS-Services

If you're interested in adding more services to RancherOS, please contribute to our [repo](https://github.com/rancher/os-services). 

<br>
<br>
