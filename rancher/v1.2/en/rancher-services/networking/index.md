---
title: Networking in Rancher
layout: rancher-default-v1.2
version: v1.2
lang: en
redirect_from:
  - /rancher/v1.2/zh/rancher-services/networking/
---

## Networking
---

Rancher implements a [CNI](https://github.com/containernetworking/cni) framework, which provides the ability to select different network drivers within Rancher. To leverage the CNI framework, an [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments) is required to use the **Network Services** infrastructure service deployed. By default, all [environment templates]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#what-is-an-environment-template) have the **Network Services** enabled.

Besides the **Network Services** infrastructure service,  select which type of networking plugin/driver that you'd like your services to use. In our default environment templates, we have enabled **IPsec** network driver to create a simple and secure overlay network using IPsec tunneling.

When a network driver is launched into the environment, it automatically creates a default network. Any services using the `managed` network will be using this default network.

### Differences from previous releases
When using Rancher's IPsec networking prior to the **1.2** release, a container in the `managed` network would be assigned with both a Docker bridge IP (`172.17.0.0/16`) and a Rancher managed IP (`10.42.0.0/16`) on the default `docker0` bridge. With the adoption of the CNI framework, any container launched in `managed` network will only have the Rancher managed IP (default subnet: `10.42.0.0/16`).

### Implications of using CNI

The Rancher managed IP address will not be present in Docker metadata, which means it will not appear in `docker inspect`. Certain images may not work if it requires a Docker bridge IP. Any ports published on a host will not be shown in `docker ps` as Rancher manages separate IPtables for the networking.

### Communication Between Containers

By default, all containers within the same environment are reachable via the `managed` network. 

If you are facing issues with cross host communication, please refer to our troubleshooting [documentation]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/faqs/troubleshooting/#cross-host-communication).

### Networking options

Services launched in the UI can change their networking options by navigating to the **Networking** tab when adding a service. In the UI, all options are available for services except for `container` networking. In order to use `container` networking for a service, you can use either Rancher CLI, Rancher Compose or Docker CLI to launch the container.

#### Managed
By default, containers launched in Rancher using the UI or [Rancher CLI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cli/) use the `managed` network, which uses Rancher's managed overlay network. All containers in the `managed` network are able to communicate with each other regardless of which host the container was deployed on. Most of Rancher's features, such as load balancers or DNS service, require the service to be in the `managed` network.

Inside the container, the `ip addr` or `ifconfig` commands will show one network interface (i.e. `eth0`) along with the loopback interface (i.e. `lo`). The IP address of the network interface would be one from Rancher's managed subnet. The default subnet is `10.42.0.0/16`, but can be configured to your own subnet.

> **Note:** For any containers relying on any networking launched from a network driver (i.e. `managed` or based on the name of the network driver), if the network infrastructure service (e.g. `ipsec`) is deleted, then the networking will fail for that container.

##### Containers created with the Docker CLI
For any containers launched through the Docker CLI, an extra label `--label io.rancher.container.network=true` can be used to launch the container into the `managed` network. Without this label, containers launched from the Docker CLI will be using the `bridge` network.

If you want to launch a container in **only** the `managed` network, you'd need to add `--net=none` and `--label io.rancher.container.network=true` for the container to be started without the `bridge` network.

#### None
When a container is launched with `none` for networking, the container is launched with no networking enabled. This is equivalent to launching a container from the Docker command line with the option `--net=none`.

Inside the container, the `ip addr` or `ifconfig` commands will not show any network interfaces except for the loopback (i.e. `lo`).

#### Host
When a container is launched with `host` networking, the container is launched with the same networking interfaces available to the host. This is equivalent to launching a container from the Docker command line with the option `--net=host`.

Inside the container, the `ip addr` or `ifconfig` commands will show the same networking interfaces as the host.

#### Bridge
When a container is launched with `bridge` networking, the container is launched on Docker's default bridge. By default, it is `docker0` unless the system administrator has changed it on the host. This is equivalent to launching a container from the Docker command line with the option `--net=bridge`.

Inside the container, the `ip addr` or `ifconfig` commands will show one network interface (i.e. `eth0`) along with the loopback interface (i.e. `lo`). The IP address of the network interface will be one from the Docker's subnet. The default subnet used by Docker is `172.17.0.0/16`.

#### Container
When a container is launched with networking from another container, the container is launched using the networking resources of the other container. This is equivalent to launching a container from the Docker command line with the option `--net=container:<CONTAINER_NAME>`.

Inside the container, the `ip addr` or `ifconfig` commands will show the same networking interfaces as the container that was selected. The actual IP address depends on the network mode of the original container. If the original container had `bridge` mode, then the IP address would be in the docker's subnet.

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

> For example, if your cloud provider's MTU is 1200 bytes then you would see an MTU of 1102 (= 1200 - 98) inside the container when you type `ip addr` or `ifconfig`
