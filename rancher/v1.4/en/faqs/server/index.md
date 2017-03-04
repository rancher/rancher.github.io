---
title: FAQS about Rancher Server
layout: rancher-default-v1.4
version: v1.4
lang: en
---

## FAQs about Rancher Server
---

### What version of Rancher am I running?

The version of Rancher is located in the footer of our site. If you click on the version, you'll be able to get specific versions of our other components.

### How do I run Rancher behind a proxy?

Read more about how to [install Rancher server behind a proxy]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#launching-rancher-server-behind-a-http-proxy).

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

### How do I export the internal database in the Rancher server container?

You can export the database from the Rancher server container with a simple Docker command.

```
$ docker exec <CONTAINER_ID_OF_SERVER> mysqldump cattle > dump.sql
```

### What happens if the IP of Rancher server has changed?

If the IP of Rancher server has been changed, you will need to re-attach the hosts with the updated information.

In Rancher, go to **Admin** -> **Settings** and update the **Host Registration** with the updated URL for Rancher server. Please note that it must include the exposed port that you started Rancher server with. By default, we have recommended using port `8080` in our [installation instructions]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/).

After the [Host Registration]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/settings/#host-registration) has been updated, go to **Infrastructure** -> **Add Hosts** -> **Custom**. The `docker run` command to add Rancher agents will have been updated with the new information. Using the updated command, run the command on all the hosts inside your Rancher server [environments]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/).

### Why is Go-Machine-Service continually restarting in my logs? What should I do?

Go-machine-service is a micro-service that connects to the Rancher API server via a websocket connection. If it fails to connect, it restarts and tries again.

If you are running in [Single Node]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/) setup, it will connect to the Rancher API server using the URL you set for Host Registration. Verify that the Host Registration URL can be reached from inside the rancher-sever container.

```bash
$ docker exec -it <rancher-server_container_id> bash
# Inside the rancher-server container
$ curl -i <Host Registration URL you set in UI>/v1
```
You should get a json response. If authentication is turned on, the response code should be 401. If authentication is not turned on, the response code should be 200.

Verify that the Rancher API server can be reached using those variables. Verify the connectivity by logging into the go-machine-service container and making a curl command using the parameters your provided to the container:

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
$ docker run -d -p 8080:8080 --restart=unless-stopped -e JAVA_OPTS="-Xmx4096m" rancher/server
```

Depending on how the MySQL database is setup, you may need to do an [upgrade]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/upgrading/) to add the additional command.

If you were unable to see the **Admin** -> **Processes** tab due to the lack of memory, after starting Rancher server again with more memory, you should be able to see the tab and start troubleshooting the processes that have been running the longest.

### Rancher server database is growing too quickly.

Rancher server automatically cleans up a couple of database tables to prevent the database from increasing too quickly. If you are noticing that these tables are not being cleaned up quick enough for you, please feel free to update the default settings using our API.

By default, any records in the `container_event` and `service_event` tables are deleted if they were created 2 weeks ago. The setting in the API is listed in seconds (`1209600`). The setting in the API is `events.purge.after.seconds`.

By default, any records in the `process_instance` table are deleted if they were created 1 day ago. The setting in the API is listed in seconds (`86400`). The setting in the API is `process_instance.purge.after.seconds`.

To update these settings in your API, navigate to the `http://<rancher-server-ip>:8080/v1/settings` page. Search for the setting you want to update and click on the link in the `links -> self` to navigate to the setting. Click on `Edit` on the side page to change the `value`. Remember, the value is in seconds.

<a id="databaselock"></a>

### Why is Rancher Server frozen? OR Why could my upgrade have failed?

If you are starting Rancher and it freezes forever, there might be a liquibase database lock. On startup, liquibase does a schema migration. There is a race condition where it might leave a lock entry, which will prevent subsequent boots.

If you have just upgraded and in the Rancher server logs, there can be a log lock on the MySQL database that has not been released.

```bash
....liquibase.exception.LockException: Could not acquire change log lock. Currently locked by <container_ID>
```

#### Releasing the database lock

> **Note:** Please do not release the database lock unless you have the above **exception** regarding the log lock. If your upgrading is taking a long time due to data migration, you may hit other migration issues if you try to release the database lock.

If you had created the data container for Rancher server per the [upgrading documentation]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/upgrading/), you'll need to `exec` into the `rancher-data` container to update the  `DATABASECHANGELOGLOCK` table and remove the lock. If you hadn't created the data container, you can `exec` into the container that has your database.

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
