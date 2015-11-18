---
title: Adding Load Balancers
layout: rancher-default
---

## Adding Load Balancers
---

After adding multiple services to your stack, you might have decided that you want to load balance your web applications. With Rancher, it's easy to add a load balancer to your stack! 

We'll walk through how to load balance the Wordpress application created earlier in the [adding services guide]({{site.baseurl}}/rancher/rancher-ui/applications/stacks/adding-services/). You add a load balancer by clicking the dropdown icon next to the **Add Service** button and selecting **Add Load Balancer**. 

In the **Add Load Balancer** page, you will need to provide a **Name** and if desired, **Description** of the load balancer. Use the slider to select the scale, i.e. how many containers of the load balancer. Alternatively, you can select **Always run one instance of this container on every host**. With this option, your load balancer will scale for any additional hosts that are added to your [environment]({{site.baseurl}}/rancher/configuration/environments/). If you have scheduling rules in the **Scheduling** section, Rancher will only start containers on the hosts that meet the host labels rules. If you add a host to your environment that doesn't meet the scheduling rules, a container will not be started on the host.

> **Note:** The number of containers of this load balancer cannot exceed the number of hosts in the environment, otherwise there will be a port conflict and this service will be stuck in an activating state. It will continue to try and find an available host and open port until you edit the scale of this load balancer or [add additional hosts]({{site.baseurl}}/rancher/rancher-ui/infrastructure/hosts/). 

In our example from the [adding services section]({{site.baseurl}}/rancher/rancher-ui/applications/stacks/adding-services/), we only have 2 hosts in our environment, so therefore we can only create a maximum of 2 load balancers.

We'll define the listening ports on the load balancer. The source port is the port that the load balancer is listening on the host. You can decide if this source port will be accessible publicly (i.e. accessible outside of the host) or internally on the host. You can also choose the target port of the load balancer. The target port is the private port that traffic will be directed to the services. If no target port is defined, the source port will also be used as the target port. You can select the protocol for each listening port. 

> **Note:** Port `42` cannot be used as a source port for load balancers because it's internally used for [health checks]({{site.baseurl}}/rancher/concepts/health-checks).  

Let's use a source port of `8090`, target port of `80`, select `Public` access and select the `http` protocol. Next, let's add our target. We will select our wordpress service. Click on **Create**. 

> **Note:** When ports are exposed in Rancher, it will not show up in `docker ps` as Rancher manages the iptable rules to make the ports fully dynamic. 

Just like with services, the load balancer is not started until the user starts the service. You can individually start the load balancer by clicking **Start** or selecting **Start** in the dropdown menu. 

Now, let's see the load balancer in action. Click on a container name inside the load balancer. This will bring you to a detailed container page of the load balancer. Copy the IP address of the host, paste the IP into the web browser of your choice and add `:8090`. The Wordpress application will come up in the browser. 

It's that easy to set up a load balancer with Rancher! 

## Load Balancer Routing 

Our load balancer has HAProxy software installed on the load balancer agent containers. The load balancer uses a round robin algorithm from HAProxy to select the target services. 

> **Note:** Load balancers will only work for services that are using the managed network. If you select any other network choice for your target services, it will **not** work with the load balancer.

### Basic Load Balancing

Rancher supports L4 load balancing by simply adding listening ports and linking target services. We can add as many listening ports and services as we'd like. We've made the assumption that the access is set as `public` for every listening ports. The source port(s) of the load balancer will use the round robin algorithm to forward traffic to any service(s) on the target port mapped to the particular source port. 

**Example:**

When we set up 2 listening ports and 3 services, the load balancer will direct traffic on both listening ports across all services.

Source Port| Target Port
---|---
80 | 81
8090 | 
<br>

| Target Services|
|----|
| Service1 |
| Service2 |
|Service3 |

<br>
In our example, any traffic directed to port `80` on the host of the load balancer would get round robin-ed to  Service1, Service2, Service3 on the target port `81`. Any traffic directed to port `8090` on the host of the load balancer would get round robin-ed to Service1, Service2, Service3 on port `8090`. Since no target port was set for the listening port `8090`, the target port will be the same as the source port.

### Internal Load Balancing

