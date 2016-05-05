---
title: Adding Load Balancers
layout: rancher-default-v1.0
version: v1.0
lang: en
---

## Adding Load Balancers
---

After adding multiple services to your stack, you might have decided that you want to load balance your web applications. With Rancher, it's easy to add a load balancer to your stack.

We'll review the minimum requirements of adding a load balancer and then provide the steps to load balance the "LetsChat" application created earlier in the [adding services section]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/adding-services/). You add a load balancer by clicking the dropdown icon next to the **Add Service** button and selecting **Add Load Balancer**. 

You can use the slider to select the scale, i.e. how many containers of the load balancer. Alternatively, you can select **Always run one instance of this container on every host**. With this option, your load balancer will scale for any additional hosts that are added to your [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/environments/). If you have scheduling rules in the **Scheduling** section, Rancher will only start containers on the hosts that meet the host labels rules. If you add a host to your environment that doesn't meet the scheduling rules, a container will not be started on the host. Please select the "Always run one instance of this container on every host".

> **Note:** The scale of the load balancer cannot exceed the number of hosts in the environment, otherwise there will be a port conflict and the load balancer service will be stuck in an activating state. It will continue to try and find an available host and open port until you edit the scale of this load balancer or [add additional hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/infrastructure/hosts/). 

You will need to provide a **Name** and if desired, **Description** of the load balancer. 

Next, you'll define the listening ports of the load balancer. The **source port** is the port that is exposed on the host. You can select the **Protocol** and decide if you want to use **SSL** termination for that port. The **target port** is the exposed port on a container that traffic will be directed to. If no target port is defined, the source port will also be used as the target port.

In the *Accesss* section, you will decide if this load balancer port will be accessible publicly (i.e. accessible outside of the host) or only internally on the host. 

> **Note:** Port `42` cannot be used as a source port for load balancers because Rancher uses this port for [health checks]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/health-checks).  

### Example of Load Balancing

First, you start by creating a load balancer that has scale of 1 container, giving it a name like "LetsChatLB". For the listening ports section, use a source port of `80`, use the default `http` protocol, use a target port of `8080`, and use the defaultof `Public` access. 

Next, let's add our targets for our load balancer. We can select the "LetsChat" service and click on **Save**. 

Now, let's see the load balancer in action. In the stack view, there is a link to  port `80` that you've used as the source port for your load balancer. If you click on it, it will automatically bring up a new tab in your browser and point to one of the hosts that has the load balancer launched. The request is re-directed to one of the "LetsChat" containers. If you were to refresh, the load balancer would redirect the new request to the other container in the "LetsChat" service as we use the round robin algorithm to distribute traffic to the targetted services.

It's that easy to set up a load balancer with Rancher! 

## Load Balancer Options  
---

Our load balancer has HAProxy software installed on the load balancer agent containers. The load balancer uses a round robin algorithm from HAProxy to select the target services. 

> **Note:** Load balancers will only work for services that are using the managed network. If you select any other network choice for your target services, it will **not** work with the load balancer.

### Basic Load Balancing

Rancher supports L4 load balancing by simply adding listening ports and linking target services. We can add as many listening ports and services as we'd like. We've made the assumption that the access is set as `public` for every listening ports. The source port(s) of the load balancer will use the round robin algorithm to forward traffic to **all service(s)**.

**Example:**

When we set up 2 listening ports and 3 services, the load balancer will direct traffic on both listening ports across all services.

Source Port | Target Port
---|---
80 | 8080
81 | 8081

<br>

|Target Services|
|---|
|Service1|
|Service2|
|Service3|

<br>
In our example, any traffic directed to port `80` on the host of the load balancer would get round robin-ed to  Service1, Service2, Service3 on the target port `8080` and `8081`. Any traffic directed to port `81` on the host of the load balancer would get round robin-ed to Service1, Service2, Service3 on port `8080` and `8081`. 

### Internal Load Balancing

You will have the option to not publish source ports to the host by setting the access level of each individual “Listening Port” to `Internal`.  All internal ports can only be accessed by services within the same environment.

### Advanced Routing Options

Rancher supports L7 load balancing with our advanced routing options. To expand the advanced options, click on the **Show advanced routing options**. The only required field is **Target Service**, which would be the equivalent of L4 load balancing. All of the other fields for L7 load balancing are optional. Since all the fields are optional, the listening ports are default when adding host/request paths, and the ports will be overridden if you specify source/target ports for a service. For each option, we cover some basic examples, but you can use all or some of these options together to define exactly how you want your load balancer to direct traffic to your services.

#### Request Host/Request Path

The request host can be a specific HTTP host header used for each service. The request path can be a specific path. The request host and request path can be used independently or in conjunction to create a specific request. 

**Example:**

```
domain1.com -> Service1 
domain2.com -> Service2

domain3.com -> Service1 
domain3.com/admin -> Service2
```

Since source/target ports are optional, the listening ports are used as defaults to direct traffic based on the request. If a source port is defined, traffic coming to a specific host header/path will need to match a specific rule in order to be directed to the target.

**Wildcards**

Rancher supports wildcards when adding host based routing. The following wildcard syntax is supported.

```
*.domain.com -> hdr_end(host) -i .domain.com
domain.com.* -> hdr_beg(host) -i domain.com.
```
<br>

**Priority with Multiple Hostname Routing Rules**

When there are multiple hostname routing rules, the order of priority is as follows:

1. Hostname with no wildcards and URL
2. Hostname with no wildcards
3. Hostname with wildcards and URL
4. Hostname with wildcards
5. URL
6. Default (no hostname, no URL)

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

### SSL Termination

To add SSL termination to your load balancer, you can enable the **SSL** checkbox for your listening port. When you enable the checkbox, the **SSL Termination** tab will provide the ability to add certificates. In the **Certificate** dropdown, you can select the main certificate for the load balancers. 

To add a certificate to Rancher, please read about [how to add certificates in the **Infrastructure** tab]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/infrastructure/certificates/).

For example, if you were load balancing a web server and wanted both `http` and `https` being served on ports 80 and 443 respectively, you would do the following:

1. [Add a certificate to the infrastructure]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/infrastructure/certificates/).
2. Create the load balancer service.
3. In the *Listening Ports* section of the screen, create an entry to map the incoming port 80, with the `http` protocol and SSL _unchecked_.
4. And then add another port mapping the incoming port 443, `http` protocol and SSL _checked_.
5. In the *SSL Termination* section, select the certificate to use for the SSL port.

It is possible to provide multiple certificates for the load balancer such that the appropriate certificate is presented to the client based on the hostname requested (see [Server Name Indication](https://en.wikipedia.org/wiki/Server_Name_Indication)). This may not work with older clients which don't support SNI (those will get the main certificate). For modern clients, they will be offered the certificate from the list for which there is a match or the main certficate if there is no match.

### Stickiness Policy for Load Balancers

You can select the **Stickiness** of the load balancer. Stickiness is the cookie policy that you want to use for when using cookies of the website. 

The two options supported in Rancher are:

* **None**: This option means that no cookie policy is in place.
* **Create new cookie**: This option means that the cookie will be defined outside of your application. This cookie is what the load balancer would set on requests and responses. This cookie would determine the stickiness policy. 

### Custom haproxy.cfg

Since Rancher is using HAProxy software, we have allowed the ability to define your own `global` and `defaults` configuration to your load balancer. Whatever you define in these sections will be appended to the configuration generated by Rancher.

### Labels/Scheduling Load Balancers 

We provide the ability to add labels to load balancers and schedule where the load balancer will be launched. Read more details about labels and scheduling [here]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/scheduling/).

