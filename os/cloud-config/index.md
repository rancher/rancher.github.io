---
title: Cloud-Config
layout: os-default

---

## Configure RancherOS with Cloud-Config
---

Cloud-config is a declarative configuration file format supported by many Linux distributions and is the primary configuration mechanism for RancherOS. 

A Linux OS supporting cloud-config will invoke a cloud-init process during startup to parse the cloud-config file and configure the operating system. RancherOS runs its own cloud-init process in a system container. The cloud-init process will attempt to retrieve a cloud-config file from a variety of data sources. Once cloud-init obtains a cloud-config file, it configures the Linux OS according to the content of the cloud-config file.

When you create a RancherOS instance on AWS, for example, you can optionally provide cloud-config passed in the `user-data` field. Inside the RancherOS instance, cloud-init process will retrieve the cloud-config content through its AWS cloud-config data source, which simply extracts the content of user-data received by the VM instance. If the file starts with "`#cloud-config`", cloud-init will interpret that file as a cloud-config file. If the file starts with `#!<interpreter>` (e.g., `#!/bin/sh`), cloud-init will simply execute that file. You can place any configuration commands in the file as scripts.

A cloud-config file uses the YAML format. YAML is easy to understand and easy to parse. For more information on YAML, please read more at the [YAML site](http://www.yaml.org/start.html). The most important formatting principle is indentation or whitespace. This indentation indicates relationships of the items to one another. If something is indented more than the previous line, it is a sub-item of the top item that is less indented.

Example: Notice how both are indented underneath `ssh-authorized-keys`.

```yaml
#cloud-config
ssh_authorized_keys:
  - ssh-rsa AAA...ZZZ example1@rancher
  - ssh-rsa BBB...ZZZ example2@rancher
```

In our example above, we have our `#cloud-config` line to indicate it's a cloud-config file. We have 1 top-level property, `ssh_authorized_keys`. Its value is a list of public keys that are represented as a dashed list under `ssh_authorized_keys:`.

## How RancherOS Applies Cloud-Config

RancherOS comes with a default configuration, which is also in cloud-config format. The cloud-config file processed by cloud-init will extend and override the default configuration and be saved as `boot.yml` in `/var/lib/rancher/conf/cloud-config.d`. Finally, the `cloud-config.yml` file will extend and override the `boot.yml` file. You should not edit `cloud-config.yml` file directly. The `ros config` command allows you to change the content of the `cloud-config.yml` file.

Typically, when you first boot the server, you pass in the cloud-config file to configure the initialization of the server. After the first boot, if you have any changes for the configuration, it's recommended that you use `ros config` to set the necessary configuration properties. Any changes will be saved in the `cloud-config.yml` file and need to be re-booted in order to take effect.

## Updating Cloud-Config After RancherOS has booted

`ros config` is the main command to interact with RancherOS configuration, here's the link to the [full ros config command docs]({{site.baseurl}}/os/rancheros-tools/ros/config/). With these commands, you can get and set values in the `cloud-config.yml` file as well as import/export configurations.

You can view the content of `cloud-config.yml` file by issuing the `ros config export` command. Another command `ros config export --full` prints the current effective configuration of RancherOS, taking into account the initial default configuration and the impact of `cloud-config.yml`.

_In v0.3.1+, we changed the command from `rancherctl` to `ros`._

## Supported Cloud-Config Directives

RancherOS currently supports a small number of cloud-config directives.

> **Note:** Currently, RancherOS doesn't support adding other users to RancherOS.

### SSH Keys

You can add SSH keys to the default `rancher` user.

```yaml
# Adds SSH keys to the rancher user
ssh_authorized_keys:
  - ssh-rsa AAA... darren@rancher
```

### Write Files to Disk

You can write files to the disk using the `write_files` directive.

```yaml
write_files:
  - path: /opt/rancher/bin/start.sh
    permissions: 0755
    owner: root
    content: |
      #!/bin/bash
      echo "I'm doing things on start"
```

### Set Hostname

You can set the hostname of the host using cloud-config. The example below shows how to configure it.

```yaml
hostname: myhost
``` 

### RancherOS Specific Configuration 

To configure other parts of RancherOS, the cloud-config information must be within the `rancher` key in the cloud-config file.

#### Network Configuration

Network configuration section must start with the `rancher` key. The example below shows network interface and DNS configuration. For each interface, you can configure DHCP, IP Address, Gateway, and MTU. There are three ways to specify network interfaces:

1. Wild card (e.g., `eth*`). This is the least specific and the lowest priority. An `eth1` specification will take precedence over `eth*` specification.
2. Exact interface name (e.g., `eth0`). Exact interface names take precedence over wild card specifications.
3. MAC address (e.g., `"mac=ea:34:71:66:90:12:01"`). Mac addresses take precedence over exact interface names.

```yaml
rancher:
  network:
    interfaces:
      eth*:
        dhcp: false
      eth0:
        address: 192.168.100.100/24
        gateway: 192.168.100.1
        mtu: 1500
      # If this MAC address happens to match eth0, eth0 will be programmed to use DHCP.
      "mac=ea:34:71:66:90:12:01":
        dhcp: true
    dns:
      nameservers:
        - 8.8.8.8
        - 8.8.4.4
```

**DNS**

In the DNS section, you can set the `nameservers`, and `search`, which directly map to the fields of the same name in `/etc/resolv.conf`.

**Interfaces**

In the `interfaces` section, the keys are used to match the desired interface to configure.  Wildcard globbing is supported so `eth*` will match `eth1` and `eth2`.  Specific MAC address can be used to pick the NIC interface using `"mac=XXX"` as a key. The available options you can set are `address`, `gateway`, `mtu`, and `dhcp`.

#### Cloud Init Data Sources

You can configure which data sources to use for cloud-init.  Multiple data sources can be set, but the data source that is available the fastest will be used.  This value is usually pre-populated with the current setting for your environment.  Valid value are:

1. `configdrive:PATH` - Look for an OpenStack compatible config drive mounted at `PATH`
1. `file:PATH` - Read the `FILE` as the user data.
1. `ec2` - Look for EC2 style meta data at 169.254.169.254
1. `ec2:IP_ADDRESS` - Look for EC2 style meta data at the `IP_ADDRESS`
1. `url:URL` - Download `URL` and use that as the user data
1. `cmdline:URL` - Look for `cloud-config-url=URL` in `/proc/cmdline` and download `URL` as user data

Within the cloud-init key, you can define the data sources.

```yaml
rancher:
  cloud_init:
    datasources:
      - configdrive:/media/config-2
```

#### Persistent State Partition

RancherOS will store its state in a single partition specified by the `dev` field.  The field can be a device such as `/dev/sda1` or a logical name such `LABEL=state` or `UUID=123124`.  The default value is `LABEL=RANCHER_STATE`.  The file system type of that partition can be set to `auto` or a specific file system type such as `ext4`.

```yaml
rancher:
  state:
    fstype: auto
    dev: LABEL=RANCHER_STATE
    autoformat:
    - /dev/sda
    - /dev/vda
```

**Auto formatting**

You can specify a list of devices to check to format on boot.  If the state partition is already found, RancherOS will not try to auto format a partition. By default, auto-formatting is off.

RancherOS will autoformat the partition to ext4 if the device specified in `autoformat`:

* Contains a boot2docker magic string
* Starts with 1 megabyte of zeros and `rancher.state.formatzero` is true 

#### Upgrades

In the `upgrade` key, the `url` is used to find the list of available and current versions of RancherOS.

```yaml
rancher:
  upgrade:
    url: https://releases.rancher.com/os/releases.yml
    image: rancher/os
```

#### Docker Configuration

The `docker` key configures the docker arguments and TLS settings.

```yaml
rancher:
  docker:
    tls_args: [--tlsverify, --tlscacert=ca.pem, --tlscert=server-cert.pem, --tlskey=server-key.pem,
      '-H=0.0.0.0:2376']
    args: [daemon, --log-opt, max-size=25m, --log-opt, max-file=2, -s, overlay, -G, docker, -H, 'unix:///var/run/docker.sock', --userland-proxy=false]
```

#### System-Docker Configuration

The `system_docker` key configures the system-docker arguments.

```yaml
rancher:
  system_docker:
    args: [daemon, --log-opt, max-size=25m, --log-opt, max-file=2, -s, overlay, -b, docker-sys,
      --fixed-cidr, 172.18.42.1/16, --restart=false, -g, /var/lib/system-docker, -G, root,
      -H, 'unix:///var/run/system-docker.sock', --userland-proxy=false]
```

