---
title: Kubernetes Addons in Rancher
layout: rancher-default-v1.4
version: v1.4
lang: en
---

## Kubernetes Addons
---

Working with Kubernetes means working wiht various tools that makes one's life easier. Addons are kubernetes tools that are started by Rancher. This way, the responsibility of starting these addons are not on the user. Rancher starts 3 kubernetes addons.

1. Helm - It is a packing tool for kubernetes
2. Dashboard - It is the UI for kubernetes
3. SkyDNS - It is the DNS server for kubernetes services

### Helm

Let us use helm to launch an application. The helm server, called tiller, will be started by Rancher. The helm client has been installed in the embedded kubectl cli.

Before we launch an application, let us ensure that helm client can talk to helm server.

Run the following command

```
> helm version
Client: &version.Version{SemVer:"v2.1.3", GitCommit:"5cbc48fb305ca4bf68c26eb8d2a7eb363227e973", GitTreeState:"clean"}
Server: &version.Version{SemVer:"v2.1.3", GitCommit:"5cbc48fb305ca4bf68c26eb8d2a7eb363227e973", GitTreeState:"clean"}
```

So, helm client and helm server are working correctly and can connect. So lets start using helm.

```
> helm repo update

Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "stable" chart repository
Update Complete. â Happy Helming!â

> helm search
NAME                    VERSION DESCRIPTION
stable/drupal           0.3.4   One of the most versatile open source content m...
stable/jenkins          0.1.1   A Jenkins Helm chart for Kubernetes.
stable/mariadb          0.5.2   Chart for MariaDB
stable/mysql            0.1.1   Chart for MySQL
stable/redmine          0.3.3   A flexible project management web application.
stable/wordpress        0.3.1   Web publishing platform for building blogs and ...
amit@kube1:~$

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

Let's ensure that mysql is installed and running

```
> helm ls

NAME            REVISION        UPDATED                         STATUS          CHART
loping-toad     1               Thu Oct 20 14:54:24 2016        DEPLOYED        mysql-0.1.1

> kubectl get pods --all-namespaces=true

NAMESPACE     NAME                                 READY     STATUS    RESTARTS   AGE
default       loping-toad-mysql-1951360640-gxmht   0/1       Pending   0          18m
kube-system   tiller-deploy-2434200834-gvk9m       1/1       Running   0          2h
```

If you notice, the service name is `loping-toad-mysql`. You can access the service using its DNS service name. The DNS service name is

`loping-toad-mysql.default.svc.cluster.local`

You can get the password for this mysql instance by running the following command

```
kubectl get secret --namespace default loping-toad-mysql -o jsonpath="{.data.mysql-root-password}" | base64 --de
code; echo
```

You can connect to the mysql instance using the following command

`mysql -h rolling-warthog-mysql -p`

then, provide your password.
