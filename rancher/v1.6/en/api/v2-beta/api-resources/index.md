---
title: API Resources
layout: rancher-api-v2-beta-default-v1.6
version: v1.6
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.6/zh/api/v2-beta/api-resources/
---

## API Resources


<br>

[Account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account/)|
---|
All resources in Rancher are owned or created by an account. |

<br>

[Agent]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/agent/)|
---|
 |

<br>

[ApiKey]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/apiKey/)|
---|
An API Key provides access to the Rancher API if access control has been turned on. The access key and secret key pair are created per environment and can be used to directly call the API or used with [rancher-compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/rancher-compose). |

<br>

[AuditLog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/auditLog/)|
---|
The audit log provides a list of API requests. It logs the environment as well as the API call. After access control is enabled, it also logs the user. |

<br>

[Azureadconfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/azureadconfig/)|
---|
 |

<br>

[Certificate]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/certificate/)|
---|
A certificate is used to add in SSL termination to load balancers. |

<br>

[ClusterMembership]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/clusterMembership/)|
---|
 |

<br>

[ConfigItem]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/configItem/)|
---|
 |

<br>

[ConfigItemStatus]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/configItemStatus/)|
---|
 |

<br>

[Container]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/container/)|
---|
A container is a representation of a Docker container on a host. |

<br>

[Databasechangelog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/databasechangelog/)|
---|
 |

<br>

[Databasechangeloglock]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/databasechangeloglock/)|
---|
 |

<br>

[DnsService]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/dnsService/)|
---|
A "dnsService" in the API is referred to as a Service Alias in the UI and the Rancher documentation. In the API documentation, we'll use the UI terminology. A service alias allows the ability to add a DNS record for your services to be discovered. |

<br>

[ExtensionPoint]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/extensionPoint/)|
---|
 |

<br>

[ExternalHandler]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/externalHandler/)|
---|
 |

<br>

[ExternalHandlerExternalHandlerProcessMap]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/externalHandlerExternalHandlerProcessMap/)|
---|
 |

<br>

[ExternalHandlerProcess]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/externalHandlerProcess/)|
---|
 |

<br>

[ExternalService]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/externalService/)|
---|
An external service allows the ability to add any IP or hostname as a service to be discovered as a service. |

<br>

[HaConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/haConfig/)|
---|
 |

<br>

[HaConfigInput]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/haConfigInput/)|
---|
 |

<br>

[Host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host/)|
---|
Hosts are the most basic unit of resource within Rancher and is represented as any Linux server, virtual or physical, with the following minimum requirements. <br> <br> * Any modern Linux distribution with a [supported version of Docker]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#supported-docker-versions). <br> * Must be able to communicate with the Rancher server via http or https through the pre-configured port (Default is 8080). <br> * Must be routable to any other hosts belonging to the same environment to leverage Rancher's cross-host networking for Docker containers.<br> <br> Rancher also supports Docker Machine and allows you to add your host via any of its supported drivers. |

<br>

[HostApiProxyToken]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/hostApiProxyToken/)|
---|
 |

<br>

[HostTemplate]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/hostTemplate/)|
---|
 |

<br>

[Identity]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/identity/)|
---|
An identity is Rancher's representation of an object(i.e. `ldap_group`, `github_user`) when Rancher has turned on [access control]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/). The `externalId` in an identity is the unique identifier in the authentication system that represents the object. The role of an identity is always null unless it is being returned as the identity of a [projectMember]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/projectMember/). |

<br>

[Ldapconfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/ldapconfig/)|
---|
 |

<br>

[LoadBalancerService]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/loadBalancerService/)|
---|
Rancher implements a managed load balancer using HAProxy that can be manually scaled to multiple hosts. A load balancer can be used to distribute network and application traffic to individual containers by directly adding them or "linked" to a basic service. A basic service that is "linked" will have all its underlying containers automatically registered as load balancer targets by Rancher. |

<br>

[LocalAuthConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/localAuthConfig/)|
---|
 |

<br>

