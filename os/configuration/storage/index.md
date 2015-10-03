---
title: Docker
layout: os-default

---

## Configuring Storage

By default User Docker runs in the console container.  This means that it will for the most part act and behave like Docker on any other standard Linux distribution.  Customizing the storage that is available to Docker is largely a matter of installing components into the console.  There is a second option in which you can create a dedicated container to provide storage.

### Modifying Console

#### Example: Mounting NFS

Example of mounting `192.168.1.180:/home` to `/mnt`

```yaml
#cloud-config
rancher:
  services_include:
    ubuntu-console: true

write_files:
  # /opt/rancher/bin/start.sh is executed on start before User Docker starts
  # /etc/rc.local is also executed on start but not guarenteed to be ran before User Docker
  - path: /opt/rancher/bin/start.sh
    permissions: "0755"
    owner: root
    content: |
      #!/bin/bash
      if ! dpkg -l | grep -q nfs-common; then
        apt-get update -qq && apt-get install -y nfs-common
      fi
      rpcbind
      mount -t nfs 192.168.1.180:/home /mnt
```

### Custom Storage Container

A custom storage container can be created and Docker will run inside of that container and not the console.  This allows one to provide custom storage but maintain a lightweight and ephemeral console.

#### Example:

```yaml
#cloud-config

rancher:
  docker:
    # This must be the name of the service that provides the storage.  Docker will run this container.
    storage_context: nfs
    
  services:
    nfs:
      # Your custom image
      image: example/custom-nfs-image

      # Everything below is required to be set so that Docker can run properly
      labels:
        io.rancher.os.after: console
        io.rancher.os.scope: system
      net: host
      pid: host
      uts: host
      ipc: host
      privileged: true
      restart: always
      volumes_from:
      - all-volumes
      volumes:
      - /usr/bin/iptables:/sbin/iptables:ro
```
