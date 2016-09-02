---
title: Amazon ECS on RancherOS
layout: os-default

---

## Amazon ECS (EC2 Container Service)
---

[Amazon ECS](https://aws.amazon.com/ecs/) is supported, which allows RancherOS EC2 instances to join your cluster.

### Pre-Requisites

Prior to launching RancherOS EC2 instances, the [ECS Container Instance IAM Role](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/instance_IAM_role.html) will need to have been created. This `ecsInstanceRole` will need to be used when launching EC2 instances. If you have been using ECS, you created this role if you followed the ECS "Get Started" interactive guide.

### Launching an instance with ECS

RancherOS makes it easy to join your ECS cluster. The ECS agent is a [system service]({{site.baseurl}}/os/system-services/adding-system-services/) that is enabled in the ECS enabled AMI. There may be other RancherOS AMIs that don't have the ECS agent enabled by default, but it can easily be added in the user data on any RancherOS AMI.

When launching the RancherOS AMI, you'll need to specify the **IAM Role** and **Advanced Details** -> **User Data** in the **Configure Instance Details** step.

For the **IAM Role**, you'll need to be sure to select the ECS Container Instance IAM role.

For the **User Data**, you'll need to pass in the [cloud-config]({{site.baseurl}}/os/configuration/#cloud-config) file.

```yaml
#cloud-config
rancher:
  environment:
    ECS_CLUSTER: your-ecs-cluster-name
# If you have selected a RancherOS AMI that does not have ECS enabled by default,
# you'll need to enable the system service for the ECS agent.
  services_include:
    amazon-ecs-agent: true
```

#### Version

By default, the ECS agent will be using the `latest` tag for the `amazon-ecs-agent` image. In v0.5.0, we introduced the ability to select which version of the `amazon-ecs-agent`.

To select the version, you can update your [cloud-config]({{site.baseurl}}/os/configuration/#cloud-config) file.

```yaml
#cloud-config
rancher:
  environment:
    ECS_CLUSTER: your-ecs-cluster-name
    # Note: You will need to make sure to include the colon in front of the version.
    ECS_AGENT_VERSION: :v1.9.0
    # If you have selected a RancherOS AMI that does not have ECS enabled by default,
    # you'll need to enable the system service for the ECS agent.
  services_include:
    amazon-ecs-agent: true
```

<br>

> **Note:** The `:` must be in front of the version tag in order for the ECS image to be tagged correctly.

### Amazon ECS enabled AMIs

Latest Release: [v0.6.0](https://github.com/rancher/os/releases/tag/v0.6.0)

Region | Type | AMI
---|--- | ---
ap-northeast-1 | HVM - ECS Enabled |  [ami-1135fe70](https://console.aws.amazon.com/ec2/home?region=ap-northeast-1#launchInstanceWizard:ami=ami-1135fe70)
ap-northeast-2 | HVM - ECS Enabled |  [ami-cee530a0](https://console.aws.amazon.com/ec2/home?region=ap-northeast-2#launchInstanceWizard:ami=ami-cee530a0)
ap-southeast-1 | HVM - ECS Enabled |  [ami-6bd20908](https://console.aws.amazon.com/ec2/home?region=ap-southeast-1#launchInstanceWizard:ami=ami-6bd20908)
ap-southeast-2 | HVM - ECS Enabled |  [ami-7fc5f31c](https://console.aws.amazon.com/ec2/home?region=ap-southeast-2#launchInstanceWizard:ami=ami-7fc5f31c)
eu-central-1 | HVM - ECS Enabled |  [ami-81f102ee](https://console.aws.amazon.com/ec2/home?region=eu-central-1#launchInstanceWizard:ami=ami-81f102ee)
eu-west-1 | HVM - ECS Enabled |  [ami-627c0e11](https://console.aws.amazon.com/ec2/home?region=eu-west-1#launchInstanceWizard:ami=ami-627c0e11)
sa-east-1 | HVM - ECS Enabled |  [ami-cf0190a3](https://console.aws.amazon.com/ec2/home?region=sa-east-1#launchInstanceWizard:ami=ami-cf0190a3)
us-east-1 | HVM - ECS Enabled |  [ami-8c7b139b](https://console.aws.amazon.com/ec2/home?region=us-east-1#launchInstanceWizard:ami=ami-8c7b139b)
us-west-1 | HVM - ECS Enabled |  [ami-88ffb2e8](https://console.aws.amazon.com/ec2/home?region=us-west-1#launchInstanceWizard:ami=ami-88ffb2e8)
us-west-2 | HVM - ECS Enabled |  [ami-e5db0a85](https://console.aws.amazon.com/ec2/home?region=us-west-2#launchInstanceWizard:ami=ami-e5db0a85)
ap-south-1 | HVM - ECS Enabled |  [ami-39abde56](https://console.aws.amazon.com/ec2/home?region=ap-south-1#launchInstanceWizard:ami=ami-39abde56)
