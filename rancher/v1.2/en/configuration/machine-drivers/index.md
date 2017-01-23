---
title: Machine Drivers in Rancher
layout: rancher-default-v1.2
version: v1.2
lang: en
redirect_from:
  - /rancher/v1.2/zh/configuration/machine-drivers/
---

## Machine Drivers
---

[Docker-machine](https://docs.docker.com/machine/) drivers can be added into Rancher so that they can be available to [add hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/other/) into Rancher. Only an [admin]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/#admin) can change which machine drivers are visible, which can be located in  **Admin** -> **Machine Drivers**.

The **active** machine drivers are the only options that are displayed on the **Infrastructure** -> **Add Hosts** page. By default, Rancher provides many machine-drivers, which only a subset are **Active** in our UI.

### Adding Machine Drivers

You can easily add your own machine-driver by clicking on **Add Machine Driver**.

1. Provide the **Download URL**. This URL is the machine driver binary 64-bit Linux.
2. (Optional) Provide a **Custom UI URL** to load a customized Add Hosts screen for the driver. The [ui-driver-skel repository](https://github.com/rancher/ui-driver-skel) has more info on how to set it up.
3. (Optional) Provide the **Checksum** to verify the downloaded driver matches the expected checksum.
4. When complete, click **Create**.

After clicking on create, Rancher adds the additional driver and will display this option in the **Driver** field of adding [other hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/other/) or with a custom image (if provided).
