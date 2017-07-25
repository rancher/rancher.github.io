---
title: External DNS Service
layout: rancher-default-v1.4
version: v1.4
lang: en
---

## External DNS Service
---

As part of the [Rancher catalog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/), Rancher provides multiple DNS services that listen to rancher-metadata events, and generate DNS records based on the metadata changes. The examples will use Route53 as an example for how the external DNS service works, but Rancher also has community contributed services with other DNS providers.

### Best Practices

* For every environment in your Rancher setup, there should be a `route53` service of scale 1.
* Multiple Rancher instances should not share the same `hosted zone`.

### Required AWS IAM permissions

The following IAM policy describes the minimum set of permissions needed for Route53 DNS to work.
Make sure that the AWS security credentials (Access Key ID / Secret Access Key) that you are specifying have been granted at least these permissions.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "route53:GetHostedZone",
                "route53:GetHostedZoneCount",
                "route53:ListHostedZonesByName",
                "route53:ListResourceRecordSets"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "route53:ChangeResourceRecordSets"
            ],
            "Resource": [
                "arn:aws:route53:::hostedzone/<HOSTED_ZONE_ID>"
            ]
        }
    ]
}
```

> **Note:** When using this JSON document to create a custom IAM policy in AWS, replace `<HOSTED_ZONE_ID>` with the ID of the Route53 hosted zone or use a wildcard ('*').

### Launching Route53 Service

From the **Catalog** tab, you can select the **Route53 DNS Stack**.

Provide a **Name**, and if desired, **Description** for the stack.

In the **Configuration Options**, you'll need to provide the following:


Name| Value
---|---
AWS Access Key | Access key to your AWS API
AWS Secret Key | Secret key to your AWS API
AWS Region | Region name in AWS. We suggest setting the region to the one closest to your geo location. It will get translated to the AWS API endpoint to which Rancher Route53 will be sending the updated DNS requests.
Hosted Zone | Route53 hosted zone. This has to pre-created on your Route53 instance.

<br>
After filling in the form, click on **Create**. The stack will be created with the `route53` service and you only need to start the service!


### Using Route53 Service

The `route53` service will generate DNS records for only services that have ports published to the host. For every DNS record that Rancher generates, it will create fqdn for the service in the following format:

```
fqdn=<serviceName>.<stackName>.<environmentName>.<yourHostedZoneName>
```

On Route 53 in AWS, it will get represented as a Record Set with name=fqdn and value=[ip address of the host(s) where the service is deployed]. Rancher `route53` service will manage only Record Sets that end with <environmentName>.<yourHostedZoneName>. Currently, the default TTL is 300 seconds.

Once DNS record is set on Route 53 on AWS, the generated fqdn will get propagated back to Rancher, and will be set on the **service.fqdn** field. You can find the fqdn field by using the **View in API** from the drop down menu of the service and searching for **fqdn**.

When using the fqdn in a browser, it will be directed to one of the containers in the service. If there are any changes to the IPs associated with the containers in a service, these changes will update the value in AWS Route 53. There will be no changes from the user perspective as the user will always be using the fqdn.

> **Note:** After the `route53` service is launched, any services with a host port already deployed will also receive a fqdn.


### Removing Route53 Service

When the `route53` service is removed from Rancher, the record sets in Amazon Route 53 is **NOT** removed. Those will need to be manually removed by yourself in your Amazon account.

### Using a Specific IP for External DNS

By default, Rancher DNS picks the host IP, that is registered in Rancher server, to be used for exposing services. There will be use cases where hosts have been configured in Rancher using a private network, but these hosts will need to expose services using external DNS through the public network. In cases where you would like to specify the IP to be used for external DNS, you will need to add a [host label]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#host-labels) before launching your external DNS service.

Before launching external DNS services, please add the following label to your host. The value of the label is what Rancher's Route53 DNS service will use when programming rules. If this label is not set on the host, Rancher's Route53 DNS service will automatically use the host IP that is displayed in Rancher.

```
io.rancher.host.external_dns_ip=<IP_TO_BE_USED_FOR_EXTERNAL_DNS>
```
