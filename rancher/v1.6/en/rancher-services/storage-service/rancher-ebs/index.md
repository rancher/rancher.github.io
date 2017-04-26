---
title: Rancher EBS Usage
layout: rancher-default-v1.6
version: v1.6
lang: en
---

## Rancher EBS
---

Rancher provides the ability to select AWS EBS volume as the backend container storage option.

### Setting up Rancher EBS

Before using Rancher-EBS, we need to launch Rancher-EBS catalog. After that, you should be able to see Rancher-EBS driver listed under Infrastructure/Storage.
To launch Rancher-EBS, you will need you own AWS accessKey and secretKey to be able to launch AWS EBS volume.

### Rancher-EBS Driver Options

Rancher-EBS provides the following options when creating the EBS volume:

```
      size: the size for EBS volume. This is required.
      volumeType:  the volume type
      iops:  the iops
      encrypted: whether the volume should be encrypted
      kmsKeyId:  the full ARN of the AWS Key Management Service (AWS KMS) customer master key (CMK) to use when creating the encrypted volume
      snapshotID: the snapshot from which to create the volume.
```
Examples:

1. Using a 10G EBS volume(gp2, iops=1000)

```yaml
version: '2'
services:
  foo:
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

2. Using a 10G EBS volume(encrypted)

```yaml
version: '2'
services:
  foo:
    image: busybox
    volumes:
    - bar:/var/lib/storage
volumes:
  bar:
    driver: rancher-ebs
    driver_opts:
      size: 10
      encrypted: true
      kmsKeyId: $yourkmsKeyId
      ec2_az: $the_availability_zone_where_your_kmskey_belongs_to
```

3. Using a 10G EBS volume from snapshot

```yaml
version: '2'
services:
  foo:
    image: busybox
    volumes:
    - bar:/var/lib/storage
volumes:
  bar:
    driver: rancher-ebs
    driver_opts:
      size: 10
      snapshotID: $yourSnapshotID
```

4. Using an existing EBS volume.

```yaml
version: '2'
services:
  foo:
    image: busybox
    volumes:
    - bar:/var/lib/storage
volumes:
  bar:
    driver: rancher-ebs
    driver_opts:
      volumeID: $your_existing_volumeID
      ec2_az: $the_availability_zone_where_your_volume_belongs_to(for example us-west-2a)
```
The driver options `ec2_az` is required so that rancher will schedule the volume to the same zone.

`ec2_az` can also be used to create volume on specific zone. Example:

```yaml
version: '2'
services:
  foo:
    image: busybox
    volumes:
    - bar:/var/lib/storage
volumes:
  bar:
    driver: rancher-ebs
    driver_opts:
      size: 10
      ec2_az: us-west-2a
```
Then containers will be scheduled to the specific zone and volumes will also be created on that zone.

Also, Starting at 1.6, Rancher automatically populates those host labels for AWS instances:

Key | Value | Description
----|----|----
`io.rancher.host.provider` | Cloud provider info | Cloud provider name (currently only applied for AWS)
`io.rancher.host.region` | Cloud provider region | Cloud provider region (currently only applied for AWS)
`io.rancher.host.zone` | Cloud provider zone | Cloud provider zone (currently only applied for AWS)

Users can use scheduling rules based on those labels to better control where the containers and volumes should land.