You will have the option to no longer publish source ports to the host by setting the access level of each individual “Listening Port” to `Internal`.  All internal ports can only be accessed by services within the same environment.

### SSL Termination

To add SSL termination to your load balancer, you can select the **SSL** checkbox. When you enable the checkbox, the **SSL Termination** tab will provide the ability to add certificates. In the **Certificate** dropdown, you can select the main certificate for the load balancers. 

To add a certificate to Rancher, please read about [how to add certificates in the **Infrastructure** tab]({{site.baseurl}}/rancher/rancher-ui/infrastructure/certificates/).

For example, if you were load balancing a web server and wanted both `http` and `https` being served on ports 80 and 443 respectively, you would do the following:

 1. [Add a certificate to the infrastructure]({{site.baseurl}}/rancher/rancher-ui/infrastructure/certificates/).
 2. Create the load balancer service.
 3. In the *Listening Ports* section of the screen, create an entry to map the incoming port 80, with the `http` protocol and SSL _unchecked_.
 4. And then add another port mapping the incoming port 443, `http` protocol and SSL _checked_.
 5. In the *SSL Termination* section, select the certificate to use for the SSL port.

It is possible to provide multiple certificates for the load balancer such that the appropriate certificate is presented to the client based on the hostname requested (see [Server Name Indication](https://en.wikipedia.org/wiki/Server_Name_Indication)). This may not work with older clients which don't support SNI (those will get the main certificate). For modern clients, they will be offered the certificate from the list for which there is a match or the main certficiate if there is no match.

### Advanced Routing Options

Rancher supports L7 load balancing with our advanced routing options. To expand the advanced options, click on the **Show advanced routing options**. The only required field is **Target Service**, which would be L4 load balancing. All of the other fields for L7 load balancing are optional. Since all the fields are optional, the listening ports are default when adding host/request paths, and the ports will be overriden if you specify source/target ports for a service. For each option, we cover some basic examples, but you can use all or some of these options together to define exactly how you want your load balancer to direct traffic to your services.

#### Request Host/Request Path 

The request host can be a specific HTTP host header used for each service. The request path can be a specific path. The request host and request path can be used independently or in conjunction to create a specific request. 

**Example:**

domain1.com -> Service1 <br>
domain2.com -> Service2

domain3.com -> Service1 <br>
domain3.com/admin -> Service2

Since source/target ports are optional, the listening ports are used as defaults to direct traffic based on the request. If a source port is defined, traffic coming to a specific host header/path will need to match a specific rule in order to be directed to the target.

#### Target Port

For each service, you can override the target port defined in the listening port section. This would allow you to direct traffic to services on different ports from the same source port.

**Example**

Source Port| Default Target Port
---|---
80 | 80
<br>

|Target Services| Target Ports|
|---| ---|
|Service1| None|
|Service2 | `90`|

<br>
In our example above, the load balancer will direct traffic to different ports depending on the service. Since the load balancer is using a round robin algorithm, any traffic to the source port `80` will be directed alternatively between the services. When traffic is being directed to Service1, it will use the default target port `80`. When traffic is directed to Service2, it will use the target port `90`, that was defined with Service2.

#### Source Port 

For any source port defined in in the listening port section, you can create specific routes for services. This might be helpful if you had multiple source ports and want to direct traffic differently for each source port. You would only add a source port if you also have defined a request host/path or target port. 

> **Note:** If you choose a source port in the advanced section, you must add it in the listening ports section.

## Stickiness Policy for Load Balancers

You can select the **Stickiness** of the load balancer. Stickiness is the cookie policy that you want to use for when using cookies of the website. 

The three options that Rancher provides are:

* **None**: This option means that no cookie policy is in place.
* **Use existing cookie**: This option means that we will attempt to use the application's cookie for stickiness policies configuration. 
* **Create new cookie**: This option means that the cookie will be defined outside of your application. This cookie is what the load balancer would set on requests and responses. This cookie would determine the stickiness policy. 

You can only select one of these three choices and by default, we have selected **None**.

## Labels/Scheduling Load Balancers 

We provide the ability to add labels to load balancers and schedule where the load balancer will be launched. Read more details about labels and scheduling [here]({{site.baseurl}}/rancher/rancher-ui/scheduling/).
