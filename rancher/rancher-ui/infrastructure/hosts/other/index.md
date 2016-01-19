---
title: Other Hosts 
layout: rancher-default
---

## Adding Hosts from Other Cloud Providers
---

Rancher supports provisioning from other cloud providers using `docker-machine`. The other cloud providers have a generic UI, which provides all the options in `docker-machine`, and we only require the necessary parameters.

Please review the docker-machine defaults for the driver you selected to confirm that you are okay with the defaults.

### Launching Other Host(s) 

Select the **Other** icon in the **Add Host** page. 

1. Select the number of hosts you want to launch using the slider.
2. Provide a **Name** and if desired, **Description** for the host.
3. Select the type of **Driver** that you'd like to use. 
4. Based on your **Driver**, the **Driver Options** section will be populated according to the available options in `docker-machine`. 
5. (Optional) Add **[labels]({{site.baseurl}}/rancher/rancher-ui/infrastructure/hosts/#labels)** to hosts to help organize your hosts and to [schedule services/load balancers]({{site.baseurl}}/rancher/rancher-ui/scheduling/).
6. (Optional) Customize your `docker-machine create` command with [Docker engine options](https://docs.docker.com/machine/reference/create/#specifying-configuration-options-for-the-created-docker-engine).
7. When complete, click **Create**. 

Once you click on create, Rancher will create start a VM in your selected **Driver** using `docker-machine` and launch the _rancher-agent_ container in the VM. In a couple of minutes, the host will be active and available for [services]({{site.baseurl}}/rancher/rancher-ui/applications/stacks/adding-services/).

#### Notes on Azure

When provisioning an Azure host, you'll need to make sure your `subscriptionCert` is a base64 string. You can convert your existing cert into base64. 

```bash
$ cat ~/.docker/ca.pem | base64
```

Use the long string that is returned to input into the `subscriptionCert` field. 