---
title: Additional Mounts
layout: os-default

---

## Additional Mounts
---

Additional mounts can be specified as part of your [cloud-config]({{site.baseurl}}/os/cloud-config/). These mounts are applied within the console container. Here's an example that will setup a simple bind mount.

```yaml
#cloud-config
write_files:
- path: /test
  content: test
- path: /home/rancher/test
mounts:
- ["/test", "/home/rancher/test", "", "bind"]
```

The four arguments for each mount are the same as those given for [cloud-init](https://cloudinit.readthedocs.io/en/latest/topics/examples.html#adjust-mount-points-mounted). Only the first four arguments are currently supported. The `mount_default_fields` and `swap` keys are also not implemented yet.

### Shared Mounts

By default, `/media` and `/mnt` are mounted as shared in the console container. This means that mounts within these directories will propogate to the host as well as other system services that mount these folders as shared.

See [here](https://www.kernel.org/doc/Documentation/filesystems/sharedsubtree.txt) for a more detailed overview of shared mounts and their properties.
