---
title: ROS Config
layout: os-default

---

## ROS Config
---

RancherOS state is controlled by a cloud config file. `ros config` is used to manipulate the configuration of the cloud config file. In previous versions (prior to v0.4.0), `ros config` would only manipulate the `rancher` key in the configuration and `rancher` was not required to set or get data.

With v0.4.0+, we simplified the configuration of RancherOS to only run off of a cloud config file. In order to make changes using `ros config`, you must prefix changes with `rancher`. 

Remember, all `ros` commands needs to be used with `sudo`. 

**For all changes to your configuration, you must reboot for them to take effect.**

### Sub commands
---
| Command  | Description                                     |
|----------|-------------------------------------------------|
| `get`      | Gets value                                       |
| `set`      | Sets a value                                     |
| `import`  | Import configuration from standard in or a file |
| `images`	 | List Docker images for a configuration from a file
| `export`   | Export configuration                            |
| `merge`    | Merge configuration from standard in                 |



### Get
---
The `get` command gets a value from the `/var/lib/rancher/conf/cloud-config.yml` file. Let's see how easy it is to get the DNS configuration of the system.

```sh
$ sudo ros config get rancher.network.dns.nameservers
- 8.8.8.8
- 8.8.4.4
```

### Set
---
The `set` command can set values in the `/var/lib/rancher/conf/cloud-config.yml` file. 

Setting a list in the `/var/lib/rancher/conf/cloud-config.yml`

```bash
$ sudo ros config set rancher.network.dns.nameservers '[8.8.8.8,8.8.4.4]'
```

Setting a simple value in the `/var/lib/rancher/conf/cloud-config.yml`

```bash
$ sudo ros config set rancher.docker.tls true
```

### Import
---
The `import` command allows you to import configurations from a standard in or a file. When using `import`, the existing configuration in `/var/lib/rancher/conf/cloud-config.yml` will be overridden. If you want to add information to the file, you'd need to use `ros config merge`.

#### Import Options

| Options  | Description                                     |
|----------|-------------------------------------------------|
| `--input`, `-i` |	File from which to read|

#### Input

The `-i` or `--input` option must be set in order for the command to work. This option determines where to find the file that you want to import.

```bash
$ sudo ros config import -i localcloudconfig.yml
```

### Export
---
The `export` command allows you to export your existing configuration from `/var/lib/rancher/conf/cloud-config.yml`. By default, only changes from the default values will be exported. 

If you run the command without any options, it will output into the shell what is in the `/var/lib/rancher/conf/cloud-config.yml` file.

```bash
$ sudo ros config export
ssh_authorized_keys: []
write_files: []
hostname: ""
rancher:
  network:
    interfaces:
        eth*: {}
        eth0:
            dhcp: true
        eth1:
            match: eth1
            address: 172.19.8.101/24
        lo:
            address: 127.0.0.1/8
  docker:
    tls: true
```
#### Export Options

| Options  | Description                                     |
|----------|-------------------------------------------------|
|`--output`, `-o` 	|File to which to save|
|`--private`, `-p`	|Include private information such as keys|
|`--full`, `-f`		|Include full configuration, including internal and default settings|


#### Output

The `-o` or `--output` option will define the name and location of where you want the file to be exported.

```bash
$ sudo ros config export -o localcloudconfig.yml
```

#### Private

Add the `-p` or `--private` option to include the certificates and private keys as part of the export. These keys are exported in addition to any changes made from the default value. The private information is located at `/var/lib/rancher/conf/cloud-config.d/private.yml`.

```bash
$ sudo ros config export --private
```

#### Full

Add the `-f` or `--full` option to include the full configuration. The full configuration will be anything in the default OS configuration, the `/var/lib/rancher/conf/cloud-config.d/boot.yml` and the `/var/lib/rancher/conf/cloud-config.yml` files. None of the certificates or private keys will be shown unless the `-p` flag is included.

```bash
$ sudo ros config export --full
```

### Merge

The `merge` command will merge in parts of a configuration fragment to the existing configuration file.

```bash
$ sudo ros config merge << "EOF"
rancher: 
  network:
    dns:
      nameservers:
       - 8.8.8.8
       - 8.8.4.4
EOF
```

