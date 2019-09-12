---
title: Kubernetes Cloud Providers
layout: rancher-default-v1.6
version: v1.6
lang: en
---

## Kubernetes - Cloud Providers
---

In Kubernetes, there is a concept of [cloud providers](https://kubernetes.io/docs/getting-started-guides/scratch/#cloud-provider), which is a module which provides an interface for managing load balancers, nodes (i.e. hosts) and networking routes.

As of Rancher v1.6.11+, Rancher supports three cloud providers when [configuring Kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#configuring-kubernetes). You can select which cloud provider to use.

### Rancher

  * **Nodes:** Supports any [hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/) that can be added in Rancher.
  * **Load Balancers:** Launches Rancher's load balancer, which uses HAproxy and the `rancher/lb-service-haproxy` image, as a Load Balancer service. By default, the load balancer will round robin traffic to the pods.

By default, the orchestration for Kubernetes is set to `rancher`.

### AWS

  * **Nodes:** Supports only AWS hosts added as a [custom host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/).
  * **Load Balancers:** Launches an AWS Elastic Load Balancer (ELB) as a Load Balancer service. You can still create Rancher load balancers by using an [ingress]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/ingress/).
  * **Persistent Volumes**: Ability to use AWS Elastic Block Stores (EBS) for [persistent volumes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/storage/).

#### Configuring the ClusterID

> **Note:** Tagging your cluster resources with a `ClusterID` is required when using **Kubernetes 1.10** and higher. In previous versions it is recommended to tag resources with a `ClusterID`, but will not generate an error.

The following resources need to tagged with a `ClusterID`:

  * **Nodes:** All hosts added in Rancher.
  * **Subnet:** The subnet used for your cluster
  * **Security Group**: The security group used for your cluster.

> **Note:** Do not tag multiple security groups, as this will generate an error when creating Elastic Load Balancer (ELB).

The tag that should be used is: `kubernetes.io/cluster/CLUSTERID=owned` where `CLUSTERID` can be chosen as you like, as long as it's equal across all tags set. Setting the value of the tag to `owned`, tells the cluster that all resources with this tag are owned and managed by this cluster. If you share resources between clusters, you can change the tag to `kubernetes.io/cluster/CLUSTERID=shared`.

#### Adding Hosts

After Kubernetes has been configured to run with an `aws` cloud provider, any hosts added into the environment will need to be an AWS EC2 instance and have at least the following IAM policy:

```json
{
  "Effect": "Allow",
  "Action": "ec2:Describe*",
  "Resource": "*"
}
```

In order to use Elastic Load Balancers (ELBs) and EBS with Kubernetes, the host will need to have the an IAM role with appropriate access.

##### Example Policy for IAM Role:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:Describe*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "ec2:AttachVolume",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "ec2:DetachVolume",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": ["ec2:*"],
      "Resource": ["*"]
    },
    {
      "Effect": "Allow",
      "Action": ["elasticloadbalancing:*"],
      "Resource": ["*"]
    }
  ]
}
```

#### Elastic Load Balancer (ELB) as a Kubernetes service

After [configuring Kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#configuring-kubernetes) to use `aws` as a cloud provider and ensuring the host has the appropriate IAM policy for ELB, you can start creating load balancers.  

##### Example `lb.yml`

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-lb
  labels:
    app: nginx
spec:
  type: LoadBalancer
  selector:
    app: nginx
  ports:
  - name: http
    port: 80
    protocol: TCP
```

Using `kubectl`, let's launch our load balancer service into Kubernetes. Remember, you can either [configure `kubectl` for your local machine]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#kubectl) or you can use the shell in the UI under **Kubernetes** -> **kubectl**.

```bash
$ kubectl create -f lb.yml
service "nginx-lb" created
$ kubectl describe services nginx-lb
Name:			nginx-lb
Namespace:		default
Labels:			app=nginx
Selector:		name=nginx
Type:			LoadBalancer
IP:			10.43.137.5
LoadBalancer Ingress:	a4c7d4290f48011e690470275ac52fef-1158549671.us-west-2.elb.amazonaws.com
Port:			http	80/TCP
NodePort:		http	32166/TCP
Endpoints:		<none>
Session Affinity:	None
Events:
  FirstSeen	LastSeen	Count	From			SubObjectPath	Type		Reason			Message
  ---------	--------	-----	----			-------------	--------	------			-------
  17s		17s		1	{service-controller }			Normal		CreatingLoadBalancer	Creating load balancer
  14s		14s		1	{service-controller }			Normal		CreatedLoadBalancer	Created load balancer
```

