---
title: FAQS on Rancher
layout: rancher-default-v1.0
version: v1.0
lang: en
---

## FAQs on Rancher Agent
---

### How do I set up my hosts behind a Proxy? 

To support hosts behind a proxy, you’ll need to edit the Docker daemon to point to the proxy. The detailed instructions are listed within our [adding custom host page]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/infrastructure/hosts/custom/#hosts-behind-a-proxy).

### What are reasons why Rancher agent would fail to start? 

#### Adding in `--name rancher-agent`

If you edited the `docker run .... rancher/agent...` command from the UI to add in `--name rancher-agent`, then Rancher agent will fail to start. Rancher agent launches 3 different containers after the initial run. There will be 1 running container and 2 stopped containers. The containers named `rancher-agent` and `rancher-agent-state` are required for the Rancher agent to successfully connect with Rancher server. The third container with the defaulted Docker name can be removed. 

#### Using a cloned VM 

If you cloned a VM and attempting to register the cloned VM, it will not work and throw an error in the rancher-agent logs. `ERROR: Please re-register this agent.` The unique ID that rancher saves in `/var/lib/rancher/state` will be the same for cloned VMs and unable to re-register. 

The workaround for this is to run the following command on the cloned VM `rm -rf /var/lib/rancher/state; docker rm -fv rancher-agent; docker rm -fv rancher-agent-state`, once completed you can register the server again.

<a id="agent-logs"></a>

### Where can I find detailed logs of the Rancher Agent container?

Running `docker logs` will on the Rancher agent container will provide a set of basic logs. To get more detailed logs of rancher agent, you will need to have SSH into your host. In the host, you will navigate to the logs for rancher. 

```bash
# On the host with issues, navigate to the specific folder
$ cd /var/log/rancher/
$ cat agent.log
```

`agent.log` will be the most recent list of logs. We create a new file for logging after the log file has reached a certain size or a new rancher agent has been launched.

#### Copying Rancher Agent logs to the Host 

Here's the command to copy the Rancher agent logs from the container to the host.

```bash
$ docker cp <container_id>:/var/log/rancher /local/path
```

### How to check your host registration is set correctly? 

If you're having issues with Rancher Agents connect to Rancher Server, please check that your hosts are set up. When you first attempted to add a host in the Rancher UI, you had to set a Host Registration URL. The URL is used to establish a connection from your hosts to the Rancher API server. This URL must be reachable from your hosts. To verify that it is, log onto the host and execute a curl command:

```
curl -i <Host Registration URL you set in UI>/v1
```

You should get a json response. If authentication is turned on, the response code should be 401. If authentication is not turned on, the response code should be 200. 

> **Note:** Both normal HTTP connections and websocket connections (ws://) are used. If this URL points to a proxy or load balancer, make sure it is configured to handle websocket connections.

###  How does the host determine IP address and how can I change it? What do I do if the IP of my host has changed (due to reboot)? 

When the agent connects to Rancher server, it auto detects the IP of the agent. Sometimes, the IP that is selected is not the IP that you want to use or it selects the docker bridge IP, i.e. `172.17.x.x`. 

Alternatively, if you've already registered a host and your host has a new IP after a reboot, the IP of your host in the UI will no longer match. 

You can override the `CATTLE_AGENT_IP` setting and set the host IP to what you want. 

When the host has the incorrect IP, the containers will not have access to the managed network. To get the host and all containers into the managed network, just edit the command to [add in a custom host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/infrastructure/hosts/custom/) by specify the new IP as an environment variable (i.e Step 4). Run the edited command on the host. Do not stop or remove the existing agent on the host!

```bash
$ sudo docker run -d -e CATTLE_AGENT_IP=<NEW_HOST_IP> --privileged \
    -v /var/run/docker.sock:/var/run/docker.sock \
    rancher/agent:v0.8.2 http://SERVER_IP:8080/v1/scripts/xxxx
```

### What happens if my host is deleted outside of Rancher?

If your host is deleted outside of Rancher, then Rancher server will continue to show the host until it’s removed. Typically, these hosts will show up in a _Reconnecting_ state and never be able to reconnect. You will be able to **Delete** these hosts to remove them from the UI. 

If you have services that have deployed containers onto the `Reconnecting` hosts, they will only be re-scheduled to other hosts if you have added [health checks]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/health-checks/). 

### Why is the same host showing up in the UI multiple times?

If you are using boot2docker to add hosts, the hosts cannot persist `var/lib/rancher`, which is what Rancher uses to store necessary information for identify hosts. 
