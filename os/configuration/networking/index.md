---
title: Configuring RancherOS Networking
layout: os-default

---

## Configuring RancherOS Networking
---

There are two ways to configure networking on RancherOS.

You can change the networking settings by using `ros config` to set different keys within the `rancher.network` key. Anything set using this command will have its change saved in the `/var/lib/rancher/conf/cloud-config.yml` file. Changes will only take affect after you reboot. To learn more information about configuring the networking settings by using `ros config`, please refer to our [`ros config`]({{site.baseurl}}/os/rancheros-tools/ros/config) docs. 

Alternatively, you can use a [cloud config]({{site.baseurl}}/os/cloud-config) file to set up how the network is configured. Cloud config is applied to the RancherOS instance when RancherOS starts. If you need to make changes to the networking after you've already passed the cloud config file, you can use `ros config` to make changes.

We'll provide some examples using both the `ros config` or setting it through the `/var/lib/rancher/conf/cloud-config.yml` file.

### DNS

Using `ros config`, you can set the `nameservers`, and `search`, which directly map to the fields of the same name in `/etc/resolv.conf`.

```bash
$ sudo ros config set rancher.network.dns.search "['mydomain.com','example.com']"
$ sudo ros config get rancher.network.dns.search
- mydomain.com
- example.com
```

If you wanted to configure the DNS through the cloud config file, you'll need to place DNS configurations within the `rancher` key.

```yaml
#cloud-config

#Remember, any changes for rancher will be within the rancher key
rancher:
  network:
    dns:
      search: 
        - mydomain.com
        - example.com
```

### Interfaces

Using `ros config`, you can configure specific interfaces. Wildcard globbing is supported so `eth*` will match `eth1` and `eth2`.  The available options you can configure are `address`, `gateway`, `mtu`, and `dhcp`.

```bash
$ sudo ros config set rancher.network.interfaces.eth1.address 172.68.1.100/24
$ sudo ros config set rancher.network.interfaces.eth1.gateway 172.68.1.1
$ sudo ros config set rancher.network.interfaces.eth1.mtu 1500
$ sudo ros config set rancher.network.interfaces.eth1.dhcp false
```

If you wanted to configure the interfaces through the cloud config file, you'll need to place interface configurations within the `rancher` key.

```yaml
#cloud-config

#Remember, any changes for rancher will be within the rancher key
rancher:
  network:
    interfaces:
      eth1:
        address: 172.68.1.100/24
        gateway: 172.68.1.1
        mtu: 1500
        dhcp: false
```

### Multiple NICs

If you want to configure one of multiple network interfaces, you can specify the MAC address of the interface you want to configure.

Using `ros config`, you can specify the MAC address of the NIC you want to configure as follows:

```bash
$ sudo ros config set rancher.network.interfaces.”mac=ea:34:71:66:90:12:01”.dhcp true
```

Alternatively, you can place the MAC address selection in your cloud config file as follows:

```yaml
#cloud-config

#Remember, any changes for rancher will be within the rancher key
rancher:
  network:
    interfaces:
      "mac=ea:34:71:66:90:12:01":
         dhcp: true
```

### NIC bonding

You can aggregate several network links into one virtual link for redundancy and increased throughput. For example:

```yaml
#cloud-config
rancher:
  network:
    interfaces:
      bond0:
        addresses:
        - 192.168.101.33/31
        - 10.88.23.129/31
        gateway: 192.168.101.32
        bond_opts:
          downdelay: "200"
          lacp_rate: "1"
          miimon: "100"
          mode: "4"
          updelay: "200"
          xmit_hash_policy: layer3+4
        post_up:
        - ip route add 10.0.0.0/8 via 10.88.23.128
      mac=0c:c4:d7:b2:14:d2:
        bond: bond0
      mac=0c:c4:d7:b2:14:d3:
        bond: bond0
```

In this example two physical NICs (with MACs `0c:c4:d7:b2:14:d2` and `0c:c4:d7:b2:14:d3`) are aggregated into a virtual one `bond0`.

### Proxy settings

HTTP proxy settings can be set directly under the `network` key. This will automatically configure proxy settings for both Docker and System Docker.

```yaml
#cloud-config
rancher:
  network:
    http_proxy: https://myproxy.example.com
    https_proxy: https://myproxy.example.com
    no_proxy: localhost,127.0.0.1
```

> **Note:** System Docker proxy settings will not be applied until after a reboot.

To add the `HTTP_PROXY`, `HTTPS_PROXY`, and `NO_PROXY` environment variables to a system service, specify each under the `environment` key for the service.

```yaml
#cloud-config
rancher:
  services:
    myservice:
      ...
      environment:
      - HTTP_PROXY
      - HTTPS_PROXY
      - NO_PROXY
```
