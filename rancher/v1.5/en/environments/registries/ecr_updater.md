---
title: ECR Credential Updater
layout: rancher-default-v1.5
version: v1.5
lang: en
---

## AWS Elastic Container Registry (ECR) Credential Updater

The ECR Credential Updater is a container service that periodically polls the AWS ECR API to fetch a
new Docker registry credential. The updater authenticates to AWS with an IAM credential, which provides it the rights to request the Docker credential. The Docker credential assumes the same repository rights as the requesting IAM user. The IAM user is required to minimally have read access to all the ECR repositories that a user will be using to pull images in Rancher. Please see the [Amazon ECR IAM Policies and Roles](http://docs.aws.amazon.com/AmazonECR/latest/userguide/ECR_IAM_policies.html) for more details on permissions.

> **Note:** Without launching this ECR updater catalog item, any ECR registries added to Rancher will have their token expired and no longer have the ability to pull images. 

### Installing ECR Updater 

#### Existing Environments

If you already have a Cattle environment running, go to **Catalog** -> **Library** to find the catalog item **Rancher ECR Credential Updater**. When launching the catalog item, you will need to configure the service with your AWS access keys. These keys should be for the user which you have provided the appropriate access policies to. 

> **Note:** If you will be using Kubernetes, it is recommended to edit your environment templates to include this catalog template before creating an envirronment. If you already have Kubernetes, you can delete the Kubernetes stack to convert it to Cattle to launch the catalog item and re-launch the Kubernetes stack from the catalog. 

#### New Environments

When creating a new environment, you can use an [environment template]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#what-is-an-environment-template), which already has the **Rancher ECR Credential Updater** enabled for the template. This would allow the updater to be deployed on any environment that uses that template. 

### Launching Images from ECR

In the environment, you should add ECR as a [registry]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/registries/). Once you have launched the service, your credentials to the ECR registry will never expire and you will always be able to launch images from ECR. 

When specifying the image name in Rancher, use the fully qualified address AWS provides such as: `aws-account-number.dkr.ecr.us-west-2.amazonaws.com/my-repo:latest`.

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
