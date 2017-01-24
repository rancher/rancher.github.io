---
title: Adding Exoscale Hosts
layout: rancher-default-v1.4
version: v1.4
lang: en
---

## Adding Exoscale Hosts
---

Rancher supports provisioning [Exoscale](https://www.exoscale.ch/) hosts using `docker machine`.

### Finding Exoscale Credentials

In order to launch an Exoscale host, you'll need your **API Key** and **Secret Key** provided by Exoscale. Log in to your Exoscale account. Navigate to the _API Keys_ tab located in your _Profile_.  

### Launching Exoscale Host(s)

Now that we've found our **API Key** and **Secret Key**, we are ready to launch our Exoscale host(s). Under the **Infrastructure -> Hosts** tab, click **Add Host**. Select the **Exoscale** icon. Provide your Exoscale **API Key** and **Secret Key**, click on **Next: Authenticate & select a Security Group**.

Next, you'll select a security group to use for the hosts. There are two choices for security groups. The **Standard** option will create or use the existing `rancher-machine` security group. If Rancher creates the `rancher-machine` security group, it will open up all the necessary ports to allow Rancher to work successfully. `docker machine` will automatically open up port `2376`, which is the Docker daemon port.

In the **Custom** option, you can choose an existing security group, but you will need to ensure that specific ports are open in order for Rancher to be working correctly.

<a id="Ports"></a>

### Required Ports for Rancher to work:

* From the rancher server to TCP port 22 (SSH to install and configure Docker) and TCP port 2376 (access to Docker daemon)
* If you are using the IPsec [networking driver]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/networking/), from and to all other hosts on UDP ports `500` and `4500`
* If you are using the VXLAN [networking driver]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/networking/), from and to all other hosts on UDP ports `4789`

> **Note:** If you re-use the `rancher-machine` security group, any missing ports in the security group will not be re-opened. You will need to check the security group in Exoscale if the host does not launch correctly.

After choosing your security option, click on **Next: Set Instance Options**.

Finally, you'll just need to finish filling out the final details of the host(s).

1. Select the number of hosts you want to launch using the slider.
2. Provide a **Name** and if desired, **Description** for the host.
3. Select the **Instance Profile**.
4. Select the **Root Size**, which is the Exoscale disk size.
5. (Optional) Add **[labels]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#labels)** to hosts to help organize your hosts and to [schedule services/load balancers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/) or to [program external DNS records using an IP other than the host IP]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/external-dns-service/#using-a-specific-ip-for-external-dns).
6. (Optional) Customize your `docker-machine create` command with [Docker engine options](https://docs.docker.com/machine/reference/create/#specifying-configuration-options-for-the-created-docker-engine).
7. When complete, click **Create**.

> **Note:** Currently, not all options in `docker machine` are exposed in the UI for Exoscale. We use the default Exoscale endpoint (i.e. `https://api.exoscale.ch/compute`), image (i.e. `ubuntu-14.04`), and availability zone (i.e. `ch-gva-2`).

Once you click on create, Rancher will create the Exoscale instance and launch the _rancher-agent_ container in the instance. In a couple of minutes, the host will be active and available for [services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/).
