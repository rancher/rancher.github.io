---
title: Registries in Rancher
layout: rancher-default-v1.5
version: v1.5
lang: en
---

## ECR Credential Updater

The ECR Credential Updater is a container service that periodically polls the ECR API to fetch a
new Docker registry credential. The updater authenticates to AWS with an IAM credential which provides it the rights to request the Docker credential. The Docker credential assumes the same repository rights as the requesting IAM user. The IAM user should have a least read access to all the ECR repos that a user desires to launch in Rancher. See [Amazon ECR IAM Policies and Roles](http://docs.aws.amazon.com/AmazonECR/latest/userguide/ECR_IAM_policies.html) for more details.

## Setup
From within a Rancher environment, select the environment catalog and then find the item called "ECR Credential Updater". On the following page you will be asked to provide a set of AWS access keys. These keys should be for the user which you have provided the appropriate access policies to. See the IAM policy example below. Additionally for any nodes running in EC2, you can apply IAM roles to those nodes with these same policies.

Once you have launched the service, you should then be able to start using images in Rancher. When specifying a container in Rancher, use fully qualified address AWS provides such as: `aws-account-number.dkr.ecr.us-west-2.amazonaws.com/my-repo:latest`.

### IAM Policy Example
The following is an example of a broad scope of access you might give in a pre-production account to this service. This would allow Rancher to pull from any repo within the respective AWS account.

```
{
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Action": [
            "ecr:GetAuthorizationToken",
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetDownloadUrlForLayer",
            "ecr:GetRepositoryPolicy",
            "ecr:DescribeRepositories",
            "ecr:ListImages",
            "ecr:DescribeImages",
            "ecr:BatchGetImage"
        ],
        "Resource": "*"
    }]
}
```
