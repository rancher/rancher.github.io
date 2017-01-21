---
title: Virtual Machines
layout: rancher-default-v1.3
version: v1.3
lang: en
redirect_from:
  - /rancher/v1.3/zh/cattle/vms/
---

## Getting Started with Virtual Machines
---

By default, launching virtual machines (VMs) in Rancher is disabled. To enable launching VMs, any [admin]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/#admin) can enable virtual machines in Rancher in the **Admin** -> **Settings** -> **Virtual Machines** section. Select **Enabled** and click **Save**.

### Hosts Requirements for Launching VMs

* Ubuntu
* RancherOS - Requires `userland-proxy` to be enabled with the following cloud-config

   ```
   #cloud-config
   rancher:
     docker:
       extra_args: [--userland-proxy=true]                                                                                                   
   ```

### Adding VMs

In **Infrastructure** -> **Virtual Machines**, click on **Add Virtual Machine** and set up your virtual machine.

For image name options, currently Rancher only supports `rancher/vm-ubuntu`. The username/password is `ubuntu/ubuntu`.

Click on **Create**.

After the container has been launched, click on the dropdown of the container to log in to the VM by clicking **Open Console**.
