---
title: Persistent Storage Service in Rancher
layout: rancher-default-v1.2
version: v1.2
lang: en
redirect_from:
  - /rancher/v1.2/zh/rancher-services/storage-service/
---

## Storage Service
---

Rancher provides different storage services that are capable of exposing volumes to containers.

### Setting up the Storage Service

When setting up an [environment template]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#what-is-an-environment-template), you can select what storage services you'd like to use in your environment.

Alternatively, if you already have an environment set up, you can select and launch a storage service from the [catalog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/).

> **Note:** Some storage services may not be compatible with some container orchestration types (i.e. Kubernetes). Environment templates will restrict which ones are compatible based on orchestration, but all options are available from the catalog.

### Viewing Storage Drivers

After your storage service has been launched, a storage driver has been created and is viewable in **Infrastructure** -> **Storage**. You will be able to see all the storage drivers that are available in your environment. The name of the storage driver is derived from the name of the stack.

In each storage driver, the hosts that have the storage service running will be listed. Typically, this is all hosts in the environment. The lists of volumes and their states in the storage driver are also listed. For each volume, you can see the name of the volume (i.e. the name of the volume on the host(s)), and the mounts of each volume. For each mount, there is the container name and the directory path inside the container.

### Volume Scopes

With our storage service, we have volumes that can be scoped at different levels. Currently, only [Rancher Compose](#using-storage-drivers-with-rancher-compose) supports creating the different types of volumes. The UI only creates volumes that are environment scoped.

#### Stack Scoped

With a stack scoped volume, services referencing the same volume in a stack would share the same volume. A service outside the stack could not use the same volume.

In Rancher, stack scoped volumes are named with the stack name as a prefix to indicate which stack the volume is scoped to and suffixed with a random number to guarantee no duplication. When referencing the volume, you still use the original volume name. For example, if you create a volume called `foo` in `stackA`, the volume name in the UI and on your hosts will be `stackA_foo_<randomNumber>`, but to use the same volume in your service, you would use the name `foo`.  

#### Environment Scoped

With an environment scoped volume, services referencing the same volume in an environment would share the same volume. Services in different stacks could share the same volume. Currently, an environment scoped volume can only be created through the UI.

### Using Storage Drivers in the UI  

After your storage service has been launched and is `active`,  [services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/) can start using the shared storage. when creating a service, in the **Volumes** tab, provide a **volume** and a **volume driver**. The **volume** will be in the same syntax as Docker, `<volume_name>:</path/in/container>`. Docker volumes default to mount in read-write mode, but you can set it to be mounted read-only by adding the `:ro` at the end of the volume. The **volume driver** will be the name of the storage driver.

If the `<volume_name>` already exists in the storage driver, the same volume will be used if the volume meets the volume scope requirements.

#### Creating New Volumes

A volume can be created in 2 sections:

1. Upon creating a service, if the volume in the **Volumes** tab does not exist in the storage driver, then an environment scoped volume is created. If the volume already exists in the volume driver, a new volume will not be created.

2. In **Infrastructure** -> **Storage**, click on **Add Volume**. Provide the name of the volume and driver options if desired. This volume will be `inactive` until a service starts to use it.

### Using Storage Drivers with Rancher Compose

After the storage infrastructure services have been launched, you can start creating volumes. In our examples below, we are using the **Rancher NFS** storage service.

Volumes can be specified as part of a Docker Compose file under the `volumes` key. Each volume can be associated with one or more services in the same file. This functionality is only available when using a Compose file in v2 format.

```yaml
version: '2'
services:
  foo:
    image: busybox
    volumes:
    - bar:/var/lib/storage
volumes:
  bar:
    driver: rancher-nfs
```

#### Stack Scoped

By default, all volumes are created at the stack scope. Services referencing the same volume in a Compose file or stack will be sharing the same volume.

When launching a new stack from the same Compose file, a new volume will be created. When a stack is deleted, its corresponding volumes are removed.

In the above example, volume `bar` has stack scope.

#### Environment Scoped

To use volumes across stacks, you would need to use an environment scoped volume. In this case, volumes must already be created in Rancher prior to starting services and stacks using the volume. To use an environment scoped volume, you'd add the `external` option to the volume.

```yaml
version: '2'
services:
  foo:
    image: busybox
    volumes:
    - bar:/var/lib/storage
volumes:
  bar:
    driver: rancher-nfs
    external: true
```

If a volume by the name of `bar` is not found at the environment level when launching this stack, then an error will be thrown. Environment scoped volumes can only be removed from the UI.
