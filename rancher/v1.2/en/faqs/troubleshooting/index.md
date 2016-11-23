---
title: Troubleshooting FAQs about Rancher
layout: rancher-default-v1.2
version: v1.2
lang: en
redirect_from:
  - /rancher/faqs/
  - /rancher/faqs/troubleshooting/
  - /rancher/v1.2/en/faqs/
  - /rancher/latest/en/faqs/troubleshooting/
  - /rancher/latest/en/faqs/

---

## Troubleshooting FAQs
---

Please read more detailed FAQs about [Rancher Server]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/faqs/server) and [Rancher Agent/Hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/faqs/agents/).

This section assumes you were able to successfully start Rancher server and add hosts.

### Services/Containers

#### Why can I only edit the name of a container?

Docker containers are immutable (not changeable) after creation. The only things you can edit are things that we store that aren't really part of the Docker container. This includes restarting, it's still the same container if you stop and start it. You will need to remove and recreate a container to change anything else.

You can **Clone**, which will pre-fill the **Add Container** screen with all the settings from an existing container. If you forget one thing, you can clone the container, change it, and then delete the old container.

#### How do linked containers/services work in Rancher?

In Docker, linked containers (using `--link` in `docker run`) shows up in the `/etc/hosts` of the container it's linked to. In Rancher, we don't edit the `/etc/hosts`. Instead we run an [internal DNS server]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/internal-dns-service/) that makes links work across hosts. The DNS server would respond with the correct IP.

<a id="container-access"></a>

#### Help! I cannot execute the shell or view logs of the container from the UI. How does Rancher access the shell/logs of a container?

Since the agent is potentially open to the public internet, requests to the agent for a shell (or logs, etc) of a container aren't automatically trusted. The request from Rancher Server includes a JWT (JSON Web Token) and that JWT is signed by the server and can be verified by the agent to have actually come from the server. Part of that includes an expiration time, which is 5 minutes from when it is issued. This prevents a token from being used for long periods of time if it were to be intercepted, which is particularly important if not using SSL.

If you run docker logs -f rancher-agent and the logs show messages about an expired token, then please check that the date/time of the Rancher Server host and Rancher Agent host are in sync.

#### Where can I see logs of my service?

In the service details, we provide service logs in a tab called **Log**. In the **Log** tab, it lists out all events related to the service including a timestamp and description of the event.

### Cross Host Communication

If containers on different hosts cannot ping each other, there are some common scenarios that could be the issue.

#### How to check if cross host communication is working?

In the **Stacks** -> **Infrastructure Stacks**, check the status of the `healthcheck` stack. If the stack is active, then cross host communication is working.

To manually test, you can exec into any container and ping the internal IP (i.e. 10.42.x.x) of another container. The containers from infrastructure stacks may be hidden on the hosts page. To view them, select the "Show System" checkbox in the upper right corner.

#### Are the IPs of the hosts correct in the UI?

Every so often, the IP of the host will accidentally pick up the docker bridge IP instead of the actual IP. These are typically `172.17.42.1` or starting with `172.17.x.x`. If this is the case, you need to re-register your host with the correct IP by explicitly setting the `CATTLE_AGENT_IP` environment variable in the `docker run` command.

```bash
$ sudo docker run -d -e CATTLE_AGENT_IP=<HOST_IP> --privileged \
    -v /var/run/docker.sock:/var/run/docker.sock \
    rancher/agent:v0.8.2 http://SERVER_IP:8080/v1/scripts/xxxx
```

#### Containers on hosts unable to ping each other, how to check that the hosts can ping each other?

Log onto Host A. Ping Host B using the IP reported in the Rancher UI. It is important to use the IP reported in the UI because this is the IP that Rancher uses to establish connections between hosts. The ping command is simply: `ping <IP of Host B>`. Note also that the host must be accessible to each other on UDP ports `500` and `4500`.

If the ping works fine, ensure there is a network agent container running on each host using this command:

```bash
$ docker ps | grep 'rancher/agent-instance'
```

That should return one running container with output similar to this:

```bash
5923dd05b7d3        rancher/agent-instance:v0.4.1   "/etc/init.d/agent-i   15 minutes ago      Up 15 minutes       0.0.0.0:500->500/udp, 0.0.0.0:4500->4500/udp   4139cada-035f-4aa8-bd3a-f4c1dcbb3bab
```

If the container is there and running, you can check its logs for errors: `docker logs <id_of_container_from_above>`.

#### How to check IPtables rules are not being malformed?

Here is an iptables command that will provide useful debugging information.

```bash
# On the host
$ iptables -L -n --line-numbers -t nat
```

The CATTLE_PREROUTING chain will be of most interest. It lists rules that are necessary for exposing ports that you've specified in Rancher. Here is some sample output:

