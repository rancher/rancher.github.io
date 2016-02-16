## Using Self Signed Certs (Beta)

### Disclaimers
  
This configuration will work for the 'core' services in Rancher running in stand alone mode (Non-HA setup). At the time of this writing, Rancher services deployed by the catalog.

Rancher Compose CLI will need the CA certificate as part of the default store for the Operating system. See [Golang root_*](https://golang.org/src/crypto/x509/)

### Server Pre-Reqs

* A CA certificate file in PEM format. 
* A certificate signed by the CA for the Rancher Server.
* An instance of NGINX or Apache configured to terminate SSL and reverse proxy Rancher server.
* Rancher Server >=v0.57.0

### Steps

#### Server

launch rancher/server container with the modified Docker command below:

```
docker run -d -p 8080:8080 -v <path to ca.crt>:/ca.crt rancher/server:<version>
```

*Note: If you are running NGINX or Apache in a container, you can just link the instance and not publish the Rancher 8080 port.*

This will configure the servers ca-certificate bundle so that the Rancher services for machine provisioning, catalog and compose executor can communicate with the Rancher server.

If you are using a container with NGINX or Apache to terminate SSL, you can now launch that container and link the two containers.

Access the server over the https address. (Should be something like https://rancher.server.domain)

Unless the machine running your web browser trusts the CA used to sign the Rancher server cert, you will get an untrusted site warning when you visit the page.

#### Adding Nodes

1. On the compute node place the CA cert (in pem format) in the directory `/var/lib/rancher/etc/ssl` with the file name `ca.crt`.

2. Run the custom registration command from the UI. (It will have -v /var/lib/rancher:/var/lib/rancher)


