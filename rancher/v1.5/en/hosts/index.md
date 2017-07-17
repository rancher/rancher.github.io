---
title: Hosts in Rancher
layout: rancher-default-v1.5
version: v1.5
lang: en
---

## Getting Started with Hosts
---

Hosts are the most basic unit of resource within Rancher and is represented as any Linux server, virtual or physical, with the following minimum requirements:

* Any modern Linux distribution with a [supported version of Docker](#supported-docker-versions). [RancherOS](http://docs.rancher.com/os/), Ubuntu, RHEL/CentOS 7 are more heavily tested.
  * For RHEL/CentOS, the default storage driver, i.e. devicemapper using loopback, is not recommended by [Docker](https://docs.docker.com/engine/reference/commandline/dockerd/#/storage-driver-options). Please refer to the Docker documentation on how to change it.
  * For RHEL/CentOS, please use kernel version `3.10.0-514.2.2.el7.x86_64` or higher. Includes when using release 7.3 or higher.
* 1GB RAM
* Recommended CPU w/ AES-NI
* Ability to communicate with a Rancher server via http or https through the pre-configured port. Default is 8080.
* Ability to be routed to any other hosts under the same environment to leverage Rancher’s cross-host networking for Docker containers.

Rancher also supports Docker Machine and allows you to add your host via any of its supported drivers.

From the  **Infrastructure** -> **Hosts** tab, click on **Add Host**.

### Supported Docker Versions

Version               | Supported? | Kubernetes Support? | Install Script |
----------------------|------------|---------------------|-----------------
`1.9.x` and earlier   | No         |                     |
`1.10.0` - `1.10.2`   | No         |                     |
`1.10.3` (and higher) | **Yes**    | **Yes**             | `curl https://releases.rancher.com/install-docker/1.10.sh | sh`
`1.11.x`              | No         |                     | `curl https://releases.rancher.com/install-docker/1.11.sh | sh`
`1.12.0` - `1.12.2`   | No         |                     |
`1.12.3` (and higher) | **Yes**    | **Yes**             | `curl https://releases.rancher.com/install-docker/1.12.sh | sh`
`1.13.x`              | **Yes**    | No                  | `curl https://releases.rancher.com/install-docker/1.13.sh | sh`
`17.03.x-ee`          | **Yes**    | No                  | n/a
`17.03.x-ce`          | **Yes**    | No                  | `curl https://releases.rancher.com/install-docker/17.03.sh | sh`
`17.04.x-ce`          | No         |                     | `curl https://releases.rancher.com/install-docker/17.04.sh | sh`
`17.05.x-ce`          | No         | No                  |

### Installing a Specific Docker Version

The standard `curl https://get.docker.com | sh` always installs the latest Docker release available at that time and may not be supported by your installed Rancher version.  Instead, we recommend you use the scripts above to install a specific version.  These are a slightly modified version of the standard script and pin the installation to a specific Docker engine version.  Exact patch releases are also available as `1.<x>.<y>.sh`, e.g. `1.12.6.sh`.

> **Note:** If you are launching a host from the UI, you can select which version of Docker you'd like to install on the host. In the **Advanced Options** section, there is a **Docker Install URL**.

### How do Hosts work?

A host gets connected to Rancher server when the Rancher agent container is started on the host. The registration token, which is the long URL in  the **Add Host** -> **Custom** screen, is used by the Rancher agent to connect to the server for the first time. Upon connection, it generates an agent account and API key pair in Rancher server. The key pair is then used for all subsequent communication using the same authentication and authorization logic as there is for other kinds of accounts, like environment API keys.

The design is that the agent is untrusted because it is running on the outside and potentially hostile (to the server) hardware. The agent accounts have access to only the resources they need in the API, replies to events are checked that the event was actually sent to that agent, etc. There is not as much in the opposite direction for the agent to verify the host, so you can also set up TLS and the certificate will be verified.

The registration token is per [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/). It is generated on the server, stored in the database, and sent to the host as part of the agent registration with the API key pair. The connections are point to point between hosts and AES encrypted, which is accelerated by most modern CPUs.

<a id="addhost"></a>

### Adding a Host

The first time that you add a host, you may be required to set up the [Host Registration URL]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/settings/#host-registration). This setup determines what DNS name or IP address, and port that your hosts will be connected to the Rancher API. By default, we have selected the management server IP and port `8080`.  If you choose to change the address, please make sure to specify the port that should be used to connect to the Rancher API. At any time, you can update the [Host Registration]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/settings/#host-registration). After setting up your host registration, click on **Save**.

We support adding hosts directly from cloud providers or adding a host that's already been provisioned. For cloud providers, we provision using `docker-machine` and support any images that `docker-machine` supports.

Select which host type you want to add:

* [Adding Custom Hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/)
* [Adding Amazon EC2 Hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/amazon/)
* [Adding Azure Hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/azure/)
* [Adding DigitalOcean Hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/digitalocean/)
* [Adding Exoscale Hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/exoscale/)
* [Adding Packet Hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/packet/)
* [Adding Rackspace Hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/rackspace/)
* [Adding Hosts from Other Cloud Providers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/other/)

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
`io.rancher.host.docker_version` | Docker Version on the host (e.g. `1.10`) | Docker Engine Version on the host

### Scheduler IPs

In order to [enable the ability to publish ports on multiple IPs]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/#scheduling-against-multiple-ips-of-a-host), the host needs to be configured so that Rancher is aware of which IPs are available to be scheduled against. The method to add scheduler IPs for a host depends on whether the host is already in Rancher (i.e. Rancher agent has already been launched) versus a new host (i.e. Rancher agent has yet to be launched).

#### Adding Scheduler IPs to Existing Hosts
For any existing hosts in an environment, additional IPs can be added for scheduling by adding a specific host label (`io.rancher.scheduler.ips` to the host. In the UI, click on **Edit Host** for the host, and add a **Scheduler IP**. If you want to update the host details through the API, you would add the host label `io.rancher.scheduler.ips` and list the IPs as the value in a comma separated list (i.e. `1.2.3.4, 2.3.4.5`).

> **Note:** If any ports are published for services on a host before adding the scheduler IPs, those ports are published on `0.0.0.0`, which means they are consumed on all IPs, including the schedulers IPs added after the service has been launched.

#### Adding Scheduler IPs for a new Host

For any [custom hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/) that have not been added to Rancher, an environment variable (i.e. `CATTLE_SCHEDULER_IPS`) can be added to the Rancher agent command to list the available IPs on the host.

```bash
$  sudo docker run -e CATTLE_SCHEDULER_IPS='1.2.3.4,<IP2>,..<IPN>' -d --privileged \
    -v /var/run/docker.sock:/var/run/docker.sock rancher/agent:v0.8.2 \
    http://<rancher-server-ip>:8080/v1/projects/1a5/scripts/<registrationToken>
```

### Hosts behind an HTTP Proxy

If you are behind an HTTP proxy, in order to add hosts to Rancher server, you will need to edit the Docker daemon of the host to point to the proxy. The detailed instructions are listed within our [adding custom host page]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/#hosts-behind-a-proxy).

<a id="machine-config"></a>

### Accessing hosts from the Cloud Providers
If you choose to select to launch a host through Rancher, Rancher is making a  Docker Machine call to lauch in the cloud provider. We provide all the certificates generated when launching the machine in an easy to download file. Click on **Machine Config** in the host's dropdown menu. It will download a tar.gz file that has all the certificates.

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

If your host is deleted outside of Rancher, then Rancher server will continue to show the host until it's removed. After retrying the connection (_Reconnecting_), the host will show up in a _Disconnected_ state. You will be able to **Delete** the host to remove them from the UI. You can also configure a delay in seconds, after which the host will automatically be removed. This setting is called `host.remove.delay.seconds` and can be found under `Admin` -> `Settings` -> `Advanced Settings`.
