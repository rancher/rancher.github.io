---
title: Private Registry with Kubernetes in Rancher
layout: rancher-default-v1.5
version: v1.5
lang: en
---

## Private Registry with Kubernetes in Rancher
---

If you are running Rancher with [no internet access]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/no-internet-access/) or Rancher does not have access to DockerHub (i.e. `docker.io`) and Google Container Registry (i.e. `gcr.io`), then the pod infra container image and Kubernetes add-ons will not be installed. You will need to [configure Kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#configuring-kubernetes) to point a private registry for being able to installing the Kubernetes add-ons and the pod infra container image.

#### Private Registry Requirements

Rancher expects the private registry to mirror DockerHub (i.e `docker.io`) and Google Container Registry (i.e. `gcr.io`).

##### Pod Infra Container Image

When [configuring Kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#configuring-kubernetes), Rancher uses an image whose network/ipc namespaces in each pod will use.

```yml
# Located as a default value in the k8s templates
Image: gcr.io/google_containers/pause-amd64:3.0
```

##### Kubernetes Add-Ons

The `namespace/name:tag` is expected to be consistent the images in the [Rancher add-on templates](https://github.com/rancher/kubernetes-package/tree/master/addon-templates).

The images below are the list of add-ons that are currently supported, you will need to [check the Github repo for exact version](https://github.com/rancher/kubernetes-package/tree/master/addon-templates) and copy the exact version for each image.

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
