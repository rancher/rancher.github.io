---
title: FAQS on Rancher
layout: rancher-default
---

## Troubleshooting FAQs
---

When trying to troubleshoot Rancher, here are some ways to get Rancher specific logs. If you open an issue, it would also be helpful to include the related logs. 

## Rancher Server

<a id="version"></a>

### What version of Rancher am I running?

As of our Beta release, you can click on the cow in the upper left hand corner, which will display which the versions of Rancher, Cattle, UI and Rancher-Compose. 

If clicking on the cow doesn't work, then you have a version prior to Beta. We recommend upgrading to Beta as it's a much more stable release due to many bug fixes. To find out what version you're running if prior to Beta, do a `docker inspect` on the container to view the environment variables. 

<a id="server-logs"></a>

### Where can I find detailed logs of the Rancher Server container?

Running `docker logs` on the Rancher server container will provide a set of the basic logs. To get more detailed logs, you can exec into the rancher server container and look at the log files.

```bash
# Exec into the server container
$ docker exec -it <container_id> bash

# Navigate to the location of the cattle logs
$ cd /var/lib/cattle/logs/
$ cat cattle-debug.log
```

Inside this folder, there will be `cattle-debug.log` and `cattle-error.log`. If you have been using Rancher server for many days, you will find a log file for each day as we create a new file for each day. 

#### Copying Rancher Server logs to the Host 

Here's the command to copy the Rancher server logs from the container to the host.

```bash
$ docker cp <container_uuid>:/var/lib/cattle/logs /local/path
```

Why is Go-Machine-Service continually restarting in my logs? What should I do?

Why is event-router restarting in my logs? What should I do? 


## Rancher Agent

### Why did Rancher agent failed to start? 

If you edited the `docker run .... rancher/agent...` command from the UI to add in `--name rancher-agent`, then Rancher agent will fail to start. Rancher agent launches 3 different containers after the initial run. There will be 1 running container and 2 stopped containers. The containers named `rancher-agent` and `rancher-agent-state` are required for the Rancher agent to successfully connect with Rancher server. The third container with the defaulted Docker name can be removed. 

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
$ docker cp <container_uuid>:/var/log/rancher /local/path
```


### How to check your host registration is set correctly? 

If you're having issues with Rancher Agents connect to Rancher Server, please check that your hosts are set up.



## Cross Host Communication

If containers on different hosts cannot ping each other, there are some common scenarios that could be the issue. 

### Are the IPs of the hosts correct in the UI?

Every so often, the IP of the host will accidentally pick up the docker bridge IP instead of the actual IP. These are typically `172.17.42.1` or starting with `172.17.x.x`. If this is the case, you need to re-register your host with the correct IP by explicitly setting the `CATTLE_AGENT_IP` environment variable in the `docker run` command.

```bash
$ sudo docker run -d --privileged -v /var/run/docker.sock:/var/run/docker.sock \
    -e CATTLE_AGENT_IP=<HOST_IP> \
    rancher/agent:v0.8.2 http://SERVER_IP:8080/v1/scripts/xxxx
```

### Have you confirmed that the UDP ports `500` and `4500` are open? 

In order for IPsec tunneling to work between the hosts, the UDP ports `500` and `4500` must be open. Use the following commands to ping between the different hosts.

```bash
$ 
```

## Network Agents

<a id="dns-config"></a>

### How can I see if my DNS is set up correctly?

If you want to see the configuration of the Rancher DNS setup, you will need to exec into any network agent in your setup. You can use the UI and select **Execute Shell** on the container. 

```bash
$ cat /var/lib/cattle/etc/cattle/dns/answers.json
```


<a id="lb-config"></a>

## Load Balancer

### How can I see the configuration of my Load Balancer?

If you want to see the configuration of the load balancer, you will need to exec into the specific _LB Agent_ container and look for the configuration file. You can use the UI and select **Execute Shell** on the container. 

```bash
$ cat /etc/haproxy/haproxy.cfg
```

This file will provide all the configuration details of the load balancer. 






## Authentication

<a id="manually-turn-off-github"></a>

### Help! I turned on [Access Control]({{site.baseurl}}/rancher/configuration/access-control/) and can no longer access Rancher. How do I reset Rancher to disable Access Control?

If something goes wrong with your authentication (like your GitHub authentication getting corrupted), then you may be locked out of Rancher. To re-gain access to Rancher, you'll need to turn off Access Control in the database. In order to do so, you'll need access to the machine that is running Rancher Server. 

```bash
$ docker exec -it <rancher_server_container_ID> bash
```

> **Note:** The `<rancher_server_container_ID>` will be the container that has the Rancher database. If you [upgraded]({{site.baseurl}}/rancher/upgrading/) and created a Rancher data container, you'll need to use the ID of the Rancher data container instead of the Rancher server container. 

```bash
root@container_id:/# mysql
```

Access the cattle database.

```bash
mysql> use cattle
```

Review the `setting` table.

```bash
mysql> select * from setting;  
```

Update the `api.security.enabled` to `false`. This change will turn off access control and anyone can access Rancher server with the UI/API.

```bash
mysql> update setting set value="false" where name="api.security.enabled";
```

Delete the client ID and secret key for GitHub.

```bash
mysql> update setting set value="" where name="api.auth.github.client.id";
mysql> update setting set value="" where name="api.auth.github.client.secret";
```

Confirm the chagnes have been made in the `setting` table.

```bash
mysql> select * from setting;  
```

It may take ~1 minute before the authentication will be turned off in the UI, but you will be able to refresh the webpage and access Rancher with access control turned off. 
