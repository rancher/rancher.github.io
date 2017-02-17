---
title: Kubernetes Persistent Storage Support in Rancher
layout: rancher-default-v1.4
version: v1.4
lang: en
---

## Persistent Storage
---

Persistent Storage in Kubernetes is managed through API resources: `PersistentVolume` and `PersistentVolumeClaim`. Persistent Volumes is a network storage component in the Kubernets cluster that may support many backends and has a separate life-cycle from the pod, PV plugins support many solutions like EBS, NFS, etc.

In this document, we are going to explore how to set up Persistent Storage resources on Kubernetes environment on Rancher using NFS persistent storage, please refer to [Kubernetes documentation](https://kubernetes.io/docs/user-guide/persistent-volumes/) for more information about Persistent volumes.


### NFS Persistent Volumes

NFS volume allows a (NFS) file system to be mounted inside the pods, it allows multiple writes from different pods, this means that the volume can be shared between pods using the same persistent volume claim.

To get started with NFS, you should have an existing NFS server running with shared exports, this document will assume that you have server running NFS and exporting `/nfs` directory.

#### Create PV and PVC

First to create the Persistent volume, you should use the `nfs` resourse in the Persistent volume spec, an example for NFS pv will be something like this:

`nfs-pv.yml`
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nfs
spec:
  capacity:
    storage: 1Mi
  accessModes:
    - ReadWriteMany
  nfs:
    server: <ip-of-nfs-server>
    path: "/nfs"
```

The previous example will try to create a persistent volume using the NFS server ``<ip-of-nfs-server>` and using `/nfs` directory.

Afterwards you can create the persistent volume claim to be able to claim the persistent volume we just created:

`nfs-pvc.yml`
```yaml
apiVersion: v1
metadata:
  name: nfs
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 1Mi
```

You should be able to see both resources created and persistent volume claim is in bounded state:

```bash
$ kubectl create -f nfs-pv.yml
$ kubectl create -f nfs-pvc.yml
$ kubectl get pv,pvc

NAME      CAPACITY   ACCESSMODES   RECLAIMPOLICY   STATUS    CLAIM         REASON    AGE
pv/nfs    1Mi        RWX           Retain          Bound     default/nfs             8s

NAME      STATUS    VOLUME    CAPACITY   ACCESSMODES   AGE
pvc/nfs   Bound     nfs       1Mi        RWX           5s
```

#### Creating A Pod

In this example, we are going to create a nginx replication controllers with two pods and the same persistent volume claim, both pods should see the same data.

`nfs-rc.yml`
```yaml
apiVersion: v1
kind: ReplicationController
metadata:
  name: nfs-rc
spec:
  replicas: 2
  selector:
    app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
          - name: nginx
            containerPort: 80
        volumeMounts:
            - name: nfs
              mountPath: "/usr/share/nginx/html"
      volumes:
      - name: nfs
        persistentVolumeClaim:
          claimName: nfs
```

The replication controller will create two pods both use the nfs pv, using the nfs claim, and mount it inside the pod in `/usr/share/nginx/html`

```bash
$ kubectl get pods
NAME           READY     STATUS    RESTARTS   AGE
nfs-rc-42785   1/1       Running   0          10s
nfs-rc-rt3ld   1/1       Running   0          10s
```

To make sure both are seeing mounting and seeing the same PV, you can add a file into /nfs on the NFS server:

```
$ echo "NFS Works!" > /nfs/index.html
```

Then we can check the data on both pods:
```
$ kubectl exec nfs-rc-42785 cat /usr/share/nginx/html/index.html
NFS Works!
$ kubectl exec nfs-rc-rt3ld cat /usr/share/nginx/html/index.html
NFS Works!
```


### EBS Persistent Volumes

To use EBS as a persistent volume inside a kubernetes cluster, you should start the kubernetes cluster with the cloud provider option AWS and set the right IAM policies on the AWS EC2 agents, for more information about AWS cloud providers and using AWS resources like EBS and ELB please refer to [Cloud Providers](({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/providers/aws) documentation.
