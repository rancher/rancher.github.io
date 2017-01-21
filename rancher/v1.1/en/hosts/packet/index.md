---
title: Adding Packet Hosts
layout: rancher-default-v1.1
version: v1.1
lang: en
redirect_from:
  - /rancher/v1.1/zh/hosts/packet/
---

## Adding Packet Hosts
---

Rancher supports provisioning [Packet](https://www.packet.net/) hosts using `docker machine`.

### Finding Packet Credentials

In order to launch a Packet host, you'll need an **API Key**. Log in to your Packet account.

1. Navigate to the [api-key page](https://app.packet.net/portal#/api-keys). If you haven't created an api key, you'll need to add one.

2. In the new api key screen, you'll put in a description (e.g. Rancher) and click **Generate**.

3. The newly created **Token** will be visible for you to copy and use in Rancher.

### Launching Packet Host(s)

Now that we've found our **Token**, we are ready to launch our Packet host(s). Under the **Infrastructure -> Hosts** tab, click **Add Host**. Select the **Packet** icon.

1. Select the number of hosts you want to launch using the slider.
2. Provide a **Name** and if desired, **Description** for the host.
3. Provide the **API Key** that you have created from your Packet account.
4. Provide the **Project** that you want the host to be launched. This project is found in your Packet account.
5. Select the **Image**. Whatever `docker machine` supports for Packet is also supported by Rancher.
5. Select the **Size** of the image.
6. Select the **Region** that you want to launch in.
7. (Optional) Add **[labels]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#labels)** to hosts to help organize your hosts and to [schedule services/load balancers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/) or to [program external DNS records using an IP other than the host IP]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/external-dns-service/#using-a-specific-ip-for-external-dns).
8. (Optional) Customize your `docker-machine create` command with [Docker engine options](https://docs.docker.com/machine/reference/create/#specifying-configuration-options-for-the-created-docker-engine).
9. When complete, click **Create**.

Once you click on create, Rancher will create the Packet and launch the _rancher-agent_ container. In a minute or two, the host will be active and available for [services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/).
