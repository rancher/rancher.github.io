---
title: Custom Hosts 
layout: rancher-default
---

## Adding Custom Hosts
---

If you already have Linux machines deployed and just want to add them into Rancher, click the **Custom** icon. In the UI, you will be provided a docker command to run on any host. The `docker` command launches the _rancher-agent_ container on the host. 

If you are using different [environments]({{site.baseurl}}/rancher/configuration/environments/), the command provided through the UI will be unique to whatever **environment** that you are in.

Ensure that you are in the environment that you want to add hosts to. The environment is displayed in the upper right corner next to the account drop-down. When you first log in to the Rancher instance, you are in the **Default** environment.

Once your hosts are added to Rancher, they are available for [our services]({{site.baseurl}}/rancher/rancher-ui/applications/stacks/adding-services/).

> **Note:** Ensure that the time stamp of your host on your server and hosts are the same and you have the access to the containers on the host. For more information, see [Rancher accesses the shell/logs of a container]({{site.baseurl}}/rancher/faqs/containers/#container-access). 

### Host Labels

With each host, you have the ability to add labels to help you organize your hosts. The labels are added as an environment variable when launching the rancher/agent container. The host label in the UI will be a key/value pair and the keys must be unique identifiers. If you added two keys with different values, we'll take the last inputted value to use as the key/value pair.

By adding labels to hosts, you can use these labels when [schedule services/load balancers/services]({{site.baseurl}}/rancher/rancher-ui/scheduling/) and create a whitelist or blacklist of hosts for your [services]({{site.baseurl}}/rancher/rancher-ui/applications/stacks/adding-services/) to run on. 

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

As of our Beta release (v0.24.0), Rancher no longer requires any additional TCP ports. But if you are using a version prior to Beta, then you will need to add the following ports:

* From the internet to TCP ports `9345` and `9346` (for UI hosts stats/graphs) 

<a id="samehost"></a>
### Adding Hosts to the same machine as Rancher Server

If you are adding an agent host on the same machine as Rancher server, you must edit the command provided from the UI. Additionally, in order for the _rancher-agent_ container to be launched correctly, set the `CATTLE_AGENT_IP` environment variable to the public IP of the VM that Rancher server is running on.

```bash
sudo docker run -d -e CATTLE_AGENT_IP=<IP_OF_RANCHER_SERVER> -v /var/run/docker....
```

If you have added a host onto the same host as Rancher server, note that you will not be able to create any containers on the host that binds to port `8080`. Since the UI of the Rancher server relies on the `8080` port, there will be a port conflict and Rancher will stop working. If you require using port `8080` for your containers, you could launch Rancher server using a different port. 

### Hosts behind a Proxy

In order to set up a HTTP proxy, configure the docker daemon to point to the proxy. Before you add the custom host, edit the `/etc/default/docker` file to point to your proxy and restart docker.

```bash
$ sudo vi /etc/default/docker
```

Within the file, edit the `#export http_proxy="http://127.0.0.1:3128/"` to have it point to your proxy. Save your changes and then restart docker. Restarting docker is different on every OS. 

> **Note:** If running docker with systemd, follow docker [instructions](https://docs.docker.com/articles/systemd/#http-proxy) on how to configure the HTTP proxy. 

#### Versions Starting with v0.34.0 and Later

As of v0.34.0, no additional environment variables need to be added to the command to launch Rancher agents. Ensure that your docker daemon is configured correctly.

#### Versions Prior to v0.34.0

For versions prior to v0.34.0, you'll need to add environment variables in order for the Rancher agent to leverage the proxy.

Potential Environment Variables to Set:

* http_proxy
* https_proxy
* NO_PROXY (must be capitalized)


> **Note:** NO_PROXY` must be set to the Rancher server IP address and localhost (i.e. 127.0.0.1) in order for Rancher agents to communicate directly to Rancher server. Communication between Rancher server and Rancher agents cannot go through the proxy. 

```bash
$ sudo docker run -d \
    -e http_proxy=<proxyURL> \
    -e https_proxy=<proxyURL> \
    -e NO_PROXY=127.0.0.1,<Rancher_Server_IP> \
    --privileged \
    -v /var/run/docker.sock:/var/run/docker.sock \
      rancher/agent:<agent_version> <URL provided from UI>
```

### VMs with Private and Public IP Addresses

By default, the IP of a VM with a private IP and public IP will be set to the public IP. If you wanted to change the IP address to the private one, you'll need to edit the command provided from the UI. In order for the _rancher-agent_  container to be launched correctly, set the `CATTLE_AGENT_IP` environment variable to the private IP address. All the hosts within Rancher will need to be on the same network as Rancher server. 

```bash
sudo docker run -d -e CATTLE_AGENT_IP=<PRIVATE_IP> -v /var/run/docker....
```

If you need to correct the IP of your host after the agent has connected, re-run the custom command. If the network agent has already started on your hosts, you'll need to restart the network on agents in your environment for the IPsec rules inside the network agent to be configured properly. 

> **Note:** When setting the private IP address, any existing containers in Rancher will not be part of the same managed network. 
