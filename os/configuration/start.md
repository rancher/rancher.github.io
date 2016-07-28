

## Configuration and system services startup order 

RancherOS system services are basically system-docker containers. They are defined in [Docker Compose](https://docs.docker.com/compose/compose-file/) like format, primarily in the default system config file `/usr/share/ros/os-config.yml`. You can add or override services in cloud-config. 

Groups of services (in start-up order):

1. Device and power management:
  - udev-cold
  - udev
  - acpid

2. syslog

3. System configuration and networking: 
  - preload-system-images
  - cloud-init-pre
  - network-pre
  - ntp
  - cloud-init
  - network

4. User interaction:
  - console
  - docker

5. Post configuration:
  - preload-user-images


### System Docker Volumes

A few services are containers in "Created" state. Their only purpose is to provide volumes to others:

- **user-volumes** - provides user accessible persistent storage directories, used by console service:
  - /home
  - /opt

- **container-data-volumes** - provides docker storage directory, used by console service (and, indirectly, by docker):
  - /var/lib/docker

- **command-volumes** - provides necessary command binaries (read-only), used by system services:
  - /usr/bin/docker-containerd.dist
  - /usr/bin/docker-containerd-shim.dist
  - /usr/bin/docker-runc.dist
  - /usr/bin/docker.dist
  - /usr/bin/dockerlaunch
  - /usr/bin/user-docker
  - /usr/bin/system-docker
  - /sbin/poweroff
  - /sbin/reboot
  - /sbin/halt
  - /sbin/shutdown
  - /usr/bin/respawn
  - /usr/bin/ros
  - /usr/bin/cloud-init
  - /usr/sbin/netconf
  - /usr/sbin/wait-for-docker
  - /usr/bin/switch-console

- **system-volumes** - provides necessary persistent directories, used by system services:
  - /host/dev
  - /etc/docker
  - /etc/hosts
  - /etc/resolv.conf
  - /etc/ssl/certs/ca-certificates.crt.rancher
  - /etc/selinux
  - /lib/firmware
  - /lib/modules
  - /run
  - /usr/share/ros
  - /var/lib/rancher/cache
  - /var/lib/rancher/conf
  - /var/lib/rancher
  - /var/log
  - /var/run

- **all-volumes** - combines all of the above, used by console service


### preload-system-images

Loads images into system-docker (to prevent pulling from the network). Images to be [preloaded]({{site.baseurl}}/os/configuration/prepacking-docker-images) into system-docker should be archives in `.tar`, `.tar.gz` or `.tar.xz` format: saved by `docker save` and optionally compressed by `gzip` or `xz`. Image archives are loaded from `/var/lib/rancher/preload/system-docker` dir.


### cloud-init-pre

Fetches and saves user-data (aka cloud-config) and metadata from cloud provider / VM runtime / management service. Writes the results to:
  - `/var/lib/rancher/conf/cloud-config.d/boot.yml` - if user-data is cloud-config (begins with `#cloud-config`, YAML)
  - `/var/lib/rancher/conf/cloud-config-script` - if user-data is a script (begins with `#!`), it's saved here
  - `/var/lib/rancher/conf/metadata` - serialized cloud provider metadata

Configured by `rancher.cloud_init.datasources` list in [cloud-config]({{site.baseurl}}/os/cloud-config). It's pre-configured in cloud-provider specific images (e.g. AWS, GCE).


### network-pre

Sets up networking (hostname, interfaces, DNS). 

Configured by `hostname` and `rancher.network` [settings]({{site.baseurl}}/os/configuration/networking) in cloud-config.


### ntp

Runs `ntpd` in a system-docker container.


### cloud-init

Does the same thing as **cloud-init-pre**, but can also use network to fetch user-data and metadata (e.g. in cloud providers).


### network

Completes setting up networking with configuration obtained by **cloud-init**.


### console

Provides RancherOS user interface by running sshd and getty. Completes RancherOS configuration on start-up:

1. If `rancher.password=<password>` kernel parameter exists, sets `<password>` as password for `rancher` user.

2. Generates host SSH keys (if they are not generated yet) and saves them under `rancher.ssh.keys` in cloud-config.

3. Runs `cloud-init -execute`, which does the following:
  
  - Update `.ssh/authorized_keys` in `/home/rancher` and `/home/docker` from cloud-config and metadata.
  
  - Write files specified by `write_files` cloud-config setting.
  
  - Resize the device specified by `rancher.resize_device` cloud-config property.
  
  - Mount devices specified in `mounts` cloud-config setting.
  
  - Set sysctl parameters specified in `rancher.sysctl` cloud-config setting.

4. Runs `/var/lib/rancher/conf/cloud-config-script` if it exists (user-data is written to this file by **cloud-init** if it starts with `#!`). Any errors are ignored.

5. Runs `/opt/rancher/bin/start.sh` if it exists and is executable. Any errors are ignored.

6. Runs `/etc/rc.local` if it exists and is executable. Any errors are ignored.


### docker

Runs user docker daemon. Normally it runs inside the console system container by running `docker-init` script which, in turn, looks for docker binaries in `/opt/bin`, `/usr/local/bin` and `/usr/bin`, adds the first found directory with docker binaries to PATH and runs `dockerlaunch docker daemon` appending the passed arguments.

Docker daemon args are read from `rancher.docker.args` cloud-config property (followed by `rancher.docker.extra_args`).


### preload-user-images

Works the same way as **preload-system-images**, but loads images into user docker from `/var/lib/rancher/preload/docker` dir.


## RancherOS Configuration (cloud-config) Load Order

[Cloud-config]({{site.baseurl}}/os/cloud-config) is read by system services when they need to get configuration, and it gets loaded in a particular order.

1. `/usr/share/ros/os-config.yml` (system default configuration, should probably **not** be modified by users)
2. `/usr/share/ros/oem/oem-config.yml` if it exists (put there by OEM, probably not a good idea to touch this too)
3. Files from `/var/lib/rancher/conf/cloud-config.d/` ordered by filename (`/var/lib/rancher/conf/cloud-config.d/boot.yml` is put there by **`cloud-init`**)
4. `/var/lib/rancher/conf/cloud-config.yml` (`ros config set` saves data here) 
5. Kernel parameters with names starting with `rancher.`
6. Metadata (read from `/var/lib/rancher/conf/metadata`, where it's put by **`cloud-init`**)
