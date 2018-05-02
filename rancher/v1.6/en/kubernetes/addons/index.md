---
title: Kubernetes Addons in Rancher
layout: rancher-default-v1.6
version: v1.6
lang: en
---

## Kubernetes Add-ons
---

Rancher automatically installs Kubernetes add-ons to help enhance the Kubernetes experience. If you would like to turn off installing the add-ons, you will need to [configure Kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#configuring-kubernetes) to disable the automatic installation of the add-ons.

* [Helm](#helm) - A Package Manager for Kubernetes
* [Dashboard](#dashboard) - A dashboard web interface for Kubernetes
* [SkyDNS](#skydns) - A DNS server for Kubernetes

### Helm

Helm is a tool that streamlines installing and managing Kubernetes applications. It helps you run applications on Kubernetes by packaging complex applications in to Charts. A Chart is a collection of files that describes Kubernetes resources, which may be used to deploy simple pods or complex applications (e.g. a full web stack with all of its components).

Helm consists of two parts, a server called Tiller and a client called Helm. Tiller is automatically started by Rancher and is launched in the **kube-system** namespace. The Helm client is installed in the embedded `kubectl` CLI.

#### Getting Started With Helm on Rancher

When installing Kubernetes on Rancher, you'll need to [configure your Kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#configuring-kubernetes) so that the add-ons enabled in order to have Helm automatically installed. After Kubernetes is installed, you can start using helm either directly [through the shell that Rancher provides in the UI](#using-helm-in-the-rancher-ui) or [configuring your workstation to use helm](#using-helm-on-a-workstation).

##### Using `helm` in the Rancher UI

Rancher provides shell access directly to a managed `kubectl` instance that can be used to manage Kubernetes clusters and applications. To start using this shell, navigate to **Kubernetes** -> **CLI**. This shell is automatically installed with a Helm client and commands for Helm can be used immediately.

![Kubectl]({{site.baseurl}}/one-point-x/img/kubernetes/kubectl.png)

##### Using `helm` on a Workstation

After installing Kubernetes on Rancher, you can configure `kubectl` on your workstation by generating a configuration under **Kubernetes** -> ** CLI**.  

In order to use Helm on your workstation, you will need to install it according to your needs. Please use the official [installation documentation for Helm](https://github.com/kubernetes/helm/blob/master/docs/install.md) to install Helm.

On your workstation, verify that you can communicate with Tiller using your installed Helm client:

```bash
$ helm init
$HELM_HOME has been configured at $HOME/.helm.
Warning: Tiller is already installed in the cluster. (Use --client-only to suppress this message.)
Happy Helming!

$ helm version
Client: &version.Version{SemVer:"v2.1.3", GitCommit:"5cbc48fb305ca4bf68c26eb8d2a7eb363227e973", GitTreeState:"clean"}
Server: &version.Version{SemVer:"v2.1.3", GitCommit:"5cbc48fb305ca4bf68c26eb8d2a7eb363227e973", GitTreeState:"clean"}
```

#### Upgrading Helm
Each Rancher release comes with a specific release of Helm based on the current state of the upstream Kubernetes add-ons repo, however you can upgrade the helm components at any time based on your requirements.

Helm has two versioned components, the client (helm) and the server (tiller). For best results it is recommended to run the same version of the client and server. Upgrading the client can be done by downloading a newer binary on your local system. The client can then be used to upgrade the server component to the matching version by running the following:

```
$ helm init --upgrade

Tiller (the helm server side component) has been upgraded to the current version.
Happy Helming!
```
**NOTE** The CLI built into the Rancher UI has its own copy of the `helm` client, so upgrading the server without upgrading this client may break functionality with the UI based CLI until Rancher releases an updated version. 

#### Using Helm

As with all package managers, before using helm, we should verify that the Charts are up-to-date.

```bash
> helm repo update

Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "stable" chart repository
Update Complete. â Happy Helming!â
```

Kubernetes has its own official Helm charts that can be used directly. We'll walk through an example of installing a Wordpress Chart on Kuberenetes.

> **Note:** As Charts are updated in Helm, our versions may not match with the latest ones. You should always install the latest versions.

First, we'll start by using `helm search` to find the available Charts.

```bash
> helm search
NAME                    VERSION DESCRIPTION
stable/drupal           0.3.4   One of the most versatile open source content m...
stable/jenkins          0.1.1   A Jenkins Helm chart for Kubernetes.
stable/mariadb          0.5.2   Chart for MariaDB
stable/mysql            0.1.1   Chart for MySQL
stable/redmine          0.3.3   A flexible project management web application.
stable/wordpress        0.3.1   Web publishing platform for building blogs and ...
```

You can immediately install the Chart directly from the Helm repository, but we are going to fetch the Wordpress Chart to examine the options available to deploy the chart.

```bash
$ helm fetch stable/wordpress
$ tar xzvf wordpress-*.tgz
$ cd wordpress
```
You can see the available options for the Wordpress Chart by examining the `values.yaml` file. This file includes all the variables that are used in the Chart. By opening the file in your favorite text editor, you can see there are multiple settings.

```bash
image: bitnami/wordpress:4.7-r0
imagePullPolicy: IfNotPresent
wordpressUsername: user
# wordpressPassword:
wordpressEmail: user@example.com
wordpressFirstName: FirstName
wordpressLastName: LastName
wordpressBlogName: User's Blog!
....
```

In the file in Wordpress, you will see that persistent storage is enabled by default. The default value is using a storage class to dynamically provision persistent volumes, which is called `default`. In order to get started with dynamically provisioned persistent storage in Kubernetes on Rancher, please read the docs on [how storage works in Rancher]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/storage).

If persistent storage is not required in your use case, then we can disable the persistent storage when installing the Chart.

```bash
$ helm install --name wordpress --set mariadb.persistence.enabled=false,persistence.enabled=false stable/wordpress
NAME:   wordpress
LAST DEPLOYED: Fri Apr 21 16:46:18 2017
NAMESPACE: default
STATUS: DEPLOYED

RESOURCES:
==> v1/Secret
NAME                TYPE      DATA      AGE
wordpress-mariadb   Opaque    2         2s
wordpress-wordpress   Opaque    2         2s

==> v1/ConfigMap
NAME                DATA      AGE
wordpress-mariadb   1         2s

==> v1/Service
NAME                  CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
wordpress-wordpress   10.43.218.155   <pending>     80:32247/TCP,443:31795/TCP   2s
wordpress-mariadb   10.43.57.189   <none>    3306/TCP   2s

==> extensions/Deployment
NAME                  DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
wordpress-wordpress   1         1         1            0           2s
wordpress-mariadb   1         1         1         0         2s


NOTES:
1. Get the WordPress URL:

  NOTE: It may take a few minutes for the LoadBalancer IP to be available.
        Watch the status with: 'kubectl get svc --namespace default -w wordpress-wordpress'

  export SERVICE_IP=$(kubectl get svc --namespace default wordpress-wordpress -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
  echo http://$SERVICE_IP/admin

2. Login with the following credentials to see your blog

  echo Username: user
  echo Password: $(kubectl get secret --namespace default wordpress-wordpress -o jsonpath="{.data.wordpress-password}" | base64 --decode)
```

You will notice a `NOTES` section that will help you get started with the installed Wordpress Chart. The notes include information about how to get the WordPress URL and how to login to the blog with the default credentials.

```bash
$ export SERVICE_IP=$(kubectl get svc --namespace default wordpress-wordpress -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
$ echo http://$SERVICE_IP/admin
http://x.x.x.x/admin

$ echo Username: user
$ echo Password: $(kubectl get secret --namespace default wordpress-wordpress -o jsonpath="{.data.wordpress-password}" | base64 --decode)
Username: user
Password: 58wYgIT06m
```

By accessing the URL displayed, you will be able to start using Wordpress on Kubernetes and log in with the provided credentials.

#### Using Persisent Storage With a Helm Chart

If you have set up [persistent storage in Rancher]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/storage), you will be able to create storage classes on Kubernetes. In the next example, we will use the same Wordpress Chart and choose to use persistent storage on AWS.

The following pre-requisites would need to be configured:

* Kubernetes is configured to use `aws` as the [cloud provider]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/providers/#aws).
* All [hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/) have been added into Rancher in AWS EC2 with the correct IAM policies.
* A [storage class]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/storage/#dynamic_provisioning) named `default` is installed and configured to use AWS volumes.

After Kubernetes is launched correctly and your storage class is created, you can deploy the Wordpress Chart to use your persistent storage.

```bash
$ helm install --name wordpress stable/wordpress
NAME:   wordpress
LAST DEPLOYED: Fri Apr 21 17:12:35 2017
NAMESPACE: default
STATUS: DEPLOYED

RESOURCES:
==> v1/Secret
NAME                TYPE      DATA      AGE
wordpress-mariadb   Opaque    2         2s
wordpress-wordpress   Opaque    2         2s

==> v1/ConfigMap
NAME                DATA      AGE
wordpress-mariadb   1         2s

==> v1/Service
NAME                CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
wordpress-mariadb   10.43.101.232   <none>        3306/TCP   2s
wordpress-wordpress   10.43.250.75   <pending>   80:30296/TCP,443:30094/TCP   2s

==> extensions/Deployment
NAME                  DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
wordpress-wordpress   1         1         1            0           2s
wordpress-mariadb   1         1         1         0         2s

==> v1/PersistentVolumeClaim
NAME                            STATUS    VOLUME                                     CAPACITY   ACCESSMODES   AGE
wordpress-wordpress-wordpress   Bound     pvc-f396de3d-26a4-11e7-9213-02ee7a4cff8e   8Gi        RWO           2s
wordpress-wordpress-apache   Bound     pvc-f3986989-26a4-11e7-9213-02ee7a4cff8e   1Gi       RWO       2s
wordpress-mariadb   Bound     pvc-f399feb7-26a4-11e7-9213-02ee7a4cff8e   8Gi       RWO       2s


NOTES:
1. Get the WordPress URL:

  NOTE: It may take a few minutes for the LoadBalancer IP to be available.
        Watch the status with: 'kubectl get svc --namespace default -w wordpress-wordpress'

  export SERVICE_IP=$(kubectl get svc --namespace default wordpress-wordpress -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
  echo http://$SERVICE_IP/admin

2. Login with the following credentials to see your blog

  echo Username: user
  echo Password: $(kubectl get secret --namespace default wordpress-wordpress -o jsonpath="{.data.wordpress-password}" | base64 --decode)
```

You can see that new resources from using persistent storage in the Chart have been created.

```bash
==> v1/PersistentVolumeClaim
NAME                            STATUS    VOLUME                                     CAPACITY   ACCESSMODES   AGE
wordpress-wordpress-wordpress   Bound     pvc-f396de3d-26a4-11e7-9213-02ee7a4cff8e   8Gi        RWO           2s
wordpress-wordpress-apache   Bound     pvc-f3986989-26a4-11e7-9213-02ee7a4cff8e   1Gi       RWO       2s
wordpress-mariadb   Bound     pvc-f399feb7-26a4-11e7-9213-02ee7a4cff8e   8Gi       RWO       2s
```

You can verify that the persistent volumes have been created.
```bash
$ kubectl get pv
NAME                                       CAPACITY   ACCESSMODES   RECLAIMPOLICY   STATUS    CLAIM                                        REASON    AGE
pvc-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   8Gi        RWO           Delete          Bound     default/wordpress-wordpress-wordpress                  4m
pvc-yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy   1Gi        RWO           Delete          Bound     default/wordpress-wordpress-apache                     4m
pvc-zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz   8Gi        RWO           Delete          Bound     default/wordpress-mariadb                              4m
```

In this example, we have selected AWS as the [cloud provider]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/providers/#aws), which will have created an ELB on AWS as a load balancer for your Wordpress Chart.

```bash
$ export SERVICE_IP=$(kubectl get svc --namespace default wordpress-wordpress -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
$ echo http://$SERVICE_IP/admin                                                                                         
http://xxxxxxxxxxxxxx.us-west-2.elb.amazonaws.com/admin
```

### SkyDNS

In Rancher, each service is given a name. Other services can communicate with a service using the DNS service name. The DNS service name is `<service_name>.<namespace_name>.svc.cluster.local`.

Using the wordpress application launched in the helm example, you can get the name and namespace of Wordpress endpoint services.

```
> kubectl get services

NAME                  CLUSTER-IP      EXTERNAL-IP        PORT(S)                      AGE
kubernetes            10.43.0.1       <none>             443/TCP                      22d
wordpress-mariadb     10.43.101.232   <none>             3306/TCP                     1h
wordpress-wordpress   10.43.250.75    xxxxxxxx...   80:30296/TCP,443:30094/TCP   1h

> kubectl describe services/wordpress-wordpress
Name:			wordpress-wordpress
Namespace:		default
Labels:			app=wordpress-wordpress
			      chart=wordpress-0.4.2
			      heritage=Tiller
			      release=wordpress
Selector:		app=wordpress-wordpress
Type:			LoadBalancer
IP:			10.43.250.75
LoadBalancer Ingress:	xxxxxxxxxxxxxxxxxxxx.elb.amazonaws.com
Port:			http	80/TCP
NodePort:		http	30296/TCP
Endpoints:		10.42.122.207:80
Port:			https	443/TCP
NodePort:		https	30094/TCP
Endpoints:		10.42.122.207:443
Session Affinity:	None
No events.
```

The wordpress application is named `wordpress`. For this instance, the DNS service name is `wordpress-wordpress.default.svc.cluster.local`.
