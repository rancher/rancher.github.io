---
title: Volumes in Rancher
layout: rancher-default-v1.6
version: v1.6
lang: en
---

## Volumes
---

### Overview

Persistent volumes are a very important part of a stateful application. Rancher makes working with volumes in multi-host environments a simple process.

#### Terminology

`Volume Plugin` and `Volume Driver` are used interchangeably in Docker and Rancher documentation. They are referring to the same thing: a [Docker Volume Plugin](https://docs.docker.com/engine/extend/plugins_volume/) that provides local or shared persistent volumes to a Docker container. Rancher Volume Plugins (Drivers) are currently implemented as Docker Volume Plugins and may be interacted with the `docker volume` command on any host, but depending on the storage technology, volumes may be accessed by one, some, or all hosts in an environment. Rancher handles the complexity of coordinating shared volumes across hosts. Examples are: rancher-nfs, rancher-ebs, pxd (portworx).

A `Storage Driver` pertains to how containers and images are stored and managed on your Docker hosts. Examples are: aufs, btrfs, zfs, devicemapper. These drivers are beyond the scope of Rancher. Rancher UI conflates the term but is actually referring to `Volume Driver` or `Volume Plugin`. More information about storage drivers is available [here](https://docs.docker.com/engine/userguide/storagedriver/imagesandcontainers/).

### Managing Volumes

In this section you’re going to learn how to create persistent volumes that may be shared between containers. [Rancher CLI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cli/) will be used exclusively in these subsections.

> **Note:** The UI may be used to manage volumes for all volume drivers except `local`.

#### Create a Volume

You can create a volume with the `rancher volume create` command.

```bash
$ rancher volume create --driver local app-data
```

This will create a new local volume with name `app-data`. The name must start with an alphanumeric character, followed by `a-z0-9`, `_` (underscore), `.` (period) or `-` (hyphen). 

The `--driver` flag specifies the volume driver to use. Docker ships with a `local` volume driver. Volumes using this driver persist their data to the host filesystem and are accessible to any container on the same host. When using the `local` volume driver, no containers on other hosts will share the same volume.

#### List Volumes

You can list volumes in an environment.

```bash
$ rancher volume ls
```

If you created the `app-data` volume from the previous section, you may wonder why it wasn't listed. You can include `inactive` volumes with the `--all` or `-a` flag.

```bash
$ rancher volume ls --all
```

#### Delete a Volume

You can delete a volume with the `rancher volume rm` command.

```bash
$ rancher volume rm app-data
```

#### Volume States

Volumes have seven distinct states: `inactive`, `activating`, `active`, `deactivating`, `detached`, `removing` and `removed`.

A newly-created volume is in `inactive` state until a container attempts to attach to it.

When a container is created, associated volumes enter `activating` state. Once the container enters the `running` phase, its volumes enter `active` state. Containers attaching to an already `active` volume will not impact that volume's state.

When all containers attached to a volume are marked for deletion, the volume enters a `deactivating` state. Once the conatiners are deleted, the volume enters `detached` state.

When a volume is marked for deletion, it enters a `removing` state. Once the data is deleted from the host(s), it enters `removed` state. Removed volumes will not appear when listing volumes, but they continue to exist in Rancher API for a period of time for debugging and auditing purposes.

### Volume Scopes

Volumes are able to have different scopes, which refer to the level at which the volume is managed by Rancher.

Currently, using Rancher Compose files supports creating the different types of volumes. Scoped volumes must be defined in the top-level `volumes` section of a `docker-compose.yml` file. By default, a stack scoped volume is created, but different scopes can be created based on modifiers in the top-level definition.

If the top-level definition is omitted, volumes behave differently. Please [read more](#v1-compose) for details.

The UI only creates volumes that are environment scoped.

#### Stack Scoped Volumes

A stack scoped volume is owned and managed by the stack in which it is defined. The primary benefit is that the volume lifecycle is automatically managed by Rancher as part of the stack lifecycle. 

With a stack scoped volume, services referencing the same volume in a stack would share the same volume. A service outside the stack could not use the same volume.

In Rancher, stack scoped volumes are named with the stack name as a prefix to indicate which stack the volume is scoped to and suffixed with a random number to guarantee no duplication. When referencing the volume, you still use the original volume name. For example, if you create a volume called `foo` in `stackA`, the volume name in the UI and on your hosts will be `stackA_foo_<randomNumber>`, but to use the same volume in your service, you would use the name `foo`.  

##### Example of Creating 

In the following example, the volume `data` will be created at the stack scoped volume.

> **Note:** There is no other modifiers in the top-level definition of the volume, therefore, the volume is stack scoped.

```yaml
version: '2'
services:
  redis:
    image: redis:3.0.7
    volumes:
    - data:/data
volumes:
  data:
    driver: local
```

In the example above, we have specifically called out the driver to be a `local` driver. By default, the driver for a volume is `local`. The most succinct way to define the `data` volume is with an empty structure `{}`.

``` yaml
volumes:
  data: {}
```

After creating this stack through Rancher CLI, you would be able to [list the volume](#list-volumes) and identify the `data` volume exists. The name of the volume would be `<STACK_NAME>_data_<RANDOM_NUMBER>`.

> **Note:** Stack scoped volumes could be mounted by other stacks. Stack scope is not a security mechanism. It is solely for managing the lifecycle of the volume.

#### Environment Scoped Volumes

An environment scoped volume may be shared by all containers in an environment. Rancher schedules a container appropriately based on the hosts that have access to its assigned volumes.

Environment scope volumes are not automatically shared across all hosts in an environment. You need to be using a shared volume driver such as `rancher-nfs` to accomplish that. This means that an environment scoped volume using the `local` driver will only be available on a single host and any container using that volume will be scheduled to that host.

Rancher requires that an environment volume exists prior to creating a service that consumes it. Any installed volume driver can be used.

The practical benefit of this scope is the ability to easily share data between different software services/stacks whose lifecycles are independently managed. The user is given full control and must [manage the volumes](#managing-volumes) themselves.

##### Shared Environment Scope Volume Example

First, [create the environment scope volume](#create-a-volume) to be shared between stacks.

```bash
$ rancher volume create --driver local redis-data-external
```

In order to create an environment scoped volume, in the top-level definition of the volume, you must add `external: true`. 

```yaml
version: '2'
services:
  redis:
    image: redis:3.0.7
    volumes:
    - redis-data-external:/data
volumes:
  redis-data-external:
    driver: local
    external: true  # Without this definition, a stack scoped volume will be created.
```

> **Note:** If `external: true` is not part of the top-level definition of the volume, the volume will be [stack scoped](#stack-scope).

After creating this stack through Rancher CLI, you would be able to [list the volume](#list-volumes) and identify the `redis-data-external` volume exists and is `active`.

> **Note:** Scaling a service up or down mounts or unmounts the same shared volume.

Any new stack within the environment may attach to the same `redis-data-external` volume. The easiest way is to copy the top-level volume definition verbatim.

```yaml
volumes:
  redis-data-external:
    driver: local
    external: true
```

### V1 vs V2 Compose

Up until this point, we've discussed volumes in the context of [Docker V2 Compose](https://docs.docker.com/compose/compose-file/compose-file-v2/#volumes-volume_driver). If you omit the top-level definition in a V2 compose file, it acts as a Docker V1 Compose volume. 

[Docker V1 Compose](https://docs.docker.com/compose/compose-file/compose-file-v1/#volumes-volume_driver) may also be used. In V1 compose, there is no top-level volume section and volumes can only be defined within the context of a service. Rancher passes V1 volumes directly to Docker; as such, there are no scheduling guarantees and volumes are not automatically deleted. To bridge the gap and ensure containers are scheduled to the host where a V1 volume resides, [scheduling affinities]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/#fields-1) may be used.

> **Note:** V1 Compose should be avoided when possible.

####  Example of V1 Compose

Notice the absence of the volume section; this doesn't exist in V1. 

```yaml
etcd:
  image: rancher/etcd:v2.3.7-11
  volumes:
  - etcd:/pdata
```

#### Heterogenerous V1 and V2 Compose

Docker compose V2 is a superset of V1; the two schemas can be used interchangeably. Create an environment scope volume first.

```bash
$ rancher volume create --driver local etcd_backup
```

In this example, `etcd_backup` is a V2 environment scope volume and `etcd` is a V1 volume. The absence of a volume definition implicitly makes `etcd` a V1 volume.

```yaml
version: '2'
services:
  etcd:
    image: rancher/etcd:v2.3.7-11
    environment:
      EMBEDDED_BACKUPS: 'true'
      BACKUP_PERIOD: 5s
      BACKUP_RETENTION: 15s
    volumes:
    - etcd:/pdata
    - etcd_backup:/data-backup
volumes:
  etcd_backup:
    driver: local
    external: true
```

Finally, if you define an empty volumes section, this will still treat the volume as a V1 volume. It is equivalent to completely omitting the volumes section.

```yaml
version: '2'
volumes: {}
```
