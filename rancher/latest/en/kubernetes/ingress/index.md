---
title: Kubernetes Ingress in Rancher
layout: rancher-default
version: latest
lang: en
redirect_from:
  - rancher/kubernetes/ingress/
---

## Kubernetes Ingress
---

_Available as of v1.1.0-dev2_

Before being able to start using [Kubernetes Ingress resources](http://kubernetes.io/docs/user-guide/ingress/), you'll first need to have an [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/environments/) that has specified the cluster management to be Kubernetes. We also recommend [setting up `kubectl` on your local machine]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#kubectl) to make it easier to launch Kubernetes resources into Rancher. Alternatively, you can use the shell provided by the Rancher UI to launch resources. 

The Kubernetes Ingress resource can be backed up by any load balancer of your choice, so to leverage the Rancher's load balancing functionality, we have introduced the concept of a Rancher ingress controller. The ingress controller is part of the system stack for Kubernetes and manages the creation/removal/update of Rancher load balancers. Each load balancer is created/removed/updated based on the Kubernetes ingress resources.

### Current Limitations 

* Ingress resources can only be added through `kubectl` 
* For every ingress, there must be 1 Host in the Kubernetes environment with port `80` available. Currently, the load balancer is automatically defaulted to port `80`.
* If you are [upgrading]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/upgrading/) to `v1.1.0-dev2`from a previous version, any existing Kubernetes environments will not be able to take advantage of the ingress support unless you de-activate/activate the environment. Currently, there is no upgrade support for kubernetes environments, so this deactivation/reactivation will permit ingress support to be activated.

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

Let's create the ingress using `kubectl`. After you create the ingress, the ingress controller will trigger a load balancer to be created and visible in the **kubernetes-ingress-lbs** stack within the **Kubernetes** -> **System** tab. From `kubectl`, you can see the ingress created, but the UI will only show the load balancer. The ingress controller has already done all the translations of the requests in the ingress to a Rancher load balancer.  

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

Let's create the ingress using `kubectl`. After you create the ingress, the ingress controller will trigger a load balancer to be created and visible in the **kubernetes-ingress-lbs** stack within the **Kubernetes** -> **System** tab. The load balancer will have the host name routing rules created from the ingress. 

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

Let's create the ingress using `kubectl`. After you create the ingress, the ingress controller will trigger a load balancer to be created and visible in the **kubernetes-ingress-lbs** stack within the **Kubernetes** -> **System** tab. The load balancer will have the host name routing rules created from the ingress. 

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

