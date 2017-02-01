---
title: Networking in Rancher
layout: rancher-default-v1.4
version: v1.4
lang: en
#redirect_from:
#  - /rancher/latest/en/rancher-services/networking/
---

## Networking
---

Rancher offers users multiple choices of networking when launching containers. Let's first understand what these different options mean.

### Networking options
#### None
Let's start with the simplest option, `none`. This means the container is launched with no networking enabled. This is similar to launching a container from command line with the option `--net=none`.

> Output of `ip addr` or `ifconfig` commands inside the container do not show any network interfaces except the loopback(`lo`).

#### Host
When a container is launched with `host` networking, it has access to all the networking interfaces available to host. The container and the host both share the same networking resources.

> Output of `ip addr` or `ifconfig` commands inside the container and the host show the same networking interfaces.

#### Bridge
Using `bridge` option means, the container is launched on the docker's default bridge. By default it is `docker0` unless the system administrator has decided to call it something else.

> Output of `ip addr` or `ifconfig` commands inside the container shows one network interface (`eth0`) along with the loopback interface(`lo`). The IP address of the network interface would be one from the docker's subnet. The default subnet used by docker is `172.17.0.0/16`.

#### Container
When one container wants to access the network resources of another container, this option is used. The newly launched container would be able access all the network resources of the other container.

> Output of `ip addr` or `ifconfig` commands inside both the containers show the same networking interfaces. The actual IP address depends on the network mode of the original container. If the original container had `bridge` mode, then the IP address would be in the docker's subnet.

#### Managed
This is the Rancher managed overlay network where containers launched on different hosts in the same environment can "magically" talk to each other. Currently Rancher offers two types of "managed" overlay networking options, IPsec and VXLAN.

> Output of `ip addr` or `ifconfig` commands inside the container shows one network interface (`eth0`) along with the loopback interface. The IP address of the network interface would be one from Rancher's managed subnet (default: `10.42.0.0/16`)

### Adoption of CNI (Container Network Interface) in Rancher

Rancher implements a [CNI](https://github.com/containernetworking/cni) framework, which allows you to use different network drivers within Rancher. To leverage our CNI framework, your [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments) will need to have the **Network Services** infrastructure service deployed. By default, all [environment templates]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#what-is-an-environment-template) have the **Network Services** enabled.

Besides the **Network Services** infrastructure service, you select which type of networking plugin/driver that you'd like your services to use. In our default environment templates, we have enabled **IPsec** network driver to create a simple and secure overlay network using IPsec tunneling.


#### Launching containers using `managed` network

##### UI & Rancher CLI
When a network driver is deployed into your environment, it automatically creates a default network. Any services using the `managed` network will be using this default network. By default, all services launched through the UI or Rancher CLI will be using the `managed` network. Besides selecting the `managed` network when starting a service, you could directly select a network based on the name of the network driver.

##### Launching a container with `managed` network
```
rancher run ubuntu:14.04.3
```

##### Using native docker CLI

For any containers launched directly from the Docker CLI, an extra label `--label io.rancher.container.network=true` can be used to select the `managed` network. Without this label, containers launched from the Docker CLI will be using the `bridge` network.

##### Start a container with both `bridge` and `managed` networks:
```
docker run --label io.rancher.container.network=true ubuntu:14.04.3
```

##### Start a container with only `managed` network:
```
docker run --net=none --label io.rancher.container.network=true ubuntu:14.04.3
```

> **Note:** For any containers relying on any networking launched from a network driver (i.e. `managed` or based on the name of the network driver), if the network infrastructure service (e.g. `ipsec`) is deleted, then the networking will fail for that container.

Most of Rancher's features, such as load balancers or DNS service, require the service to be in the `managed` network, but are not network driver dependent.


#### Differences from previous releases
When using Rancher's IPsec networking before **1.2** release, a container would be assigned both a Docker bridge IP (172.17.0.0/16) and a Rancher managed IP (10.42.0.0/16) on the default docker0 bridge. But with adoption of the CNI framework, any container launched in `managed` network will have **only one** IP address, from the Rancher's subnet (`10.42.0.0/16`). By default, all containers within the same environment are reachable via the managed network.

If you are facing issues with cross host communication, please refer to our troubleshooting [documentation]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/faqs/troubleshooting/#cross-host-communication).

#### Implications of using CNI

The Rancher managed IP address will not be present in Docker metadata and as such will not appear in the result of a Docker "inspect." This sometimes causes incompatibilities with certain tools that require a Docker bridge IP. Also the published port information is not available in the output of `docker ps` command. We are already working with the Docker community to make sure a future version of Docker can handle overlay networks more cleanly.

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
      - network_address: $SUBNET
      dns:
      - 169.254.169.250
      dns_search:
      - rancher.internal
    cni_config:
      '10-rancher.conf':
        name: rancher-cni-network
        type: rancher-bridge
        bridge: $DOCKER_BRIDGE
        bridgeSubnet: $SUBNET
        logToFile: /var/log/rancher-cni.log
        isDebugLevel: ${RANCHER_DEBUG}
        isDefaultGateway: true
        hostNat: true
        hairpinMode: true
        mtu: ${MTU}
        linkMTUOverhead: 98
        ipam:
          type: rancher-cni-ipam
          logToFile: /var/log/rancher-cni.log
          isDebugLevel: ${RANCHER_DEBUG}
          routes:
          - dst: 169.254.169.250/32
```

#### Name

The name of the network driver.

#### Default Network
The `default_network` defines options for the networking in the environment.

##### Name

The name of the default network can be used when selecting a network mode for a service.

##### Host Ports

By default, ports on a host are allowed to be published, but you can create a network that does not allow publishing ports on the host.

##### Subnets

You can select the network addresses for the subnet of the managed overlay network.

##### DNS && DNS Search

The values in DNS and DNS Search  will be autopopulated in the containers.

#### CNI configuration

For the network driver, you can set the CNI configuration within the `cni_config`. The example above shows the CNI configuration for Rancher's IPsec infrastructure service.

Most of the options specified in the CNI config are generic except a few which are specific to Rancher's CNI plugin implementation. This configuration can be customized by third party CNI plugin providers when they are integrating with Rancher.

##### bridge

Specify the bridge name to be used by the CNI plugin. This is a generic CNI bridge plugin option.

> For the "Rancher IPsec" plugin, the default is `docker0`

##### bridgeSubnet

The subnet to use with this network plugin. This is Rancher specific option.

> For the "Rancher IPsec" plugin, the default network is `10.42.0.0/16`. If you would like to use a different subnet other than this, this configuration option needs to be customized when creating a new environment template which is later used to deploy a new environment with the customized subnet.

##### mtu

Different cloud providers have different MTU values in their networks. This option allows you to customize it to your needs. This is also a Rancher specific option.

> Rancher's IPsec overlay network has an overhead of 98 bytes.
> `MTU of the container's network interface = MTU of the network - 98`

> For example, if your cloud providers MTU is 1200 bytes then you would see an MTU of 1102 (1200 - 98 =) inside the container when you type `ip addr` or `ifconfig`