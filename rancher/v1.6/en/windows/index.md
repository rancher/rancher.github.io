---
title: Windows in Rancher
layout: rancher-default-v1.6
version: v1.6
lang: en
---

## Windows (Experimental)
---

_Rancher v1.6.13+_

### Windows Host Requirements

System OS: Windows Server 2016

Required Applications
* Windows Features: RemoteAccess and Routing - Note: If this is not installed on the machine, steps on how to install are in the directions in Rancher server
* Docker: Version >= 17.06

AWS Instance Requirements
* 1 core CPU
* 2+ GB memory
* One Subnet will be for NAT and used across Rancher Server and any hosts added
* One Subnet will be for the overlay network that allows cross host communication

### Networking Requirements in AWS

1. Create a VPC
2. Create 2 subnets in the VPC. Ensure that these 2 subnets are in the same availability zone.
  * One subnet will be used for NAT (`Subnet A`)
  * One subnet will be used for creating the overlay network (`Subnet B`)
3. Create an additional network interface in `Subnet B`. For each additional host that is added, an additional network interface will need to be created in `Subnet B`.

### Launching Rancher Server in AWS

1. Launch Rancher Server in an AWS EC2 instance that is in `Subnet A`. Ensure the instance meets the [Rancher server requirements](https://rancher.com/docs/rancher/v1.6/en/installing-rancher/installing-server/#requirements).
2. In Rancher, create a new Windows environment.

### Launching AWS EC2 Hosts with Windows and setting Networking up

1. Launch a new AWS EC2 instance that is in `Subnet A` and meets the [Windows hosts requirements](#windows-hosts-requirements).
2. After the instance is running, log in to the instance using Remote Desktop. The instance will already have a public IP from `Subnet A`.
3. Attach the additional network interface to the instance. Select the instance in AWS, click on **Actions** -> **Networking** -> **Attach Network Interface**. Remember, this network interface needs to be in the same availability zone as your instance, and it should be in `Subnet B`.
4. Make sure that the network interface just attached has disabled the **Source/Dest. Check**. In **Network Interfaces** page, select the network interface and click on **Actions** -> **Change Source/Dest. Check** -> select **Disabled**.
5. After attaching the additional network interface, restart the AWS EC2 instance.
6. After you can log back into the instance, there are currently two public IPs on the instance due to the 2 NICs. You can verify that there are two IPs by running `ipconfig`. We only want one public IP to be assigned to the instance. We need to set the default route on the interface from `Subnet A` that will have the public IP as this is the subnet for NAT.
7. Set static ip of subnet B instead of DHCP. It will ensure that the route metric of subnet B will be greater than subnet A's. And then, the default route always will be subnet A.

```
$ip=Get-NetIPAddress -ipaddress <subnet-B-ipaddress>
set-NetIPInterface -ifIndex $ip.ifIndex -AddressFamily $ip.AddressFamily -Dhcp Disabled
Remove-NetIPAddress -ifIndex $ip.ifIndex -AddressFamily $ip.AddressFamily -Confirm:$false
New-NetIPAddress -IfIndex $ip.IfIndex -IpAddress $ip.IpAddress -PrefixLength $ip.PrefixLength
```

### Adding Windows Hosts into Rancher

In Rancher Server, click on **Infrastructure** -> **Add Hosts** in the Windows environment. Follow the instructions on the screen.

* Subnet: Set the subnet that will be used to launch the containers on the host. In order to support an overlay network in Windows, each host in the environment must have a unique subnet. Note: This subnet is not related to either `Subnet A` or `Subnet B` created in AWS. This is a unique subnet in Rancher between the different hosts that will provide IPs to each container.
* Route IP: Set the route IP for this instance, which is used to forward network traffic between the different hosts. In our AWS EC2 example, the route IP is the IP of `Subnet B`.
* Agent IP (Optional): This is the public IP of the AWS EC2 instance, which is used in the Rancher agent.

After running the custom command to add the hosts, you'll need to wait a couple minutes before the host is up and running in Rancher. There will be a couple infrastructure stacks launched and running on the hosts.

### Troubleshooting

#### Agent
If your host isn't running, you can check the Rancher agent is running correctly. This service was launched through the `agent-windows` container.

```
Get-service rancher-agent
```

#### Networking

If the agent is running correctly, but there is no networking, check on the networking services (`per-host-subnet`).

```
Get-service rancher-per-host-subnet
```

Confirm that the Docker network has been established.
```
docker network inspect transparent
```

Check for the IP of transparent NIC with `ipconfig`. The IP of the transparent NIC should be in the host subnet.

Check that the metadata route in the host is on the transparent NIC.

```
get-netroute 169.254.169.250/32
```

Check the NAT setting and confirm it includes all the physical network adapters being used.

### Steps to Remove Windows Hosts

1. In the Rancher UI, deactivate and delete the host under **Infrastructure**.
2. On the Windows host, run following commands to un-register services and stop them.
```
"c:\program files\rancher\agent.exe --unregister-service"
"c:\program files\rancher\per-host-subnet.exe --unregister-service"
stop-service rancher-agent
stop-service rancher-per-host-subnet
```

3. On the Windows host, remove any containers in the transparent network.
4. On the Windows host, remove the transparent network in Docker.
```
docker network rm transparent
```
5. Use devcon.exe to uninstall the virtual NIC
```
"c:\program files\rancher\devcon.exe remove *MSLOOP"
```

6. Remove the folders created by Rancher.
```
rm "c:\program files\rancher"
rm "c:\programdata\rancher"
```

### Using Amazon's ECR Registry in a Windows environment

_Available as of Rancher v1.6.13+_

If you want to use images located in Amazon's ECR Registry in a **Windows** environment, see [Using Amazon's ECR Registry]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/registries/#using-amazons-ecr-registry) to understand why you need **AWS ECR Credential Updater** and read the instructions on the [AWS ECR Credential Updater page]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/registries/ecr_updater/#windows-environments) to configure it.


_Prior to v1.6.13_

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
