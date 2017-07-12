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

`Volume Plugin` and `Volume Driver` are used interchangeably in Docker and Rancher documentation. They are referring to the same thing: a [Docker Volume Plugin](https://docs.docker.com/engine/extend/plugins_volume/) that provides local or shared persistent volumes to a Docker container. Rancher Volume Plugins (Drivers) are currently implemented as Docker Volume Plugins and may be interacted with the `docker volume` command on any host, but depending on the storage technology, volumes may be accessed by one, some, or all hosts in an environment. Rancher handles the complexity of coordinating shared volumes across hosts. Examples are: rancher-nfs, rancher-efs, rancher-ebs, pxd (portworx).

A `Storage Driver` pertains to how containers and images are stored and managed on your Docker hosts. Examples are: aufs, btrfs, zfs, devicemapper. These drivers are beyond the scope of Rancher. Rancher UI conflates the term but is actually referring to `Volume Driver` or `Volume Plugin`. More information about storage drivers is available [here](https://docs.docker.com/engine/userguide/storagedriver/imagesandcontainers/).

### Managing Volumes

In this section you’re going to learn how to create persistent volumes that may be shared between containers. [Rancher CLI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cli/) will be used exclusively in these subsections.

> **Note:** The UI may be used to manage volumes for all volume drivers except `local`.

#### Create a Volume

You can create a volume with the `rancher volume create` command.

```
$ rancher volume create --driver local app-data
```

This will create a new local volume with name `app-data`. The name must start with an alphanumeric character, followed by `a-z0-9`, `_` (underscore), `.` (period) or `-` (hyphen). 

The `--driver` flag specifies the volume driver to use. Docker ships with a `local` volume driver. Volumes using this driver persist their data to the host filesystem and are accessible to any container on the same host.

#### List Volumes

You can list volumes in an environment.

```
$ rancher volume ls
```

If you created the `app-data` volume from the previous section, you may wonder why it wasn't listed. You can include `inactive` volumes with the `--all` or `-a` flag.

```
$ rancher volume ls --all
```

#### Delete a Volume

You can delete a volume with the `rancher volume rm` command.

```
$ rancher volume rm app-data
```

#### Volume States

Volumes have seven distinct states: `inactive`, `activating`, `active`, `deactivating`, `detached`, `removing` and `removed`.

A newly-created volume is in `inactive` state until a container attempts to attach to it.

When a container is created, associated volumes enter `activating` state. Once the container enters the `running` phase, its volumes enter `active` state. Containers attaching to an already `active` volume will not impact that volume's state.

When all containers attached to a volume are marked for deletion, the volume enters a `deactivating` state. Once the conatiners are deleted, the volume enters `detached` state.

When a volume is marked for deletion, it enters a `removing` state. Once the data is deleted from the host(s), it enters `removed` state. Removed volumes will not appear when listing volumes, but they continue to exist in Rancher API for a period of time for debugging and auditing purposes.

### Volume Scopes

There are two different volume scopes. The scope refers to the level at which the volume is managed by Rancher.

Scoped volumes must be defined in the top-level `volumes` section of a `docker-compose.yml` file. If the definition is omitted, volumes behave differently. See [V1 Compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/volumes/#v1-compose) for details.

#### Stack Scope

A stack-scoped volume is owned and managed by the stack in which it is defined. The primary benefit is that the volume lifecycle is automatically managed by Rancher as part of the stack lifecycle.

##### Shared Example

Save the `docker-compose.yml` file below to a directory. Notice that no modifiers are added to the volume; stack scope is default behavior.

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

The default driver for a volume is `local`. The most succinct way to define the `data` volume is with an empty structure `{}`.

``` yaml
volumes:
  data: {}
```

Now create the stack.

```
$ rancher stack create
```

To avoid name collisions with other volumes, unique names are used for the stack scope volumes you define. They include the stack name, original volume name, and a random component. [List the volumes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/volumes/#list-volumes) and identify the `data` volume exists in this form.

> **Note:** Stack-scope volumes could be mounted by other stacks. Stack scope is not a security mechanism. It is solely for managing the lifecycle of the volume.

#### Environment Scope

An `environment` scope volume may be shared by all containers in an environment. Rancher schedules a container appropriately based on the hosts that have access to its assigned volumes.

Environment scope volumes are not automatically shared across all hosts in an environment. You need to be using a shared volume driver such as `rancher-nfs` to accomplish that. This means that an `environment` scope volume using the `local` driver will only be available on a single host and any container using that volume will be scheduled to that host.

Rancher requires that an environment volume exists prior to creating a service that consumes it. Any installed volume driver can be used.

The practical benefit of this scope is the ability to easily share data between different software services/stacks whose lifecycles are independently managed. The user is given full control and must [manage the volumes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/volumes/#managing-volumes) themselves.

##### Shared Environment Scope Volume Example

First, [create the environment scope volume]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/volumes/#create-a-volume) to be shared between stacks.

```
$ rancher volume create --driver local redis-data-external
```

Define the volume with `external: true` modifier to indicate the volume's lifecycle is managed externally (environment scope). Save the `docker-compose.yml` file below to a directory.

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
    external: true
```

> **Note:** If `external: true` is omitted, the volume will be [stack scoped]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/volumes/#stack-scope).

Now create the stack.

```
$ rancher stack create
```

[List the volumes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/volumes/#list-volumes) to verify that `redis-data-external` volume is `active`.

> **Note:** Scaling a service up or down mounts or unmounts the same shared volume.

Any new stack within the environment may attach to the same `redis-data-external` volume. The easiest way is to copy the volume definition verbatim.

```yaml
volumes:
  redis-data-external:
    driver: local
    external: true
```

### V1 Compose

Up until this point, we've discussed volumes in the context of [Docker V2 Compose](https://docs.docker.com/compose/compose-file/compose-file-v2/#volumes-volume_driver).

[Docker V1 Compose](https://docs.docker.com/compose/compose-file/compose-file-v1/#volumes-volume_driver) may also be used. In V1 compose, there is no top-level volume section and volumes can only be defined within the context of a service. Rancher passes V1 volumes directly to Docker; as such, there are no scheduling guarantees and volumes are not automatically deleted. To bridge the gap and ensure containers are scheduled to the host where a V1 volume resides, [scheduling affinities](https://docs.rancher.com/rancher/v1.6/en/cattle/scheduling/#fields-1) may be used.

> **Note:** V1 Compose should be avoided when possible.

#### Pure V1 Compose

Save the `docker-compose.yml` file below to a directory. Notice the absence of the volume section; this doesn't exist in V1. 

```yaml
etcd:
  image: rancher/etcd:v2.3.7-11
  volumes:
  - etcd:/pdata
```

Now create the stack.

```
$ rancher stack create
```

#### Heterogenerous V1 and V2 Compose

Docker compose V2 is a superset of V1; the two schemas can be used interchangeably. Create an environment scope volume first.

```
$ rancher volume create --driver local etcd_backup
```

Save the `docker-compose.yml` file below to a directory.

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

Now create the stack.

```
$ rancher stack create
```

In this example, `etcd_backup` is a V2 environment scope volume and `etcd` is a V1 volume. The absence of a volume definition implicitly makes `etcd` a V1 volume.

Finally, note that while you can define an empty volumes section like this:

```yaml
version: '2'
volumes: {}
```

Doing so will have no effect. It is equivalent to completely omitting the volumes section. Any volumes referenced by services will still be V1 volumes.