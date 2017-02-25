---
title: Kubernetes Persistent Storage Support in Rancher
layout: rancher-default-v1.5
version: v1.5
lang: en
---

## Persistent Storage in Kubernetes
---

Rancher can launch services with persistent storage through the native Kubernetes resources. In Kubernetes, [persistent storage](https://kubernetes.io/docs/user-guide/persistent-volumes/) is managed through the Kubernetes API resources, `PersistentVolume` and `PersistentVolumeClaim`. The storage components in Kubernetes support a variety of backends (e.g. NFS, EBS, etc.), which have separate life-cycles from pods. Depending on the type of persistent volumes that you are interested in using, you may need to [configure your Kubernetes environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/providers/).

We've outlined some examples of how to use [NFS](#persistent-volumes---nfs) and [EBS](#persistent-volumes---ebs) with Kubernetes in Rancher.

### Persistent Volumes - NFS

When using the NFS volume for Kubernetes, a file system (i.e. NFS) is mounted inside the pods. The filesystem allows multiple writes from different pods, which use the same persistent volume claim. Volumes can be shared between pods with the same data in each pod.

#### NFS Configuration

You will need to have a running NFS server running with shared exports. In our examples, we're assuming that the `/nfs` directory is exported.

#### Create Persistent Volumes (PV) and Persistent Volume Claims (PVC)

In your Kubernetes template, the `kind` would be `PersistentVolume` and you should use the `nfs` resource. The server will use the `<IP_OF_NFS_SERVER>` and exported directory (i.e. `/nfs` in our yaml).

Example  `pv-nfs.yml`

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
    server: <IP_OF_NFS_SERVER>
    # Exported path of your NFS server
    path: "/nfs"
```

Using `kubectl`, let's launch our persistent volume into Kubernetes. Remember, you can either [configure `kubectl` for your local machine]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#kubectl) or you can use the shell in the UI under **Kubernetes** -> **kubectl**.

```bash
$ kubectl create -f pv-nfs.yml
```

After the persistent volume is created, you can create the persistent volume claim, which claims the persistent volume that was just created.

Example `pvc-nfs.yml`

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

Using `kubectl`, let's launch our persistent volume into Kubernetes. Remember, you can either [configure `kubectl` for your local machine]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#kubectl) or you can use the shell in the UI under **Kubernetes** -> **kubectl**.

```bash
$ kubectl create -f pvc-nfs.yml
```

After creating both the persistent volume and persistent volume claim, you can confirm that the persistent volume is bound.

```bash
$ kubectl get pv,pvc

NAME      CAPACITY   ACCESSMODES   RECLAIMPOLICY   STATUS    CLAIM         REASON    AGE
pv/nfs    1Mi        RWX           Retain          Bound     default/nfs             8s

NAME      STATUS    VOLUME    CAPACITY   ACCESSMODES   AGE
pvc/nfs   Bound     nfs       1Mi        RWX           5s
```

#### Creating A Pod to Use the Persistent Volume Claim

Now that the persistent volume claim has been created, we can start creating pods that will use the persistent volume claim and the pods will have the same data.

Example `rc-nfs.yml`

```yaml
apiVersion: v1
kind: ReplicationController
metadata:
  name: rc-nfs-test
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

Using `kubectl`, let's create our replication controller and two pods into Kubernetes. The two pods will both use the `nfs` persistent volume, using the `nfs` persistent volume claim. It will mount inside the pod in `/usr/share/nginx/html`. Remember, you can either [configure `kubectl` for your local machine]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#kubectl) or you can use the shell in the UI under **Kubernetes** -> **kubectl**.


```bash
$ kubectl create -f rc-nfs-test.yml
service "nginx-service" created
replicationcontroller "nginx" created

$ kubectl get pods
NAME           READY     STATUS    RESTARTS   AGE
rc-nfs-test-42785   1/1       Running   0          10s
rc-nfs-test-rt3ld   1/1       Running   0          10s
```

Let's check that both pods are able to access the persistent volume and access any changes in the NFS server. We'll add a file into `/nfs` folder on the NFS server.

```bash
$ echo "NFS Works!" > /nfs/index.html
```

After adding the file onto the NFS server, we can check that the file is located on both pods as well.

```
$ kubectl exec rc-nfs-test-42785 cat /usr/share/nginx/html/index.html
NFS Works!
$ kubectl exec rc-nfs-test-rt3ld cat /usr/share/nginx/html/index.html
NFS Works!
```

### Persistent Volumes - EBS

In order to use EBS as a persistent volume in Kubernetes, you will need to configure Kubernetes with a couple of specific options.

1. Configure the Kubernetes environment with the [cloud provider option as AWS]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/providers/#aws).
2. Any [hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/) should be started in AWS EC2 with the correct IAM policies.

Using EBS volumes with Kubernetes as persistent volumes can be divided into two sections: [static provisioning](#static-provisioning), and [dynamic provisioning](#dynamic-provisioning) using storage classes.

#### Static provisioning

EBS volumes will need to be created in the same region and availability zone as the Rancher agents **before** using it in Kubernetes as a persistent volume. In order to start using the persistent volume, you will first need to create the persistent volume resource.

Example `pv-ebs.yml`

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: ebs
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Recycle
  awsElasticBlockStore:
    fsType: ext4
    # The EBS volume ID
    volumeID: <VOLUME_ID_IN_EBS>
```

Using `kubectl`, let's launch our persistent volume into Kubernetes. The `<VOLUME_ID_IN_EBS>` will need to be replaced with the EBS volume id. Remember, you can either [configure `kubectl` for your local machine]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#kubectl) or you can use the shell in the UI under **Kubernetes** -> **kubectl**.

```bash
$ kubectl create -f pv-ebs.yml
```

After the persistent volume is created, you can create the persistent volume claim, which claims the persistent volume that was just created.

Example `pvc-ebs.yml`

```yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: pvs-ebs
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


After creating both the persistent volume and persistent volume claim, you can confirm that the persistent volume is bound.

```bash
$ kubectl get pv,pvc
```

#### Creating A Pod to Use the Persistent Volume Claim

After the persistent volume claim is made, you just need to make a pod that uses it.

Example `pod-ebs.yml`

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
        name: ebs
  volumes:
    - name: ebs
      persistentVolumeClaim:
        claimName: pvc-ebs
```

The volume in AWS should turn from `available` to `in-use` after the pod uses it.


```bash
$ kubectl get pods,pv,pvc
NAME       READY     STATUS    RESTARTS   AGE
po/mypod   1/1       Running   0          3m

NAME      CAPACITY   ACCESSMODES   RECLAIMPOLICY   STATUS    CLAIM             REASON    AGE
pv/ebs    1Gi        RWO           Recycle         Bound     default/myclaim             3m

NAME          STATUS    VOLUME    CAPACITY   ACCESSMODES   AGE
pvc/pvc-ebs  Bound     pv1       1Gi        RWO           3m
```

#### Dynamic provisioning

An alternative approach in EBS is to use [dynamic provisioning](http://blog.kubernetes.io/2016/10/dynamic-provisioning-and-storage-in-kubernetes.html), which only uses the [StorageClass](https://kubernetes.io/docs/user-guide/persistent-volumes/#class-1) to automatically create and attach volumes to pods. In our example, the storage class will specify AWS as its storage provider and use type `gp2` and availability zone `us-west-2a`.


Example `storage-class.yml`

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

#### Creating Pods using Storage Classes

You can start using a storage class in any pod or claim to make Kubernetes automatically create new volumes and attach it to the pod.

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
