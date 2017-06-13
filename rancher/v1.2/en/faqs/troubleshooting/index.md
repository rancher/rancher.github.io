---
title: Troubleshooting FAQs about Rancher
layout: rancher-default-v1.2
version: v1.2
lang: en
redirect_from:
  - /rancher/v1.2/en/faqs/
  - /rancher/v1.2/zh/faqs/
  - /rancher/v1.2/zh/faqs/troubleshooting/
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

In the service details, we provide service logs in a tab called **Log**. In the **Log** tab, it lists out all events related to the service including a timestamp and description of the event that occurs in the API. These logs are kept for 24 hours before being deleted.

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

#### Running Ubuntu, and containers are unable to communicate with each other.

If you have `UFW` enabled, you can either disable `UFW` OR change `/etc/default/ufw` to:

```
DEFAULT_FORWARD_POLICY="ACCEPT"
```

<a id="subnet"></a>

#### The default subnet (`10.42.0.0/16`) used by Rancher is already used in my network and prohibiting the managed network. How do I change the subnet?

The default subnet used for Rancher's overlay networking is `10.42.0.0/16`. If your network is already using this subnet, you will need to change the default subnet used in Rancher's networking. You will need to ensure the networking infrastructure service that you want to use has the correct [subnet]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/networking/#subnets) in the `default_network` in the `rancher-compose.yml` file.

To change Rancher's IPsec or VXLAN network driver, you will need to have an [environment template]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#what-is-an-environment-template) with an updated infrastructure service. When creating a new environment template or editing an existing one, you edit the configuration of the networking infrastructure service by clicking on **Edit Config**. In the edit screen, you can enter a different subnet in the **Configuration Options** -> **Subnet** and click **Configure**. Any **new** environment using the updated environment template would be using the new subnet. Editing an existing environment template will not update the infrastructure services in existing environments.

Here's an example of the updated network driver's `rancher-compose.yml` to change the subnet to `10.32.0.0/16`.

```yaml
ipsec:
  network_driver:
    name: Rancher IPsec
    default_network:
      name: ipsec
      host_ports: true
      subnets:
      # After the configuration option is updated, the default subnet address is updated
      - network_address: 10.32.0.0/16
      dns:
      - 169.254.169.250
      dns_search:
      - rancher.internal
    cni_config:
      '10-rancher.conf':
        name: rancher-cni-network
        type: rancher-bridge
        bridge: docker0
        # After the configuration option is updated, the default subnet address is updated
        bridgeSubnet: 10.32.0.0/16
        logToFile: /var/log/rancher-cni.log
        isDebugLevel: false
        isDefaultGateway: true
        hostNat: true
        hairpinMode: true
        mtu: 1500
        linkMTUOverhead: 98
        ipam:
          type: rancher-cni-ipam
          logToFile: /var/log/rancher-cni.log
          isDebugLevel: false
          routes:
          - dst: 169.254.169.250/32
```

> **Note:** The previous method of updating the subnet through the API will no longer be applicable as Rancher has moved to infrastructure services.

### DNS

<a id="dns-config"></a>

### How can I see if my DNS is set up correctly?

If you want to see the configuration of the Rancher DNS setup, go to the **Stacks** -> **Infrastructure**. Find the `network-services` stack and select the `metadata` service. In the `metadata` service, exec into any of the containers named `network-services-metadata-dns-X`. You can use the UI and select **Execute Shell** on the container.

```bash
$ cat /etc/rancher-dns/answers.json
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

### HA

#### Rancher Compose Executor and Go-Machine-Service are continuously restarting.

In an HA set, if rancher-compose-executor and go-machine-service are continuously restarting, if you are behind a proxy, please ensure that proxy protocol is being used.

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
