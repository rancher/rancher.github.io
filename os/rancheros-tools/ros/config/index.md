---
title: ROS Config
layout: os-default

---

## ROS Config
---
_In v0.3.1+, we changed the command from `rancherctl` to `ros`._

RancherOS state is controlled by a cloud config file. `ros config` is used to manipulate the configuration of the `rancher` section of the cloud config file. With v0.4.0+, we simplified the configuration of RancherOS to only run off of a cloud config file. In order to make changes using `ros config`, you must prefix changes with `rancher`. Prior to v0.4.0, `rancher` is not needed as a prefix.

Remember, all `ros` commands needs to be used with `sudo`. 

**For all changes to your configuration, you must reboot for them to take effect.**

### Sub commands
---
| Command  | Description                                     |
|----------|-------------------------------------------------|
| `get`      | Gets value                                       |
| `set`      | Sets a value                                     |
| `import`  | Import configuration from standard in or a file |
| `export`   | Export configuration                            |
| `merge`    | Merge configuration from standard in                 |



### Get
---
The `get` command gets a value from the `cloud-config-local.yml` file. Let's see how easy it is to get the DNS configuration of the system.

```sh
$ sudo ros config get rancher.network.dns.nameservers
- 8.8.8.8
- 8.8.4.4
```

### Set
---
The `set` command can set values in the `cloud-config-local.yml` file. 

Setting a list in the `cloud-config-local.yml`

```bash
$ sudo ros config set rancher.network.dns.nameservers '[8.8.8.8,8.8.4.4]'
```

Setting a simple value in the `cloud-config-local.yml`

```bash
$ sudo ros config set rancher.docker.tls true
```

### Import
---
The `import` command allows you to import configurations from a standard in or a file. When using `import`, the existing configuration in `cloud-config-local.yml` will be overridden. If you want to add information to the file, you'd need to use `ros config merge`.

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
The `export` command allows you to export your existing configuration from `cloud-config-local.yml`. By default, only changes from the default values will be exported. 

If you run the command without any options, it will output into the shell what is in the `cloud-config-local.yml` file.

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

Add the `-p` or `--private` option to include the certificates and private keys as part of the export. These keys are exported in addition to any changes made from the default value. 

```bash
$ sudo ros config export --private
```

#### Full

Add the `-f` or `--full` option to include the full configuration. The full configuration will be anything in the default OS configuration, the `cloud-config.yml` and the `cloud-config-local.yml` files. None of the certificates or private keys will be shown unless the `-p` flag is included.

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

