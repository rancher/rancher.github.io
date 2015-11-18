---
title: API
layout: rancher-default
---

## Resource Types

<br>

[account]({{site.baseurl}}/rancher/api/account/)|
---|
Collection Test Description |

<br><br>
<br>

[addOutputsInput]({{site.baseurl}}/rancher/api/addOutputsInput/)|
---|
 |

<br><br>
<br>

[apiKey]({{site.baseurl}}/rancher/api/apiKey/)|
---|
An API Key provides access to the Rancher API if access control has been turned on. The access key and secret key pair are created per environment and can be used to directly call the API or used with [rancher-compose]({{site.baseurl}}/rancher/rancher-compose). |

<br><br>
<br>

[certificate]({{site.baseurl}}/rancher/api/certificate/)|
---|
A certificate is used to add in SSL termination to load balancers. |

<br><br>
<br>

[cluster]({{site.baseurl}}/rancher/api/cluster/)|
---|
Collection Test Description |

<br><br>
<br>

[container]({{site.baseurl}}/rancher/api/container/)|
---|
A container is a representation of a Docker container on a host. |

<br><br>
<br>

[containerEvent]({{site.baseurl}}/rancher/api/containerEvent/)|
---|
Collection Test Description |

<br><br>
<br>

[containerExec]({{site.baseurl}}/rancher/api/containerExec/)|
---|
Collection Test Description |

<br><br>
<br>

[credential]({{site.baseurl}}/rancher/api/credential/)|
---|
Collection Test Description |

<br><br>
<br>

[dnsService]({{site.baseurl}}/rancher/api/dnsService/)|
---|
A "dnsService" in the API is referred to as a Service Alias in the UI and the Rancher documentation. In the API documentation, we'll use the UI terminology. A service alias allows the ability to add a DNS record for your services to be discovered. |

<br><br>
<br>

[dockerBuild]({{site.baseurl}}/rancher/api/dockerBuild/)|
---|
Collection Test Description |

<br><br>
<br>

[environment]({{site.baseurl}}/rancher/api/environment/)|
---|
An "environment" in the API is referred to as a stack in the UI and the Rancher documentation. In the API documentation, we'll use the UI terminology. A Rancher stack mirrors the same concept as a docker-compose project.  It represents a group of services that make up a typical application or workload. |

<br><br>
<br>

[environmentUpgrade]({{site.baseurl}}/rancher/api/environmentUpgrade/)|
---|
Collection Test Description |

<br><br>
<br>

[externalDnsEvent]({{site.baseurl}}/rancher/api/externalDnsEvent/)|
---|
Collection Test Description |

<br><br>
<br>

[externalEvent]({{site.baseurl}}/rancher/api/externalEvent/)|
---|
Collection Test Description |

<br><br>
<br>

[externalHostEvent]({{site.baseurl}}/rancher/api/externalHostEvent/)|
---|
 |

<br><br>
<br>

[externalService]({{site.baseurl}}/rancher/api/externalService/)|
---|
An external service allows the ability to add any IP or hostname as a service to be discovered as a service. |

<br><br>
<br>

[externalServiceEvent]({{site.baseurl}}/rancher/api/externalServiceEvent/)|
---|
 |

<br><br>
<br>

[externalStoragePoolEvent]({{site.baseurl}}/rancher/api/externalStoragePoolEvent/)|
---|
Collection Test Description |

<br><br>
<br>

[externalVolumeEvent]({{site.baseurl}}/rancher/api/externalVolumeEvent/)|
---|
Collection Test Description |

<br><br>
<br>

[globalLoadBalancer]({{site.baseurl}}/rancher/api/globalLoadBalancer/)|
---|
Collection Test Description |

<br><br>
<br>

[host]({{site.baseurl}}/rancher/api/host/)|
---|
Hosts are the most basic unit of resource within Rancher and is represented as any Linux server, virtual or physical, with the following minimum requirements. <br> <br> * Any modern Linux distribution that supports Docker 1.6+. <br> * Must be able to communicate with the Rancher server via http or https through the pre-configured port (Default is 8080). <br> * Must be routable to any other hosts belonging to the same environment to leverage Rancher's cross-host networking for Docker containers.<br> <br> Rancher also supports Docker Machine and allows you to add your host via any of its supported drivers. |

<br><br>
<br>

[hostAccess]({{site.baseurl}}/rancher/api/hostAccess/)|
---|
Collection Test Description |

<br><br>
<br>

[identity]({{site.baseurl}}/rancher/api/identity/)|
---|
Collection Test Description |

<br><br>
<br>

[image]({{site.baseurl}}/rancher/api/image/)|
---|
Collection Test Description |

<br><br>
<br>

[instance]({{site.baseurl}}/rancher/api/instance/)|
---|
Collection Test Description |

<br><br>
<br>

[instanceLink]({{site.baseurl}}/rancher/api/instanceLink/)|
---|
Collection Test Description |

<br><br>
<br>

[ipAddress]({{site.baseurl}}/rancher/api/ipAddress/)|
---|
Collection Test Description |

<br><br>
<br>

[label]({{site.baseurl}}/rancher/api/label/)|
---|
Collection Test Description |

<br><br>
<br>

[loadBalancer]({{site.baseurl}}/rancher/api/loadBalancer/)|
---|
 |

<br><br>
<br>

[loadBalancerConfig]({{site.baseurl}}/rancher/api/loadBalancerConfig/)|
---|
Collection Test Description |