[Machine]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/machine/)|
---|
Machines are created whenever Rancher uses `docker-machine` to create hosts in Rancher. Adding any type of host through the UI that is not the custom command option is calling `docker-machine` and a machine entry will be created as well as a [host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host). |

<br>

[MachineDriver]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/machineDriver/)|
---|
 |

<br>

[Network]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/network/)|
---|
The networks available within Rancher that containers could be launched on. |

<br>

[NetworkDriver]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/networkDriver/)|
---|
A network driver is the |

<br>

[NetworkDriverService]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/networkDriverService/)|
---|
 |

<br>

[NetworkPolicyRuleWithin]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/networkPolicyRuleWithin/)|
---|
 |

<br>

[Openldapconfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/openldapconfig/)|
---|
 |

<br>

[ProcessDefinition]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/processDefinition/)|
---|
 |

<br>

[ProcessExecution]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/processExecution/)|
---|
 |

<br>

[ProcessInstance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/processInstance/)|
---|
 |

<br>

[ProcessPool]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/processPool/)|
---|
 |

<br>

[ProcessSummary]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/processSummary/)|
---|
 |

<br>

[Project]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/project/)|
---|
A "project" in the API is referred to as an environment in the UI and Rancher documentation. In the API documentation, we'll use the UI terminology. All hosts and any Rancher resources (i.e. containers, load balancers, etc.) are created and belong to an [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/). Access control to who can view and manage these resources are then defined by the owner of the environment. Rancher currently supports the capability for each user to manage and invite other users to their environment and allows for the ability to create multiple environments for different workloads. For example, you may want to create a "dev" environment and a separate "production" environment with its own set of resources and limited user access for your application deployment. |

<br>

[ProjectMember]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/projectMember/)|
---|
A "project member" in the API is referred to as an environment members in the UI and Rancher documentation. An environment member is a list of all of the members of the environment. An environment member is an [identity]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/identity). |

<br>

[ProjectTemplate]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/projectTemplate/)|
---|
 |

<br>

[PullTask]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/pullTask/)|
---|
 |

<br>

[RegistrationToken]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/registrationToken/)|
---|
 |

<br>

[Registry]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/registry/)|
---|
A registry is where image repositories are hosted. The repository can be either from DockerHub, Quay.io, or a custom private registry. |

<br>

[RegistryCredential]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/registryCredential/)|
---|
A registry credential is used to authenticate against a [registry]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/registry). |

<br>

[ResourceDefinition]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/resourceDefinition/)|
---|
 |

<br>

[ScheduledUpgrade]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/scheduledUpgrade/)|
---|
 |

<br>

[Secret]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/secret/)|
---|
 |

<br>

[Service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/service/)|
---|
Rancher adopts the standard Docker Compose terminology for services and defines a basic service as one or more containers created from the same Docker image. Once a service (consumer) is linked to another service (producer) within the same stack, a DNS record mapped to each container instance is automatically created and discoverable by containers from the "consuming" service. Other benefits of creating a service under Rancher include" |

<br>

[ServiceLog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/serviceLog/)|
---|
 |

<br>

[Setting]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/setting/)|
---|
 |

<br>

[Stack]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/stack/)|
---|
 |

<br>

[StorageDriver]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/storageDriver/)|
---|
 |

<br>

[StorageDriverService]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/storageDriverService/)|
---|
 |

<br>

[Task]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/task/)|
---|
 |

<br>

[TaskInstance]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/taskInstance/)|
---|
 |

<br>

[UserPreference]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/userPreference/)|
---|
 |

<br>

[Volume]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/volume/)|
---|
A volume can be associated to containers or storage pools. <br><br> * A container can have many volumes and containers are mapped to volumes the [mount]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/mount/) link on a container. <br> * A storage pool owns many volumes. The volume is only available to containers deployed on hosts that are part of the storage pool. When a volume is being created, you do not directly associate it to a storage pool. You will only need to specify a driver and during allocation, Rancher will resolve it to a storage pool. |

<br>

[VolumeTemplate]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/volumeTemplate/)|
---|
 |

