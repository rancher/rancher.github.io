---
title: High Availability (HA)
layout: rancher-default
---

## Installing Rancher Server (High Availability)
---

Available as of v1.0.1+

### Pre-requisites

* MySQL Database with at least 1 GB RAM
* External Load Balancer 
* Nodes to be used in HA setup that meet the single node [requirements]({{site.baseurl}}/rancher/installing-rancher/installing-server/#requirements) 


### Preparing for the High Availability (HA) Setup

1. Prepare a MySQL database with at least 1 GB RAM following the same directions as [starting a single node using an external database]({{site.baseurl}}/rancher/installing-rancher/installing-server/#using-an-external-database), but do not launch Rancher server according to those instructions. By default, users will only be able to access the database from localhost. You will need to grant access to the new user for the network where your Rancher nodes will reside.
2. Configure an external load balancer that will balance traffic on ports 80 and 443 across a pool of nodes that will be running Rancher server. Depending on your cloud provider, it may be necessary to start the nodes before being able to configure the external load balancer.
3. Prepare the nodes that will be used in the HA setup. These nodes should meet the same [requirements]({{site.baseurl}}/rancher/installing-rancher/installing-server/#requirements) as a single node setup of Rancher.
    
    Currently, our HA setup supports 3 cluster sizes. 
    * 1 Node: Not really HA
    * 3 Nodes: Any **one** host can fail
    * 5 Nodes: Any **two** hosts can fail

4. On one of the nodes, launch a Rancher server that will be used to generate the HA startup scripts. This script generating Rancher server will connect to the external MySQL database and populate the database schema. It will be used to bootstrap the HA deployment process. Eventually, the Rancher server container used in this step will be replaced with a HA configured Rancher server.   
    
    > **Note:** Please be patient with this step, initialization may take up to 15 minutes to complete. 


```bash
$ sudo docker run -d -p 8080:8080 \
-e CATTLE_DB_CATTLE_MYSQL_HOST=<hostname or IP of MySQL instance> \
-e CATTLE_DB_CATTLE_MYSQL_PORT=<port> \
-e CATTLE_DB_CATTLE_MYSQL_NAME=<Name of Database> \
-e CATTLE_DB_CATTLE_USERNAME=<Username> \
-e CATTLE_DB_CATTLE_PASSWORD=<Password> \
-v /var/run/docker.sock:/var/run/docker.sock \
rancher/server:v1.0.1
```

### Generating the Configuration Scripts 

1. Access the script generating Rancher server's UI at `http://<server_IP>:8080`. Under **Admin** -> **HA**, there will be a confirmation that Rancher server has successfully connected to an external database. If this is not set up correctly, please repeat steps 1 and 4 in the previous section. 
2. Select the cluster size, which should be the number of Rancher server nodes that you created in step 3 in the previous section. 
3. In the **Host Registration URL**, provide the external load balancer's IPV4 address or hostname.
4. Select which certificate type you would like to use. Rancher can generate a self-signed certificate for you or you can use your own valid certificate. 
5. Click on **Generate Config Script**. 
6. Download the script and save it locally. 

> **Note:** After the configuration script is saved, you can stop and remove the script generating Rancher server container. This will allow you to reuse that node for the HA setup.  

### Launching Rancher in HA

1. For each node that you want in HA, use the startup script to launch Rancher server. The script will start a Rancher server container that connects to the same external MySQL database created earlier.  
2. Navigate to the IP or hostname of the external load balancer that you provided earlier and used in the **Host Registration URL** when generating the configuration scripts. Please note that it will take a couple of minutes before the UI is available as Rancher.
3. Once the UI is available, you can prepare to add hosts to your HA nodes. Under the **Admin** -> **HA** tab, HA is now enabled and indicates the number of HA nodes are in your setup. For any host that you want to add on to your node, save the management certificate to `/var/lib/rancher/etc/ssl/ca.crt` with `400` permissions. The registration command will automatically be created to use the management certificate. 
4. Once you have added all the hosts into your environment, your HA setup is complete and you can start launching [services in the UI]({{site.baseurl}}/rancher/rancher-ui/applications/stacks/adding-services/),  launching templates from the [Rancher Catalog]({{site.baseurl}}/rancher/catalog/) or start using [rancher-compose]({{site.baseurl}}/rancher/rancher-compose/) to launch services.
