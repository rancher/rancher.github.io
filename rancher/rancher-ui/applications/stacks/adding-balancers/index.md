---
title: Adding Load Balancers
layout: rancher-default
---

## Adding Load Balancers
---

After adding multiple services to your stack, you might have decided that you want to load balance your web applications. With Rancher, it's easy to add a load balancer to your stack! 

We'll walk through how to load balance the Wordpress application created earlier in the [adding services guide]({{site.baseurl}}/rancher/rancher-ui/applications/stacks/adding-services/). You add a load balancer by clicking the dropdown icon next to the **Add Service** button and selecting **Add Load Balancer**. 

In the **Add Load Balancer** page, you will need to provide a **Name** and if desired, **Description** of the load balancer. Use the slider to select the scale, i.e. how many containers of the load balancer. 

> **Note:** The number of containers of this load balancer cannot exceed the number of hosts in the environment, otherwise there will be a port conflict and this service will be stuck in an activating state. It will continue to try and find an available host and open port until you edit the scale of this load balancer or [add additional hosts]({{site.baseurl}}/rancher/rancher-ui/infrastructure/hosts/). 

In our example, we only have 2 hosts in our environment, so therefore we can only create a maximum of 2 load balancers.

We'll define the listening ports on the load balancer. These ports will be accessed publicly through through. You can define the protocol for each port. Currently, the load balancers have only one algorithm that is used by HAProxy, which is round robin. HAProxy is the software that is installed on our load balancers. 

In our example, we'll use `8090` with the `http` protocol. 

Next, we will select our target and port, which is our wordpress service. The available target(s) in the drop down list are any services within the stack. The target port is the private port that targets will use to communicate with the hosts. 

In our example, we'll select our wordpress service and use port `80`.


You can select the **Stickiness** of the load balancer. Stickiness is the cookie policy that you want to use for when using cookies of the website. 

The three options that Rancher provides are:

* **None**: This option means that no cookie policy is in place.
* **Use existing cookie**: This option means that we will attempt to use the application's cookie for stickiness policies configuration. 
* **Create new cookie**: This option means that the cookie will be defined outside of your application. This cookie is what the load balancer would set on requests and responses. This cookie would determine the stickiness policy. 

You can only select one of these three choices and by default, we have selected **None**.

Click on **Create**. 

Just like with services, the load balancer is not started until the user starts the service. You can individually start the load balancer by clicking **Start** or selecting **Start** in the dropdown menu. If the user selects to **Start Services** from the dropdown menu of the stack, then it will also start the load balancer.

Now, to see the load balancer in action, click on a container name inside the load balancer. This will bring you to a detailed container page of the load balancer. Copy the IP address of the host by clicking on the **paper icon**. Paste the IP into the web browser of your choice and add `:8090`. The Wordpress application will come up.

