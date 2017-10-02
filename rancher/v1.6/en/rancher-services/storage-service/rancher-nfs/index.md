---
title: Using Rancher NFS
layout: rancher-default-v1.6
version: v1.6
lang: en
---

## Rancher NFS
---

Rancher provides the ability to select NFS volumes as a storage option for containers.

### Prerequisites when using NFS

A NFS server has to be installed prior to launching the Rancher NFS driver. For example, to install a NFS server on Ubuntu 16.04, you can use the following commands.

```bash
sudo apt-get update
sudo apt-get install nfs-kernel-server
```

On the server, you will need to export a base directory. First, you'll need to create the shared directory. 

```bash
sudo mkdir /nfs
sudo chown nobody:nogroup /nfs
```

Modify the exports file (`/etc/exports`).

```bash
/nfs    *(rw,sync,no_subtree_check,no_root_squash)
```

After all the modifications, restart the NFS kernel server. 

```bash
sudo systemctl restart nfs-kernel-server
```

### Using the Rancher NFS driver on Amazon EFS

The Rancher NFS driver can connect to Amazon EFS. When using Rancher NFS driver with Amazon EFS, all hosts in the environment will need to be EC2 instances, deployed in the same availability zone as where EFS is deployed. 

### Setting up Rancher NFS

When setting up an [environment template]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#what-is-an-environment-template), you can select the **Rancher NFS** catalog item so that it will be available in any environment created from that environment template.

Alternatively, if you already have an environment set up, you can select and launch Rancher NFS from the [catalog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/).

> **Note:** Some storage services may not be compatible with some container orchestration types (i.e. Kubernetes). Environment templates will restrict which ones are compatible based on orchestration, but all options are available from the catalog.

In order to launch Rancher NFS, you will need to specify the following:

* **NFS Server**: NFS server ip address or hostname.
* **Export Base Directory**: Exported shared directory on the NFS server.
* **NFS Version**: The NFS version to use, current used version is 4.
* **Mount Options**: Comma delimited list of default mount options, for example: 'proto=udp'. Do not specify `nfsvers` option, it will be ignored.
* **On Remove**: On removal of Rancher NFS volume, should the underlying data be retained or purged. Options are `purge` and `retain`, default is `purge`. Available as of Rancher v1.6.6.

### Rancher NFS Driver Options

When creating volumes using the Rancher NFS driver, there are several options that can be used to customize the volume. These options are key value pairs that can be added in the UI as a driver options or in compose files under the `driver_opts` key.   

#### Driver Options

* **Host** - (`host`): NFS host
* **Export** - (`export`): When the volume is configured with the host and export, no subfolder is created; the root export directory is mounted.
* **Export Base** - (`exportBase`): By default, the volume can be configured with the host and export base, which creates a uniquely named subfolder on the NFS server.
* **Mount Options** - (`mntOptions`): Comma delimited list of default mount options.
* **On Remove** - (`onRemove`): On removal of Rancher NFS volume, should the underlying data be retained or purged. Options are `purge` and `retain`, default is `purge`. Available as of Rancher v1.6.6.

### Using Rancher NFS in the UI

#### Creating Volumes

After **Rancher NFS** is launched in Rancher, you will need to create the volumes in the NFS in **Infrastructure** -> **Storage** before using the volume in a service.

1. Click on **Add Volume**.
2. Create the name of the volume that will be used in the service.
4. Optional: Add any additional driver options. 

#### Using Volumes in Services

Once a volume is created in the UI, [services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/) can start using the shared storage. when creating a service, in the **Volumes** tab, provide a **volume** and a **volume driver**.

The **volume** will be in the same syntax as Docker, `<volume_name>:</path/in/container>`. Docker volumes default to mount in read-write mode, but you can set it to be mounted read-only by adding the `:ro` at the end of the volume.

The **volume driver** will be the name of the storage driver, which is the name of the stack. By default, the **Rancher NFS** storage driver will be `rancher-nfs`.

### Using Rancher NFS in a Compose File

After the **Rancher NFS** infrastructure stack has been launched, you can start creating volumes in a compose file.

Volumes can be specified as part of a compose file under the `volumes` key. Each volume can be associated with one or more services in the same file.

> **Note:** This functionality is only available when using a compose file in v2 format.

#### Example of a NFS volume

In this example, we are creating a NFS volume while creating services that use this volume. All services in this stack will share the same volume.  

```yaml
version: '2'
services:
  foo:
    image: alpine
    stdin_open: true
    volumes:
    - bar:/data
volumes:
  bar:
    driver: rancher-nfs
```

#### Examples of using host, exportBase and export

The following example shows how to override `host` and `exportBase` for this particular service.

```yaml
version: '2'
services:
  foo:
    image: alpine
    stdin_open: true
    volumes:
    - bar:/data
volumes:
  bar:
    driver: rancher-nfs
    driver_opts:
      host: 192.168.0.1
      exportBase: /thisisanothershare
```

You can also use a different `exportBase` per volume, see the example below.

```yaml
version: '2'
services:
  foo:
    image: alpine
    stdin_open: true
    volumes:
    - bar:/bardata
    - baz:/bazdata
volumes:
  bar:
    driver: rancher-nfs
    driver_opts:
      host: 192.168.0.1
      exportBase: /thisisanothershare
  baz:
    driver: rancher-nfs
    driver_opts:
      host: 192.168.0.1
      exportBase: /evenanothershare
```

### Using Rancher NFS with AWS EFS

After creating an EFS file system on AWS, you can launch the Rancher NFS driver to use this EFS file system. Since Amazon EFS is only reachable internally, only EC2 instances in the same availability zone can reach this EFS, therefore EC2 instances should be added to Rancher prior to creating the storage driver.

You can launch Rancher NFS with the following options for example:

* **NFS Server**: `xxxxxxx.efs.us-west-2.amazonaws.com`
* **Export Base Directory**: `/`
* **NFS Version**: `nfsvers=4`

### Preserving data on volume removal
The default value for the `onRemove` driver option is `purge`. This means that the underlying data will be removed if the volume is removed from Rancher. If you want to retain the underlying data, you can specify the `retain` value. You can also override this behavior on a per-volume basis. If the nfs-driver option `onRemove` is set to `retain`, but you want to purge the data of a particular volume when it's removed from Rancher, you can configure `onRemove: purge` in the `driver_opts` of the volume specification inside `docker-compose.yml` like in the example below.

```yaml
services:
  foo:
    image: alpine
    stdin_open: true
    volumes:
    - bar:/data
volumes:
  bar:
    driver: rancher-nfs
    driver_opts:
      onRemove: purge
```

If the nfs-driver option `onRemove` is set to `purge`, you can configure `onRemove: retain` in the `driver_opts` of the volume specification to preserve the data after the volume is removed in Rancher.

```yaml
services:
  foo:
    image: alpine
    stdin_open: true
    volumes:
    - bar:/data
volumes:
  bar:
    driver: rancher-nfs
    driver_opts:
      onRemove: retain
```

> **Note:** Creating an external volume with the same name as a previously removed volume with retained data will make the retained data accessible to the container using this volume.