#### Using EBS Volumes

After configuring Kubernetes to use `aws` as a cloud provider and ensuring the host has the appropriate IAM policy for EBS, you can start [using EBS volumes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/storage/#persistent-volumes---ebs).

### Azure

* **Nodes:** Supports both Azure hosts added as [custom hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/) or added using the UI for [Azure Hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/azure/)
* **Load Balancers:** Launches an Azure Load Balancer within a specific Network Security Group.
* **Persistent Volumes:** Supports using Azure Blob disks and Azure Managed Disks with standard and premium storage accounts.
* **Network Storage:** Support Azure Files via CIFS mounts.

#### Known Limitations Regarding Azure Subscriptions

* Kubernetes Azure Cloud Provider does not support single tenant accounts (e.g. accounts with no subscriptions)
* Currently, Rancher doesn't support multi-subscription accounts

#### Configuration

To start Kubernetes using the Azure Cloud Provider, you need to follow these steps:

* Configure the infrastructure template to use the `azure` cloud provider.
* Complete the configuration by providing the following items:
  * Azure Cloud Environment
  * Azure Tenant ID
  * Azure Client ID
  * Azure Client Secret
  * Azure Network Security Group

###### Azure Cloud Environment

Select one of the available Azure Cloud Environments.

###### Azure Tenant ID

In your Azure Portal, go to `Azure Active Directory` and select `properties`. Your `Directory ID` is your `Tenant ID`.

Also, you can run the command `az account show` in your Azure Shell to get the same information.

###### Azure Client ID and Azure Client Secret

Both values can be generated by following the procedure to create an Azure App Registration described [here](https://rancher.com/docs/rancher/latest/en/hosts/azure/#app-registration).

###### Azure Network Security Group

Custom Azure Network Security Group needed to allow Azure Load Balancers to work. If you provision hosts using Rancher Machine Azure driver, you will need to edit them manually to assign them to this Network Security Group. You should already assign custom hosts to this Network Security Group during provisioning.

Only hosts expected to be Load Balancer backends need to be in this group.

#### Creating an Azure Load Balancer

First, run a simple `nginx` deployment:

```
$ kubectl run my-nginx --image=nginx --replicas=2 --port=80
deployment "my-nginx" created
```

Next, let's expose our deployment with a Load Balancer:

```
$ kubectl expose deployment my-nginx --port=80 --type=LoadBalancer
service "my-nginx" exposed
```

It may take a minute or two for the Load Balancer to be created:

```
$ kubectl get all
NAME              DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
deploy/my-nginx   2         2         2            2           1m

NAME                    DESIRED   CURRENT   READY     AGE
rs/my-nginx-5d69b5ff7   2         2         2         1m

NAME              DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
deploy/my-nginx   2         2         2            2           1m

NAME                    DESIRED   CURRENT   READY     AGE
rs/my-nginx-5d69b5ff7   2         2         2         1m

NAME                           READY     STATUS    RESTARTS   AGE
po/my-nginx-5d69b5ff7-n4kpv    1/1       Running   0          1m
po/my-nginx-5d69b5ff7-wzs4j    1/1       Running   0          1m

NAME             TYPE           CLUSTER-IP     EXTERNAL-IP    PORT(S)        AGE
svc/kubernetes   ClusterIP      10.43.0.1      <none>         443/TCP        8m
svc/my-nginx     LoadBalancer   10.43.46.216   1.2.3.4        80:31131/TCP   1m

$ kubectl describe svc/my-nginx
Name:                     my-nginx
Namespace:                default
Labels:                   run=my-nginx
Annotations:              <none>
Selector:                 run=my-nginx
Type:                     LoadBalancer
IP:                       10.43.46.216
LoadBalancer Ingress:     1.2.3.4
Port:                     <unset>  80/TCP
TargetPort:               80/TCP
NodePort:                 <unset>  31131/TCP
Endpoints:                10.42.176.106:80,10.42.245.193:80
Session Affinity:         None
External Traffic Policy:  Cluster
Events:
  Type    Reason                Age   From                Message
  ----    ------                ----  ----                -------
  Normal  EnsuringLoadBalancer  5m    service-controller  Ensuring load balancer
  Normal  EnsuredLoadBalancer   4m    service-controller  Ensured load balancer
```

#### Creating an Azure Blob Disk

Based on [Kubernetes examples](https://github.com/kubernetes/examples/tree/master/staging/volumes/azure_disk/claim/blob-based-disk/dedicated-hdd). First, we create a `storageclass`:

```yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1beta1
metadata:
  name: dedicatedhdd
provisioner: kubernetes.io/azure-disk
parameters:
  skuname: Standard_LRS
```

```
$ kubectl create -f storageclass-dedicated-hdd.yaml
storageclass "dedicatedhdd" created
```

Next, a Persistent Volume Claim `pvc`:

```yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: pv-dd-dedicated-hdd-5g
  annotations:
    volume.beta.kubernetes.io/storage-class: dedicatedhdd
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
```

```
$ kubectl create -f pvc-on-dedicated-hdd.yaml
persistentvolumeclaim "pv-dd-dedicated-hdd-5g" created
```

It can take a minute or two for the `pvc` to be in `Bound` state:

```
$ kubectl get pvc,storageclass
NAME                         STATUS    VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc/pv-dd-dedicated-hdd-5g   Bound     pvc-fa2a05fc-b2bd-11e7-a78c-026ae539e127   5Gi        RWO            dedicatedhdd   34m

NAME                          PROVISIONER
storageclasses/dedicatedhdd   kubernetes.io/azure-disk
```

Finally, a simple `pod` to mount and write to this volume:

```yaml
kind: Pod
apiVersion: v1
metadata:
  name: pod-uses-dedicated-hdd-5g
  labels:
    name: storage
spec:
  containers:
  - image: nginx
    name: az-c-01
    command:
    - /bin/sh
    - -c
    - while true; do echo $(date) >> /mnt/blobdisk/outfile; sleep 1; done
    volumeMounts:
    - name: blobdisk01
      mountPath: /mnt/blobdisk
  volumes:
  - name: blobdisk01
    persistentVolumeClaim:
      claimName: pv-dd-dedicated-hdd-5g
```

```
$ kubectl create -f pod-uses-dedicated-hdd.yaml
pod "pod-uses-dedicated-hdd-5g" created
```

#### Using an Azure Files network share

First, you need an Azure storage account to create an Azure Files share as described [here](https://docs.microsoft.com/en-us/azure/storage/files/storage-how-to-create-file-share). You will also need your Storage Account access key.

Next, we will create a `secret` that contains the base64-encoded Storage Account name and key.

```
$ echo -n 'test-storage-account' | base64
dGVzdC1zdG9yYWdlLWFjY291bnQ=
$ echo -n 'PN5oyspxbJlw4jfmHENHkEOHntAxkbIhwEnA3TM1yrVWwC8ytDPK3mXHnGiW01==' | base64
UE41b3lzcHhiSmx3NGpmbUhFTkhrRU9IbnRBeGtiSWh3RW5BM1RNMXlyVld3Qzh5dERQSzNtWEhuR2lXMDE9PQ==
```

Be careful not to encode an extra new line in the account name or the key value. This is why the `-n` is used.

```yaml
# azure-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: azure-secret
type: Opaque
data:
  azurestorageaccountname: dGVzdC1zdG9yYWdlLWFjY291bnQ=
  azurestorageaccountkey: UE41b3lzcHhiSmx3NGpmbUhFTkhrRU9IbnRBeGtiSWh3RW5BM1RNMXlyVld3Qzh5dERQSzNtWEhuR2lXMDE9PQ==
```

```
$ kubectl create -f azure-secret.yaml
secret "azure-secret" created
```

Finally, we create a `pod` that will use the secret to access the file share we created:

```yaml
# pod.yaml
apiVersion: v1
kind: Pod
metadata:
 name: azure
spec:
 containers:
  - image: nginx
    name: nginx-share
    volumeMounts:
      - name: azure
        mountPath: /mnt/azure
 volumes:
      - name: azure
        azureFile:
          secretName: azure-secret
          shareName: k8stestshare
          readOnly: false
```
