---
title: Azure Hosts 
layout: rancher-default-v1.0
version: v1.0
lang: en
---

## Adding Azure Hosts
---

Rancher supports provisioning [Microsoft Azure](https://azure.microsoft.com) hosts using `docker machine`. 

### Launching Azure Host(s)

1. Select the number of hosts you want to launch using the slider.
2. Provide a **Name** and if desired, **Description** for the host.
3. Provide the **Account Access** information from your Azure account. This includes **Username**, **Password**, **Subscription ID** and **Subscription Certificate**. 
     
    > **Note:** If you paste in your subscription certificate, it must be a base64 string.

4. Select the **Image** that you want launched. Whatever `docker machine` supports for Azure is also supported by Rancher.
5. Select the **Size** of the image. 
6. Update the **SSH port**, **Docker port** and **Docker Swarm Master Port** if they will be different from the default. 
7. Add your **Publish Settings File**. 
8. Select which **Region** your Azure resources are part of. 
9. (Optional) Add **[labels]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/infrastructure/hosts/#labels)** to hosts to help organize your hosts and to [schedule services/load balancers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/scheduling/) or to [program external DNS records using an IP other than the host IP]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/dns-service/#using-a-specific-ip-for-external-dns).
10. (Optional) In **Advanced Options**, customize your `docker-machine create` command with [Docker engine options](https://docs.docker.com/machine/reference/create/#specifying-configuration-options-for-the-created-docker-engine).
11. When complete, click **Create**. 

Once you click on create, Rancher will create the Azure virtual machine and launch the _rancher-agent_ container in the droplet. In a couple of minutes, the host will be active and available to start [adding services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/adding-services/).


