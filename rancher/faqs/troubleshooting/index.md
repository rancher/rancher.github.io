---
title: FAQS on Rancher
layout: rancher-default
---

## Troubleshooting FAQs
---

When trying to troubleshoot Rancher, here are some ways to get Rancher specific logs. If you open an issue, it would also be helpful to include the related logs. 

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

Inside this folder, there will be `cattle_debug.log` and `cattle_error.log`. If you have been using Rancher server for many days, you will find a log file for each day as we create a new file for each day. 

<a id="agent-logs"></a>

### Where can I find detailed logs of the Rancher Agent container?

Running `docker logs` will on the Rancher agent container will provide a set of basic logs. To get more detailed logs of rancher agent, you will need to have SSH into your host. In the host, you will navigate to the logs for rancher. 

```bash
# On the host with issues, navigate to the specific folder
$ cd /var/log/rancher/
$ cat agent.log
```

`agent.log` will be the most recent list of logs. We create a new file for logging after the log file has reached a certain size or a new rancher agent has been launched.

<a id="lb-config"></a>

### How can I see the configuration of my Load Balancer?

If you want to see the configuration of the load balancer, you will need to exec into the specific _LB Agent_ container and look for the configuration file. You can use the UI and select **Execute Shell** on the container. 

```bash
$ cat /etc/haproxy/haproxy.cfg
```

This file will provide all the configuration details of the load balancer. 

<a id="dns-config"></a>

### How can I see if my DNS is set up correctly?

If you want to see the configuration of the Rancher DNS setup, you will need to exec into any network agent in your setup. You can use the UI and select **Execute Shell** on the container. 

```bash
$ cat /var/lib/cattle/etc/cattle/dns/answers.json
```

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