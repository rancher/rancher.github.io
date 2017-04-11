---
title: Kubernetes Addons in Rancher
layout: rancher-default-v1.4
version: v1.4
lang: en
---

## Kubernetes Add-ons
---

Rancher automatically installs Kubernetes add-ons to help enhance the Kubernetes experience. 

* [Helm](#helm) - A Package Manager for Kubernetes
* [Dashboard](#dashboard) - A dashboard web interface for Kubernetes
* [SkyDNS](#skydns) - A DNS server for Kubernetes

### Helm

Helm consists of two parts, a server called tiller and a client called helm. Tiller is automatically started by Rancher and is launched in the **kube-system** namespace. The helm client is installed in the embedded kubectl CLI. 

#### Verifying Helm 

Before we start using helm to launch applications, let's verify that the helm client can talk to helm server( i.e. tiller). Use `helm version` in the embedded kubectl CLI, which is available in **Kubernetes** -> **CLI**.

```bash
> helm version
Client: &version.Version{SemVer:"v2.1.3", GitCommit:"5cbc48fb305ca4bf68c26eb8d2a7eb363227e973", GitTreeState:"clean"}
Server: &version.Version{SemVer:"v2.1.3", GitCommit:"5cbc48fb305ca4bf68c26eb8d2a7eb363227e973", GitTreeState:"clean"}
```

If there is a result for both the client and server, then helm is working properly. 

#### Using Helm

Similar to most package managers, we should confirm we have the latest list of charts. 

```bash
> helm repo update

Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "stable" chart repository
Update Complete. â Happy Helming!â
```

Using `helm search`, you can search for different charts that are available to be installed. 

```
> helm search
NAME                    VERSION DESCRIPTION
stable/drupal           0.3.4   One of the most versatile open source content m...
stable/jenkins          0.1.1   A Jenkins Helm chart for Kubernetes.
stable/mariadb          0.5.2   Chart for MariaDB
stable/mysql            0.1.1   Chart for MySQL
stable/redmine          0.3.3   A flexible project management web application.
stable/wordpress        0.3.1   Web publishing platform for building blogs and ...
amit@kube1:~$
```

Once you've found the chart that you want to install, run `helm install <chart_name>` to install the application that you want.

```
> helm install stable/mysql

Fetched stable/mysql to mysql-0.1.1.tgz
NAME: loping-toad
LAST DEPLOYED: Thu Oct 20 14:54:24 2016
NAMESPACE: default
STATUS: DEPLOYED

RESOURCES:
==> v1/Secret
NAME                TYPE      DATA      AGE
loping-toad-mysql   Opaque    2         3s

==> v1/Service
NAME                CLUSTER-IP   EXTERNAL-IP   PORT(S)    AGE
loping-toad-mysql   192.16.1.5   <none>        3306/TCP   3s

==> extensions/Deployment
NAME                DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
loping-toad-mysql   1         0         0            0           3s

==> v1/PersistentVolumeClaim
NAME                STATUS    VOLUME    CAPACITY   ACCESSMODES   AGE
loping-toad-mysql   Pending                                      3s
```

After you've installed the charts that you want, you can check which applications are running by using `helm ls`. All services are deployed in the namespace that you are currently using CLI in. 

```bash
> helm ls

NAME            REVISION        UPDATED                         STATUS          CHART
loping-toad     1               Thu Oct 20 14:54:24 2016        DEPLOYED        mysql-0.1.1
```


### SkyDNS

In Rancher, each service is given a name. Other services can communicate with a service using the DNS service name. The DNS service name is `<service_name>.<namespace_name>.svc.cluster.local`. 

Using the mysql application launched in the helm example, you can get the name and namespace of the mysql service. 

```bash
> kubectl get pods --all-namespaces=true

NAMESPACE     NAME                                 READY     STATUS    RESTARTS   AGE
default       loping-toad-mysql-1951360640-gxmht   0/1       Pending   0          18m
kube-system   tiller-deploy-2434200834-gvk9m       1/1       Running   0          2h
```

The mysql application is named `loping-toad-mysql`. For this instance, the DNS service name is `loping-toad-mysql.default.svc.cluster.local`.
