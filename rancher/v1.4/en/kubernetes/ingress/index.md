---
title: Kubernetes Ingress Support in Rancher
layout: rancher-default-v1.4
version: v1.4
lang: en
redirect_from:
  - /rancher/v1.4/zh/kubernetes/ingress/
---

## Ingress Support
---

Before being able to start using [Kubernetes Ingress resources](http://kubernetes.io/docs/user-guide/ingress/), you'll need to have an [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/) that has an orchestation type as  Kubernetes. We also recommend [setting up `kubectl` on your local machine]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#kubectl) to make it easier to launch Kubernetes resources into Rancher. Alternatively, you can use the shell provided by the Rancher UI to launch resources.

The Kubernetes Ingress resource can be backed up by any load balancer of your choice, so to leverage the Rancher's load balancing functionality, we have introduced the concept of a Rancher ingress controller. The ingress controller is created as part of ingress-controller service, which gets deployed as part of the system stack for Kubernetes.

The ingress controller manages the creation/removal/update of Rancher load balancers. Each load balancer is created/removed/updated based on the Kubernetes ingress resources. If an ingress is updated or service endpoints are changed, the ingress controller will update the corresponding Rancher load balancer to the changes in the ingress. Similarly, if the ingress is removed, the Rancher load balancer will be removed as well. If the backend services of an ingress has changes (e.g. when a replication controller is scaled up or down or a pod gets recreated), the Rancher load balancer will be updated accordingly. The ingress controller ensures that the Rancher load balancer matches the ingress and backend services in Kubernetes.

### Current Limitations

* Ingress resources can only be added through `kubectl`
* If you are [upgrading]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/upgrading/) to `v1.1.0`from a previous version, any existing Kubernetes environments will not be able to take advantage of the ingress support unless you de-activate/activate the environment. Currently, there is no upgrade support for kubernetes environments, so this deactivation/reactivation will permit ingress support to be activated.

### Rancher Ingress Controller

The Rancher ingress controller will leverage the existing load balancing functionality within Rancher and convert what is in Kubernetes ingress to a load balancer in Rancher.

The ingress controller will:

* Listen to Kubernetes server events
* Deploy a load balancer and program it with the routing rules defined in Ingress
* Configure the Ingress `Address` field with the Public Endpoint of your Load Balancer

### Creating Ingress resources in Rancher

#### Setting up an Example Nginx Service

Before setting up any ingress, services will need to be created in Kubernetes. We'll start by adding a service and replication controller into our Kubernetes environment.

Here's a simple nginx service to add into Kubernetes.

Example `nginx-service.yml`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
  labels:
    k8s-app: nginx-service
spec:
  ports:
  - port: 90
    targetPort: 80
    protocol: TCP
    name: http
  selector:
    k8s-app: nginx-service
---
apiVersion: v1
kind: ReplicationController
metadata:
  name: nginx-service
spec:
  replicas: 1
  selector:
    k8s-app: nginx-service
  template:
    metadata:
      labels:
        k8s-app: nginx-service
    spec:
      terminationGracePeriodSeconds: 60
      containers:
      - name: nginx-service
        image: nginx:latest
        ports:
        - containerPort: 80
```

Using `kubectl`, let's launch our nginx service into Kubernetes. Remember, you can either [configure `kubectl` for your local machine]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#kubectl) or you can use the shell in the UI under **Kubernetes** -> **kubectl**.

```bash
$ kubectl create -f nginx-service.yml
service "nginx-service" created
replicationcontroller "nginx-service" created
```

#### Setting up a Simple Ingress Resource

You can set up a simple ingress resource for the single service.

Example `simple-ingress.yml`

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: simplelb
spec:
  backend:
    serviceName: nginx-service
    servicePort: 90
```

Let's create the ingress using `kubectl`. After you create the ingress, the ingress controller will trigger a load balancer service to be created and visible in the **kubernetes-ingress-lbs** stack within the **Kubernetes** -> **System** tab. By default, the load balancer service will only have 1 instance of the load balancer deployed. From `kubectl`, you can see the ingress created, but the UI will only show the load balancer. The ingress controller has already done all the translations of the requests in the ingress to a Rancher load balancer.  

```bash
$ kubectl create -f simple-ingress.yml
ingress "simplelb" created
$ kubectl get ingress
NAME          RULE      BACKEND            ADDRESS          AGE
simplelb      -         nginx-service:80   1.2.3.4          5m
```

The `address` in the ingress will be the public endpoint of where the load balancer service was launched. If the load balancer is moved to a different host and gets a different public endpoint, the ingress `address` will be updated.

To access your application, you can hit the address at our default port `80` (i.e. `http://1.2.3.4:80`) or the address directly (i.e. `http://1.2.3.4`).

#### Setting up Multiple Services

If you want the ingress to act as an entry point for more than one service, then it will need to be configured with  host name routing rules, which allows adding host/path based routing to services.

Let's start by adding multiple services into Kubernetes.

Example `multiple-nginx-services.yml`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service-1
  labels:
    k8s-app: nginx-service-1
