---
title: Storage Service
layout: rancher-default-v1.0
version: v1.0
lang: en
---

## Storage Service
---

In the [Rancher catalog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/), Rancher provides storage services that are capable of exposing volumes to containers. Currently, the storage services are pre-fixed with `Convoy` in the catalog. 

### Prerequisites
* You have the underlying storage system properly deployed and accessible to Rancher services

### Limitations

* Only one Convoy stack can be deployed once per one Rancher [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/environments/). 
* Users are able to create service/containers and models exactly the same behavior as if you deployed a container using native Docker 1.10.3 commands. When creating a new container, the following rules apply:
    * If the volume name  (e.g. __foo__:/path/in/container) is specified with a driver name (e.g. Convoy-Gluster), the container will be deployed on one of the hosts that belong to the Convoy-Gluster Storage Pool with a new volume "foo" created.
    * If the volume name (e.g. __foo__:/path/in/container) is specified with or without a driver name and "foo" exists in Rancher, the container will be launched on a host from that Storage Pool that has access to "foo".
    * If the volume name  (e.g. __foo__:/path/in/container) is specified with __NO__ driver name and "foo" __*DOES NOT*__ exist in Rancher, it will be created as a __local__ disk volume for that container.  At this point, normal scheduling rules apply. 

### Setting up the Storage Service

From the **Catalog** tab, select one of the **Convoy** services. 

By default, we've auto-populated the required fields. Edit the fields to your desired choices. After filling in the form, click on **Create**. 

### Viewing Storage Pools

After your storage service has been launched, a storage pool has been created and is viewable in **Infrastructure** -> **Storage Pools**. You will be able to see all the Convoy storage services that are running in your environment. The name of the storage pool is derived from the name of the stack.

In each storage pool, the hosts that have the storage service running will be listed. Besides the list of hosts, the lists of volumes used in the storage pool is also listed. For each volume, you can see the name of the volume (i.e. the name of the volume on the host(s)), and the mounts of each volume. For each mount, there is the container name and the directory path inside the container. 

### Using the Storage Service in the UI  

After your storage service has been launched, a storage pool has been created and is viewable in **Infrastructure** -> **Storage Pools**. [Services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/adding-services/) can start using the shared storage. In the **Volumes** tab, provide a **volume** and a **volume driver**. The **volume** will be in the same syntax as Docker, `<volume_name_on_host>:</path/in/container>`. Docker volumes default to mount in read-write mode, but you can set it to be mounted read-only by adding the `:ro` at the end of the volume. The **volume driver** will be the name of the storage pool, that was created after launching the Convoy storage service. 

### Using the Storage Service with Rancher-Compose

After the storage service has been launched, you can start using the storage service as a `volume_driver` in the `docker-compose.yml`. The `volume_driver` would be the name of the storage pool.

```yaml
test:
  tty: true
  image: ubuntu:14.04.3
  stdin_open: true
  volumes:
  - volume_name_on_host:/path/in/container
  volume_driver: <name_of_storage_pool>
```

#### Adding Volumes to Storage Pools

A volume can be added to a storage pool with two methods:

1. Upon starting a service that has a volume and a volume driver, that is the storage service. When the service is started, the volume is created on all hosts and mounted in all containers. The volume is also added to the storage pool in Rancher.
2. In **Infrastructure** -> **Storage Pools**, click on **Add Volume**. Provide the name of the volume for the specified storage pool. 


