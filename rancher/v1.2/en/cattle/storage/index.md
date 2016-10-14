---
title: Storage
layout: rancher-default-v1.2
version: v1.2
lang: en
---

## Storage in Rancher
---

Through our infrastructure catalog, Rancher provides a variety of storage options.

### Launching Storage Drivers

### Using Storage Drivers in the UI

### Using Storage Drivers with Rancher Compose

Volumes can be specified as part of a Docker Compose file under the `volumes` key. Each volume can be associated with one or more services in the same file. This functionality is only available when using a Compose file in v2 format.

```
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

There are three different scopes that can be used to define volumes.

#### Stack Scoped

By default all volumes are created at the stack scope. Services referencing the same volume in a Compose file will be sharing the same volume.

When launching a new stack from the same Compose file, a new volume will be created. When a stack is deleted, its corresponding volumes are removed.

In the above example, volume `bar` has stack scope.

#### Container Scoped

In some cases it makes sense to have a volume created for each instance of a container. This is indicated via the `per_container` option for a volume.

```
version: '2'
services:
  foo:
    image: busybox
    volumes:
    - bar:/var/lib/storage
volumes:
  bar:
    driver: rancher-nfs
    per_container: true
```

When scaling up the `foo` service, a volume will be created for each new container. When scaling down the `foo` service, the volumes corresponding to the removed containers will be removed.

#### Environment Scoped

To use volumes across stacks, the environment scope can be used. In this case volumes must be created by the user prior to starting services and stacks using the volume. This is indicated in a Compose file via the `external` option.

```
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

If a volume by the name of `bar` is not found when launching this stack then an error will be thrown. Environment scoped volumes will only be removed when manually done by a user.
