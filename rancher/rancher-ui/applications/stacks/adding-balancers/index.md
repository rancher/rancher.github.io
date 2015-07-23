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

Let's use a source port of `8090`, target port of `80`, select `Public` access and select the `http` protocol. Next, let's add our target. We will select our wordpress service. Click on **Create**. 

Just like with services, the load balancer is not started until the user starts the service. You can individually start the load balancer by clicking **Start** or selecting **Start** in the dropdown menu. 

Now, let's see the load balancer in action. Click on a container name inside the load balancer. This will bring you to a detailed container page of the load balancer. Copy the IP address of the host, paste the IP into the web browser of your choice and add `:8090`. The Wordpress application will come up in the browser. 

It's that easy to set up a load balancer with Rancher! 

## Load Balancer Routing 

Our load balancer has HAProxy software installed on the load balancer agent containers. The load balancer uses a round robin algorithm from HAProxy to select the target services. 

### Internal Load Balancers

With Rancher, you have the ability to create an internal load balancer by setting the listening port(s) to `Internal`. When the listening port is set to internal, then the source port of the load balancer will not be exposed on the host. Therefore, for any internal load balancer on a host, only services on the same host will be able to access this load balancer. Any services on a different host will **not** be able to access the load balancer.

### Basic Load Balancing

In the most basic use case, we can select as many listening ports and services as we'd like. We've made the assumption that the access is set as `public` for every listening ports. The source port(s) of the load balancer will use the round robin algorithm to forward traffic to any service(s) on the target port(s). 

**Example:**

When we set up 2 listening ports and 3 services, the load balancer will direct traffic on both listening ports across all services.

Source Port| Listening Port
---|---
80 | 80
443 | 
<br>

| Target Services|
|----|
| Service1 |
| Service2 |
|Service3 |

<br>
In our example, any traffic directed to port `80` on the host of the load balancer would alternate between Service1, Service2 and Service3 on the target port `80`. Any traffic directed to port `443` on the host of the load balancer would alternate between Service1, Service2 and Service3 on port `443`. 

With our basic load balancing, it should solve the most basic use cases. There are limitations within the basic load balancing. If you want to load balance different services (i.e. virtual hosting) or listen using host headers/paths/ports, you can use our advanced routing options for more flexibility.

### Advanced Routing Options

To expand the advanced options, click on the **Show advanced routing options**. When using the advanced options, the only required field is **Target Service**, which would mimic the basic load balancing examples. All of the other fields in the advanced section are optional. For each option, we cover some basic examples, but you can use all or some of these options together to define exactly how you want your load balancer to direct traffic to your services.

#### Request Host/Request Path 

The request host can be a specific HTTP host header used for each service. The request path can be a specific path. The request host and request path can be used independently or in conjunction to create a specific request. 

**Example:**

domain1.com -> Service1 <br>
domain2.com -> Service2

domain3.com -> Service1 <br>
domain3.com/admin -> Service2

If no ports are defined for the service, then the source port and target port of the listening ports will be used to direct traffic based on the request. You can also specify the source ports and target ports for each request and the traffic would use the specified ports for the request.

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
|Service2 | `443`|

<br>
In our example above, the load balancer will direct traffic to different ports depending on the service. Since the load balancer is using a round robin algorithm, any traffic to the source port `80` will be directed alternatively between the services. When traffic is being directed to Service1, it will use the default target port `80`. When traffic is directed to Service2, it will use the target port `443`, that was defined with Service2.

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