spec:
  ports:
  - port: 90
    targetPort: 80
    protocol: TCP
    name: http
  selector:
    k8s-app: nginx-service-1
---
apiVersion: v1
kind: ReplicationController
metadata:
  name: nginx-service-1
spec:
  replicas: 1
  selector:
    k8s-app: nginx-service-1
  template:
    metadata:
      labels:
        k8s-app: nginx-service-1
    spec:
      terminationGracePeriodSeconds: 60
      containers:
      - name: nginx-service-1
        image: nginx:latest
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-service-2
  labels:
    k8s-app: nginx-service-2
spec:
  ports:
  - port: 90
    targetPort: 80
    protocol: TCP
    name: http
  selector:
    k8s-app: nginx-service-2
---
apiVersion: v1
kind: ReplicationController
metadata:
  name: nginx-service-2
spec:
  replicas: 1
  selector:
    k8s-app: nginx-service-2
  template:
    metadata:
      labels:
        k8s-app: nginx-service-2
    spec:
      terminationGracePeriodSeconds: 60
      containers:
      - name: nginx-service-2
        image: nginx:latest
        ports:
        - containerPort: 80
```

Using `kubectl`, let's launch our services and replication controllers into Kubernetes. Remember, you can either [configure `kubectl` for your local machine]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#kubectl) or you can use the shell in the UI under **Kubernetes** -> **kubectl**.

```bash
$ kubectl create -f multiple-nginx-services.yml
service "nginx-service-1" created
replicationcontroller "nginx-service-1" created
service "nginx-service-2" created
replicationcontroller "nginx-service-2" created
```

#### Setting up a Ingress Resource with Host Based Routing

Example `host-based-ingress.yml`

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: host-based-ingress
spec:
  rules:
  - host: foo.bar.com
    http:
      paths:
      - backend:
          serviceName: nginx-service-1
          servicePort: 90
  - host: bar.foo.com
    http:
      paths:
      - backend:
          serviceName: nginx-service-2
          servicePort: 90
```

Let's create the ingress using `kubectl`. After you create the ingress, the ingress controller will trigger a load balancer service to be created and visible in the **kubernetes-ingress-lbs** stack within the **Kubernetes** -> **System** tab. By default, the load balancer service will only have 1 instance of the load balancer deployed. The load balancer will have the host name routing rules created from the ingress.

From `kubectl`, you can see the ingress created, but the UI will only show the load balancer. The ingress controller has already done all the translations of the requests in the ingress to a Rancher load balancer.  


```bash
$ kubectl create -f host-based-ingress.yml
ingress "host-based-ingress" created
$ kubectl get ingress
NAME                    RULE            BACKEND             ADDRESS     AGE
host-based-ingress      -                                   1.2.3.4     20m
                        foo.bar.com    
                                        nginx-service-1:80
                        foo1.bar.com   
                                        nginx-service-2:80
```

Similar to the simple ingress load balancer, this load balancer will be in the **kubernetes-ingress-lbs** stack within the **Kubernetes** -> **System** tab.

The `address` in the ingress will be the public endpoint of where the load balancer service was launched. If the load balancer is moved to a different host and gets a different public endpoint, the ingress `address` will be updated.

To access your application, you can hit the address at our default port `80` (i.e. `http://1.2.3.4:80`) or the address directly (i.e. `http://1.2.3.4`).


#### Setting up a Ingress Resource with Path Based Routing

If we have multiple services that you want load balanced, then you could add path based routing to your ingress.

Example `path-based-ingress.yml`

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: path-based-ingress
spec:
  rules:
  - host: foo.bar.com
    http:
      paths:
      - path: /foo
        backend:
          serviceName: nginx-service-1
          servicePort: 90
      - path: /bar
        backend:
          serviceName: nginx-service-2
          servicePort: 90
```

Let's create the ingress using `kubectl`. After you create the ingress, the ingress controller will trigger a load balancer to be created and visible in the **kubernetes-ingress-lbs** stack within the **Kubernetes** -> **System** tab. By default, the load balancer service will only have 1 instance of the load balancer deployed. The load balancer will have the host name routing rules created from the ingress.

From `kubectl`, you can see the ingress created, but the UI will only show the load balancer. The ingress controller has already done all the translations of the requests in the ingress to a Rancher load balancer.  


```bash
$ kubectl create -f path-based-ingress.yml
ingress "path-based-ingress" created
$ kubectl get ingress
NAME                    RULE            BACKEND             ADDRESS            AGE
path-based-ingress      -                                   1.2.3.4             15s
                        foo.bar.com    
                        /foo            nginx-service1:80
                        /bar            nginx-service2:80
```

Similar to the simple ingress load balancer, this load balancer will be in the **kubernetes-ingress-lbs** stack within the **Kubernetes** -> **System** tab.

The `address` in the ingress will be the public endpoint of where the load balancer service was launched. If the load balancer is moved to a different host and gets a different public endpoint, the ingress `address` will be updated.

To access your application, you can hit the address at our default port `80` (i.e. `http://1.2.3.4:80`) or the address directly (i.e. `http://1.2.3.4`).

