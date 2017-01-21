---
title: Internal DNS Service in Kubernetes Environments
layout: rancher-default-v1.2
version: v1.2
lang: en
redirect_from:
  - /rancher/v1.2/zh/kubernetes/k8s-internal-dns-service/
---

## Internal DNS Service in Kubernetes Environments
---

Within Rancher, we use our own internal DNS service in a [Kubernetes environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/) and not the SkyDNS cluster add on that Kubernetes uses.

Service discovery works by listening for events in Kubernetes. Each service will get its own record created in the format `<serviceName>.svc.cluster.local`.

All services in the Kubernetes environment are resolvable by `<serviceName>`. DNS resolutions are done on a per service basis in the format of `<serviceName>.<namespaceName>.svc.cluster.local`, per the format of [DNS in Kubernetes](https://github.com/kubernetes/kubernetes/blob/release-1.2/cluster/addons/dns/README.md).

On the Rancher DNS side, the record gets mapped to:

* Kubernetes Service Cluster IP: Kubernetes will distribute the traffic coming to this cluster IP to all the pod IPs associated to the cluster.
* [Headless Service](http://kubernetes.io/docs/user-guide/services/#headless-services) Mode (No Cluster IP defined on the service): service fqdn gets mapped to IPs of all the pod IPs behind the service.

### Examples

In a Kubernetes environment, let's create a service `foo` in the namespace `bar`. There are 2 pods linked to the `foo` service. The IPs of the container pods are `10.42.22.22`, `10.42.22.23`.

In this example, the service can be resolved by `foo.bar.svc.cluster.local`.

If this service was [headless](http://kubernetes.io/docs/user-guide/services/#headless-services), then `foo.bar.svc.cluster.local` will resolve to multiple A records, which are the IPs of the pods (i.e. `10.42.22.22`, `10.42.22.23`).  

If there is a cluster IP from the `10.42.x.x` space (e.g. `10.42.195.128`), it will get resolved to the service's cluster IP.
