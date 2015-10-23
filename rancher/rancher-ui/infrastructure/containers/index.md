---
title: Containers
layout: rancher-default
---

## Containers
---

### Adding Containers

Typically, we recommend that people add containers using [services]({{site.baseurl}}/rancher/rancher-ui/applications/stacks/adding-services) as it provides a little more flexibility for the user, but sometimes we understand that you might want to spin up one container. 

There are a couple of ways to add a container to Rancher.

Option 1: In the **Infrastructure** -> **Container** page, click on **Add Container**.

Option 2: On a specific host, you can click on the **+ Add Container** image within the list of containers on the host. 

These options will bring you to the **Add Container** page. Any options that `docker run` supports when creating containers is also supported in Rancher.

1. Provide a **Name** and if desired, **Description** for the container.
2. Provide the **Image** to use. You can use any image on [DockerHub](https://hub.docker.com/) as well as any [registries]({{site.baseurl}}/rancher/configuration/registries) that have been added to Rancher. The syntax for image name would match any `docker run` commands. 

    Syntax of image names. By default, we pull from the docker registry. If no tag is specified, we will pull the latest tag. 

    `[registry-name]/[namespace]/[imagename]:[version]`

    <a id="port-mapping"></a>

3. If desired, set up port mapping for your host to container relationship. Assuming that your host is using its public IP, when we are mapping ports, we are creating the ability to access the container through the host IP. In the **Port Map** section, you will define the public ports that will be used to communicate with the container. You will also be defining which port will be exposed on the container. When mapping ports for a container to a host, Rancher will check to see if there are any port conflicts. 

    > **Note:** When ports are exposed in Rancher, it will not show up in `docker ps` as Rancher manages the iptable rules to make the ports fully dynamic. 

4. In the **Advanced Options** section, all options available in Docker are available for Rancher. By default, we have set the `-i -t`. 
  
    If you chose to add the container from the **Infrastructure** -> **Containers** page, Rancher will automatically pick a host for you. Otherwise, if you have picked a host to add a container to, the host will be populated within the **Advanced Options** -> **Security/Host** tab.
    
    There is also the ability to add labels to a container as well as apply scheduling rules. More details about labels and scheduling can be read [here]({{{{site.baseurl}}/rancher/rancher-ui/scheduling/).

5. When you have completed filling out your container options, click **Create**. If this is the first container on the host to be launched by Rancher, it will automatically deploy a container named _Network Agent_ in the Rancher UI. This container is what Rancher uses to allow containers between different hosts be able to communicate with each other. The _Network Agent_ runs using the `rancher/agent-instance` image. Rancher will automatically pull the correct version tag for this container.

## Editing Containers
---

From the dropdown of a container, you can select different actions to perform on a container. When viewing containers on a host or service, the dropdown icon can be found by hovering over the container name. In the **Infrastructure** -> **Containers**, the dropdown icon is only visible for containers that were created specifically on the hosts. Any containers created through a service will not display its dropdown icon. 

You can always click on the container name, which will bring you to the container details page. On that page, the dropdown menu is located in the upper right hand corner next to the state of the container.

When you select **Edit** from the dropdown menu, you will be only able to change the name and description of the container. Docker containers are immutable (not changeable) after creation. The only things you can edit are things that we store that aren't really part of the Docker container. This includes restarting, it's still the same container if you stop and start it. You will need to remove and recreate a container to change anything else. 

> **Note:** When ports are exposed in Rancher, it will not show up in `docker ps` as Rancher manages the iptable rules to make the ports fully dynamic. 

You can **Clone**, which will pre-fill the **Add Container** screen with all the setttings from an existing container. If you forget one thing, you can clone the container, change it, and then delete the old container. 

### Changing the Container States

When a container is in a **Running** state, you can **Stop** the container. This will stop the container on the host, but will not remove it. After the container is in the _Stopped_ state, you can select **Start** to have the container start running again. Another option is to **Restart** the container, which will stop and start the container in one step. 

You can **Delete** a container and have it removed from the host. 

### Executing the Shell

When you select **Execute Shell**, it brings you into the container shell prompt. 

### Viewing Logs

It's always useful to see what is going on with the logs of a container. Clicking **View Logs** provides the equivalent of `docker logs <CONTAINER_ID>` on the host.

