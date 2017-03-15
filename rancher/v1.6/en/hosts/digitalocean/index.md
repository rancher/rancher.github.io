---
title: Adding DigitalOcean Hosts
layout: rancher-default-v1.6
version: v1.6
lang: en
---

## Adding DigitalOcean Hosts
---

Rancher supports provisioning [DigitalOcean](https://www.digitalocean.com/) hosts using `docker machine`.

### Finding DigitalOcean Credentials

In order to launch a DigitalOcean host, you'll need a **Personal Access Token** provided by DigitalOcean. Log in to your DigitalOcean account.

1. Navigate to the [Apps & API page](https://cloud.digitalocean.com/settings/applications).

2. In the **Personal Access Tokens**, click on the **Generate New Token** button. Name your token (e.g. Rancher) and click **Generate Token**.

3. Copy your **Access Token** from the UI and save it somewhere safe. This is the only time you will be able to see the access token. Next time you go to the page, the token will no longer be shown and you will not be able to retrieve it.

### Launching DigitalOcean Host(s)

Now that we've saved the **Access Token**, we are ready to launch our DigitalOcean host. Under the **Infrastructure -> Hosts** tab, click **Add Host**. Select the **DigitalOcean** icon.

1. Select the number of hosts you want to launch using the slider.
2. Provide a **Name** and if desired, **Description** for the host.
3. Provide the **Access Token** that you have created for your DigitalOcean account.
4. Select the **Image** that you want launched. Whatever `docker machine` supports for DigitalOcean is also supported by Rancher.
5. Select the **Size** of the image.
6. Select the **Region** that you want to launch in. We've provided the available regions that can be launched using metadata. Some regions may not be included as the API doesn't support it.
7. (Optional) If you want to enable any of the advanced options (i.e. backups, IPv6, private networking), select the ones that you want to include.
8. (Optional) Add **[labels]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#labels)** to hosts to help organize your hosts and to [schedule services/load balancers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/) or to [program external DNS records using an IP other than the host IP]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/external-dns-service/#using-a-specific-ip-for-external-dns).
9. (Optional) In **Advanced Options**, customize your `docker-machine create` command with [Docker engine options](https://docs.docker.com/machine/reference/create/#specifying-configuration-options-for-the-created-docker-engine).
10. When complete, click **Create**.

Once you click on create, Rancher will create the DigitalOcean droplet and launch the _rancher-agent_ container in the droplet. In a couple of minutes, the host will be active and available for [services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/).
