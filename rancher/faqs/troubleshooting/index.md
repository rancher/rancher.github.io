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
$ docker cp <container_id>:/var/lib/cattle/logs /local/path
```

### Why is Go-Machine-Service continually restarting in my logs? What should I do?

Go-machine-service is a micro-service that connects to the Rancher API server via a websocket connection. If it fails to connect, it restarts and tries again. 

If you are running in [Single Node]({{site.baseurl}}/rancher/installing-rancher/installing-server/) setup, it will connect to the Rancher API server using the URL you set for Host Registration. Verify that the Host Registration URL can be reached from inside the rancher-sever container.

```bash
$ docker exec -it <rancher-server_container_id> bash
# Inside the rancher-server container
$ curl -i <Host Registration URL you set in UI>/v1
```
You should get a json response. If authentication is turned on, the response code should be 401. If authentication is not turned on, the response code should be 200.

If you are running in [Multi Node]({{site.baseurl}}/rancher/installing-rancher/installing-server/multi-nodes/) setup, then you started go-machine-service in its own container and explicitly provided a URL, access key, and secret key as environment variables upon startup. Verify that the Rancher API server can be reached using those variables. Verify the connectivity by logging into the go-machine-service container and making a curl command using the parameters your provided to the container:

```bash
$ docker exec -it <go-machine-service_container_id> bash
# Inside the go-machine-service container
$ curl -i -u '<value of CATTLE_ACCESS_KEY>:<value of CATTLE_SECRET_KEY>' <value of CATTLE_URL>
```

You should get a json response back and a 200 response code.

If the curl command fails, then you have a connectivity issue between go-machine-service and the Rancher API server.

If the curl command does not fail, the problem could be related to the fact that go-machine-service is attempting to establish a websocket connection, not a normal http connection. If you have a proxy or load balancer between go-machine-service and your Rancher API server, verify that it is configured to allow websocket connections.

### Rancher server was working and has now slowed down tremendously. How can I recover?

Most likely there are some tasks that are stuck running for some reason. If you are able to look at the **Admin** -> **Processes** tab in the UI, you'd be able to see what is stuck in `Running`. If these tasks have been running (and failing) for a long time, Rancher ends up using too much memory to track the tasks. Essentially creates a running out of memory situation for Rancher server. 

In order to get your server into a responsive state, you'll need to add more memory. Typically, 4GB is more than sufficient. 

If you run the Rancher server command again, just add an additional option, `-e JAVA_OPTS="-Xmx4096m"` to the command. 

```bash
$ docker run -d -p 8080:8080 --restart=always -e JAVA_OPTS="-Xmx4096m" rancher/server
```

Depending on how the MySQL database is setup, you may need to do an [upgrade]({{site.baseurl}}/rancher/upgrading/) to add the additional command. 

If you were unable to see the **Admin** -> **Processes** tab due to the lack of memory, after starting Rancher server again with more memory, you should be able to see the tab and start troubleshooting the processes that have been running the longest.

<div id="databaselock">

### Why is Rancher Server frozen? OR Why could my upgrade have failed?

If you are starting Rancher and it freezes forever, there might be a liquibase database lock. On startup, liquibase does a schema migration. There is a race condition where it might leave a lock entry, which will prevent subsequent boots. 

If you have just upgraded and in the Rancher server logs, there can be a log lock on the MySQL database that has not been released. 

```bash
....liquibase.exception.LockException: Could not acquire change log lock. Currently locked by <container_ID>
```

#### Releasing the database lock

If you had created the data container for Rancher server per the [upgrading documentation]({{site.baseurl}}/rancher/upgrading/), you'll need to `exec` into the `rancher-data` container to update the  `DATABASECHANGELOGLOCK` table and remove the lock. If you hadn't created the data container, you can `exec` into the container that has your database.

```bash
$ sudo docker exec -it <container_id> mysql
```

Once you are in MySQL database, you'll need to access the `cattle` database.

```bash
mysql> use cattle;

# Check that there is a lock in the table
mysql> select * from DATABASECHANGELOGLOCK;

# Update to remove the lock by the container
mysql> update DATABASECHANGELOGLOCK set LOCKED="", LOCKGRANTED=null, LOCKEDBY=null where ID=1;


# Check that the lock has been removed
mysql> select * from DATABASECHANGELOGLOCK;
+----+--------+-------------+----------+
| ID | LOCKED | LOCKGRANTED | LOCKEDBY |
+----+--------+-------------+----------+
|  1 |        | NULL        | NULL     |
+----+--------+-------------+----------+
1 row in set (0.00 sec)
```

## Rancher Agent

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

### What do I do if the IP of my host has changed (due to reboot)? 

If your host has a new IP after a reboot, the IP of your host in Rancher will no longer match. Your containers will no longer have access to the managed network. To get the host and all containers back into the managed network, just re-run the command to [add in a custom host]({{site.baseurl}}/rancher/rancher-ui/infrastructure/hosts/custom/). Do not stop or remove the existing agent on the host!

## Cross Host Communication

If containers on different hosts cannot ping each other, there are some common scenarios that could be the issue. 

### Are the IPs of the hosts correct in the UI?

Every so often, the IP of the host will accidentally pick up the docker bridge IP instead of the actual IP. These are typically `172.17.42.1` or starting with `172.17.x.x`. If this is the case, you need to re-register your host with the correct IP by explicitly setting the `CATTLE_AGENT_IP` environment variable in the `docker run` command.

```bash
$ sudo docker run -d --privileged -v /var/run/docker.sock:/var/run/docker.sock \
    -e CATTLE_AGENT_IP=<HOST_IP> \
    rancher/agent:v0.8.2 http://SERVER_IP:8080/v1/scripts/xxxx
```

### Containers on hosts unable to ping each other, how to check that the hosts can ping each other?

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

### How to check IPtables rules are not being malformed?

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

### Running Ubuntu, and containers are unable to communicate with each other.

If you have `UFW` enabled, you can either disable `UFW` OR change `/etc/default/ufw` to:

```
DEFAULT_FORWARD_POLICY="ACCEPT"
```

## Network Agents

<a id="dns-config"></a>

### How can I see if my DNS is set up correctly?

If you want to see the configuration of the Rancher DNS setup, you will need to exec into any network agent in your setup. You can use the UI and select **Execute Shell** on the container. 

```bash
$ cat /var/lib/cattle/etc/cattle/dns/answers.json
```

## Networking

### CentOS

#### Why are my containers unable to connect to network?

If you run a container on the host (i.e. `docker run -it ubuntu`) and the container cannot talk to the internet or anything outside the host, then you might have hit a networking issue. 

CentOS will by default set `/proc/sys/net/ipv4/ip_forward` to `0`, which will essentially bork all networking for Docker.  Docker sets this value to `1` but if you run `service restart networking` on CentOS it sets it back to `0`.

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
$ docker exec -it <rancher_server_container_ID> mysql
```

> **Note:** The `<rancher_server_container_ID>` will be the container that has the Rancher database. If you [upgraded]({{site.baseurl}}/rancher/upgrading/) and created a Rancher data container, you'll need to use the ID of the Rancher data container instead of the Rancher server container. 

Access the cattle database.

```bash
mysql> use cattle;
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