<br><br>
<br>

[loadBalancerConfigListenerMap]({{site.baseurl}}/rancher/api/loadBalancerConfigListenerMap/)|
---|
Collection Test Description |

<br><br>
<br>

[loadBalancerHostMap]({{site.baseurl}}/rancher/api/loadBalancerHostMap/)|
---|
Collection Test Description |

<br><br>
<br>

[loadBalancerListener]({{site.baseurl}}/rancher/api/loadBalancerListener/)|
---|
Collection Test Description |

<br><br>
<br>

[loadBalancerService]({{site.baseurl}}/rancher/api/loadBalancerService/)|
---|
Rancher implements a managed load balancer using HAProxy that can be manually scaled to multiple hosts.  A load balancer can be used to distribute network and application traffic to individual containers by directly adding them or "linked" to a basic service.  A basic service that is "linked" will have all its underlying containers automatically registered as load balancer targets by Rancher. |

<br><br>
<br>

[loadBalancerTarget]({{site.baseurl}}/rancher/api/loadBalancerTarget/)|
---|
Collection Test Description |

<br><br>
<br>

[machine]({{site.baseurl}}/rancher/api/machine/)|
---|
 |

<br><br>
<br>

[mount]({{site.baseurl}}/rancher/api/mount/)|
---|
Collection Test Description |

<br><br>
<br>

[network]({{site.baseurl}}/rancher/api/network/)|
---|
Collection Test Description |

<br><br>
<br>

[password]({{site.baseurl}}/rancher/api/password/)|
---|
Collection Test Description |

<br><br>
<br>

[physicalHost]({{site.baseurl}}/rancher/api/physicalHost/)|
---|
Collection Test Description |

<br><br>
<br>

[port]({{site.baseurl}}/rancher/api/port/)|
---|
Collection Test Description |

<br><br>
<br>

[project]({{site.baseurl}}/rancher/api/project/)|
---|
A "project" in the API is referred to as an environment in the UI and the Rancher documentation. In the API documentation, we'll use the UI terminology.  All hosts and any Rancher resources (i.e. containers, load balancers, etc.) are created and belong to an [environment]({{site.baseurl}}/rancher/configuration/environments/).  Access control to who can view and manage these resources are then defined by the owner of the environment.  Rancher currently supports the capability for each user to manage and invite other users to their environment and allows for the ability to create multiple environments for different workloads.  For example, you may want to create a "dev" environment and a separate "production" environment with its own set of resources and limited user access for your application deployment. |

<br><br>
<br>

[projectMember]({{site.baseurl}}/rancher/api/projectMember/)|
---|
An environment member is how a user can be a part of an environment. |

<br><br>
<br>

[pullTask]({{site.baseurl}}/rancher/api/pullTask/)|
---|
Collection Test Description |

<br><br>
<br>

[register]({{site.baseurl}}/rancher/api/register/)|
---|
Collection Test Description |

<br><br>
<br>

[registrationToken]({{site.baseurl}}/rancher/api/registrationToken/)|
---|
Collection Test Description |

<br><br>
<br>

[registry]({{site.baseurl}}/rancher/api/registry/)|
---|
A registry is where image repositories are hosted. The repository can be either from DockerHub, Quay.io, or a custom private registry. |

<br><br>
<br>

[registryCredential]({{site.baseurl}}/rancher/api/registryCredential/)|
---|
Collection Test Description |

<br><br>
<br>

[schema]({{site.baseurl}}/rancher/api/schema/)|
---|
This is the schema resource |

<br><br>
<br>

[service]({{site.baseurl}}/rancher/api/service/)|
---|
Rancher adopts the standard Docker Compose terminology for services and defines a basic service as one or more containers created from the same Docker image.  Once a service (consumer) is linked to another service (producer) within the same stack, a DNS record mapped to each container instance is automatically created and discoverable by containers from the "consuming" service. Other benefits of creating a service under Rancher include":" <br><br> * Service HA - the ability to have Rancher automatically monitor container states and maintain a service's desired scale. <br> * Health Monitoring - the ability to set basic monitoring thresholds for container health. |

<br><br>
<br>

[serviceConsumeMap]({{site.baseurl}}/rancher/api/serviceConsumeMap/)|
---|
Collection Test Description |

<br><br>
<br>

[serviceEvent]({{site.baseurl}}/rancher/api/serviceEvent/)|
---|
Collection Test Description |

<br><br>
<br>

[serviceExposeMap]({{site.baseurl}}/rancher/api/serviceExposeMap/)|
---|
Collection Test Description |

<br><br>
<br>

[setting]({{site.baseurl}}/rancher/api/setting/)|
---|
Collection Test Description |

<br><br>
<br>

[snapshot]({{site.baseurl}}/rancher/api/snapshot/)|
---|
Collection Test Description |

<br><br>
<br>

[statsAccess]({{site.baseurl}}/rancher/api/statsAccess/)|
---|
Collection Test Description |

<br><br>
<br>

[storagePool]({{site.baseurl}}/rancher/api/storagePool/)|
---|
Collection Test Description |

<br><br>
<br>

[subscribe]({{site.baseurl}}/rancher/api/subscribe/)|
---|
 |

<br><br>
<br>

[typeDocumentation]({{site.baseurl}}/rancher/api/typeDocumentation/)|
---|
Collection Test Description |

<br><br>
<br>

[volume]({{site.baseurl}}/rancher/api/volume/)|
---|
Collection Test Description |

<br><br>

