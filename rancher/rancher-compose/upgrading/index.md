---
title: Upgrading
layout: rancher-default

---

## Upgrading Services with Rancher Compose
---

In Rancher, services can be upgraded from one version to another version using `rancher-compose`. With the `upgrade` command, as the new version of a service is deployed, the old version is removed from Rancher. 

The command to upgrade to a new service is easy:  

```bash
$ rancher-compose upgrade service1 service2 
```

`service2` is the name of the new service that you want to start in Rancher. `service1` is the name of the service that you want stopped in Rancher. As `service2` is deployed, the containers in `service1` will be removed from Rancher. The service is not removed from Rancher, but the scale of the service will be brought to 0.

Inside the `docker-compose.yml`, both names of the services will need to be included. For `service1`, only the name of the service is required for `rancher-compose` to find the service in Rancher. For `service2`, the service will need to be populated with all the details of the service in order for `rancher-compose` to launch the service.

**`docker-compose.yml` Example**

```yaml
service1:
# Nothing needs to actually be placed in the file as the service is already running
service2:
image: wordpress
links: 
# Define any outbound links to other services in the stack
- db:mysql
```

> **Note:** There is no `rancher-compose.yml` file used while upgrading services. By default, the scale of the new service is based on the scale of the old service. You can override this scale by passing in the `--scale` option. 

### Scaling during an Upgrade

Containers are not removed from the old service until the sum of containers from the new service and old service have exceeded the final scale of the new service.

**Example:**

`service1` has a scale of 2 containers and is upgrading to `service2`, which will eventually have 5 containers.

```bash
$ rancher-compose upgrade service1 service2 --scale 5
```

`service1` | `service2` | Notes
---|---|---
2 | 0 |  `service1` is running with 2 containers.
2 | 2 | `service2` starts 2 containers at a time (Default [Batch Size]({{site.baseurl}}/rancher/rancher-compose/upgrading/#batch-size)).
2 | 4 | `service2` starts another 2 containers. 
1 | 4 | After the previous step, the sum (6) of the new and old containers is greater than the final scale (5), `service1` stops and removes one of the containers to maintain the final scale of 5.
1 | 5 | `service2` starts only 1 container to reach the final scale of 5.
0 | 5 | `service1` removes the last running container.


## Options with the Upgrade

With the `upgrade` command, there are several options that can be passed in to customize your upgrade.

### Final Scale

By default, the scale of a new service is based on the scale of the old service. You can change the scale of the new service by passing in `--scale` and a number. The number defines the final number of running containers you want in the new service. 

```bash
# Setting the scale of service2 to 8 containers
$ rancher-compose upgrade service1 service2 --scale 8
```

### Batch Size

By default, containers of the new service are started 2 at a time during an upgrade. You can change how many containers you want upgraded at a time, by passing in `--batch-size` and a number. This number is how many containers will be started in the new service during the upgrade process. 

```bash
# Containers of service2 will be started in batches of 3 
# until the scale of the service2 is reached
$ rancher-compose upgrade service1 service2 --batch-size 3
```

> **Note:** The containers of the old service will not be removed based on batch size. After the containers are launched in a particular batch, containers of the old service are stopped and removed when the sum of containers in the old and new service exceed the final scale of the new service.

### Interval

By default, during the upgrade, there is a 2 second wait between when containers on the new service have started and when containers on the old service are removed. You can override this interval by passing in `--interval` and the number of milliseconds for the interval.

```bash
# Set the interval to 30 seconds, which is the time between 
# when the containers of the new service have started and 
# when the containers of the old service are removed
$ rancher-compose upgrade service1 service2 --interval "30000"
```
### Updating Inbound Links

By default, any services that were linked **TO** the old service are also linked to the new service. If you don't want any of these services to be linked to the new service, you can pass in `--update-links="false"` so that there will be no links to the new service. 

```bash
# Do not set the links to the old service in the set up of the new service
$ rancher-compose upgrade service1 service2 --update-links="false"
```

### Waiting for Upgrade to Complete

By default, `rancher-compose` will exit after the upgrade has been passed to Rancher, but the upgrade may not have been completed. By passing in the `--wait` or `-w` to the `upgrade` command, `rancher-compose` will not exit until after the new service has completely started and the old service has been removed.

```bash
# Wait for the upgrade to be completed
$ rancher-compose upgrade service1 service2 --wait
```
