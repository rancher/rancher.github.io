---
title: Kubernetes - Backups
layout: rancher-default-v1.6
version: v1.6
lang: en
---

## Kubernetes - Backups
---

By default, backups are enabled in Kubernetes. Network storage latency and size should be taken into consideration for backups. 50MB for any single backup is a good estimate for storage requirements. For example, backups created every 15 minutes and retained for 1 day would store a maximum of 96 backups, requiring ~5 GB storage. If there is no intention to ever restore to a previous point in time, fewer historical backups may be retained.

### Kubernetes Configuration  

When [configuring Kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#configuring-kubernetes), you can select whether or not backups should be enabled.

If backups are enabled, you can indicate the duration for the **Backup Creation Period** and **Backup Retention Period**.

The backup period durations must be a sequence of decimal numbers, each with optional fraction and a unit suffix, such as `300ms`, `1.5h` or `2h45m`. Valid time units are `ns`, `us` or `µs`, `ms`, `s`, `m` and `h`.

The **Backup Creation Period** duration indicates at what rate backups should be created. It is not recommended to create backups more often than `30s`.

The **Backup Retention Period** duration indicates at what rate historical backups should be deleted. Backups outside of the retention period are expired after the next successful backup.

The maximum number of backups stored on disk at any given moment follows the equation `ceiling(retention period / creation period)`. For example, `5m` creation period with `4h` retention period would store at most `ceiling(4h / 5m)` backups or `48` backups. A conservative estimate for backup size is `50MB`, so the attached network storage should have at least `2.4GB` free space. Backup sizes will vary depending on usage.

If backups are disabled, the values for **Backup Creation Period** and **Backup Retention Period** are ignored.

### Configuring Remote Backups

Currently, backups are persisted to a static location on the host at `/var/etcd/backups`. It is required that you mount network storage at this location on all the hosts running the **etcd** service. Setting up the network storage must be done before Kubernetes is launched.

### Restoring Backups

If all hosts running the **etcd** service fail, follow these steps:

1. Change your orchestration type for the environment to **Cattle** by deleting the **Kubernetes** stack from the **Kubernetes** -> **Infrastructures Stacks**. Pods will remain intact and available.
2. Delete the `disconnected` hosts and add new hosts. If you have opted to have [resiliency planes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/resiliency-planes), you will need to add hosts with the label `etcd=true`.
3. For each host that will be running the **etcd** service, mount the network storage containing backups, this should have been created as part of [configuring remote backups](#configuring-remote-backups). Then run these commands:
    
    In a terminal session Run:
    * ```target=<NAME_OF_BACKUP>```
    * ```docker volume rm etcd```
    * ```docker volume create --name etcd```
    * ```docker run -d -v etcd:/data --name etcd-restore busybox```
    * ```docker cp /var/etcd/backups/$target etcd-restore:/data/data.current```
    * ```docker rm etcd-restore```
    ```
    > **Note:** You must be logged in as a user with read access to the remote backups. Otherwise, the `docker cp` command will silently fail.

5. Launch Kubernetes through the catalog. Make sure you [configure Kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#configuring-kubernetes). The **Kubernetes** infrastructure stack will launch and your pods will be reconciled. Your backup may reflect a different deployment topology than what currently exists. **Pods may be deleted/recreated.**
