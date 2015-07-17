---
title: FAQS on Rancher
layout: rancher-default
---

## Troubleshooting FAQs
---

When trying to troubleshoot Rancher, here are some ways to get Rancher specific logs. If you open an issue, it would also be helpful to include the related logs. 

### What version of Rancher am I running?

As of our Beta release, you can click on the cow in the upper left hand corner, which will display which the versions of Rancher, Cattle, UI and Rancher-Compose. 

If clicking on the cow doesn't work, then you have a version prior to Beta. We recommend upgrading to Beta as it's a much more stable release due to many bug fixes. To find out what version you're running if prior to Beta, do a `docker inspect` on the container to view the environment variables. 

### Where can I find detailed logs of the Rancher Server container?

Running `docker logs` on the Rancher server container will provide a set of the basic logs. To get more detailed logs, you can exec into the rancher server container and look at the log files.

```bash
# Exec into the server container
$ docker exec -it <container_id> bash

# Navigate to the location of the cattle logs
$ cd /var/lib/cattle/logs/
$ cat cattle_debug.log
```

Inside this folder, there will be `cattle_debug.log` and `cattle_error.log`. If you have been using Rancher server for many days, you will find a log file for each day as we create a new file for each day. 

### Where can I find detailed logs of the Rancher Agent container?

Running `docker logs` will on the Rancher agent container will provide a set of basic logs. To get more detailed logs of rancher agent, you will need to have SSH into your host. In the host, you will navigate to the logs for rancher. 

```bash
# On the host with issues, navigate to the specific folder
$ cd /var/log/rancher/
$ cat agent.log
```

`agent.log` will be the most recent list of logs. We create a new file for logging after the log file has reached a certain size or a new rancher agent has been launched.

### How can I see the configuration of my Load Balancer?

If you want to see the configuration of the load balancer, you will need to exec into the specific _LB Agent_ container and look for the configuration file. You can use the UI and select **Execute Shell** on the container. 

```bash
$ cat /etc/haproxy/haproxy.cfg
```

This file will provide all the configuration details of the load balancer. 

### How can I see if my DNS is set up correctly?

If you want to see the configuration of the Rancher DNS setup, you will need to exec into any network agent in your setup. You can use the UI and select **Execute Shell** on the container. 

```bash
$ cat /var/lib/cattle/etc/cattle/dns/answers.json
```