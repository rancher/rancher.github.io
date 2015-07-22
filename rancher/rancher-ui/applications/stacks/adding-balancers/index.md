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

In our example, we only have 2 hosts in our environment, so therefore we can only create a maximum of 2 load balancers.

We'll define the listening ports on the load balancer. These ports will be accessed publicly through through. You can define the protocol for each port. Currently, the load balancers have only one algorithm that is used by HAProxy, which is round robin. HAProxy is the software that is installed on our load balancers. 

In our example, we'll use `8090` with the `http` protocol. 

Next, we will select our target and port, which is our wordpress service. The available target(s) in the drop down list are any services within the stack. The target port is the private port that targets will use to communicate with the hosts. 

In our example, we'll select our wordpress service and use port `80`.

### Stickiness Policy 

You can select the **Stickiness** of the load balancer. Stickiness is the cookie policy that you want to use for when using cookies of the website. 

The three options that Rancher provides are:

* **None**: This option means that no cookie policy is in place.
* **Use existing cookie**: This option means that we will attempt to use the application's cookie for stickiness policies configuration. 
* **Create new cookie**: This option means that the cookie will be defined outside of your application. This cookie is what the load balancer would set on requests and responses. This cookie would determine the stickiness policy. 

You can only select one of these three choices and by default, we have selected **None**.

### Labels/Scheduling

By adding labels to a load balancer, every load balancer container will receive that label, which is a key value pair. In Rancher, we use these container labels to help define scheduling rules. You can create as many labels on a load balancer as you'd like. By default, Rancher already adds system related labels on every container. 

In a load balancer, you might want to pick specific hosts to have your load balancers started on. This can be accomplished by creating a set of scheduling rules for the load balancer. To add scheduling rules, click on  the **Scheduling** tab. You can add as many scheduling rules as you want by clicking on the **Add Scheduling Rule** button. Any host that follows all the rules is a host that could have the load balancer containers started on. 

For each rule, you select a **condition** of the rule. There are 4 different conditions, which define how strict the rule must be followed. The **field** determines which field you want the rule to be applied to. The **key** and **value** are the values which you want the field to be checked against. Rancher will spread the distribution of containers on the applicable hosts based on the load of each host. Depending on the condition chosen will determine what the applicable hosts are.

> **Note:** If you have selected the **Always run one instance of this container on every host**, then only the host labels will appear as a possible field.

_Conditions_

* **must** or **must not**: Rancher will only use hosts that match or do not match the field and value. If Rancher cannot find a host that meets all of the rules with these conditions, your service could get stuck in an _Activating_ state. The service will be continually trying to find a host for the containers. To fix this state, you can either edit the scale value of the service or add/edit another host that would satisfy all of these rules.  
* **should** or **should not**: Rancher will attempt to use hosts that match the field and value. In the case of when there is no  host that matches all the rules, Rancher will remove one by one the soft contraints (should/should not rules) until a host satisfies the remaining constraints. 

_Fields_

* **host label**: When selecting the hosts to use for the service, Rancher will check the labels on the host to see if they match the key/value pair provided. Since every host can have one or more labels, Rancher will compare the key/value pair against all labels on a host. When adding a host to Rancher, you can add labels to the host. You can also edit the labels on the hosts by using the **Edit** option in the host's dropdown menu. The list of labels on active hosts are available from the dropdown in the key field.
* **container with label**: When selecting this field, Rancher will look for hosts that already have containers with labels that match the key/value pair. Since every container can have one or more labels, Rancher will compare the key/value pair against all labels on every container in a host. The container labels are in the **Advanced Options** -> **Labels** for a container. You will not be able to edit the container labels after the container is started. In order to create a new container with the same settings, you can **Clone** the container and add the labels before starting it. The list of user labels on running containers are available from the dropdown in the key field.
* **service with the name**: Rancher will check to see if a host has a container from the specified service running on it. If at a later time, this service has a name change or is inactive/removed, the rule will no longer be valid. If you pick this field, the value will need to be in the format of `stack_name/service_name`. The list of running services are available from the dropdown in the value field.
* **container with the name**: Rancher will check to see if a host has a container with a specific name running on it. If at a later time, the container has a name change or is inactive/removed, the rule will no longer be valid. The list of running containers are available from the dropdown in the value field.

Click on **Create**. 

Just like with services, the load balancer is not started until the user starts the service. You can individually start the load balancer by clicking **Start** or selecting **Start** in the dropdown menu. If the user selects to **Start Services** from the dropdown menu of the stack, then it will also start the load balancer.

Now, to see the load balancer in action, click on a container name inside the load balancer. This will bring you to a detailed container page of the load balancer. Copy the IP address of the host by clicking on the **paper icon**. Paste the IP into the web browser of your choice and add `:8090`. The Wordpress application will come up.

