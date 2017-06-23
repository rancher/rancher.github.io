---
title: Hosts in Rancher
layout: rancher-default-v1.1
version: v1.1
lang: en
redirect_from:
  - /rancher/v1.1/en/rancher-ui/infrastructure/hosts/
  - /rancher/v1.1/zh/rancher-ui/infrastructure/hosts/
  - /rancher/v1.1/zh/hosts/
---

## Getting Started with Hosts
---

Hosts are the most basic unit of resource within Rancher and is represented as any Linux server, virtual or physical, with the following minimum requirements:

* Any modern Linux distribution that supports Docker 1.10.3+. [RancherOS](http://docs.rancher.com/os/), Ubuntu, RHEL/CentOS 7 are more heavily tested.
  * For RHEL/CentOS, the default storage driver, i.e. devicemapper using loopback, is not recommended by [Docker](https://docs.docker.com/engine/reference/commandline/dockerd/#/storage-driver-options). Please refer to the Docker documentation on how to change it.
* 1GB RAM
* Recommended CPU w/ AES-NI
* Ability to communicate with a Rancher server via http or https through the pre-configured port. Default is 8080.
* Ability to be routed to any other hosts under the same environment to leverage Rancher’s cross-host networking for Docker containers.

Rancher also supports Docker Machine and allows you to add your host via any of its supported drivers.

From the  **Infrastructure** -> **Hosts** tab, click on **Add Host**.

### How do Hosts work?

A host gets connected to Rancher server when the rancher agent container is started on the host. The registration token, which is the long URL in  the **Add Host** -> **Custom** screen, is used by the rancher agent to connect to the server for the first time. Upon connection, it generates an agent account and API key pair in Rancher server. The key pair is then used for all subsequent communication using the same authentication and authorization logic as there is for other kinds of accounts, like environment API keys.

The design is that the agent is untrusted because it is running on the outside and potentially hostile (to the server) hardware. The agent accounts have access to only the resources they need in the API, replies to events are checked that the event was actually sent to that agent, etc. There is not as much in the opposite direction for the agent to verify the host, so you can also set up TLS and the certificate will be verified.

The IPSec key is per [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/). It is generated on the server, stored in the database, and sent to the host as part of the agent registration with the API key pair. The connections are point to point between hosts and AES encrypted, which is accelerated by most modern CPUs.

<a id="addhost"></a>

### Adding a Host

The first time that you add a host, you may be required to set up the [Host Registration]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/settings/#host-registration). This setup determines what DNS name or IP address, and port that your hosts will be connected to the Rancher API. By default, we have selected the management server IP and port `8080`.  If you choose to change the address, please make sure to specify the port that should be used to connect to the Rancher API. At any time, you can update the [Host Registration]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/settings/#host-registration). After setting up your host registration, click on **Save**.

We support adding hosts directly from cloud providers or adding a host that's already been provisioned. For cloud providers, we provision using `docker-machine` and support any images that `docker-machine` supports.

Select which host type you want to add:

* [Adding Custom Hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/)
* [Adding Amazon EC2 Hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/amazon/)
* [Adding Azure Hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/azure/)
* [Adding DigitalOcean Hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/digitalocean/)
* [Adding Exoscale Hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/exoscale/)
* [Adding Packet Hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/packet/)
* [Adding Rackspace Hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/rackspace/)
* [Adding Hosts from Other Drivers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/other/)

When a host is added to Rancher, a rancher agent container is launched on the host. Rancher will automatically pull the correct image version tag for the `rancher/agent` and run the required version. The agent version is tagged specifically to each Rancher server version.

<a id="labels"></a>

### Host Labels

With each host, you have the ability to add labels to help you organize your hosts. The labels are added as an environment variable when launching the rancher/agent container. The host label in the UI will be a key/value pair and the keys must be unique identifiers. If you added two keys with different values, we'll take the last inputted value to use as the key/value pair.

By adding labels to hosts, you can use these labels when [schedule services/load balancers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/) and create a whitelist or blacklist of hosts for your [services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/) to run on.

If you are planning to use an [external DNS service]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/external-dns-service/) and will require [to program the DNS records using an IP other than the host IP]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/external-dns-service/#using-a-specific-ip-for-external-dns), then you will need to include the label `io.rancher.host.external_dns_ip=<IP_TO_BE_USED_FOR_EXTERNAL_DNS>` on the host. The host label can be added when registering the host or after the host has been added to Rancher, but it should be added to the host before the external DNS service starts. The value of this label will be used when programming rules for external DNS services.

When using the UI to add hosts with the different cloud providers, the rancher/agent command is automatically launched for you with the host labels that are added in the UI.

When adding a custom host, you can add the labels using the UI and it will automatically add the environment variable (`CATTLE_HOST_LABELS`) with the key/value pair into the command on the UI screen.

##### Example

```bash
# Adding one host label to the rancher/agent command
$  sudo docker run -e CATTLE_HOST_LABELS='foo=bar' -d --privileged \
    -v /var/run/docker.sock:/var/run/docker.sock rancher/agent:v0.8.2 \
    http://<rancher-server-ip>:8080/v1/projects/1a5/scripts/<registrationToken>

# Adding more than one host label requires joining the additional host labels with an `&`
$  sudo docker run -e CATTLE_HOST_LABELS='foo=bar&hello=world' -d --privileged \
    -v /var/run/docker.sock:/var/run/docker.sock rancher/agent:v0.8.2 \
    http://<rancher-server-ip>:8080/v1/projects/1a5/scripts/<registrationToken>
```

<br>

> **Note:** The `rancher/agent` version is correlated to the Rancher server version. You will need to check the custom command to get the appropriate tag for the version to use.

#### Automatically Applied Host Labels

Rancher automatically creates host labels related to linux kernel version and Docker Engine version of the host.

Key | Value | Description
----|----|----
`io.rancher.host.linux_kernel_version` | Linux Kernel Version on Host (e.g, `3.19`) |  Version of the Linux kernel running on the host
`io.rancher.host.docker_version` | Docker Version on the host (e.g. `1.10.3`) | Docker Engine Version on the host


### Hosts behind a Proxy
To support hosts behind a proxy, you'll need to edit the Docker daemon to point to the proxy. The detailed instructions are listed within our [adding custom host page]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/#hosts-behind-a-proxy).

<a id="machine-config"></a>

### Accessing hosts from the Cloud Providers
After Rancher launches the host, you may want to be able to access the host. We provide all the certificates generated when launching the machine in an easy to download file. Click on **Machine Config** in the host's dropdown menu. It will download a tar.gz file that has all the certificates.

To SSH into your host, go to your terminal/command prompt. Navigate to the folder of all the certificates and ssh in using the `id_rsa` certificate.

```bash
$ ssh -i id_rsa root@<IP_OF_HOST>
```

### Cloning a Host

Since launching hosts on cloud providers requires using an access key, you might want to easily create another host without needing to input all the credentials again. Rancher provides the ability to clone these credentials to spin up a new host. Select **Clone** from the host's drop down menu. It will bring up an **Add Host** page with the credentials of the cloned host populated.

### Editing Hosts

The options for what can be done to a host are located in the host's dropdown. From the **Infrastructure** -> **Hosts** page, the dropdown icon will appear when you hover over the host. If you click on the host name to view more details of a host, the dropdown icon is located in the upper right corner of the page. It's located next to the State of the host.

If you select **Edit**, you can update the name, description or labels on the host.

### Deactivating/Activating Hosts

Deactivating the host will put the host into an _Inactive_ state. In this state, no new containers can be deployed. Any active containers on the host will continue to be active and you will still have the ability to perform actions on these containers (start/stop/restart). The host will still be connected to the Rancher server. Select **Deactivate** from the host's dropdown menu.

When a host is in the _Inactive_ state, you can bring the host back into an _Active_ state by clicking on **Activate** from the host's dropdown menu.

> **Note:** If a host is down in Rancher (i.e. in `reconnecting` or `inactive` state), you will need to implement a [health check]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/health-checks/) in order for Rancher to launch the containers on your service on to a different host.

### Removing Hosts

In order to remove a host from the server, you will need to do a couple of steps from the dropdown menu.

Select **Deactivate**. When the host has completed the deactivation, the host will display an _Inactive_ state. Select **Delete**. The server will start the removal process of the host from the Rancher server instance. The first state that it will display after it’s finished deleting it will be _Removed_. It will continue to finalize the removal process and move to a _Purged_ state before immediately disappearing from the UI.

If the host was created on a cloud provider using Rancher, the host will be deleted from the cloud provider. If the host was added by using the [custom command]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/), the host will remain on the cloud provider.

> **Notes:** For custom hosts, all containers including the Rancher agent will continue to remain on the host. Also, the IP set on the `docker0` interface by the Rancher network driver will remain.

### Deleting Hosts outside of Rancher

If your host is deleted outside of Rancher, then Rancher server will continue to show the host until it’s removed. Eventually, these hosts will show up in a _Reconnecting_ state and never be able to reconnect. You will be able to **Delete** these hosts to remove them from the UI.
