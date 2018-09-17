---
title: Installing Rancher Server
layout: rancher-default-v1.6
version: v1.6
lang: en
redirect_from:
  - /rancher/installing-rancher/installing-server/
---

## Installing Rancher Server
---
Rancher is deployed as a set of Docker containers. Running Rancher is as simple as launching two containers. One container as the management server and another container on a node as an agent.

* [Rancher Server - Single Container (non-HA)](#single-container)
* [Rancher Server - Single Container (non-HA) - External database](#single-container-external-database)
* [Rancher Server - Single Container (non-HA)- Bind mounted MySQL volume](#single-container-bind-mount)
* [Rancher Server - Full Active/Active HA](#multi-nodes)
* [Rancher Server - Using ELB in AWS](#elb)
* [Rancher Server - AD/OpenLDAP using TLS](#ldap)
* [Rancher Server - HTTP Proxy](#http-proxy)
* [Rancher Server - MySQL over SSL](#mysql-ssl)


> **Note:** You can get all help options for the Rancher server container by running `docker run rancher/server --help`.

### Requirements

* Any modern Linux distribution with a [supported version of Docker]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#supported-docker-versions). [RancherOS](http://docs.rancher.com/os/), Ubuntu, RHEL/CentOS 7 are more heavily tested.
  * For RHEL/CentOS, the default storage driver, i.e. devicemapper using loopback, is not recommended by [Docker](https://docs.docker.com/engine/reference/commandline/dockerd/#/storage-driver-options). Please refer to the Docker documentation on how to change it.
  * For RHEL/CentOS, if you want to enable SELinux, you will need to [install an additional SELinux module]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/selinux/).

> **Note:** Currently, Docker for Mac is not supported in Rancher.

* A minimum of 1GB RAM available on the host to be used (excluding OS resources)
* Accurate time synchronization (e.g. `ntpd`)
* MySQL server should have a max_connections setting > 150
  * MYSQL Configuration Requirements   
    * Option 1: Run with Antelope with default of `COMPACT`
    * Option 2: Run MySQL 5.7 with Barracuda where the default `ROW_FORMAT` is `Dynamic`
  * Recommended settings:
    * `max_allowed_packet` >= 32M (default is usually 16M)
    * `innodb_log_file_size` >= 256M (If you have an existing DB, please make sure to appropriate plan how to change this setting.)
    * `innodb_file_per_table=1`
    * `innodb_buffer_pool_size` >= 1GB (For larger installs, 4-8G pools on dedicated MySQL servers) 

> **Note:** Currently, MariaDB 10.3 and MySQL 8.x are not supported.

### Rancher Server Tags

Rancher server has 2 different tags. For each major release tag, we will provide documentation for the specific version.

* `rancher/server:latest` tag will be our latest development builds. These builds will have been validated through our CI automation framework. These releases are not meant for deployment in production.
* `rancher/server:stable` tag will be our latest stable release builds. This tag is the version that we recommend for production.  

Please do not use any release with a `rc{n}` suffix. These `rc` builds are meant for the Rancher team to test out builds.

<a id="single-container"></a>

### Launching Rancher Server - Single Container (non-HA)

On the Linux machine with Docker installed, the command to start a single instance of Rancher is simple.

```bash
$ sudo docker run -d --restart=unless-stopped -p 8080:8080 rancher/server
```

### Rancher UI

The UI and API will be available on the exposed port `8080`. After the docker image is downloaded, it will take a minute or two before Rancher has successfully started and is available to view.

Navigate to the following URL: `http://<SERVER_IP>:8080`. The `<SERVER_IP>` is the public IP address of the host that is running Rancher server.

Once the UI is up and running, you can start by [adding hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/) or select a container orchestration from the Infrastructure catalog. By default, if a different container orchestration type is not selected, the environment will be using cattle. After the hosts are added into Rancher, you can start adding [services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/) or launch templates from the [Rancher catalog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/).

<a id="single-container-external-database"></a>

### Launching Rancher Server - Single Container - External Database

Instead of using the internal database that comes with Rancher server, you can start Rancher server pointing to an external database. The command would be the same, but appending in additional arguments to direct how to connect to your external database.

> **Note:** Your database, name and user of the database will already need to be created, but no schemas will need to be created. Rancher will automatically create all the schemas related to Rancher.

Here is an example of a SQL command to create a database and users.

```sql
> CREATE DATABASE IF NOT EXISTS cattle COLLATE = 'utf8_general_ci' CHARACTER SET = 'utf8';
> GRANT ALL ON cattle.* TO 'cattle'@'%' IDENTIFIED BY 'cattle';
> GRANT ALL ON cattle.* TO 'cattle'@'localhost' IDENTIFIED BY 'cattle';
```

To start Rancher connecting to an external database, you pass in additional arguments as part of the command for the container.

```bash
$ sudo docker run -d --restart=unless-stopped -p 8080:8080 rancher/server \
    --db-host myhost.example.com --db-port 3306 --db-user username --db-pass password --db-name cattle
```

> **Note:** When you connect to an external database cluster which requires a primary key on the tables, you can add `--db-strict-enforcing` as a parameter to the command. Available as of v1.6.11

Most of the options to pass in also have default values and are not required. Only the location of the MySQL server is required.

```bash
--db-host               IP or hostname of MySQL server
--db-port               port of MySQL server (default: 3306)
--db-user               username for MySQL login (default: cattle)
--db-pass               password for MySQL login (default: cattle)
--db-name               MySQL database name to use (default: cattle)
--db-strict-enforcing   Ensures table has primary key (default: false), available as of v1.6.11
```

<br>

> **Note:** In previous versions of Rancher server, we had connected to an external database using environment variables, those environment variables will continue to work, but Rancher recommends using the arguments instead.

> **Note:** When using a proxy between the database server and the `rancher/server` container, make sure you configure the timeout parameters correctly. Please see [the FAQ]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/faqs/server/#why-is-rancher-server-logging-uncaught-exception-orgjooqexceptiondataaccessexception-sql-query-conn10-could-not-read-packet-unexpected-end-of-stream-read-0-bytes-from-4-or-mysql-yyyymmdd-hhmmss-packetsgo33-unexpected-eof) for more information.

<a id="single-container-bind-mount"></a>

### Launching Rancher Server - Single Container - Bind Mount MySQL Volume

If you would like to persist the database inside your container to a volume on your host, launch Rancher server by bind mounting the MySQL volume.

```bash
$ sudo docker run -d -v <host_vol>:/var/lib/mysql --restart=unless-stopped -p 8080:8080 rancher/server
```
With this command, the database will persist on the host. If you have an existing Rancher container and would like to bind mount the MySQL volume, the instructions are located in our [upgrading documentation]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/upgrading/#single-container-bind-mount).

<a id="multi-nodes"></a>

### Launching Rancher Server - Full Active/Active HA

Running Rancher server in High Availability (HA) is as easy as running [Rancher server using an external database](#using-an-external-database), exposing an additional port, and adding in an additional argument to the command for the external load balancer. Setting up HA requires a minimum of 3 nodes.

#### Requirements for HA

* HA Nodes (a minimum of 3 nodes is required):
    * Any modern Linux distribution with a [supported version of Docker]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#supported-docker-versions). [RancherOS](http://docs.rancher.com/os/), Ubuntu, RHEL/CentOS 7 are more heavily tested.
      * For RHEL/CentOS, the default storage driver, i.e. devicemapper using loopback, is not recommended by [Docker](https://docs.docker.com/engine/reference/commandline/dockerd/#/storage-driver-options). Please refer to the Docker documentation on how to change it.
      * For RHEL/CentOS, if you want to enable SELinux, you will need to [install an additional SELinux module]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/selinux/).
    * Ports that needs to be opened between nodes: `9345`, `8080`
    * A minimum of 1GB RAM available on the host to be used (excluding OS resources)

> **Note:** Currently, Docker for Mac is not supported in Rancher.

* MySQL database
    * A minimum of 1GB RAM available on the host to be used (excluding OS resources)
    * 50 connections per Rancher server node (e.g. A 3 node setup will need to support at least 150 connections)
    * MYSQL Configuration Requirements   
      * Option 1: Run with Antelope with default of `COMPACT`
      * Option 2: Run MySQL 5.7 with Barracuda where the default `ROW_FORMAT` is `Dynamic`

> **Note:** Currently, MariaDB 10.3 and MySQL 8.x are not supported.

* External Load Balancer
    * Port that needs to be opened between nodes and external load balancer: `8080`


#### Recommendations for Larger Deployments

* Each Rancher server node should have a 4 GB or 8 GB heap size, which requires having at least 8 GB or 16 GB of RAM
* MySQL database should have fast disks
* For true HA, a replicated MySQL database with proper backups is recommended. Using Galera and forcing writes to a single node, due to transaction locks, would be an alternative.

1. On each of your nodes that you want to add into the HA setup, run the following command:

   ```bash
   # Launch on each node in your HA cluster
   $ docker run -d --restart=unless-stopped -p 8080:8080 -p 9345:9345 rancher/server \
        --db-host myhost.example.com --db-port 3306 --db-user username --db-pass password --db-name cattle \
        --advertise-address <IP_of_the_Node>
   ```

   For each node, the `<IP_of_the_Node>` will be unique to each node, as it will be the IP of each specific node that is being added into the HA setup.

   If you change `-p 8080:8080` to expose the HTTP port to a different port on the host, you will need to add `--advertise-http-port <host_port>` to the command.

   > **Note:** You can get the help for the commands by running `docker run rancher/server --help`

2. Configure an external load balancer that will balance traffic on ports `80` and `443` across a pool of nodes that will be running Rancher server and target the nodes on port `8080`. Your load balancer must support websockets and forwarded-for headers, in order for Rancher to function properly. See [SSL settings page]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}//installing-rancher/installing-server/basic-ssl-config/) for example configuration settings.

#### Options for advertise-address

| Option | Example | Description |
|---|---|---|
| IP address | `--advertise-address 192.168.100.100` | Uses the give IP address |
| Interface | `--advertise-address eth0` | Retrieves the IP of the given interface |
| awslocal | `--advertise-address awslocal` | Retrieves the IP from `http://169.254.169.254/latest/meta-data/local-ipv4` |
| ipify | `--advertise-address ipify` | Retrieves the IP from `https://api.ipify.org` |

#### Notes on the Rancher Server Nodes in HA

If the IP of your Rancher server node changes, your node will no longer be part of the Rancher HA cluster. You must stop the old Rancher server container using the incorrect IP for `--advertise-address` and start a new Rancher server with the correct IP for `--advertise-address`.

<a id="elb"></a>

### Running Rancher Server Behind an Elastic/Classic Load Balancer (ELB) in AWS

We recommend using an ELB in AWS in front of your Rancher servers. In order for ELB to work correctly with Rancher's websockets, you will need to enable proxy protocol mode and ensure HTTP support is disabled. By default, ELB is enabled in HTTP/HTTPS mode, which does not support websockets. Special attention must be paid to listener configuration.

If you have issues with ELB setup, we recommend trying the [terraform version](#configuring-using-terraform) as this reduces the opportunity to miss a setting.

> **Note:** If you are using a self signed certificate, please read more about how to [configure your ELB in AWS under our SSL section]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/basic-ssl-config/#elb).

#### Listener Configuration - Plaintext

For simple, unencrypted load balancing purposes, the following listener configuration is required:

| Configuration Type | Load Balancer Protocol | Load Balancer Port | Instance Protocol | Instance Port |
|---|---|---|---|---|
| Plaintext | TCP | 80 | TCP | 8080  (or the port used with `--advertise-http-port` when launching Rancher server) |

#### Enabling Proxy Protocol

In order for websockets to function properly, the ELB proxy protocol policy must be applied.

* Enable [proxy protocol](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/enable-proxy-protocol.html) mode

```
$ aws elb create-load-balancer-policy --load-balancer-name <LB_NAME> --policy-name <POLICY_NAME> --policy-type-name ProxyProtocolPolicyType --policy-attributes AttributeName=ProxyProtocol,AttributeValue=true
$ aws elb set-load-balancer-policies-for-backend-server --load-balancer-name <LB_NAME> --instance-port 443 --policy-names <POLICY_NAME>
$ aws elb set-load-balancer-policies-for-backend-server --load-balancer-name <LB_NAME> --instance-port 8080 --policy-names <POLICY_NAME>
```

* Health check can be configured to use HTTP:8080 using `/ping` as your path.

#### Configuring using Terraform

The following can be used as an example for configuring with Terraform:

```
resource "aws_elb" "lb" {
  name               = "<LB_NAME>"
  availability_zones = ["us-west-2a","us-west-2b","us-west-2c"]
  security_groups = ["<SG_ID>"]

  listener {
    instance_port     = 8080
    instance_protocol = "tcp"
    lb_port           = 443
    lb_protocol       = "ssl"
    ssl_certificate_id = "<IAM_PATH_TO_CERT>"
  }

}

resource "aws_proxy_protocol_policy" "websockets" {
  load_balancer  = "${aws_elb.lb.name}"
  instance_ports = ["8080"]
}
```

<a id="alb"></a>

### Running Rancher Server Behind an Application Load Balancer (ALB) in AWS

We no longer recommend Application Load Balancer (ALB) in AWS over using the Elastic/Classic Load Balancer (ELB). If you still choose to use an ALB, you will need to direct the traffic to the HTTP port on the nodes, which is `8080` by default.

<a id="ldap"></a>

### Enabling Active Directory or OpenLDAP for TLS

In order to enable Active Directory or OpenLDAP for Rancher server with TLS, the Rancher server container will need to be started with the LDAP certificate, provided by your LDAP setup. On the Linux machine that you want to launch Rancher server on, save the certificate.

Start Rancher by bind mounting the volume that has the certificate. The certificate **must** be called `ca.crt` inside the container.

```bash
$ sudo docker run -d --restart=unless-stopped -p 8080:8080 \
  -v /some/dir/cert.crt:/var/lib/rancher/etc/ssl/ca.crt rancher/server
```

You can check that the `ca.crt` was passed to Rancher server container successfully by checking the logs of the rancher server container.

```bash
$ docker logs <SERVER_CONTAINER_ID>
```

In the beginning of the logs, there will be confirmation that the certificate was added correctly.

```bash
Adding ca.crt to Certs.
Updating certificates in /etc/ssl/certs... 1 added, 0 removed; done.
Running hooks in /etc/ca-certificates/update.d....done.
Certificate was added to keystore
```

<a id="http-proxy"></a>

### Launching Rancher Server behind an HTTP proxy

In order to set up an HTTP proxy, the Docker daemon will need to be modified to point to the proxy. Before starting Rancher server, edit the `/etc/default/docker` file to point to your proxy and restart Docker.

```bash
$ sudo vi /etc/default/docker
```

In the file, edit the `#export http_proxy="http://127.0.0.1:3128"` to have it point to your proxy. Save your changes and then restart docker. Restarting Docker is different on every OS.

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

<a id="mysql-ssl"></a>

### Launching Rancher Server with MySQL over SSL
> **Note:** Currently, supported in Rancher 1.6.3+

### Important Note

If you are using a LDAP/AD authentication backend with Rancher whose certificate is signed by a different CA then that of the MySQL server, then this guide will not work for you!

### Prerequisites

- The certificate or CA cert of the MySQL server (PEM encoded)

### Instructions

1. Copy the server's certificate or CA certificate to the Rancher server host. When starting the `rancher/server` container you will have to mount that certificate to `/var/lib/rancher/etc/ssl/ca.crt`.
2. Construct a custom JDBC URL by replacing the placeholders in this string with your database parameters:
```
jdbc:mysql://<DB_HOST>:<DB_PORT>/<DB_NAME>?useUnicode=true&characterEncoding=UTF-8&characterSetResults=UTF-8&prepStmtCacheSize=517&cachePrepStmts=true&prepStmtCacheSqlLimit=4096&socketTimeout=60000&connectTimeout=60000&sslServerCert=/var/lib/rancher/etc/ssl/ca.crt&useSSL=true
```
3. Export this JDBC URL to the container in both the `CATTLE_DB_CATTLE_MYSQL_URL` and `CATTLE_DB_LIQUIBASE_MYSQL_URL` environment variables 
4. Export `CATTLE_DB_CATTLE_GO_PARAMS="tls=true"` to the container. If the subject field of the server's certificate does not match the server's hostname, you will need to use `CATTLE_DB_CATTLE_GO_PARAMS="tls=skip-verify"` instead.

#### Example

```shell

export DB_HOST="1.2.3.4"
export DB_PORT=3306
export DB_NAME="rancherdb"
export DB_USER="root"
export DB_PASS="123456"

export JDBC_URL="jdbc:mysql://$DB_HOST:$DB_PORT/$DB_NAME?useUnicode=true&characterEncoding=UTF-8&characterSetResults=UTF-8&prepStmtCacheSize=517&cachePrepStmts=true&prepStmtCacheSqlLimit=4096&socketTimeout=60000&connectTimeout=60000&sslServerCert=/var/lib/rancher/etc/ssl/ca.crt&useSSL=true"

cat <<EOF > docker-compose.yml
version: '2'
  services:
    rancher-server:
      image: rancher/server:stable
      restart: unless-stopped
      command: --db-host $DB_HOST --db-port $DB_PORT --db-name $DB_NAME --db-user $DB_USER --db-pass $DB_PASS
      environment:
        CATTLE_DB_LIQUIBASE_MYSQL_URL: $JDBC_URL
        CATTLE_DB_CATTLE_MYSQL_URL: $JDBC_URL
        CATTLE_DB_CATTLE_GO_PARAMS: "tls=true"
      volumes:
        - /path/to/mysql/ca.crt:/var/lib/rancher/etc/ssl/ca.crt
      ports:
        - "8080:8080"
EOF

docker-compose up -d
```

*Important*: You have to specify your database parameters both in the JDBC URL as well as in the `--db-xxx` command arguments!
