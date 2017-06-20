---
title: Adding Amazon EC2 Hosts
layout: rancher-default-v1.1
version: v1.1
lang: en
redirect_from:
  - rancher/v1.1/en/rancher-ui/infrastructure/hosts/amazon/
  - rancher/v1.1/zh/rancher-ui/infrastructure/hosts/amazon/
  - /rancher/v1.1/zh/hosts/amazon/
---

## Adding Amazon EC2 Hosts
---

Rancher supports provisioning [Amazon EC2](http://aws.amazon.com/ec2/) hosts using `docker machine`.

### Finding AWS Credentials

Before launching a host on AWS, you'll need to find your AWS account credentials as well as your security group information. The **Account Access** information can be found using Amazon's [documentation](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSGettingStartedGuide/AWSCredentials.html) to find the correct keys. When creating an **access key** and **secret key**, please be sure to save it somewhere as it will not be available unless you create a new key pair.

### Launching Amazon EC2 Host(s)

Under the Infrastructure -> Hosts tab, click **Add Host**. Select the **Amazon EC2** icon. Select your desired **Region**. Provide your AWS **Access key** and **Secret Key**, click on **Next: Authenticate & select a network**. Rancher will use your credentials to determine what is available in AWS to launch instances.

You'll need to select the availability zone to create the instance. Depending on which zone that you select, the available VPC IDs and Subnet IDs will be displayed. Select a **VPC ID** or **Subnet ID**, and click on **Next: Select a Security Group**.

Next, you'll select a security group to use for the hosts. There are two choices for security groups. The **Standard** option will create or use the existing `rancher-machine` security group. If Rancher creates the `rancher-machine` security group, it will open up all the necessary ports to allow Rancher to work successfully. `docker machine` will automatically open up port `2376`, which is the Docker daemon port.

In the **Custom** option, you can choose an existing security group, but you will need to ensure that specific ports are open in order for Rancher to be working correctly.

<a id="EC2Ports"></a>

### Required Ports for Rancher to work

 * From the rancher server to TCP port `22` (SSH to install and configure Docker)
 * From and To all other hosts on UDP ports `500` and `4500` (for IPsec networking)

> **Note:** If you re-use the `rancher-machine` security group, any missing ports in the security group will not be re-opened. You will need to check the security group in AWS if the host does not launch correctly.

After choosing your security option, click on **Next: Set Instance Options**.

Finally, you'll just need to finish filling out the final details of the host(s).

1. Select the number of hosts you want to launch using the slider.
2. Provide a **Name** and if desired, **Description** for the host.
3. Select the **Instance Type** that you want launched.
4. Select the **Root Size** of the image. The default in `docker machine` is 16GB, which is what we have defaulted in Rancher.
5. (Optional) For the **AMI**, `docker machine` defaults with an Ubuntu 16.04 LTS image in the specific region. You also have the option to select your own AMI. If you select your own AMI, please make sure of the following:
   1. It's available in your previously selected region
   2. You define the correct **SSH User**. When using a [RancherOS AMI](https://github.com/rancher/os#amazon), this should be `rancher`.
6. (Optional) Provide the **IAM Profile** to be used as an instance profile.
7. (Optional) Add **[labels]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#labels)** to hosts to help organize your hosts and to [schedule services/load balancers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/) or to [program external DNS records using an IP other than the host IP]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/external-dns-service/#using-a-specific-ip-for-external-dns).
8. (Optional) In **Advanced Options**, customize your `docker-machine create` command with [Docker engine options](https://docs.docker.com/machine/reference/create/#specifying-configuration-options-for-the-created-docker-engine).
9. When complete, click **Create**.

Rancher will create the EC2 instance(s) and launch the _rancher-agent_ container in the instance. In a couple of minutes, the host will be active and available for [services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/).
