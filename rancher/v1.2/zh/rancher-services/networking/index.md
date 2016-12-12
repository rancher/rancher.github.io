---
title: Networking in Rancher
layout: rancher-default-v1.2
version: v1.2
lang: zh
redirect_from:
  - /rancher/latest/zh/rancher-services/networking/
---

## Networking
---

Rancher implements a [CNI](https://github.com/containernetworking/cni) framework, which allows you to use different network drivers within Rancher. To leverage our CNI framework, your [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments) will need to have the **Network Services** infrastructure service deployed. By default, all [environment templates]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#what-is-an-environment-template) have the **Network Services** enabled.

Besides the **Network Services** infrastructure service, you select which type of networking that you'd like your services to use. In our default environment templates, we have enabled **IPsec** network driver to create a simple and secure overlay network using IPsec tunneling.

When a network driver is deployed into your environment, it automatically creates a default network. Any services using the `managed` network will be using this default network. By default, all services launched through the UI or CLI will be using the `managed` network. Besides selecting the `managed` network when starting a service, you could directly select a network based on the name of the network driver.

For any containers launched directly from the Docker CLI, an extra label `--label io.rancher.container.network=true` can be used to select the `managed` network. Without this label, containers launched from the Docker CLI will be using the `host` network.

> **Note:** For any containers relying on any networking launched from a network driver (i.e. `managed` or based on the name of the network driver), if the network infrastructure service (e.g. `ipsec`) is deleted, then the networking will fail for that container.

Most of Rancher's features, such as load balancers or DNS service, require the service to be in the `managed` network, but are not network driver dependent.

Using Rancher's IPsec networking, a container will be assigned both a Docker bridge IP (172.17.0.0/16) and a Rancher managed IP (10.42.0.0/16) on the default docker0 bridge. Containers within the same environment are then routable and reachable via the managed network.

> **Note:** The Rancher managed IP address will not be present in Docker metadata and as such will not appear in the result of a Docker "inspect." This sometimes causes incompatibilities with certain tools that require a Docker bridge IP. We are already working with the Docker community to make sure a future version of Docker can handle overlay networks more cleanly.

If you are facing issues with cross host communication, please refer to our troubleshooting [documentation]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/faqs/troubleshooting/#cross-host-communication).

### Example of Rancher's IPSec Network Service

To leverage the CNI framework, you can enable a network infrastructure service, which is created from a network driver in a yaml file. In the `network_driver` key of the yaml, there are several options that are defined.

Here is an example of Rancher's IPsec infrastructure service. The `network_driver` is configured in the `rancher-compose.yml` file.

```yaml
ipsec:
  network_driver:
    name: Rancher IPsec
    default_network:
      name: ipsec
      host_ports: true
      subnets:
      - network_address: '10.42.0.0/16'
      dns:
      - 169.254.169.250
      dns_search:
      - rancher.internal
    cni_config:
      '10-rancher.conf':
        name: rancher-cni-network
        type: rancher-bridge
        bridge: docker0
        bridgeSubnet: '10.42.0.0/16'
        isDefaultGateway: true
        hairpinMode": true
        hostNat: true
        hairpinMode: true
        linkMTUOverhead: 98
        ipam:
          type: rancher-cni-ipam
          logToFile: /var/log/rancher-ipam.log
```

#### Default Network
The `default_network` defines options for the networking in the environment.

##### Name

The name of the default network can be used when selecting a network mode for a service.

#### Host Ports

By default, ports on a host are allowed to be published, but you can create a network that does not allow publishing ports on the host.

#### Subnets

You can select the network addresses for the subnet of the managed overlay network.

#### DNS && DNS Search

The values in DNS and DNS Search  will be autopopulated in the containers.

### CNI configuration

For the network driver, you can set the CNI configuration within the `cni_config`. The example above shows the CNI configuration for Rancher's IPsec infrastructure service.

### Network Metadata

The metadata in the network driver populates the metadata in the network created in Rancher.
