---
title: Loading Kernel Modules
layout: os-default

---

## Loading Kernel Modules
---

Privileged containers can load kernel modules.  In RancherOS we have the kernel modules in the standard `/lib/modules/$(uname -r)` folder.  If you want to be able to run `modprobe` from a container just bind mount `/lib/modules` into your container.  For example

```yaml
myservice:
  image: ...
  privileged: true
  volumes:
  - /lib/modules:/lib/modules
```

The `/lib/modules` folder is already available in the console by default.
