---
title: Using Rancher EBS
layout: rancher-default-v1.6
version: v1.6
lang: en
---

## Rancher EBS
---

Rancher provides the ability to select AWS EBS volumes as the storage option for containers.

### Restrictions when using EBS

An AWS EBS volume can only be attached to a single AWS EC2 instance. Therefore, all containers using the same AWS EBS volume will be scheduled on the same host.

### Setting up Rancher EBS

When setting up an [environment template]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#what-is-an-environment-template), you can select the **Rancher EBS** catalog item so that it will be available in any environment created from that environment template.

Alternatively, if you already have an environment set up, you can select and launch Rancher EBS from the [catalog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/).

> **Note:** Some storage services may not be compatible with some container orchestration types (i.e. Kubernetes). Environment templates will restrict which ones are compatible based on orchestration, but all options are available from the catalog.

In order to launch Rancher EBS, you will need an AWS Access Key and Secret Key that has valid permissions to launch AWS EBS volumes. Depending on your driver options, additional permissions may be required.  

### Rancher EBS Driver Options

When creating AWS EBS volumes, there are several options that can be used to customize the volume. These options are key value pairs that can be added in the UI as a driver options or in compose files under the `driver_opts` key.   

#### Required Driver Options

* **Size** - (`size`): Size of the EBS volume

#### Optional Driver Options

* **Volume Type** - (`volumeType`): Type of volume
* **IOPS** - (`iops`): IOPS option
* **Specific Availability Zone** (`ec2_az`): The specific availability zone to create containers and EBS volume. (e.g. `us-west-1a`)

For the following options, you **must** specify the specific availability zone (`ec2_az`) that the IDs are associated with in the driver options.  

* **Encrypted** (`encrypted`): Whether or not the volume should be encrypted. Note: As of Rancher v1.6.11+ with `rancher/storage-ebs:v0.8.11`, if no AWS KMS ID is specified, the default customer master key (CMK) will be created and/or used. For any previous version, specifying the AWS KMS ID is required when using this option.
* **AWS KMS ID** (`kmsKeyId`): The full ARN of the AWS Key Management Service (AWS KMS) customer master key (CMK) to use when creating the encrypted volume. Note: As of Rancher v1.6.11+, this is optional when selecting encrypted.
* **Snapshot ID** (`snapshotID`): The snapshot from which to create the volume.
* **Volume ID** (`volumeID`): The ID of an existing volume to use.

### Using Rancher EBS in the UI

#### Creating Volumes

After **Rancher EBS** is launched in Rancher, you will need to create the volumes in EBS in **Infrastructure** -> **Storage** before using the volume in a service.

1. Click on **Add Volume**.
2. Create the name of the volume that will be used in the service.
3. Required: Add a driver option for `size`.
4. Optional: Add any additional driver options. Note: If you use encryption, snapshot ID or volume ID, you will also have to specify the availability zone.

#### Using Volumes in Services

Once a volume is created in the UI, [services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/) can start using the shared storage. when creating a service, in the **Volumes** tab, provide a **volume** and a **volume driver**.

The **volume** will be in the same syntax as Docker, `<volume_name>:</path/in/container>`. Docker volumes default to mount in read-write mode, but you can set it to be mounted read-only by adding the `:ro` at the end of the volume.

The **volume driver** will be the name of the storage driver, which is the name of the stack. By default, the **Rancher EBS** storage driver will be `rancher-ebs`.

### Using Rancher EBS in a Compose File

After the **Rancher EBS** infrastructure stack has been launched, you can start creating volumes in a compose file.

Volumes can be specified as part of a compose file under the `volumes` key. Each volume can be associated with one or more services in the same file.

> **Note:** This functionality is only available when using a compose file in v2 format.

#### Example of a Stack Scoped Volume specifying Size, Volume Type and IOPS

In this example, we are creating a [stack scoped volume]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/storage-service/#stack-scoped) while creating services that use this volume. All services in this stack will share the same volume.  

```yaml
version: '2'
services:
  foo1:
    image: busybox
    stdin_open: true
    volumes:
    - bar:/var/lib/storage
  foo2: 
    image: busybox
    volumes:
    - bar:/var/lib/storage

volumes:
  bar:
    driver: rancher-ebs
    driver_opts:
      size: 10
      volumeType: gp2
      iops: 1000
```

