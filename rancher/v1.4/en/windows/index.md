---
title: Windows in Rancher
layout: rancher-default-v1.4
version: v1.4
lang: en
---

## Windows (Experimental)
---

To deploy Windows in Rancher, you'll first need to create a new [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/) that has an [environment template]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#what-is-an-environment-template) with the container orchestration set as **Windows**.

Currently, Rancher only supports creating containers on specific hosts. Most of the other features in Cattle that may appear in the UI are currently not supported (e.g. service discovery, healthcheck, meta data, DNS, load balancer).

> **Note:** There is a default Windows environment template available. If you try to create your own environment template with Windows, you will need to disable all other infrastructure services as they are currently not compatible with Windows.

### Creating a Windows Environment

In the dropdown of environments, click on the **Manage Environments**. To create a new environment, click on **Add Environment**, provide a **Name**, **Description** (Optional), and select an environment template that has Windows as the orchestration. If [access control]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/) is turned on, you can [add members]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#editing-members) and select their [membership role]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#membership-roles). Anyone added to the membership list would have access to your environment.

After a Windows environment has been created, you can navigate to the environment by either selecting the name of the environment in the environment's dropdown in the upper left hand corner or by selecting **Switch to this Environment** in the specific environment's drop down.

> **Note:** As Rancher adds support for multiple container orchestration frameworks, Rancher currently does not support the ability to switch between environments that already have services running in it.

### Adding Windows hosts

In order to add a host into Windows, you'll need to prepare a host running [Windows Server 2016 with Docker](https://msdn.microsoft.com/en-us/virtualization/windowscontainers/about/index) installed.

In the **Infrastructure** tab, you will get a custom command to launch the Rancher agent service. Follow the directions to launch the Rancher agent service in Windows.

On the hosts, the agent binary will be download to a folder called `C:/Program Files/rancher` and agent logs will be found at `C:/ProgramData/rancher/agent.log`.

### Removing Windows hosts

As part of adding a host into Rancher, the Rancher agent is installed and registered on the host as a service. In order to re-use a host, you must delete the existing service. In the powershell, run the following command. After the service is deleted, you can re-use the host in a Windows environment.

```bash
& 'C:\Program Files\rancher\agent.exe' -unregister-service
```

### Networking in Windows

By default, we support NAT and transparent [networking](https://docs.microsoft.com/en-us/virtualization/windowscontainers/container-networking/architecture).

Currently, the default **Windows** environment template supports a transparent network named `transparent`, which is created by running `docker network create -d transparent transparent`.

If you want to create a transparent network with a different name, you will need to create a new environment template with **Windows** as the container orchestration. After selecting **Windows**, you can click on **Edit Config** to change the name of the transparent network. The default name is `transparent`. After creating the updated environment template, you can create a new environment that will support the newly named transparent network. The UI will continue to have `transparent` as the default name, so you will need to update the command to be `docker network create -d transparent <NEW_NAME_IN_TEMPLATE`.
