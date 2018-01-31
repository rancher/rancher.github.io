---
title: Private Registry with Kubernetes in Rancher
layout: rancher-default-v1.6
version: v1.6
lang: en
---

## Private Registry with Kubernetes in Rancher
---

If you are running Rancher with [no internet access]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/no-internet-access/) or Rancher does not have access to DockerHub (i.e. `docker.io`) and Google Container Registry (i.e. `gcr.io`), then the pod infra container image and Kubernetes add-ons will not be installed. You will need to [configure Kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#configuring-kubernetes) to point to a private registry for installing the Kubernetes add-ons and the pod infra container image.

#### Private Registry Requirements

Rancher expects the private registry to mirror DockerHub (i.e `docker.io`) and Google Container Registry (i.e. `gcr.io`).

##### Pod Infra Container Image

When [configuring Kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#configuring-kubernetes), Rancher uses an image whose network/ipc namespaces will be used in each pod. 

```yml
# Located as a default value in the k8s templates
Image: gcr.io/google_containers/pause-amd64:3.0
```

##### Kubernetes Add-Ons

The `namespace/name:tag` is expected to be consistent the images in the [Rancher add-on templates](https://github.com/rancher/kubernetes-package/tree/master/addon-templates).

To retrieve the exact image versions needed for the Kubernetes version that is tied to the Rancher server version you are running, you can use the `print-catalog-images.py` script inside the `scripts` directory in the `rancher/rancher` repository. To show the Kubernetes addons images, you need to specify the `--k8saddons` flag. See an example below:

```bash
# We need python to run the script
$ docker run -ti python:2.7 bash
# Clone the rancher repository
$ git clone https://github.com/rancher/rancher
# Install required python modules
$ cd rancher/scripts/print-catalog-images/
$ pip install -r requirements.txt
...
Successfully installed ...
# Run the script to print the needed images, specify --k8saddons to list Kubernetes addons
$ ./print-catalog-images.py -v 1.6.14 --k8saddons
Rancher Version: 1.6.14
Catalog URL: https://git.rancher.io/rancher-catalog
Catalog Branch: v1.6-release
...
k8s: v1.8.5-rancher4
    - busybox
    - rancher/lb-service-rancher:v0.7.17
    - rancher/k8s:v1.8.5-rancher4
    - rancher/etcd:v2.3.7-13
    - rancher/kubectld:v0.8.5
    - rancher/etc-host-updater:v0.0.3
    - rancher/kubernetes-agent:v0.6.6
    - rancher/kubernetes-auth:v0.0.8
    - k8s-dns-sidecar-amd64:1.14.5
    - heapster-grafana-amd64:v4.4.3
    - k8s-dns-kube-dns-amd64:1.14.5
    - tiller:v2.6.1
    - heapster-amd64:v1.4.0
    - kubernetes-dashboard-amd64:v1.8.0
    - heapster-influxdb-amd64:v1.3.3
    - k8s-dns-dnsmasq-nanny-amd64:1.14.5
...
```

##### Images for Helm

```yml
# Located in the helm/tiller-deploy.yaml
image: <$PRIVATE_REGISTRY>/kubernetes-helm/tiller:<VERSION>
```

##### Images for Dashboard

```yml
# Located in the dashboard/dashboard-controller.yaml
image: <$PRIVATE_REGISTRY>/google_containers/kubernetes-dashboard-amd64:<VERSION>
```

##### Images for Heapster

```yml
# Located in the heapster/heapster-controller.yaml
image: <$PRIVATE_REGISTRY>/google_containers/heapster:<VERSION>

# Located in the heapster/influx-grafana-controller.yaml
image: <$PRIVATE_REGISTRY>/kubernetes/heapster_influxdb:<VERSION>
image: <$PRIVATE_REGISTRY>/google_containers/heapster_grafana:<VERSION>
```

##### Images for kube-dns
```yml
# Located in the dns/kubedns-controller.yaml.sed
image: <$PRIVATE_REGISTRY>/google_containers/k8s-dns-kube-dns-amd64:<VERSION>
image: <$PRIVATE_REGISTRY>/google_containers/k8s-dns-dnsmasq-nanny-amd64:<VERSION>
image: <$PRIVATE_REGISTRY>/google_containers/k8s-dns-sidecar-amd64:<VERSION>
```