```bash
Chain CATTLE_PREROUTING (1 references)
num  target     prot opt source               destination
1    DNAT       tcp  --  0.0.0.0/0            0.0.0.0/0            ADDRTYPE match dst-type LOCAL tcp dpt:80 to:10.42.160.45:8080
2    DNAT       udp  --  0.0.0.0/0            0.0.0.0/0            ADDRTYPE match dst-type LOCAL udp dpt:4500 to:10.42.179.222:4500
3    DNAT       udp  --  0.0.0.0/0            0.0.0.0/0            ADDRTYPE match dst-type LOCAL udp dpt:500 to:10.42.179.222:500
```

The first rule is an example of a rule for a user-defined container in which the user mapped host port `80` to container port `8080`. The ip `10.42.160.45` is the IP the Rancher assigned to the container. If Rancher is working properly, you should a rule for each port mapping you defined for each container running on the host. The second two rules are for the Rancher network agent container that runs on each host to provide Rancher networking. We always use ports `500` and `4500`.

If it seems that you are missing rules, try deploying another container from the Rancher UI and specify a port mapping. When the container is deployed, all rules will be synced up with the Rancher database. This obviously is not a permanent fix to the problem, but is useful for debugging and short-term fixes.

#### Running Ubuntu, and containers are unable to communicate with each other.

If you have `UFW` enabled, you can either disable `UFW` OR change `/etc/default/ufw` to:

```
DEFAULT_FORWARD_POLICY="ACCEPT"
```

<a id="subnet"></a>

#### The subnet used by Rancher is already used in my network and prohibiting the managed network. How do I change the subnet?

To change the subnet used for networking of containers, you will need to ensure the networking infrastructure service that you want to use has the correct [subnet]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/networking/#subnets) in the `default_network` in the `rancher-compose.yml` file.

To change Rancher's IPsec network driver, you can export the yaml files and update the `subnet` address in the `rancher-compose.yml` file. After the files are updated, you can launch the infrastructure service independently.

> **Note:** The previous method of updating the subnet through the API will no longer be applicable as Rancher has moved to infrastructure services.

### DNS

<a id="dns-config"></a>

### How can I see if my DNS is set up correctly?

If you want to see the configuration of the Rancher DNS setup, go to the **Stacks** -> **Infrastructure Stacks**. Find the `dns` stack and exec into any of the containers. You can use the UI and select **Execute Shell** on the container.

```bash
$ cat /etc/rancher-dns/answers.json
```

### Networking

#### Where can I find logs for networking?

If you are having issues with networking inside Rancher, you can obtain the following logs from the **Network Agent** container.

```
/var/log/rancher-net.log
/var/log/charon.log
```

#### CentOS

##### Why are my containers unable to connect to network?

If you run a container on the host (i.e. `docker run -it ubuntu`) and the container cannot talk to the internet or anything outside the host, then you might have hit a networking issue.

CentOS will by default set `/proc/sys/net/ipv4/ip_forward` to `0`, which will essentially bork all networking for Docker.  Docker sets this value to `1` but if you run `service restart networking` on CentOS it sets it back to `0`.

<a id="lb-config"></a>

### Load Balancer

#### Why is my load balancer stuck in `Initializing`>?

Load balancers automatically have [health checks]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/health-checks/) enabled on them. If the load balancer is stuck in `initializing` state, then most likely the [cross host communication](#cross-host-communication) between the hosts is not working.

#### How can I see the configuration of my Load Balancer?

If you want to see the configuration of the load balancer, you will need to exec into the specific load balancer container and look for the configuration file. You can use the UI and select **Execute Shell** on the container.

```bash
$ cat /etc/haproxy/haproxy.cfg
```

This file will provide all the configuration details of the load balancer.

#### Where can I find the logs of HAProxy?

The logs of HAProxy can be found inside the load balancer container. `docker logs` of the load balancer container will only provide details of the service related to load balancer, but not the actual HAProxy logging.

```
$ cat /var/log/haproxy
```

### Authentication

<a id="manually-turn-off-github"></a>

#### Help! I turned on [Access Control]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/) and can no longer access Rancher. How do I reset Rancher to disable Access Control?

If something goes wrong with your authentication (like your GitHub authentication getting corrupted), then you may be locked out of Rancher. To re-gain access to Rancher, you'll need to turn off Access Control in the database. In order to do so, you'll need access to the machine that is running Rancher Server.

```bash
$ docker exec -it <rancher_server_container_ID> mysql
```

> **Note:** The `<rancher_server_container_ID>` will be the container that has the Rancher database. If you [upgraded]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/upgrading/) and created a Rancher data container, you'll need to use the ID of the Rancher data container instead of the Rancher server container.

Access the cattle database.

```bash
mysql> use cattle;
```

Review the `setting` table.

```bash
mysql> select * from setting;  
```

Update the `api.security.enabled` to `false` and clear the `api.auth.provider.configured` value . This change will turn off access control and anyone can access Rancher server with the UI/API.

```bash
mysql> update setting set value="false" where name="api.security.enabled";
mysql> update setting set value="" where name="api.auth.provider.configured";
```

Confirm the changes have been made in the `setting` table.

```bash
mysql> select * from setting;  
```

It may take ~1 minute before the authentication will be turned off in the UI, but you will be able to refresh the webpage and access Rancher with access control turned off.
