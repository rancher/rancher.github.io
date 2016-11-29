---
title: Installing Rancher Server (Single Node)
layout: rancher-default-v1.2
version: v1.2
lang: zh
redirect_from:
  - /rancher/latest/zh/installing-rancher/installing-server/
---

## Installing Rancher Server (Single Node)
---
Rancher is deployed as a set of Docker containers. Running Rancher is a simple as launching two containers. One container as the management server and another container on a node as an agent.

### Requirements

* Any modern Linux distribution that supports Docker 1.10.3+. [RancherOS](http://docs.rancher.com/os/), Ubuntu, RHEL/CentOS 7 are more heavily tested.
  * For RHEL/CentOS, the default storage driver, i.e. devicemapper using loopback, is not recommended by [Docker](https://docs.docker.com/engine/reference/commandline/dockerd/#/storage-driver-options). Please refer to the Docker documentation on how to change it.
* 1GB RAM
* MySQL server should have a max_connections setting > 150
  * MYSQL Configuration Requirements   
    * Option 1: Run with Antelope with default of `COMPACT`
    * Option 2: Run MySQL 5.7 with Barracuda where the default `ROW_FORMAT` is `Dynamic`

> **Note:** Currently, Docker for Windows and Docker for Mac are not supported in Rancher.

### Rancher Server Tags

The `rancher/server:latest` tag will be our stable release builds, which Rancher recommends for deployment in production. For each major release tag, we will provide documentation for the specific version.

If you are interested in trying one of our latest development builds which will have been validated through our CI automation framework, please check our [releases page](https://github.com/rancher/rancher/releases) to find the latest development release tag. These releases are not meant for deployment in production. All development builds will be appended with a `*-pre{n}` suffix to denote that it's a development release. Please do not use any release with a `rc{n}` suffix. These `rc` builds are meant for the Rancher team to test out the development builds.

### Launching Rancher Server

On the Linux machine with Docker installed, the command to start Rancher is simple.

```bash
$ sudo docker run -d --restart=unless-stopped -p 8080:8080 rancher/server
```

#### Rancher UI

The UI and API will be available on the exposed port `8080`. After the docker image is downloaded, it will take a minute or two before Rancher has successfully started and is available to view.

Navigate to the following URL: `http://<SERVER_IP>:8080`. The `<SERVER_IP>` is the public IP address of the host that is running Rancher server.

Once the UI is up and running, you can start by [adding hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/) or select a container orchestration from the Infrastructure catalog. By default, if a different container orchestration type is not selected, the environment will be using cattle. After the hosts are added into Rancher, you can start adding [services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/) or launch templates from the [Rancher catalog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/).

<a id="ldap"></a>

### Enabling Active Directory or OpenLDAP for TLS

In order to enable Active Directory or OpenLDAP for Rancher server with TLS, the Rancher server container will need to be started with the LDAP certificate, provided by your LDAP setup. On the Linux machine that you want to launch Rancher server on, save the certificate.

Start Rancher by bind mounting the volume that has the certificate. The certificate **must** be called `ca.crt` inside the container.

```bash
$ sudo docker run -d --restart=unless-stopped -p 8080:8080 \
  -v /dir_that_contains_the_cert/cert.crt:/ca.crt rancher/server
```

You can check that the `ca.crt` was passed to Rancher server container successfully by checking the logs of the rancher server container.

```bash
$ docker logs <server_container_id>
```

In the beginning of the logs, there will be confirmation that the `ldap.crt` was added correctly.

```bash
DEFAULT_CATTLE_RANCHER_COMPOSE_WINDOWS_URL=https://releases.rancher.com/compose/beta/latest/rancher-compose-windows-386.zip
Adding ca.crt to Certs.
Updating certificates in /etc/ssl/certs... 1 added, 0 removed; done.
Running hooks in /etc/ca-certificates/update.d....
done.
done.
[BOOTSTRAP] Starting Cattle
```

### Bind Mount MySQL Volume

If you would like to persist the database inside your container to a volume on your host, launch Rancher server by bind mounting the MySQL volume.

```bash
$ sudo docker run -d -v <host_vol>:/var/lib/mysql --restart=unless-stopped -p 8080:8080 rancher/server
```
With this command, the database will persist on the host. If you have an existing Rancher container and would like to bind mount the MySQL volume, the instructions are located in our [upgrading documentation]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/upgrading/#upgrading-rancher-launched-using-bind-mounts).

<a id="external-db"></a>

### Using an External Database

If you would prefer to use an external database to run Rancher server, you run the same command as before, but add in additional arguments to connect to the external database.

> **Note:** Your database, name and user of the database will already need to be created, but no schemas will need to be created. Rancher will automatically create all the schemas related to Rancher.

Here is an example of a SQL command to create a database and users.

```sql
> CREATE DATABASE IF NOT EXISTS cattle COLLATE = 'utf8_general_ci' CHARACTER SET = 'utf8';
> GRANT ALL ON cattle.* TO 'cattle'@'%' IDENTIFIED BY 'cattle';
> GRANT ALL ON cattle.* TO 'cattle'@'localhost' IDENTIFIED BY 'cattle';
```

To start Rancher connecting to an external database, you pass in additional arguments as part of the command for the container.

```bash
$ sudo docker run -d --restart=unless-stopped -p 8080:8080 rancher/server --db-host myhost.example.com --db-port 3306 --db-user username --db-pass password --db-name cattle
```

Most of the options to pass in also have default values and are not required.

```bash
--db-host               IP or hostname of MySQL server
--db-port               port of MySQL server (default: 3306)
--db-user               username for MySQL login (default: cattle)
--db-pass               password for MySQL login (default: cattle)
--db-name               MySQL database name to use (default: cattle)
```

> **Note:** In previous versions of Rancher server, we had connected to an external database using environment variables, those environment variables will continue to work, but moving forward, Rancher recommends using the arguments instead.

<a id="http-proxy"></a>

### Launching Rancher Server behind an HTTP proxy

In order to set up an HTTP proxy, the Docker daemon will need to be modified to point to the proxy. Before starting Rancher server, edit the `/etc/default/docker` file to point to your proxy and restart Docker.

```bash
$ sudo vi /etc/default/docker
```

In the file, edit the `#export http_proxy="http://127.0.0.1:3128/"` to have it point to your proxy. Save your changes and then restart docker. Restarting Docker is different on every OS.

> **Note:** If you are running Docker with systemd, please follow Docker's [instructions](https://docs.docker.com/articles/systemd/#http-proxy) on how to configure the HTTP proxy.

In order for the [Rancher catalog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/) to load, the proxy will need to be configured and Rancher server will need to be launched with environment variables to pass in the proxy information.

```bash
$ sudo docker run -d \
    -e http_proxy=<proxyURL> \
    -e https_proxy=<proxyURL> \
    -e no_proxy="localhost,127.0.0.1" \
    -e NO_PROXY="localhost,127.0.0.1" \
    --restart=unless-stopped -p 8080:8080 rancher/server
```

If the [Rancher catalog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/) will not be used, run the Rancher server command as you normally would.

When [adding hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/) to Rancher, there is no additional requirements behind an HTTP proxy.
