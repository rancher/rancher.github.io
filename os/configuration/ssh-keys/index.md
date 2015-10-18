---
title: Configuring RancherOS with SSH Keys
layout: os-default

---

## Configuring SSH Keys for RancherOS
---

RancherOS supports adding SSH keys through the [cloud-config]({{site.baseurl}}/os/cloud-config) file. Within the cloud-config file, you simply add the ssh keys within the `ssh-authorized-keys` key. 

```yaml
#cloud-config
ssh_authorized_keys:
  - ssh-rsa AAA...ZZZ example1@rancher
  - ssh-rsa BBB...ZZZ example2@rancher
```

When we pass the cloud-config file during the `ros install` command, it will allow these ssh keys to be associated with the **rancher** user. You can ssh into RancherOS using the key.

```bash
$ ssh -i /path/to/private/key rancher@<ip-address>
```

