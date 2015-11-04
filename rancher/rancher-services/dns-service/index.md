---
title: DNS Service
layout: rancher-default

---

## DNS Service

_Available as of v0.44.0+_

As part of the [Rancher catalog]({{site.baseurl}}/rancher/rancher-ui/applications/catalog/), Rancher provides a DNS service that is integrated with Amazon Route53 DNS. When launching the service, a single route53 container is launched in Rancher. This container will listen for rancher-metadata events, generate DNS records based on the metadata changes, and update Route53 accordingly.

### Best Practices

* There should be one `route53` service of scale 1 for every environment in your Rancher setup.
* Multiple Rancher instances should not share the same `hosted zone`. 

### Launching Route53 Service

From the **Applications** -> **Catalog** tab, you can select the **Route53 DNS Stack**. 

Provide a **Name**, and if desired, **Description** for the stack. 

In the **Configuration Options**, you'll need to provide the following:


Name| Value
---|---
AWS Access Key | Access key to your AWS API
AWS Secret Key | Secret key to your AWS API
AWS Region | Region name in AWS. We suggest setting the region to the one closest to your geo location. It will get translated to the AWS API endpoint to which Rancher Route53 will be sending the updated DNS requests.
Hosted Zone | Route53 hosted zone. This has to pre-created on your Route53 instance.

After filling in the form, click on **Create**. The stack will be created with the `route53` service and you only need to start the service!


### Using Route53 Service

The `route53` service will generate DNS records for only services that have ports published to the host. For every DNS record that Rancher generates, it will create fqdn for the service in the following format:

```
fqdn=<serviceName>.<stackName>.<environmentName>.<yourHostedZoneName>
```

On Route53 in AWS, it will get represented as a Record Set with name=fqdn and value=[ip addresses of the host(s) where service is deployed]. Rancher Route53 service will manage only Record Sets that end with <environmentName>.<yourHostedZoneName>.

Once DNS record is set on Route53 on AWS, the generated fqdn will get propagated back to Rancher, and will be set on the `service.fqdn` field. You can find the fqdn field by using the **View in API** from the drop down menu of the service and searching for `fqdn`.





