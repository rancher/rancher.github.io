---
title: Configuring RancherOS
layout: os-default

---

## Configuring RancherOS
---
The configuration of RancherOS is derived from two sources.

1. RancherOS ships with a default configuration. The default configuration cannot be changed, but it can be extended or overridden by [cloud-config file]({{site.baseurl}}/os/cloud-config).

2. [Cloud-config]({{site.baseurl}}/os/cloud-config) extends and overrides RancherOS default config. Cloud-config is obtained on boot from several sources by the cloud-init program running as a system container inside RancherOS.  Additionally the cloud-config is read from disk if you wish to make local changes.

As a convenience we provide the `ros config` command which makes it easy to modify the cloud-config on disk.

> **Note:** For any changes made with `sudo ros config`, you must reboot for them to take effect. 

### Getting Values 

You can easily get any value that's been set in the `/var/lib/rancher/conf/cloud-config.yml` file. Let's see how easy it is to get the DNS configuration of the system.

```
$ sudo ros config get rancher.network.dns.nameservers
- 8.8.8.8
- 8.8.4.4
```

### Setting Values 

You can set values in the `/var/lib/rancher/conf/cloud-config.yml` file.

Setting a list in the `/var/lib/rancher/conf/cloud-config.yml`

```
$ sudo ros config set rancher.network.dns.nameservers "['8.8.8.8','8.8.4.4']"
```

Setting a simple value in the `/var/lib/rancher/conf/cloud-config.yml`

```
$ sudo ros config set rancher.docker.tls true
```

### Reviewing the RancherOS configuration

You can export the existing configuration from `/var/lib/rancher/conf/cloud-config.yml`. By default, only changes from the default values will be exported. If you run the command without any options, it will output into the shell what is in the `/var/lib/rancher/conf/cloud-config.yml` file.

#### Outputting the Configuration to a File

You can export your configuration directly to a file using `-o` or `--output` and specifying the name and location of where you want the file to be exported to. 

```
$ sudo ros config export -o localcloudconfig.yml
```

#### Exporting Certificates and Private Keys

By default, certificates and private keys are not included in the export, but can be added by adding in the `-p` or `--private` option. The private information is located at `/var/lib/rancher/conf/cloud-config.d/private.yml`.

#### Viewing the entire RancherOS configuration

You can view the entire RancherOS configuration in its entirety by typing `sudo ros config export --full`. The full configuration will be anything in the default OS configuration, the `/var/lib/rancher/conf/cloud-config.d/boot.yml` and the `/var/lib/rancher/conf/cloud-config.yml` files. None of the certificates or private keys will be shown unless the `-p` flag is included.
