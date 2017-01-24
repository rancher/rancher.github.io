---
title: Adding Other Hosts
layout: rancher-default-v1.4
version: v1.4
lang: en
---

## Adding Hosts from Other Cloud Providers
---

Rancher supports provisioning from other cloud providers using `docker-machine`. The other cloud providers have a generic UI, which provides all the options in `docker-machine`, and we only require the necessary parameters.

Please review the Docker Machine defaults for the driver you selected to confirm that you are okay with the defaults.

### Adding Additional Drivers

If you'd like to add other drivers to your Rancher instance, an [admin]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/accounts/#admin) will need to add them in our [machine drivers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/machine-drivers/) page.

### Launching Other Host(s)

Select the **Other** icon in the **Add Host** page.

1. Select the number of hosts you want to launch using the slider.
2. Provide a **Name** and if desired, **Description** for the host.
3. Select the type of **Driver** that you'd like to use.
4. Based on your **Driver**, the **Driver Options** section will be populated according to the available options in `docker-machine`.
5. (Optional) Add **[labels]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#labels)** to hosts to help organize your hosts and to [schedule services/load balancers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/) or to [program external DNS records using an IP other than the host IP]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/external-dns-service/#using-a-specific-ip-for-external-dns).
6. (Optional) Customize your `docker-machine create` command with [Docker engine options](https://docs.docker.com/machine/reference/create/#specifying-configuration-options-for-the-created-docker-engine).
7. When complete, click **Create**.

Once you click on create, Rancher will create start a VM in your selected **Driver** using `docker-machine` and launch the _rancher-agent_ container in the VM. In a couple of minutes, the host will be active and available for [services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/).