### Load Balancer Options with Kubernetes Ingress

By default, a Kubernetes ingress will deploy 1 load balancer on only 1 host using http/https on default ports `80`/`443`. Rancher has added the ability to support multiple load balancers using the port of your choice. By scaling the ingress, the address programmed in Kubernetes will also reflect all the hosts that have the load balancer available.

> **Note:** If you choose to increase the scale of your ingress, you will need to ensure that there are at least the equivalent number of hosts available in your Kubernetes environment that have the port available.

#### Setting up a Simple Service

Before setting up any ingress, services will need to be created in Kubernetes. We'll start by adding a service and replication controller into our Kubernetes environment.

Here's a simple nginx service to add into Kubernetes.

Example `nginx-service.yml`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
  labels:
    k8s-app: nginx-service
spec:
  ports:
  - port: 90
    targetPort: 80
    protocol: TCP
    name: http
  selector:
    k8s-app: nginx-service
---
apiVersion: v1
kind: ReplicationController
metadata:
  name: nginx-service
spec:
  replicas: 1
  selector:
    k8s-app: nginx-service
  template:
    metadata:
      labels:
        k8s-app: nginx-service
    spec:
      terminationGracePeriodSeconds: 60
      containers:
      - name: nginx-service
        image: nginx:latest
        ports:
        - containerPort: 80
```

Using `kubectl`, let's launch our nginx service into Kubernetes. Remember, you can either [configure `kubectl` for your local machine]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#kubectl) or you can use the shell in the UI under **Kubernetes** -> **kubectl**.

```bash
$ kubectl create -f nginx-service.yml
service "nginx-service" created
replicationcontroller "nginx-service" created
```

#### Example of 2 Load Balancers using an Alternative Port

You can set up a ingress that is launched using 2 load balancers on 2 different hosts that uses a port, `99`, instead of the default ingress port `80`. For this ingress to work correctly, your kubernetes environment will need at least 2 hosts that have port `99` available.

Example `scaled-ingress.yml`

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: scaledlb
  annotations:
    scale: "2"
    http.port: "99"
spec:
  backend:
    serviceName: nginx-service
    servicePort: 90
```

Let's create the ingress using `kubectl`. After you create the ingress, the ingress controller will trigger the load balancer service to be created and visible in the **kubernetes-ingress-lbs** stack within the **Kubernetes** -> **System** tab. Since the `scale` is set to `2` in the ingress, the load balancer service will have 2 instances of the load balancer deployed.

From `kubectl`, you can see the ingress created, but the UI will only show the load balancer. The ingress controller has already done all the translations of the requests in the ingress to a Rancher load balancer. Since there are 2 load balancers, there will be 2 addresses set in the ingress.


```bash
$ kubectl create -f scaled-ingress.yml
ingress "host-based-ingress" created
$ kubectl get ingress
NAME       RULE      BACKEND            ADDRESS             AGE
simplelb   -         nginx-service:90   1.2.3.4,5.6.7.8     41s
```

#### Example using TLS

If you want to use TLS with Kubernetes, you'll need to [add the certifcate]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/certificates/) into Rancher. The certificate added into Rancher can be used to secure an ingress for TLS termination.

Let's say we added a certificate called `foo`.

Example `tls-ingress.yml` using the `foo` certificate

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: tlslb
  annotations:
    https.port: "444"
spec:
  tls:
   - secretName: foo
  backend:
    serviceName: nginx-service
    servicePort: 90
```

Let's create the ingress using `kubectl`. After you create the ingress, the ingress controller will trigger the load balancer service to be created and visible in the **kubernetes-ingress-lbs** stack within the **Kubernetes** -> **System** tab. By default, the load balancer service will only have 1 instance of the load balancer deployed.

From `kubectl`, you can see the ingress created, but the UI will only show the load balancer. The ingress controller has already done all the translations of the requests in the ingress to a Rancher load balancer.

##### Blocking HTTP

By default, port `80` is accessible even if a TLS is being used. In order to block port `80`, you can add in additional annotation `allow.http: "false"` as part of the ingress template.

Example `tls-ingress.yml` and blocking port `80`

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: tlslb
  annotations:
    https.port: "444"
    # Added to block HTTP
    allow.http: "false"
spec:
  tls:
   - secretName: foo
  backend:
    serviceName: nginx-service
    servicePort: 90
```

#### Example customization

In Rancher, our load balancers run HAProxy software. If you want to customize the `global` and `defaults` sections of the load balancer, they can be configured through ingress annotations.

Example `custom-ingress.yml`

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: customlb
  annotations:
    config: "defaults\nbalance source\ntimeout server 70000\nglobal\nmaxconnrate 60"
spec:
  backend:
    serviceName: nginx-service
    servicePort: 80
```

In our configuration, the `defaults` and `global` keywords identify the customizable sections and should be followed by a new line. Every parameter in these sections should be followed by a new line.
