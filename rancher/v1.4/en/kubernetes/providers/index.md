---
title: Kubernetes Cloud Providers
layout: rancher-default-v1.4
version: v1.4
lang: en
---

## Kubernetes Providers
---

Currently you can choose between two cloud providers backend to be used to install Kubernetes on Rancher:

* [AWS](#aws)
* [Rancher](#rancher)


### Rancher

Using Rancher as the cloud provider will enable the user to use kubernetes with Rancher's resources, for example when using external LoadBalancer service, Kubernetes will create a load balancer container using the `rancher/lb-service-haproxy` image, this load balancer container will bounce the requests between the pods.

### AWS

Using AWS as cloud provider for Kubernetes will enable the user to use AWS resources like AWS Elastic Block Stores (EBS) as kuberntes volumes, and Elastic Load Balancers (ELB) as LoadBalancer service on kubernetes.

#### Installation

To use AWS as the cloud provider for Kubernetes on Rancher, you can choose `aws` from the drop down menu of Kubernetes stack configuration options:

![kubernetes-stack]({{site.baseurl}}/img/rancher/kubernetes_stack_1.png)

Make sure that all the agents registered with Rancher server are AWS EC2 instances, and have the right IAM role for the hosts to use EBS and ELB on AWS, as an example for the policy that can be used with IAM Role:

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
    },
  ]
}
```

#### EBS Volumes

Using EBS volumes with Kubernetes as persistent volumes can be divided into two sections: static provisioning, and dynamic provisioning using storage classes.

##### Static provisioning

In this type the EBS volume should be created in the same region and availability zone as the Rancher agents before using it inside kubernetes as persistent volume, to start using the created volume as PV, you should create the persistent volume resource, as an example for persistent volume resource:

persistentVolume.yaml
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv1
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Recycle
  awsElasticBlockStore:
    fsType: ext4
    volumeID: <volume-id>
```

persistentVolumeClaim.yaml
```yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: myclaim
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  selector:
    matchLabels:
      release: "stable"
```

And finally you can use this claim in a pod:
```yaml
apiVersion: v1
metadata:
  name: mypod
spec:
  containers:
    - name: myfrontend
      image: nginx
      volumeMounts:
      - mountPath: "/var/www/html"
        name: pv1
  volumes:
    - name: pv1
      persistentVolumeClaim:
        claimName: myclaim
```

You should replace the `<volume-id>` with the EBS volume id. After creating the previous resources you should be to see the status of the volume in AWS turned from `available` state to `in-use`, and you should be able to see the pod starting up correctly:

```bash
$ kubectl get pods,pv,pvc
NAME       READY     STATUS    RESTARTS   AGE
po/mypod   1/1       Running   0          3m

NAME      CAPACITY   ACCESSMODES   RECLAIMPOLICY   STATUS    CLAIM             REASON    AGE
pv/pv1    1Gi        RWO           Recycle         Bound     default/myclaim             3m

NAME          STATUS    VOLUME    CAPACITY   ACCESSMODES   AGE
pvc/myclaim   Bound     pv1       1Gi        RWO           3m
```

##### Dynamic provisioning

Unlike the previous approach, [dynamic provisioning](http://blog.kubernetes.io/2016/10/dynamic-provisioning-and-storage-in-kubernetes.html) only uses [StorageClass](https://kubernetes.io/docs/user-guide/persistent-volumes/#class-1) to automatically create and attach volumes to pods, first you should create the storage class resources that specify AWS as its provider:

```yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1beta1
metadata:
  name: standard
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp2
  zone: us-west-2a
```

The previous storage class will specify AWS as its storage provider and use type `gp2` and availability zone `us-west-2a`.

You can start using this storage class in any pod or claim to make Kubernetes automatically create new volume and attach it to the pod.

```json
{
  "kind": "PersistentVolumeClaim",
  "apiVersion": "v1",
  "metadata": {
    "name": "claim2",
    "annotations": {
      "volume.beta.kubernetes.io/storage-class": "standard"
    }
  },
  "spec": {
    "accessModes": [
      "ReadWriteOnce"
    ],
    "resources": {
      "requests": {
        "storage": "1Gi"
      }
    }
  }
}
```

After using this claim with a pod resource, you should be able to see a new pv is created and bounded to the claim automatically:

```bash
$ kubectl get pv,pvc,pods
NAME                                          CAPACITY   ACCESSMODES   RECLAIMPOLICY   STATUS    CLAIM             REASON    AGE
pv/pvc-36fcf5dd-f476-11e6-b547-0275ac92095a   1Gi        RWO           Delete          Bound     default/claim2              1m

NAME          STATUS    VOLUME                                     CAPACITY   ACCESSMODES   AGE
pvc/claim2    Bound     pvc-36fcf5dd-f476-11e6-b547-0275ac92095a   1Gi        RWO           1m

NAME       READY     STATUS    RESTARTS   AGE
po/nginx   1/1       Running   0          29s
```


#### ELB As Kubernetes Service

To use ELB as external LoadBalancer service in kubernetes, you should have the right IAM policy on ELB as described above, then create the service directly with type `LoadBalancer`:

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

After creating the previous resource, you should be able to see the AWS ELB created:
```bash
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
