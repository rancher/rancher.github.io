---
title: Upgrading
layout: rancher-default-v1.0
version: v1.0
lang: en
---

## Upgrading Services with Rancher Compose
---

With `rancher-compose`, there are two methods of upgrades supported. With the `rancher-compose up --upgrade`, the containers in existing services are upgraded to the provided `docker-compose.yml` and the existing containers in the service are removed.  With the `rancher-compose upgrade`, a [rolling upgrade]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-compose/upgrading/#rolling-upgrade) can be performed. A new service will be deployed, and as it's deployed, the containers in the old service are stopped.

## In-Service Upgrade
---

For in-service upgrades, the commands are just options passed in during a `rancher-compose up` command. By adding the `--upgrade` option, the  `docker-compose.yml` will upgrade any services, that have the same name, in the stack. The in-service upgrade is a two step process as we require the user to confirm the upgrade is okay. 

### Step 1: Performing the Upgrade

For an upgrade, you can upgrade an entire stack or specific services within the `docker-compose.yml`

```bash
# Upgrades all services in the stack (i.e. docker-compose.yml)
$ rancher-compose up --upgrade
# Upgrade specific services (i.e. service1 and service2)
$ rancher-compose up --upgrade service1 service2
# Force an upgrade even though the docker-compose.yml for the services didn't change
$ rancher-compose up --force-upgrade
```

#### Upgrade Options

Option | Description
---|---
`--pull`, `-p`			|	Before doing the upgrade do an image pull on all hosts that have the image already
`-d`			|		Do not block and log
`--upgrade`, `-u`, `--recreate`		| Upgrade if service has changed
`--force-upgrade`, `--force-recreate` |	Upgrade regardless if service has changed
`--confirm-upgrade`, `-c` |		Confirm that the upgrade was success and delete old containers
`--rollback`, `-r`		|	Rollback to the previous deployed version
`--batch-size` "2"	|		Number of containers to upgrade at once
`--interval` "1000"	|		Update interval in milliseconds

<br>
**Pull** 

During your upgrade, you can also perform a `docker pull` before the images are deployed. Since the hosts would typically have your image already cached, you might want to add in the `--pull` option to pull the most up-to-date images on your hosts.

```bash
# During upgrade, force a pull to the host for latest images
$ rancher-compose up --upgrade --pull
```

**Batch Size**

By default, containers of the new service are started 2 at a time during an upgrade. You can change how many containers you want upgraded at a time, by passing in `--batch-size` and a number. This number is how many containers will be started in the new service during the upgrade process. 

```bash
# Containers of service2 will be started in batches of 3 
# until the scale of the service2 is reached
$ rancher-compose up --upgrade --batch-size 3
```

**Interval**

By default, during the upgrade, there is a 2 second wait between when containers on the new service have started and when containers on the old service are removed. You can override this interval by passing in `--interval` and the number of milliseconds for the interval.

```bash
# Set the interval to 30 seconds, which is the time between 
# when the containers of the new service have started and 
# when the containers of the old service are removed
$ rancher-compose upgrade service1 service2 --interval "30000"
```

#### Starting New Containers Before Stopping Old Containers

By default, the in-service upgrade stops the existing containers, and then launch the new containers. To start the new containers before stopping the old containers, you must provide additional content in the `rancher-compose.yml`.

```yaml
myservice:
  upgrade_strategy:
    start_first: true
```

<br>

```bash
# Upgrading myservice with the above yaml will start the new service first
$ rancher-compose up --upgrade myservice
```

### Step 2: Confirming the upgrade

Once you have verified the upgrade passes your validation, you will need to confirm that the upgrade is complete. The confirmation is required as it allows users to rollback to their old versions if necessary. **Once you have confirmed the upgrade, rolling back to the old version is no longer possible.**

```bash
# Confirm that the upgrade is complete and successful
$ rancher-compose up --upgrade --confirm-upgrade
```

#### Rolling Back 

After performing an upgrade, if your upgraded services have issues, Rancher provides the ability to roll back to your old service. This can only be accomplished if you have **not** confirmed your upgrade. 

```bash
# Roll back to previous version
$ rancher-compose up --upgrade --rollback
```

## Rolling Upgrade 
---

The command to perform a rolling upgrade to a new service is easy:  

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

By default, any load balancers or services linked to `service1` (i.e. inbound links) will automatically be updated with a new link to `service2`. If you do not wish for these links to be created, you can [set an option to not have them created]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-compose/upgrading/#updating-inbound-links).

