---
title: Amazon ECS
layout: os-default

---

## Amazon ECS (EC2 Container Service)
---

As of RancherOS v0.4.0+, [Amazon ECS](https://aws.amazon.com/ecs/) is supported, which allows RancherOS EC2 instances to join your cluster. 

### Pre-Requisites

Prior to launching RancherOS EC2 instances, the [ECS Container Instance IAM Role](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/instance_IAM_role.html) will need to have been created. This `ecsInstanceRole` will need to be used when launching EC2 instances. If you have been using ECS, you most likely have created this role if you followed the ECS "Get Started" interactive guide. 

### Launching an instance with ECS

RancherOS makes it easy to join your ECS cluster. The ECS agent is a [system-service]({{site.baseurl}}/os/configuration/system-services/) that is enabled in the ECS enabled AMI. There may be other RancherOS AMIs that don't have the ECS agent enabled by default, but it can easily be defaulted in the user data on any RancherOS AMI. 

When launching the RancherOS AMI, you'll need to specify the **IAM Role** and **Advanced Details** -> **User Data** in the **Configure Instance Details** step. 

For the **IAM Role**, you'll need to be sure to select the ECS Container Instance IAM role. 

For the **User Data**, you'll need to pass in the [cloud-config]({{site.baseurl}}/os/cloud-config/) file.

```yaml
#cloud-config
rancher:
  environment:
    ECS_CLUSTER: your-ecs-cluster-name
# If you have selected a RancherOS AMI that does not have ECS enabled by default,
# you'll need to enable the system-service for the ECS agent.
  services_include:
    amazon-ecs-agent: true
```

### Amazon ECS enabled AMIs

Latest Release: [v0.4.1](https://github.com/rancher/os/releases/tag/v0.4.1)

Region | Type | AMI
---|--- | ---
ap-northeast-1 | HVM - ECS Enabled |  [ami-8ed6f6e0](https://console.aws.amazon.com/ec2/home?region=ap-northeast-1#launchInstanceWizard:ami=ami-8ed6f6e0)
ap-southeast-1 | HVM - ECS Enabled |  [ami-a25593c1](https://console.aws.amazon.com/ec2/home?region=ap-southeast-1#launchInstanceWizard:ami=ami-a25593c1)
ap-southeast-2 | HVM - ECS Enabled |  [ami-000a5363](https://console.aws.amazon.com/ec2/home?region=ap-southeast-2#launchInstanceWizard:ami=ami-000a5363)
eu-central-1 | HVM - ECS Enabled |  [ami-ae6674c2](https://console.aws.amazon.com/ec2/home?region=eu-central-1#launchInstanceWizard:ami=ami-ae6674c2)
eu-west-1 | HVM - ECS Enabled |  [ami-c26eb5b1](https://console.aws.amazon.com/ec2/home?region=eu-west-1#launchInstanceWizard:ami=ami-c26eb5b1)
sa-east-1 | HVM - ECS Enabled |  [ami-e079c38c](https://console.aws.amazon.com/ec2/home?region=sa-east-1#launchInstanceWizard:ami=ami-e079c38c)
us-east-1 | HVM - ECS Enabled |  [ami-976a10fd](https://console.aws.amazon.com/ec2/home?region=us-east-1#launchInstanceWizard:ami=ami-976a10fd)
us-west-1 | HVM - ECS Enabled |  [ami-59412f39](https://console.aws.amazon.com/ec2/home?region=us-west-1#launchInstanceWizard:ami=ami-59412f39)
us-west-2 | HVM - ECS Enabled |  [ami-4df1e02c](https://console.aws.amazon.com/ec2/home?region=us-west-2#launchInstanceWizard:ami=ami-4df1e02c)