#### Example of a Stack Scoped Volume scheduled to a specific Availability Zone

In this example, we are creating a [stack scoped volume]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/storage-service/#stack-scoped) while creating services that use this volume. All services in this stack will share the same volume.

We are specifying the availability zone that we want the volume to be created in. The containers for any service using the EBS volume will automatically be scheduled onto the same host as where the EBS volume is attached to.

```yaml
version: '2'
services:
  foo:
    image: busybox
    stdin_open: true
    volumes:
    - bar:/var/lib/storage

volumes:
  bar:
    driver: rancher-ebs
    driver_opts:
      size: 10
      ec2_az: us-west-2a
```

#### Example of a Stack Scoped Volume that is Encrypted

In this example, we are creating a [stack scoped volume]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/storage-service/#stack-scoped) while creating services that use this volume. All services in this stack will share the same volume.

In order to encrypt a volume, you will need to specify in the driver options that you want it encrypted as well as the availability zone where the customer master key (CMK) is located in. As of Rancher v1.6.11+ using `rancher/storage-ebs:v0.8.11`, specifying the customer master key is no longer required. If you don't specifiy the `kmsKeyId`, the default customer master key (CMK) in the specified availability zone will be used. If a customer master key (CMK) does not exist in the specified availability zone, one will be created and used.

The containers for any service using the EBS volume will automatically be scheduled onto the same host as where the EBS volume is attached to.

Example of enabling encryption without specifying the customer master key (CMK) in `kmsKeyId`:

```yaml
version: '2'
services:
  foo:
    image: busybox
    stdin_open: true
    volumes:
    - bar:/var/lib/storage

volumes:
  bar:
    driver: rancher-ebs
    driver_opts:
      size: 10
      encrypted: true
      # Specifying the availability zone is required when using encryption
      ec2_az: <AVAILABILITY_ZONE_IN_REGION_WHERE_THE_DEFAULT_KMS_KEY_IS>
```

Example of enabling encryption and specifying the customer master key (CMK) in `kmsKeyId`:

```yaml
version: '2'
services:
  foo:
    image: busybox
    stdin_open: true
    volumes:
    - bar:/var/lib/storage

volumes:
  bar:
    driver: rancher-ebs
    driver_opts:
      size: 10
      encrypted: true
      kmsKeyId: <KMS_KEY_ID>
      # Specifying the availability zone is required when using encryption and kmsKeyId
      ec2_az: <AVAILABILITY_ZONE_IN_REGION_WHERE_THE_KMS_KEY_IS>
```

#### Example of a Stack Scoped Volume that is based off an existing Snapshot

In this example, we are creating a [stack scoped volume]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/storage-service/#stack-scoped) while creating services that use this volume. All services in this stack will share the same volume.

The volume will be created from an existing snapshot in AWS. You will need to specify the snapshot ID as well as the availability zone where the snapshot is located in.

The containers for any service using the EBS volume will automatically be scheduled onto the same host as where the EBS volume is attached to.

```yaml
version: '2'
services:
  foo:
    image: busybox
    stdin_open: true
    volumes:
    - bar:/var/lib/storage

volumes:
  bar:
    driver: rancher-ebs
    driver_opts:
      size: 10
      snapshotID: <SNAPSHOT_ID>
      # Specifying the availability zone is required when using snapshotID
      ec2_az: <AVAILABILITY_ZONE_WHERE_THE_SNAPSHOT_IS>
```

#### Example of a Volume using an existing EBS volume

In this example, the service is using an existing EBS volume. Any services using an existing EBS volume will be sharing the same volume. The different scopes of volumes will be ignored when using an existing volume.

You will need to specify the volume ID as well as the availability zone where the volume is located in.

The containers for any service using the EBS volume will automatically be scheduled onto the same host as where the EBS volume is attached to.

```yaml
version: '2'
services:
  foo:
    image: busybox
    stdin_open: true
    volumes:
    - bar:/var/lib/storage

volumes:
  bar:
    driver: rancher-ebs
    driver_opts:
      size: 10
      volumeID: <VOLUME_ID>
      # Specifying the availability zone is required when using volumeID
      ec2_az: <AVAILABILITY_ZONE_WHERE_THE_VOLUME_IS>
```
