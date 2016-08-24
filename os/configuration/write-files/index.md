---
title: Writing Files in RancherOS
layout: os-default

---

## Writing Files
---

You can automate writing files to disk using the `write_files` cloud-config directive.

```yaml
#cloud-config
write_files:
  - path: /etc/rc.local
    permissions: "0755"
    owner: root
    content: |
      #!/bin/bash
      echo "I'm doing things on start"
```
