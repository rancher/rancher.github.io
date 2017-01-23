---
title: Adding Custom Hosts
layout: rancher-default-v1.1
version: v1.1
lang: en
redirect_from:
  - rancher/v1.1/en/rancher-ui/infrastructure/hosts/amazon/
  - rancher/v1.1/zh/rancher-ui/infrastructure/hosts/amazon/
  - /rancher/v1.1/zh/hosts/custom/
---

## Adding Custom Hosts
---

If you already have Linux machines deployed and just want to add them into Rancher, click the **Custom** icon. In the UI, you will be provided a docker command to run on any host. The `docker` command launches the _rancher-agent_ container on the host.

If you are using different [environments]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/), the command provided through the UI will be unique to whatever **environment** that you are in.

Ensure that you are in the environment that you want to add hosts to. The environment is displayed in the upper right corner next to the account drop-down. When you first log in to the Rancher instance, you are in the **Default** environment.

Once your hosts are added to Rancher, they are available for [our services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/).

> **Note:** Ensure that the time stamp of your host on your server and hosts are the same and you have the access to the containers on the host. For more information, see [Rancher accesses the shell/logs of a container]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/faqs/troubleshooting/#container-access).

### Host Labels

With each host, you have the ability to add labels to help you organize your hosts. The labels are added as an environment variable when launching the rancher/agent container. The host label in the UI will be a key/value pair and the keys must be unique identifiers. If you added two keys with different values, we'll take the last inputted value to use as the key/value pair.

By adding labels to hosts, you can use these labels when [schedule services/load balancers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/) and create a whitelist or blacklist of hosts for your [services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/) to run on.

When adding a custom host, you can add the labels using the UI and it will automatically add the environment variable (`CATTLE_HOST_LABELS`) with the key/value pair into the command on the UI screen.

_Example_

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

### Security Groups/Firewalls

For any hosts that are added, ensure that any security groups or firewalls allow traffic. If these are not enabled, the Rancher functionality will be limited.

* From and to all other hosts on UDP ports `500` and `4500` (for IPsec networking)

<a id="samehost"></a>

### Adding Hosts to the same machine as Rancher Server

If you are adding an agent host on the same machine as Rancher server, you must edit the command provided from the UI. Additionally, in order for the _rancher-agent_ container to be launched correctly, set the `CATTLE_AGENT_IP` environment variable to the public IP of the VM that Rancher server is running on.

```bash
$ sudo docker run -d -e CATTLE_AGENT_IP=<IP_OF_RANCHER_SERVER> -v /var/run/docker....
```

If you have added a host onto the same host as Rancher server, note that you will not be able to create any containers on the host that binds to port `8080`. Since the UI of the Rancher server relies on the `8080` port, there will be a port conflict and Rancher will stop working. If you require using port `8080` for your containers, you could launch Rancher server using a different port.

### Hosts behind a Proxy

In order to set up a HTTP proxy, configure the docker daemon to point to the proxy. Before you add the custom host, edit the `/etc/default/docker` file to point to your proxy and restart docker.

```bash
$ sudo vi /etc/default/docker
```

Within the file, edit the `#export http_proxy="http://127.0.0.1:3128/"` to have it point to your proxy. Save your changes and then restart docker. Restarting docker is different on every OS.

> **Note:** If running docker with systemd, follow docker [instructions](https://docs.docker.com/articles/systemd/#http-proxy) on how to configure the HTTP proxy.

No additional environment variables need to be added to the command to launch Rancher agents. You only need to ensure that your docker daemon is configured correctly.

### VMs with Private and Public IP Addresses

By default, the IP of a VM with a private IP and public IP will be set to match the IP specified in the registration URL. For example, if a private IP is used in the registration URL, then the host's private IP will be used. If you wanted to change the host's IP address, you’ll need to edit the command provided from the UI. In order for the rancher-agent container to be launched correctly, set the CATTLE_AGENT_IP environment variable to the desired IP address. All the hosts within Rancher will need to be on the same network as Rancher server.

```bash
$ sudo docker run -d -e CATTLE_AGENT_IP=<PRIVATE_IP> -v /var/run/docker....
```

If you need to correct the IP of your host after the agent has connected, re-run the custom command. If the network agent has already started on your hosts, you'll need to restart the network on agents in your environment for the IPsec rules inside the network agent to be configured properly.

> **Note:** When setting the private IP address, any existing containers in Rancher will not be part of the same managed network.
