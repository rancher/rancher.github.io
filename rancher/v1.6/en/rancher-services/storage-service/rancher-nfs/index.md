---
title: Using Rancher NFS
layout: rancher-default-v1.6
version: v1.6
lang: en
---

## Rancher NFS
---

Rancher provides the ability to select NFS volumes as a storage option for containers.

### prerequisites when using NFS

NFS server has to be installed prior to setting up Rancher NFS driver, the NFS driver will connect to this NFS server, for example to install NFS server on Ubuntu 16.04, use the following commands:

```bash
sudo apt-get update
sudo apt-get install nfs-kernel-server
```

Then you will need to export a base directory on this server, first create the shared directory:

```bash
sudo mkdir /nfs
sudo chown nobody:nogroup /nfs
```

Then modify the exports file (/etc/exports):
```bash
/nfs    *(rw,sync,no_subtree_check)
```
Then finally restart the nfs kernel server:

```bash
sudo systemctl restart nfs-kernel-server
```

Alternatively, Rancher NFS driver can connect to Amazon EFS, however all hosts registered with Rancher server have to be EC2 instances and in the same AZ as the EFS deployed.

### Setting up Rancher NFS

When setting up an [environment template]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#what-is-an-environment-template), you can select the **Rancher NFS** catalog item so that it will be available in any environment created from that environment template.

Alternatively, if you already have an environment set up, you can select and launch Rancher NFS from the [catalog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/).

> **Note:** Some storage services may not be compatible with some container orchestration types (i.e. Kubernetes). Environment templates will restrict which ones are compatible based on orchestration, but all options are available from the catalog.

In order to launch Rancher NFS, you will need to specify the following:

* **NFS Server**: NFS server ip address or hostname.
* **Export Base Directory**: Exported shared directory on the NFS server.
* **NFS Version**: The NFS version to use, current used version is 4.
* **Mount Option**: Comma delimited list of default mount options, for example: 'proto=udp'. Do not specify `nfsvers` option, it will be ignored.

### Rancher NFS Driver Options

When creating NFS volumes, there are several options that can be used to customize the volume. These options are key value pairs that can be added in the UI as a driver options or in compose files under the `driver_opts` key.   

#### Driver Options

* **Host** - (`host`): NFS host.
* **Export** - (`export`): When volume is configured with host/export, no subfolder is created; the root export directory is mounted.
* **Export Base** - (`exportBase`): The volume can be configured with host/exportBase which is the default option, a uniquely-named subfolder is created on the NFS server.
* **Mount Options** - (`mntOptions`): Comma delimited list of default mount options.

### Using Rancher NFS in the UI

#### Creating Volumes

After **Rancher NFS** is launched in Rancher, you will need to create the volumes in NFS in **Infrastructure** -> **Storage** before using the volume in a service.

1. Click on **Add Volume**.
2. Create the name of the volume that will be used in the service.
3. Required: Add a driver option for `size`.
4. Optional: Add any additional driver options. Note: If you use encryption, snapshot ID or volume ID, you will also have to specify the availability zone.

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

```
version: '2'
services:
  foo:
    image: alpine
    volumes:
    - bar:/data
volumes:
  bar:
    driver: rancher-nfs
```

### Using Rancher NFS with AWS EFS

After Creating an EFS file system on AWS, you can launch Rancher NFS to use this EFS file system, however since EFS is only reachable internally, only EC2 instances in the same AZ can reach this EFS, so EC2 instances should be added to rancher prior to creating the machine driver.

You can launch Rancher NFS with the following options for example:

* **NFS Server**: `xxxxxxx.efs.us-west-2.amazonaws.com`
* **Export Base Directory**: `/`
* **NFS Version**: `nfsvers=4`
