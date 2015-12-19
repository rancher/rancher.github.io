---
title: FAQS on Rancher
layout: rancher-default
---

## FAQs
---

### What version of Rancher am I running?

As of our Beta release, you can click on the cow in the upper left hand corner, which will display which version of Rancher you are running. 

If clicking on the cow doesn't work, then you have a version prior to Beta. We recommend upgrading to Beta as it's a much more stable release due to many bug fixes. To find out what version you're running if prior to Beta, do a `docker inspect` on the container to view the environment variables. 

### How do I run Rancher and my hosts behind a proxy?

For the Rancher server and any hosts, you'll need to configure the Docker daemon to point to the HTTP proxy. This configuration will need to occur before running any Docker commands. You'll need to edit the `/etc/default/docker` file to point to your proxy and restart Docker.

```bash
$ sudo vi /etc/default/docker
```

Within the file, edit the `#export http_proxy="http://127.0.0.1:3128/"` to have it point to your proxy. Save your changes and then restart docker. Restarting Docker is different on every OS. 

> **Note:** If running Docker with systemd, please follow Docker's [instructions](https://docs.docker.com/articles/systemd/#http-proxy) on how to configure the HTTP proxy. 

For Rancher server, you only need to launch Rancher server after the Docker daemon is configured.

For Rancher agents, for versions after v0.34.0, you can launch your rancher agents normally. For versions prior to v0.34.0, please review our [custom hosts section]({{site.baseurl}}/rancher/rancher-ui/infrastructure/hosts/custom/#hosts-behind-a-proxy) for instructions.

### How do linked containers/services work in Rancher?

In Docker, linked containers (using `--link` in `docker run`) shows up in the /etc/hosts of the container it's linked to. In Rancher, we don't edit the /etc/hosts. Instead we run a DNS server that makes links work across hosts. The DNS server would respond with the correct IP.

This means that any images that rely on populating environment variables from the `--link` container will not work. You will need to add these environment variables when adding the service/container.

<a id="subnet"></a>

### The subnet used by Rancher is already used in my network. How do I change the subnet?

In order for Rancher to work with a new subnet, you will need to update a setting in the API and create new environments. None of the existing environments in Rancher server (including the Default one) will use the new subnet after changing the setting. 

To change the setting in your API, you need to go to the following API page:

```
http://<rancher_server_ip>:8080/v1/settings/docker.network.subnet.cidr
```

Click on the **Edit** under the **Operations** section. Update the value from `10.42.0.0/16` to a subnet that works for you. 

Click on **Show Request** and finally **Send Request**. After the request is sent, you can click on **Reload** and see that the value has been updated in the API. 

After the value is updated, you'll need to create new environments to have containers start using the new subnet for the managed network. 

> **Note:** Any existing environment prior to the API change will not be updated to use the new subnet. 