> **Note:** There is no need for a `rancher-compose.yml` file used while upgrading services. By default, the scale of the new service is based on the scale of the old service. You can override this scale by passing in the `--scale` option. 

### Scaling during an Upgrade

Containers are not removed from the old service until the sum of containers from the new service and old service have exceeded the final scale of the new service.

**Example:**

```bash
$ rancher-compose upgrade service1 service2 --scale 5
```

`service1` has a scale of 2 containers and is upgrading to `service2`, which will eventually have 5 containers.

`service1` | `service2` | Notes
---|---|---
2 | 0 |  `service1` is running with 2 containers.
2 | 2 | `service2` starts 2 containers at a time (Default [Batch Size]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-compose/upgrading/#batch-size)).
2 | 4 | `service2` starts another 2 containers. 
1 | 4 | After the previous step, the sum (6) of the new and old containers is greater than the final scale (5), `service1` stops and removes one of the containers to maintain the final scale of 5.
1 | 5 | `service2` starts only 1 container to reach the final scale of 5.
0 | 5 | `service1` removes the last running container.


### Options with the `Upgrade` Command

With the `upgrade` command, there are several options that can be passed in to customize your upgrade.

Options | Description
---|---
`--batch-size` "2" |	Number of containers to upgrade at once
`--scale` "-1"	|		Final number of running containers
`--interval` "2000" |		Update interval in milliseconds
`--update-links` |	Update inbound links on target service
`--wait`, `-w`	|		Wait for upgrade to complete
`--pull`, `-p`	|		Before doing the upgrade do an image pull on all hosts that have the image already
`--cleanup`, `-c` |		Remove the original service definition once upgraded, implies --wait

#### Batch Size

By default, containers of the new service are started 2 at a time during an upgrade. You can change how many containers you want upgraded at a time, by passing in `--batch-size` and a number. This number is how many containers will be started in the new service during the upgrade process. 

```bash
# Containers of service2 will be started in batches of 3 
# until the scale of the service2 is reached
$ rancher-compose upgrade service1 service2 --batch-size 3
```

#### Final Scale

By default, the scale of a new service is based on the scale of the old service. You can change the scale of the new service by passing in `--scale` and a number. The number defines the final scale of running containers you want in the new service. 

```bash
# Setting the scale of service2 to 8 containers
$ rancher-compose upgrade service1 service2 --scale 8
```

<br>

> **Note:** The containers of the old service will not be removed based on batch size. After the containers are launched in a particular batch, containers of the old service are stopped and removed when the sum of containers in the old and new service exceed the final scale of the new service.

#### Interval

By default, during the upgrade, there is a 2 second wait between when containers on the new service have started and when containers on the old service are removed. You can override this interval by passing in `--interval` and the number of milliseconds for the interval.

```bash
# Set the interval to 30 seconds, which is the time between 
# when the containers of the new service have started and 
# when the containers of the old service are removed
$ rancher-compose upgrade service1 service2 --interval "30000"
```

#### Updating Inbound Links

By default, any services that were linked **TO** the old service are also linked to the new service. If you don't want any of these services to be linked to the new service, you can pass in `--update-links="false"` so that there will be no links to the new service. 

```bash
# Do not set the links to the old service in the set up of the new service
$ rancher-compose upgrade service1 service2 --update-links="false"
```

#### Waiting for Upgrade to Complete

By default, `rancher-compose` will exit after the upgrade has been passed to Rancher, but the upgrade process may not have been completed. By passing in the `--wait` or `-w` to the `upgrade` command, `rancher-compose` will not exit until after the new service has completely started and the old service has been stopped.

```bash
# Wait for the upgrade to be completed
$ rancher-compose upgrade service1 service2 --wait
```

#### Pulling a new Image

By default, `rancher-compose` will not pull an image if the image already exists on the host. By passing in the `--pull` or `-p` to the `upgrade` command, `rancher-compose` will pull the image again even if the image is already on the host. 

```bash
# Pull a new image even if image already exists
$ rancher-compose upgrade service1 service2 --pull
```

#### Cleanup Original Service

By default, the original service will remain in Rancher with a scale of 0 after the upgrade is complete. If you are positive that you will not need to rollback or save the original service definition, you can pass in the `--cleanup` or `-c` option with the `upgrade` command. This option implies that `--wait` as the `rancher-compose` will wait for the upgrade to be completed before removing the service from Rancher. 

```bash
# Cleanup service1 from Rancher after upgrade is complete
$ rancher-compose upgrade service1 service2 --cleanup
```
